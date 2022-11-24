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
        scaffoldBackgroundColor: Color.fromRGBO(4, 12, 44, 1)
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
  }
  @override
  Widget build(BuildContext context) {
    // print(widget.snapshot);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather"),
        backgroundColor: Color.fromRGBO(4, 12, 44, 1),
        elevation: 0,
        actions: [
          Center(child: Text("News")),
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

      backgroundColor: Color.fromRGBO(	4, 12, 44,1),
      body:  SingleChildScrollView(child: Container(
          child: FetchScreen(lat: widget.lat, long: widget.long,snapshot: widget.snapshot,),
      ),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(14, 20, 51, 1),

        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Search()));
        },
        
        child: const Icon(Icons.search,
        color: Color.fromRGBO(64,198,233,1),
        ),
      ),
    );
  }
}
