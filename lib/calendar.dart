import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final DateTime? selectedDate;
  final Function? onDateSelected;
  const Calendar({Key? key, this.selectedDate, this.onDateSelected}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _forcusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ja_JP',
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
      calendarFormat: _calendarFormat,
      rowHeight: 40,
      headerStyle: HeaderStyle(
        leftChevronPadding: EdgeInsets.all(0),
        rightChevronPadding: EdgeInsets.all(0),
        formatButtonVisible: false,
        titleCentered: true,
        titleTextFormatter: (date, locale) => DateFormat.yM(locale).format(date)
      ),
      selectedDayPredicate: (day) {
        return isSameDay(widget.selectedDate, day);
      },
      onDaySelected: (selectedDay, forcusedDay) {
        if (!isSameDay(widget.selectedDate, selectedDay)) {
          setState(() {
            _forcusedDay = forcusedDay;
          });

          if (widget.onDateSelected != null) {
            widget.onDateSelected!(selectedDay);
          }
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (forcusedDay) {
        _forcusedDay = forcusedDay;
      },
    );
  }
}
