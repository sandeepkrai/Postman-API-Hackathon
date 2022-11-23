import 'package:flutter/material.dart';
import 'package:postmanapihackathon/News/NewsMain.dart';
import 'package:postmanapihackathon/Weather/Services/DataFetching.dart';
import 'package:postmanapihackathon/Weather/Services/searchScreen.dart';
import 'package:postmanapihackathon/Weather/Services/splashScreen.dart';

import 'Weather/Models/weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.blueAccent
      ),
      home:  SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  double? lat = 0;
  double? long = 0;
  AsyncSnapshot<WeatherData>? snapshot;
  MyHomePage({this.lat, this.long, this.snapshot});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _initUser(){
    print("i m here");
  }
  @override
  Widget build(BuildContext context) {
    print(widget.snapshot);
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewsMain()),
              );
            },
            icon: const Icon(Icons.newspaper),
          ),
        ],
      ),

      backgroundColor: Color.fromRGBO(	137, 207, 240,1),
      body:  SingleChildScrollView(child: FetchScreen(lat: widget.lat, long: widget.long,snapshot: widget.snapshot,)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Search()));
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
