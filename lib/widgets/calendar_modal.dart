import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weekly_task/states/note_detail.dart';
import 'package:weekly_task/widgets/modal_overlay.dart';
import 'package:weekly_task/widgets/calendar.dart';

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

class ModalContents extends ConsumerStatefulWidget {
  final BuildContext context;
  const ModalContents({Key? key, required this.context}) : super(key: key);

  @override
  _ModalContentsState createState() => _ModalContentsState();
}

class _ModalContentsState extends ConsumerState<ModalContents> {
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
                  ref.read(noteProvider.notifier).setScheduledDate(_scheduledDate);
                  Navigator.of(widget.context).pop();
                },
              ),
            ],
          )
        ]
    );
  }
}
