import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weekly_task/modal_overlay.dart';

class CalendarModal {
  BuildContext context;
  CalendarModal(this.context) : super();

  void showCalendarModal() {
    Navigator.push(
      context,
      ModalOverlay(
        TableCalendar(
            locale: 'ja_JP',
            shouldFillViewport: true,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
          )
      )
    );
  }

  void hideModal() {
    Navigator.of(context).pop();
  }
}