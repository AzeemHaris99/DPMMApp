import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/utils.dart';

class EntryEventField {
  static const eventCreated = 'eventCreated';
}

class EntryEvent {

  final String id;
  final String eventDate;
  final String eventLink;
  final String eventImage;
  final String eventTitle;
  final DateTime eventCreated;

  EntryEvent({this.eventDate, this.eventLink, this.eventImage, this.eventTitle, @required this.eventCreated, @required this.id});

  factory EntryEvent.fromJson(Map<String, dynamic> json){
    return EntryEvent(
      eventDate: json['eventDate'],
      eventLink: json['eventLink'],
      eventImage: json['eventImage'],
      eventTitle: json['eventTitle'],
      id: json['id'],
      eventCreated: Utils.toDateTime(json['eventCreated']),
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'eventDate': eventDate,
      'eventLink':eventLink,
      'eventImage':eventImage,
      'eventTitle':eventTitle,
      'id':id,
      'eventCreated': Utils.fromDateTimeToJson(eventCreated)
    };
  }
}