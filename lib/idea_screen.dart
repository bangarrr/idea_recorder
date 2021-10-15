import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idea_recorder/idea_item.dart';
import 'package:provider/provider.dart';
import 'package:idea_recorder/ideas_model.dart';
import 'package:idea_recorder/idea.dart';
import 'package:idea_recorder/more_popup.dart';

class IdeaScreen extends StatefulWidget {
  const IdeaScreen({Key? key}) : super(key: key);

  @override
  _IdeaScreenState createState() => _IdeaScreenState();
}

class _IdeaScreenState extends State<IdeaScreen> {
  final inputCtrl = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            const CustomAppBar(),
            _buildList(),
            _buildInputRow()
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<IdeasModel>(
        builder: (context, model, _) => Expanded(
            child: model.ideas.length != 0
                ? ListView.builder(
                controller: _scrollController,
                itemCount: model.ideas.length,
                itemBuilder: _ideaItemBuilder
            ) : Center(
              child: Text('Add something')
            )
        )
    );
  }

  Widget _buildInputRow() {
    return Container(
      margin: EdgeInsets.only(top: 7),
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                controller: inputCtrl,
                decoration: InputDecoration(
                  hintText: 'I want to...',
                  border: InputBorder.none
                ),
              )
          ),
          FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Color(0xff2c2f36),
            textColor: Colors.white,
            child: Text('+ Add Task'),
            onPressed: () {
              if (inputCtrl.text.isNotEmpty) {
                var idea = Idea(text: inputCtrl.text.trim());
                Provider.of<IdeasModel>(context, listen: false).addIdea(idea);

                setState(() {
                  inputCtrl.text = '';
                });

                _scrollToBottom();
              }
            }
          )
        ],
      ),
    );
  }

  Widget _ideaItemBuilder(BuildContext context, int index) {
    final idea = Provider.of<IdeasModel>(context, listen: false).ideas[index];
    return IdeaItem(idea: idea, index: index);
  }

  void _scrollToBottom() {
    if (_scrollController.positions.toList().isNotEmpty) {
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 80,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease
      );
    }
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 18, bottom: 18, right: 5),
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          'To-do list',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
        ),
        MorePopUp()
      ]),
    );
  }
}
