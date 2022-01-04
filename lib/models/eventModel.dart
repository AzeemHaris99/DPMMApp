import 'package:flutter/cupertino.dart';

import '../utils.dart';

class TodoField{
  static const eventCreated = 'eventCreated';
}

class Todo {
  String id;
  String eventTitle;
  String eventDate;
  String eventLink;
  String eventImage;
  DateTime eventCreated;

  Todo({
    this.id,
    this.eventTitle,
    this.eventDate,
    this.eventLink,
    this.eventImage,
    @required this.eventCreated,
  });

  static Todo fromJson(Map<String, dynamic> json) => Todo(
    id: json['id'],
    eventTitle: json['eventTitle'],
    eventDate: json['eventDate'],
    eventLink: json['eventLink'],
    eventImage: json['eventImage'],
    eventCreated: Utils.toDateTime(json['eventCreated']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'eventTitle': eventTitle,
    'eventDate': eventDate,
    'eventLink': eventLink,
    'eventImage': eventImage,
    'eventCreated': Utils.fromDateTimeToJson(eventCreated)
  };

}