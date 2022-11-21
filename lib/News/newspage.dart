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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.news.title==null ? "": widget.news.title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                widget.news.imageUrl == null
                    ? const SizedBox(
                        // width: 100,
                        // height: 100,
                        )
                    : Image.network(
                        widget.news.imageUrl!,
                        fit: BoxFit.cover,
                        // width: 100,
                        // height: 100,
                      ),
                Text("${widget.news.content==null ? "": widget.news.content!}\n"),
                Text("Authors- \n\t${widget.news.creator==null ? "": widget.news.creator!}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
