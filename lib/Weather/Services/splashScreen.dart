import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../Models/weather.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
  double? lat ;
  double? long ;
  SplashScreen({this.lat, this.long});
}

class _SplashScreenState extends State<SplashScreen> {

  Future<WeatherData> getData() async{
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=${_center.latitude}&lon=${_center.longitude}&appid=358af07939445d0f4e5c3daf89f19537'));
    var data = jsonDecode(response.body.toString());
    print(data.toString());
    if(response.statusCode==200){
      return WeatherData.fromJson(data);
    }
    else{
      return WeatherData.fromJson(data);
    }
  }


  int ci=0;
  late LatLng _center ;
  late Position currentLocation;


  Future<Position> locateUser() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    print(_center.longitude);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLocation();
  }


  _initUser() async {
    FutureBuilder<WeatherData>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot);
            return MyHomePage(snapshot: snapshot,);
          }
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
  @override
  Widget build(BuildContext context) {
    if(widget.lat!=null){
      _center = LatLng(widget.lat!, widget.long!);
    }
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(4, 12, 44, 1),
        child: FutureBuilder<WeatherData>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot);
                return MyHomePage(snapshot: snapshot,);
              }
              else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),

    );
  }
}