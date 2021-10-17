import 'package:flutter/material.dart';
import 'package:idea_recorder/idea.dart';
import 'package:idea_recorder/ideas_model.dart';
import 'package:provider/provider.dart';

class Note extends StatefulWidget {
  final Idea? idea;

  Note({Key? key, this.idea}) : super(key: key);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final TextEditingController _inputCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.idea != null) {
      _inputCtrl.text = widget.idea!.text;
    }
  }

  void _inputComplete() {
    String _text = _inputCtrl.text.trim();

    if (_text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('入力されていません'),
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          width: 160.0,
          behavior: SnackBarBehavior.floating,
        )
      );
      return;
    }

    if (widget.idea != null) {
      Provider.of<IdeasModel>(context, listen: false)
          .update(widget.idea!.id!, _text);
    } else {
      Idea idea = Idea(text: _text);
      Provider.of<IdeasModel>(context, listen: false).addIdea(idea);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('メモ'),
          actions: [
            IconButton(onPressed: _inputComplete, icon: Icon(Icons.check))
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: _inputCtrl,
            enabled: true,
            maxLines: 50,
            decoration: InputDecoration(
                hintText: '入力してください',
                border: InputBorder.none,
                counterText: '0 Characters'),
          ),
        ));
  }
}
