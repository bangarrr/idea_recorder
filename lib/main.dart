import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weekly_task/task_repository.dart';
import 'package:weekly_task/task_screen.dart';
import 'package:weekly_task/tasks_model.dart';
import 'package:weekly_task/note.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: TaskRepoFactory.getInstance().fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) print(snapshot.error);
            return _buildTodosPage(snapshot);
          }
        });
  }

  Widget _buildTodosPage(AsyncSnapshot snapshot) {
    return ChangeNotifierProvider(
        create: (context) => TasksModel(tasks: snapshot.data), child: MainScreen());
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weekly Task',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home());
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weekly Task')),
      body: SafeArea(child: TaskScreen()),
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
