import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weekly_task/models/task.dart';
import 'package:weekly_task/screens/note.dart';
import 'package:weekly_task/states/tasks.dart';

class TaskItem extends HookConsumerWidget {
  const TaskItem({Key? key, required this.task, required this.index}) : super(key: key);

  final Task task;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksState = ref.read(tasksProvider.notifier);

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
      key: ValueKey<String>(task.text),
      background: getDissmissBackground(true),
      secondaryBackground: getDissmissBackground(false),
      onDismissed: (DismissDirection direction) =>
          tasksState.removeTaskAt(index),
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: Text(
            task.text.split('\n')[0],
            style: TextStyle(
                decoration: task.completed
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: task.completed ? Colors.grey : Colors.black),
          ),
          subtitle: Text(task.formattedScheduledDate()),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return Note(task: task);
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
