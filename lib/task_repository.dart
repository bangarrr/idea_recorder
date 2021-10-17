import 'dart:convert';

import 'package:idea_recorder/idea.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdeaRepoFactory {
  static IdeaRepository getInstance() => PrefsIdeaRepo();
}

abstract class IdeaRepository {
  fetchIdeas();
  saveIdeas(List<Idea> ideas);
}

class PrefsIdeaRepo implements IdeaRepository {
  final kKey = 'IdeaRecorder';

  List<Idea> decode(String? source) {
    var json = jsonDecode(source ?? '[]') as List;
    return json.map((item) => Idea.fromJson(item)).toList();
  }

  @override
  Future<List<Idea>> fetchIdeas() async {
    var prefs = await SharedPreferences.getInstance();
    return decode(prefs.getString(kKey));
  }

  @override
  saveIdeas(List<Idea> ideas) async {
    var prefs = await SharedPreferences.getInstance();
    var jsonString = jsonEncode(ideas);
    print(await prefs.setString(kKey, jsonString));
  }
}