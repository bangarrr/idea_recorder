import 'package:flutter/widgets.dart';

class NoteDetailProvider extends ChangeNotifier {
  DateTime? _scheduledDate;
  DateTime? get scheduledDate => _scheduledDate;

  void setScheduledDate(DateTime? date) {
    _scheduledDate = date;
    notifyListeners();
  }
}