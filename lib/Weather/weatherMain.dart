import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';


import 'Models/weather.dart';



class DataFetching extends StatefulWidget {
  const DataFetching({Key? key}) : super(key: key);

  @override
  State<DataFetching> createState() => _DataFetchingState();
}

class _DataFetchingState extends State<DataFetching> {
  late Future<Map> futurePost;
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    checkGps();
    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if(servicestatus){
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        }else if(permission == LocationPermission.deniedForever){
          print("'Location permissions are permanently denied");
        }else{
          haspermission = true;
        }
      }else{
        haspermission = true;
      }

      if(haspermission){
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    }else{
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
        locationSettings: locationSettings).listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
    });
  }
  Future<Map> fetchPost() async {
    Map m={};

    final response =
    await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&appid=1edab82812f31d185367061702bd26dd'));

    if (response.statusCode == 200) {
      final Map weather = json.decode(response.body);

      final List listItem = weather['weather'];
      print(weather[''].toString());
      return await weather;
    } else {
      throw Exception('Failed to load album');
    }

  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child:  FutureBuilder<Map>(
          future: fetchPost(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
            List<Widget> children;
            var teather = snapshot.data!['weather'];
            if (snapshot.hasData) {

              children = <Widget>[
                Center(
                  child: Text('${snapshot.data!["weather"][0]['main']}'),
                ),
                Center(
                  child: Text('${snapshot.data!["weather"][0]['description']}'),
                ),
                Center(
                  child: Text('${snapshot.data!["name"]}'),
                ),
                Center(

                  child: Text('${DateTime.monthsPerYear}'),
                ),
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
            }  else {
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
            return Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),),
                SizedBox(
                  height: 20,
                ),
                Text(snapshot.data!['name']),
                Text(snapshot.data!['weather'][0]['description']),
                Text(snapshot.data!['main']['temp'].toString()+" F"),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("MIN"),
                          Text(snapshot.data!['main']['temp_min'].toString())
                        ],
                      ),
                      Column(
                        children: [
                          Text("MAX"),
                          Text(snapshot.data!['main']['temp_max'].toString())
                        ],
                      )
                    ],
                  ),
                )

              ],
            ),);
          },
        ),
    );
  }
}

