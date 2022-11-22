import 'package:flutter/material.dart';
import 'package:postmanapihackathon/News/Services/api_service.dart';
import 'package:postmanapihackathon/News/newspage.dart';

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
      backgroundColor: Color.fromRGBO(137, 207, 240,0.2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0,bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        pageNumber--;
                      });
                    },
                    child: const Text("Previous"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        pageNumber++;
                      });
                    },
                    child: const Text("Next"),
                  ),
                ],
              ),
            ),
            FutureBuilder(
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
                            (e) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => NewsPage(news: e)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    color: Colors.grey
                                  ),
                                  child: Row(

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
                                ),
                              ),
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
          ],
        ),
      ),
    );
  }
}
