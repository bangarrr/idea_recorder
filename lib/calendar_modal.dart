import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weekly_task/modal_overlay.dart';
import 'package:weekly_task/calendar.dart';
import 'package:weekly_task/providers/NoteDetailProvider.dart';

class CalendarModal {
  BuildContext context;
  CalendarModal(this.context) : super();

  void showCalendarModal() {
    Navigator.push(
      context,
      ModalOverlay(ModalContents(context: context))
    );
  }

  void hideModal() {
    Navigator.of(context).pop();
  }
}

class ModalContents extends StatefulWidget {
  final BuildContext context;
  const ModalContents({Key? key, required this.context}) : super(key: key);

  @override
  _ModalContentsState createState() => _ModalContentsState();
}

class _ModalContentsState extends State<ModalContents> {
  DateTime? _scheduledDate;

  void _onDateSelected(DateTime date) {
    setState(() {
      _scheduledDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Calendar(selectedDate: _scheduledDate, onDateSelected: _onDateSelected),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: const Text('キャンセル'),
                onPressed: () => Navigator.of(widget.context).pop(),
              ),
              TextButton(
                child: const Text('選択'),
                onPressed: () {
                  Provider.of<NoteDetailProvider>(widget.context, listen: false).setScheduledDate(_scheduledDate);
                  Navigator.of(widget.context).pop();
                },
              ),
            ],
          )
        ]
    );
  }
}
