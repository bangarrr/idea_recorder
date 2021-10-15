import 'package:flutter/material.dart';
import 'package:idea_recorder/main.dart';

class Note extends StatefulWidget {
  const Note({Key? key}) : super(key: key);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  String _text = '';

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  void _inputComplete() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) {
        return MyApp();
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メモ'),
        actions: [
          IconButton(
              onPressed: _inputComplete, icon: Icon(Icons.check)
          )
        ],
      ),
        body: Container(
          padding: const EdgeInsets.all(36.0),
          child: TextField(
            enabled: true,
            maxLines: 30,
            onChanged: _handleText,
          ),
        ));
  }
}