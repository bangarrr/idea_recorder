import 'package:flutter/material.dart';
import 'package:idea_recorder/idea_repository.dart';
import 'package:idea_recorder/idea_screen.dart';
import 'package:idea_recorder/ideas_model.dart';
import 'package:idea_recorder/note.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: IdeaRepoFactory.getInstance().fetchIdeas(),
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
        create: (context) => IdeasModel(ideas: snapshot.data), child: MainScreen());
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Idea Recorder',
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
      appBar: AppBar(title: Text('IdeaRecorder')),
      body: SafeArea(child: IdeaScreen()),
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
