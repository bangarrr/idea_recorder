import 'package:flutter/material.dart';
import 'package:weekly_task/task.dart';
import 'package:weekly_task/tasks_model.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weekly_task/calendar_modal.dart';

class Note extends StatefulWidget {
  final Task? task;

  Note({Key? key, this.task}) : super(key: key);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final TextEditingController _inputCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _inputCtrl.text = widget.task!.text;
    }
  }

  void _inputComplete() {
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

    if (widget.task != null) {
      Provider.of<TasksModel>(context, listen: false)
          .update(widget.task!.id!, _text);
    } else {
      Task task = Task(text: _text);
      Provider.of<TasksModel>(context, listen: false).addTask(task);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('メモ'),
          actions: [
            IconButton(onPressed: _inputComplete, icon: Icon(Icons.check))
          ],
        ),
        body: Column(children: [
          Expanded(child: Container(
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
          MetaOptions()
        ]));
  }
}

class MetaOptions extends StatelessWidget {
  const MetaOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildItem(
            FontAwesomeIcons.calendarAlt, '予定日', '2021/1/23', false,
            () => {CalendarModal(context).showCalendarModal()}
        ),
        _buildItem(FontAwesomeIcons.bell, '通知', 'なし', true,
            () => {print("tuuti")}
        ),
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

  Widget _buildItem(IconData icon, String text, String value, bool isLast, GestureTapCallback onTap) {
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
