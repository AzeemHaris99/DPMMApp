import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/models/entryEvent.dart';
import 'package:flutter_test_login_register/services/firestoreEvent_service.dart';
import 'package:uuid/uuid.dart';

class EntryEventProvider with ChangeNotifier {
  final firestoreService = FirestoreEventService();
  String _eventDate;
  String _eventLink;
  String _eventImage = 'https://upload.wikimedia.org/wikipedia/commons/1/14/Dpmmnews.png';
  String _eventTitle;
  DateTime _eventCreated;
  String _id;
  var uuid = Uuid();

  //Getters
  String get eventDate => _eventDate;
  String get eventLink => _eventLink;
  String get eventImage => 'https://upload.wikimedia.org/wikipedia/commons/1/14/Dpmmnews.png';
  String get eventTitle => _eventTitle;
  DateTime get eventCreated =>DateTime.now();
  Stream<List<EntryEvent>> get entries => firestoreService.getEntries();

  //Setters
  set changeDate(String eventDate){
    _eventDate = eventDate;
    notifyListeners();
  }

  set changeLink(String eventLink){
    _eventLink = eventLink;
    notifyListeners();
  }

  set changeTitle(String eventTitle){
    _eventTitle = eventTitle;
    notifyListeners();
  }

  set changeImage(String eventImage){
    _eventImage = eventImage;
    notifyListeners();
  }

  //Functions
  loadAll(EntryEvent entryEvent){
    if (entryEvent != null){
      _eventDate = entryEvent.eventDate;
      _eventLink =entryEvent.eventLink;
      _eventImage ='https://upload.wikimedia.org/wikipedia/commons/1/14/Dpmmnews.png';
      _eventTitle =entryEvent.eventTitle;
      _eventCreated =DateTime.now();
      _id = entryEvent.id;
    } else {

    }
  }

  saveEntryEvent(){
    if (_id == null){
      //Add
      var newEntryEvent = EntryEvent(eventDate: _eventDate, eventLink: _eventLink, eventImage: _eventImage, eventTitle: _eventTitle, eventCreated: _eventCreated, id: uuid.v1());
      print(newEntryEvent.eventTitle);
      print(newEntryEvent.eventDate);
      print(newEntryEvent.eventLink);
      print(newEntryEvent.eventImage);
      print(newEntryEvent.eventCreated);
      firestoreService.setEntryEvent(newEntryEvent);
    } else {
      //Edit
      var updatedEntryEvent = EntryEvent(eventDate: _eventDate, eventLink: _eventLink, eventImage: _eventImage, eventTitle: _eventTitle, eventCreated: _eventCreated, id: _id);
      firestoreService.setEntryEvent(updatedEntryEvent);
    }
  }

  removeEntryEvent(String id){
    firestoreService.removeEntryEvent(id);
  }

}