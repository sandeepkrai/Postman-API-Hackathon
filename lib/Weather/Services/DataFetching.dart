import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/weather.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {

  Future<WeatherData> getData() async{
      final response = await http.get(Uri.parse('https://webhook.site/72d82a4b-d37b-4684-925d-b29af6b58158'));
      var data = jsonDecode(response.body.toString());
      print(data.toString());
      if(response.statusCode==200){
        return WeatherData.fromJson(data);
      }
      else{
        return WeatherData.fromJson(data);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: FutureBuilder<WeatherData>(
          future: getData(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Text(snapshot.data!.weather![0].main.toString());
            }
            else{
              return Text('Loading');
            }
          },
        ))
      ],
    );
  }
}
