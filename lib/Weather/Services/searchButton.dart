import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class SearchButton extends StatefulWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    var uuid = const Uuid();
    // Session Token for personalizing service
    String _sessiontoken = '123456';
    //Session Token linked with Unique Id

    //List of Dynamic Places which is generated under autocomplete
    List<dynamic> _placesList = [];
    //Suggestion function under autocomplete function
    void getSuggestion(String input) async {
      String kPLACES_API_KEY = 'AIzaSyC1_U9ZJk98Su3FtNnSpnKeIJpTPEai06M';
      String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessiontoken';
      var response = await http.get(Uri.parse(request));
      var data = response.body.toString();
      print(data);
      if (response.statusCode == 200){
        setState(() {
          _placesList = jsonDecode(response.body.toString()) ['predictions'];
        });
      }else{
        throw Exception('Failed to load Data');
      }
    }
    void onChange(){
      if(_sessiontoken==null){
        setState(() {
          _sessiontoken = uuid.v4();
        });
      }
      else{
        getSuggestion(textEditingController.text);
      }
    }
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
                    },
                    title: Text(_placesList[index]['description'])  ,
                  );
                })),
      ],
    );
  }
}
