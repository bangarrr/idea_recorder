import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weekly_task/models/task.dart';
import 'package:weekly_task/repositories/task_repository.dart';
import 'package:weekly_task/screens/task_list.dart';
import 'package:weekly_task/screens/note.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weekly_task/states/tasks.dart';

void main() {
  initializeDateFormatting().then(
          (_) => runApp(
              ProviderScope(child: MyApp())
          )
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  /*@override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: TaskRepoFactory.getInstance().fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) print(snapshot.error);
            ref.read(tasksProvider.notifier).setInitialTasks(snapshot.data as List<Task>);
            return MainScreen();
          }
        });
  }*/

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MainScreen();
  }
}

class MainScreen extends HookConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: 'Weekly Task',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home());
  }
}

class Home extends HookConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Weekly Task')),
      body: SafeArea(child: TaskList()),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Note();
            }));
          }),
    );
  }
}
