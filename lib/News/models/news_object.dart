import 'package:flutter/material.dart';

class NewsObject {
  String? title;
  String? link;
  List<dynamic>? keywords;
  List<dynamic>? creator;
  String? videoUrl;
  String? description;
  String? content;
  String? pubDate;
  String? imageUrl;
  String? sourceId;
  List<String>? country;
  List<String>? category;
  String? language;

  NewsObject(
      {this.title,
        this.link,
        this.keywords,
        this.creator,
        this.videoUrl,
        this.description,
        this.content,
        this.pubDate,
        this.imageUrl,
        this.sourceId,
        this.country,
        this.category,
        this.language});

  NewsObject.fromJson(Map<String, dynamic> json) {
    // Method which converts JSON to Objects
    title = json['title'];
    link = json['link'];
    keywords = json['keywords'];
    creator = json['creator'];
    videoUrl = json['video_url'];
    description = json['description'];
    content = json['content'];
    pubDate = json['pubDate'];
    imageUrl = json['image_url'];
    sourceId = json['source_id'];
    country = json['country'].cast<String>();
    category = json['category'].cast<String>();
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    // Method which converts Object to JSON
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['link'] = link;
    data['keywords'] = keywords;
    data['creator'] = creator;
    data['video_url'] = videoUrl;
    data['description'] = description;
    data['content'] = content;
    data['pubDate'] = pubDate;
    data['image_url'] = imageUrl;
    data['source_id'] = sourceId;
    data['country'] = country;
    data['category'] = category;
    data['language'] = language;
    return data;
  }
}