import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idea_recorder/idea_item.dart';
import 'package:provider/provider.dart';
import 'package:idea_recorder/ideas_model.dart';
import 'package:idea_recorder/idea.dart';

class IdeaScreen extends StatefulWidget {
  const IdeaScreen({Key? key}) : super(key: key);

  @override
  _IdeaScreenState createState() => _IdeaScreenState();
}

class _IdeaScreenState extends State<IdeaScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            _buildList(),
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
              child: Text('データがありません')
            )
        )
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
