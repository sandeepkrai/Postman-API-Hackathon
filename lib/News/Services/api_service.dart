import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postmanapihackathon/News/models/news_object.dart';
import '../constants.dart';
class ApiService {
  // ApiService which interacts with the News API
  Future<List<NewsObject>?> getNews({required int pageNumber}) async {
    // Fetch news from the api and convert it into a List of Objects
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          // ApiConstants.country +
          ApiConstants.page +
          pageNumber.toString());
      // Converts String to a Url on which get/post/patch requests can be made
      var response = await http.get(url);
      // Waits for the response of the request
      Map<String, dynamic> data = jsonDecode(response.body);
      // Converts the successful response into a Dart Map
      List results = data["results"];
      // Storing the required data in a List<dynamic>
      List<NewsObject> finalData = results.map((e) {
        return NewsObject.fromJson(e);
      }).toList();
      // Mapping every result element into a NewsObject and storing all of them in a list
      return finalData;
      // Returns the final data i.e. list of NewsObjects
    } catch (e) {
      debugPrint(e.toString());
      // Prints the error occurred to the terminal
      return null;
    }
  }
}
