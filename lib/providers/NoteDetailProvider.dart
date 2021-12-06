import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoteDetailProvider extends StateNotifier<DateTime?> {
  NoteDetailProvider() : super(null);

  void setScheduledDate(DateTime? date) {
    state = date;
  }
}