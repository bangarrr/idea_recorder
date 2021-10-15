import 'package:flutter/material.dart';
import 'package:idea_recorder/ideas_model.dart';
import 'package:provider/provider.dart';

enum ChoiceAction { Delete }

class Choice {
  const Choice({required this.title, required this.action});

  final String title;
  final ChoiceAction action;
}

class MorePopUp extends StatelessWidget {
  final List<Choice> choices = const [
    Choice(title: 'Delete All', action: ChoiceAction.Delete)
  ];
  const MorePopUp({Key? key}) : super(key: key);

  void _handleSelect(Choice choice, BuildContext context) {
    switch (choice.action) {
      case ChoiceAction.Delete:
        Provider.of<IdeasModel>(context, listen: false).clearAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: Icon(Icons.more_horiz),
      onSelected: (Choice choice) => _handleSelect(choice, context),
      itemBuilder: (context) {
        return choices.map((Choice choice) {
          return PopupMenuItem<Choice>(
            value: choice,
            child: Text(choice.title),
          );
        }).toList();
      }
    );
  }
}
