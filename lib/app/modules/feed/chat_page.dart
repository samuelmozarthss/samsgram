

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:samsgram/app/modules/feed/feed_store.dart';

class ChatPage extends StatefulWidget {
  final String title;

  const ChatPage({Key? key, this.title = 'ChatPage'}) : super(key: key);
  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends ModularState<ChatPage, FeedStore> with TickerProviderStateMixin{
  final List<Msg> _messages = <Msg>[];
  late final TextEditingController _textController;

  bool _escrevendo = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:  Column(
        children: <Widget>[
          Flexible(
              child: ListView.builder(
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
                reverse: true,
                padding: EdgeInsets.all(6.0),
              )
          ),
          Divider(height: 1),
          Container(
            child: _buildComposer(),
            decoration: BoxDecoration(color: Theme.of(context).dialogBackgroundColor),
          ),
        ],
      )
    );
  }
  Widget _buildComposer() {
    return IconTheme(
        data: IconThemeData(color: Colors.green),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 9.0),
          child: Row(
            children: [
              Flexible(
                  child: TextField(
                    controller: _textController,
                    onChanged: (String txt) {
                      setState(() {
                        _escrevendo = txt.length > 0;
                      });
                    },
                    onSubmitted: _enviarMsg,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Ensira algum texto para enviar uma mensagem'
                    ),
                  )
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3),
                child: CupertinoButton(
                  child: Text('Enviar'),
                  onPressed: _escrevendo ? () => _enviarMsg(_textController.text) : null
                ),
              ),
              IconButton(
                  onPressed: _escrevendo
                      ? () => _enviarMsg(_textController.text) : null,
                  icon: Icon(Icons.message))
            ],
          ),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.brown))
          )
        )
    );
  }

  void _enviarMsg(String txt) {
    _textController.clear();
    setState(() {
      _escrevendo = false;
    });
    Msg msg = Msg(
        txt: txt,
        animationController: AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 800)
        )
    );
  }

}

class Msg extends StatelessWidget {
  static const String defaultUserName = "John Doe";
  final String txt;
  final AnimationController animationController;
  Msg({required this.txt, required this.animationController});

  @override
  Widget build(BuildContext ctx) {
    return SizeTransition(sizeFactor: CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceOut,
    ),
      axisAlignment: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                child: Text(defaultUserName),
              ),
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(defaultUserName, style: Theme.of(ctx).textTheme.subtitle1),
                    Container(
                      margin: const EdgeInsets.only(top: 6.0),
                      child: Text(txt),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }

}
