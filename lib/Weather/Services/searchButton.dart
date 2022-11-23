import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:postmanapihackathon/Weather/Services/DataFetching.dart';
import 'package:postmanapihackathon/Weather/Services/splashScreen.dart';
import 'package:uuid/uuid.dart';

import '../../main.dart';

class SearchButton extends StatefulWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  State<SearchButton> createState() => _SearchButtonState();
}
TextEditingController textEditingController = TextEditingController();
class _SearchButtonState extends State<SearchButton> {

  var uuid = const Uuid();
  // Session Token for personalizing service
  String _sessiontoken = '123456';
  //Session Token linked with Unique Id

  //List of Dynamic Places which is generated under autocomplete
  List<dynamic> _placesList = [];
  //Suggestion function under autocomplete function
  void getSuggestion(String input) async {
    String kPLACES_API_KEY = 'AIzaSyCo41oyG5q2XEwwx6hY-etKfY6Bzc0nplw';
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessiontoken';
    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print(data);
    if (response.statusCode == 200){
      if(this.mounted)
      setState(() {
        _placesList = jsonDecode(response.body.toString()) ['predictions'];
      });
    }else{
      throw Exception('Failed to load Data');
    }
  }
  void onChange(){
    if(_sessiontoken==null){
      if(this.mounted)
      setState(() {
        _sessiontoken = uuid.v4();
      });
    }
    else{
      getSuggestion(textEditingController.text);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.addListener(() {
      onChange();
    });
  }
  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: const Icon(Icons.search,
              size:  30,),
            title: TextFormField(
              cursorColor: Colors.black,
              controller: textEditingController ,
              decoration: const InputDecoration(
                hintText: 'Search Places',
              ),
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount:  _placesList.length,
                itemBuilder: (context,index){
                  return ListTile(
                    leading: const Icon(Icons.location_on,
                      color: Colors.black,),
                    onTap: () async {
                      List<Location> locations = await locationFromAddress(_placesList[index]['description']);
                      print(locations);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SplashScreen(lat: locations[0].latitude, long: locations[0].longitude,)));

                    },
                    title: Text(_placesList[index]['description'])  ,
                  );
                })),
      ],
    );
  }
}
