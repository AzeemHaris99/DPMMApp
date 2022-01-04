import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/models/entry.dart';
import 'package:flutter_test_login_register/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class EntryProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _newsDate;
  String _newsLink;
  String _newsImage = 'https://upload.wikimedia.org/wikipedia/commons/1/14/Dpmmnews.png';
  String _newsTitle;
  DateTime _newsCreated;
  String _id;
  var uuid = Uuid();

  //Getters
  String get newsDate => _newsDate;
  String get newsLink => _newsLink;
  String get newsImage => 'https://upload.wikimedia.org/wikipedia/commons/1/14/Dpmmnews.png';
  String get newsTitle => _newsTitle;
  DateTime get newsCreated =>DateTime.now();
  Stream<List<Entry>> get entries => firestoreService.getEntries();

  //Setters
  set changeDate(String newsDate){
    _newsDate = newsDate;
    notifyListeners();
  }

  set changeLink(String newsLink){
    _newsLink = newsLink;
    notifyListeners();
  }

  set changeTitle(String newsTitle){
    _newsTitle = newsTitle;
    notifyListeners();
  }

  set changeImage(String newsImage){
    _newsImage = newsImage;
    notifyListeners();
  }

  //Functions
  loadAll(Entry entry){
    if (entry != null){
      _newsDate = entry.newsDate;
      _newsLink =entry.newsLink;
      _newsImage ='https://upload.wikimedia.org/wikipedia/commons/1/14/Dpmmnews.png';
      _newsTitle =entry.newsTitle;
      _newsCreated =DateTime.now();
      _id = entry.id;
    } else {

    }
  }

  saveEntry(){
    if (_id == null){
      //Add
      var newEntry = Entry(newsDate: _newsDate, newsLink: _newsLink, newsImage: _newsImage, newsTitle: _newsTitle, newsCreated: _newsCreated, id: uuid.v1());
      print(newEntry.newsTitle);
      print(newEntry.newsDate);
      print(newEntry.newsLink);
      print(newEntry.newsImage);
      print(newEntry.newsCreated);
      firestoreService.setEntry(newEntry);
    } else {
      //Edit
      var updatedEntry = Entry(newsDate: _newsDate, newsLink: _newsLink, newsImage: _newsImage, newsTitle: _newsTitle, newsCreated: _newsCreated, id: _id);
      firestoreService.setEntry(updatedEntry);
    }
  }

  removeEntry(String id){
    firestoreService.removeEntry(id);
  }

}