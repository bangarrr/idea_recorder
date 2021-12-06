import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:weekly_task/models/task.dart';
import 'package:weekly_task/repositories/task_repository.dart';

class TasksModel extends ChangeNotifier {
  List<Task> _tasks;

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  TasksModel({@required tasks}) : _tasks = tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void update(String id, String text, DateTime? scheduledDate) {
    Task task = _tasks.firstWhere((item) => item.id == id);
    task.text = text;
    task.scheduled_date = scheduledDate;
    notifyListeners();
  }

  void swap(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    Task deleted = _tasks.removeAt(oldIndex);
    _tasks.insert(newIndex, deleted);
    notifyListeners();
  }

  removeTaskAt(int id) {
    _tasks.removeAt(id);
    notifyListeners();
  }

  toggleCompletedAt(int id) {
    _tasks[id].toggleCompleted();

    notifyListeners();
  }

  clearAll() {
    _tasks.clear();

    notifyListeners();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
    persist(this.tasks);
  }
}

persist(tasks) {
  TaskRepoFactory.getInstance().saveTasks(tasks);
}