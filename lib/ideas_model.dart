import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:idea_recorder/idea.dart';
import 'package:idea_recorder/idea_repository.dart';

class IdeasModel extends ChangeNotifier {
  List<Idea> _ideas;

  UnmodifiableListView<Idea> get ideas => UnmodifiableListView(_ideas);

  IdeasModel({@required ideas}) : _ideas = ideas;

  void addIdea(Idea idea) {
    _ideas.add(idea);
    notifyListeners();
  }

  void update(String id, String text) {
    Idea idea = _ideas.firstWhere((item) => item.id == id);
    idea.text = text;
    notifyListeners();
  }

  void swap(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    Idea deleted = _ideas.removeAt(oldIndex);
    _ideas.insert(newIndex, deleted);
    notifyListeners();
  }

  removeIdeaAt(int id) {
    _ideas.removeAt(id);
    notifyListeners();
  }

  toggleCompletedAt(int id) {
    _ideas[id].toggleCompleted();

    notifyListeners();
  }

  clearAll() {
    _ideas.clear();

    notifyListeners();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
    persist(this.ideas);
  }
}

persist(ideas) {
  IdeaRepoFactory.getInstance().saveIdeas(ideas);
}