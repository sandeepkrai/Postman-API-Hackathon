import 'package:flutter/material.dart';
import 'package:postmanapihackathon/News/models/news_object.dart';

class NewsPage extends StatefulWidget {
  final NewsObject news;

  // Accepting the parameter which was passed to this widget
  const NewsPage({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // Stores the device height and width and thus it differs for every device
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.7),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.news.title == null ? "" : widget.news.title!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.1,
                  ),
                ),
                // Displays the Title if it has been provided by the API
                SizedBox(
                  height: height * 0.03,
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
                // Displays the Image if it has been provided by the API
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  "${widget.news.content == null ? "" : widget.news.content!}\n",
                  style: TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.normal,
                      height: height * 0.0014),
                ),
                // Displays the Content if it has been provided by the API
                widget.news.creator == null
                    ? const Text("")
                    : Text(
                        "Authors: ${widget.news.creator!}",
                        style: TextStyle(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.w600,
                          letterSpacing: height * 0.001,
                        ),
                      ),
                // Displays the Authors if it has been provided by the API
              ],
            ),
          ),
        ),
      ),
    );
  }
}
