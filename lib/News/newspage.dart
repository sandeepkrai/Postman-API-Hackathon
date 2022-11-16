import 'package:flutter/material.dart';
import 'package:postmanapihackathon/News/models/news_object.dart';

class NewsPage extends StatefulWidget {
  NewsObject news;

  NewsPage({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              widget.news.title!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
