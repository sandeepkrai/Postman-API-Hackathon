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
    final ApiService api = ApiService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromRGBO(	4, 12, 44,1),
        title: const Text("News"),
      ),
      backgroundColor: Color.fromRGBO(	4, 12, 44,1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10.0, bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
              style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color.fromRGBO(64, 198, 233, 1)),),
                    onPressed: () {
                      if (pageNumber > 0) {
                        setState(() {
                          // Changes the page number and hence the api is called for the changed page number
                          pageNumber--;
                        });
                      }
                    },
                    child: const Text("Previous"),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(64, 198, 233, 1)),),
                    onPressed: () {
                      setState(() {
                        // Changes the page number and hence the api is called for the changed page number
                        pageNumber++;
                      });
                    },
                    child: const Text("Next"),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: api.getNews(pageNumber: pageNumber),
              // Future builder takes Future Data which takes page-number as input
              builder: (
                BuildContext context,
                AsyncSnapshot<List<NewsObject>?> snapshot,
              ) {
                if (snapshot.hasData) {
                  List<NewsObject>? data = snapshot.data;
                  // Fetching the snapshot data into variable
                  return SingleChildScrollView(
                    child: Column(
                      children: data!
                          .map(
                            // Mapping every NewsObject to a Custom widget displaying appropriate Fields of data such as Image and Title
                            (e) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => NewsPage(news: e),
                                  ),
                                );
                              // Pushing to a new page when clicking a news card
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      color: Color.fromRGBO(14, 20, 51, 1),),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${e.title!.trim()}\n",
                                          // softWrap: true,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white
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
                    // Showing a loading indicator while the future hasnt been resolved yet
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
