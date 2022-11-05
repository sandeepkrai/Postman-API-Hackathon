import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postmanapihackathon/News/models/news_object.dart';
import '../constants.dart';

class ApiService {
  Future<List<NewsObject>?> getNews({required int pageNumber}) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          // ApiConstants.country +
          ApiConstants.page +
          pageNumber.toString());
      var response = await http.get(url);
      Map<String, dynamic> data = jsonDecode(response.body);
      List results = data["results"];
      // print(results);
      List<NewsObject> finalData = results.map((e) {
        return NewsObject.fromJson(e);
      }).toList();
      return finalData;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
