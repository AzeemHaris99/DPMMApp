import 'package:flutter/cupertino.dart';

import '../utils.dart';

class TodoField{
  static const newsCreated = 'newsCreated';
}

class Todo {
  String id;
  String newsTitle;
  String newsDate;
  String newsLink;
  String newsImage;
  DateTime newsCreated;

  Todo({
    this.id,
    this.newsTitle,
    this.newsDate,
    this.newsLink,
    this.newsImage,
    @required this.newsCreated,
  });

  static Todo fromJson(Map<String, dynamic> json) => Todo(
    id: json['id'],
    newsTitle: json['newsTitle'],
    newsDate: json['newsDate'],
    newsLink: json['newsLink'],
    newsImage: json['newsImage'],
    newsCreated: Utils.toDateTime(json['newsCreated']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'newsTitle': newsTitle,
    'newsDate': newsDate,
    'newsLink': newsLink,
    'newsImage': newsImage,
    'newsCreated': Utils.fromDateTimeToJson(newsCreated)
  };

}