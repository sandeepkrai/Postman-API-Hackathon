import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dataFetchingClass.dart';

Future<Map> fetchPost() async {
  Map m={};
  final response =
  await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=26.7922&lon=82.1998&appid=1edab82812f31d185367061702bd26dd'));

  if (response.statusCode == 200) {
    final Map weather = json.decode(response.body);

    final List listItem = weather['weather'];
    print(weather[''].toString());
    return await weather;
  } else {
    throw Exception('Failed to load album');
  }

}

class DataFetching extends StatefulWidget {
  const DataFetching({Key? key}) : super(key: key);

  @override
  State<DataFetching> createState() => _DataFetchingState();
}

class _DataFetchingState extends State<DataFetching> {
  late Future<Map> futurePost;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     futurePost = fetchPost();
    //print(futurePost);
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child:  FutureBuilder<Map>(
          future: fetchPost(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Result: ${snapshot.data!['weather']}'),
                ),
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                ),
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                ),
              ];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            );
          },
        ),
    );
  }
}

