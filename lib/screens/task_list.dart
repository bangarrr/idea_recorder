import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weekly_task/models/task.dart';
import 'package:weekly_task/states/tasks.dart';
import 'package:weekly_task/widgets/task_item.dart';

class TaskList extends HookConsumerWidget {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider) as List<Task>;

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: tasks.length != 0
                  ? ReorderableListView(
                  children: [
                    for (var i = 0; i < tasks.length; i++)
                      TaskItem(task: tasks[i], index: i, key: Key(tasks[i].created_at.toString()))
                  ],
                  onReorder: (oldIndex, newIndex) {
                    ref.read(tasksProvider.notifier).swap(oldIndex, newIndex);
                  }
              ) : Center(child: Text('データがありません'))
            )
          ],
        ),
      ),
    );
  }

  void _scrollToBottom() {
    if (_scrollController.positions.toList().isNotEmpty) {
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 80,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease
      );
    }
  }
}
