import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weekly_task/models/task.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weekly_task/states/note_detail.dart';
import 'package:weekly_task/states/tasks.dart';
import 'package:weekly_task/widgets/calendar_modal.dart';

class Note extends ConsumerStatefulWidget {
  final Task? task;

  Note({Key? key, this.task}) : super(key: key);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends ConsumerState<Note> {
  final TextEditingController _inputCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _inputCtrl.text = widget.task!.text;
      //_scheduledDate = widget.task!.scheduled_date;
    }
  }

  void _inputComplete(BuildContext context) {
    String _text = _inputCtrl.text.trim();

    if (_text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('入力されていません'),
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        width: 160.0,
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }

    var scheduledDate = ref.watch(noteProvider) as DateTime?;

    if (widget.task != null) {
      ref.read(tasksProvider.notifier)
          .update(widget.task!.id!, _text, scheduledDate);
    } else {
      Task task = Task(text: _text, scheduled_date: scheduledDate);
      ref.read(tasksProvider.notifier).addTask(task);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('メモ'),
          actions: [
            IconButton(onPressed: () => _inputComplete(context), icon: Icon(Icons.check))
          ],
        ),
        body: Column(children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _inputCtrl,
              enabled: true,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  hintText: '入力してください', border: InputBorder.none),
            ),
          )),
          MetaOptions(scheduledDate: ref.watch(noteProvider) as DateTime?)
        ]));
  }
}

class MetaOptions extends StatelessWidget {
  final DateTime? scheduledDate;
  const MetaOptions({Key? key, required this.scheduledDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildItem(
            FontAwesomeIcons.calendarAlt,
            '予定日',
            scheduledDate != null ? DateFormat('yyyy-MM-dd').format(scheduledDate!) : 'なし',
            false,
            () => {CalendarModal(context).showCalendarModal()}),
        _buildItem(
            FontAwesomeIcons.bell, '通知', 'なし', true, () => {print("tuuti")}),
      ],
    );
  }

  Widget _buildItems(IconData icon, String text, String value, bool? is_last) {
    return ListTile(
        title: Text(text),
        leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [FaIcon(icon, size: 20)]),
        trailing: Text(value));
  }

  Widget _buildItem(IconData icon, String text, String value, bool isLast,
      GestureTapCallback onTap) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
                border: Border(
                    top: isLast
                        ? BorderSide.none
                        : BorderSide(color: Colors.grey[300]!),
                    bottom: BorderSide(color: Colors.grey[300]!))),
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(right: 8),
                    child: FaIcon(icon, size: 16)),
                Text(text),
                Expanded(child: Text(value, textAlign: TextAlign.right))
              ],
            )));
  }
}
