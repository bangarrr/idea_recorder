import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoteDetailNotifier extends StateNotifier<DateTime?> {
  NoteDetailNotifier({initialDate}) : super(null);

  void setScheduledDate(DateTime? date) {
    state = date;
  }
}