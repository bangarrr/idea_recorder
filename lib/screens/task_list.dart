import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weekly_task/widgets/task_item.dart';
import 'package:provider/provider.dart';
import 'package:weekly_task/providers/tasks_model.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            _buildList(),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<TasksModel>(
        builder: (context, model, _) => Expanded(
            child: model.tasks.length != 0
                ? ReorderableListView.builder(
                itemCount: model.tasks.length,
                itemBuilder: _taskItemBuilder,
                onReorder: (oldIndex, newIndex) {
                  Provider.of<TasksModel>(context, listen: false).swap(oldIndex, newIndex);
                }
            ) : Center(
              child: Text('データがありません')
            )
        )
    );
  }

  Widget _taskItemBuilder(BuildContext context, int index) {
    final task = Provider.of<TasksModel>(context, listen: false).tasks[index];
    return TaskItem(task: task, index: index, key: Key(task.text));
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
