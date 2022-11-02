import 'package:flutter/material.dart';

class NewsMain extends StatefulWidget {
  const NewsMain({Key? key}) : super(key: key);

  @override
  State<NewsMain> createState() => _NewsMainState();
}

class _NewsMainState extends State<NewsMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("This is news"),),
    );
  }
}
