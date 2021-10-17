import 'package:flutter/material.dart';
import 'package:idea_recorder/idea.dart';
import 'package:idea_recorder/note.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:idea_recorder/ideas_model.dart';

class IdeaItem extends StatelessWidget {
  const IdeaItem({Key? key, required this.idea, required this.index}) : super(key: key);

  final Idea idea;
  final int index;

  @override
  Widget build(BuildContext context) {
    final notCompletedIconColor = Color(0xff4ed9d6);
    final completedIconColor = notCompletedIconColor.withAlpha(100);

    Widget getDissmissBackground(bool left) {
      return Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.red[400]),
        alignment: Alignment(left ? -0.9 : 0.9, 0),
        child: Icon(
          Icons.train,
          color: Colors.white,
          size: 20,
        ),
      );
    }

    return Dismissible(
      key: ValueKey<String>(idea.text),
      background: getDissmissBackground(true),
      secondaryBackground: getDissmissBackground(false),
      onDismissed: (DismissDirection direction) =>
          Provider.of<IdeasModel>(context, listen: false).removeIdeaAt(index),
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: Text(
            idea.text.split('\n')[0],
            style: TextStyle(
                decoration: idea.completed
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: idea.completed ? Colors.grey : Colors.black),
          ),
          subtitle: Text(DateFormat('yyyy/MM/dd').format(idea.created_at)),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return Note(idea: idea);
              })
            );
          },
          // leading: IconButton(
          //   icon: idea.completed
          //       ? Icon(
          //     Icons.check_circle,
          //     color: completedIconColor,
          //   )
          //       : Icon(
          //     Icons.circle,
          //     color: notCompletedIconColor,
          //   ),
          //   onPressed: () => Provider.of<IdeasModel>(context, listen: false)
          //       .toggleCompletedAt(index),
          // ),
        ),
      ),
    );
  }
}
