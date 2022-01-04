import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/utils.dart';

class EntryField {
  static const newsCreated = 'newsCreated';
}

class Entry {

  final String id;
  final String newsDate;
  final String newsLink;
  final String newsImage;
  final String newsTitle;
  final DateTime newsCreated;

  Entry({this.newsDate, this.newsLink, this.newsImage, this.newsTitle, @required this.newsCreated, @required this.id});

  factory Entry.fromJson(Map<String, dynamic> json){
    return Entry(  
      newsDate: json['newsDate'],
      newsLink: json['newsLink'],
        newsImage: json['newsImage'],
        newsTitle: json['newsTitle'],
      id: json['id'],
        newsCreated: Utils.toDateTime(json['newsCreated']),
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'newsDate': newsDate,
      'newsLink':newsLink,
      'newsImage':newsImage,
      'newsTitle':newsTitle,
      'id':id,
      'newsCreated': Utils.fromDateTimeToJson(newsCreated)
    };
  }
}