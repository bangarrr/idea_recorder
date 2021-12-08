import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weekly_task/providers/tasks_notifier.dart';
import 'package:weekly_task/repositories/task_repository.dart';

final tasksProvider = StateNotifierProvider(
        (_) => TasksNotifier(
            tasks: TaskRepoFactory.getInstance().fetchTasks()
        )
);