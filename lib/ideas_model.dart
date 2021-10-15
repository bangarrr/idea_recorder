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