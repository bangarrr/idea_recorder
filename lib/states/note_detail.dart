import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weekly_task/providers/note_detail_notifier.dart';

final noteProvider = StateNotifierProvider((_) => NoteDetailNotifier());