import 'package:flutter/material.dart';
import 'package:postmanapihackathon/News/Services/api_service.dart';

import 'models/news_object.dart';

class NewsMain extends StatefulWidget {
  const NewsMain({Key? key}) : super(key: key);

  @override
  State<NewsMain> createState() => _NewsMainState();
}

class _NewsMainState extends State<NewsMain> {
  int pageNumber = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final ApiService _api = ApiService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: FutureBuilder(
          future: _api.getNews(pageNumber: pageNumber),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<NewsObject>?> snapshot,
          ) {
            if (snapshot.hasData) {
              List<NewsObject>? data = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: data!
                      .map(
                        (e) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${e.title!.trim()}\n",
                                    // softWrap: true,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                e.imageUrl == null
                                    ? const SizedBox(
                                        width: 100,
                                        height: 100,
                                      )
                                    : Image.network(
                                        e.imageUrl!,
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                      ),
                              ],
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
