import 'dart:convert';

import 'package:weekly_task/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskRepoFactory {
  static TaskRepository getInstance() => PrefsTaskRepo();
}

abstract class TaskRepository {
  fetchTasks();
  saveTasks(List<Task> tasks);
}

class PrefsTaskRepo implements TaskRepository {
  final kKey = 'WeeklyTask';

  List<Task> decode(String? source) {
    var json = jsonDecode(source ?? '[]') as List;
    return json.map((item) => Task.fromJson(item)).toList();
  }

  @override
  Future<List<Task>> fetchTasks() async {
    var prefs = await SharedPreferences.getInstance();
    return decode(prefs.getString(kKey));
  }

  @override
  saveTasks(List<Task> tasks) async {
    var prefs = await SharedPreferences.getInstance();
    var jsonString = jsonEncode(tasks);
    print(await prefs.setString(kKey, jsonString));
  }
}