import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  final String title;
  const FeedPage({Key? key, this.title = 'FeedPage'}) : super(key: key);
  @override
  FeedPageState createState() => FeedPageState();
}
class FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Samsgram'),
        actions: [
          IconButton(
          onPressed: () {},
          icon: Icon(Icons.add_box_outlined)
        ),
          IconButton(
          onPressed: () {},
        icon: Icon(Icons.favorite_border)
        ),
          IconButton(
          onPressed: () {},
        icon: Icon(Icons.chat_outlined)
          ),
        ],
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}