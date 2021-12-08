import 'dart:collection';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weekly_task/models/task.dart';
import 'package:weekly_task/repositories/task_repository.dart';

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier({tasks}) : super([]);

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(state);
  int get size => state.length;

  void setInitialTasks(List<Task> tasks) {
    state = tasks;
  }

  void addTask(Task task) {
    state = [...state, task];
    persist(state);
  }

  void update(String? id, String text, DateTime? scheduledDate) {
    if (id == null) return;

    List<Task> oldState = [...state];
    int index = oldState.indexWhere((item) => item.id == id);
    oldState[index].text = text;
    oldState[index].scheduled_date = scheduledDate;
    state = oldState;
    persist(state);
  }

  void swap(int oldIndex, int newIndex) {
    List<Task> oldState = [...state];

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    Task deleted = oldState.removeAt(oldIndex);
    oldState.insert(newIndex, deleted);
    state = oldState;
    persist(state);
  }

  removeTaskAt(int id) {
    List<Task> oldState = [...state];
    oldState.removeAt(id);
    state = oldState;
    persist(state);
  }

  toggleCompletedAt(int id) {
    List<Task> oldState = [...state];
    oldState[id].toggleCompleted();
    state = oldState;
    persist(state);
  }

  clearAll() {
    List<Task> oldState = [...state];
    oldState.clear();
    state = oldState;
    persist(state);
  }
}

persist(tasks) {
  TaskRepoFactory.getInstance().saveTasks(tasks);
}