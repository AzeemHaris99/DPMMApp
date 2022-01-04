import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test_login_register/models/entryEvent.dart';

class FirestoreEventService {
    FirebaseFirestore _db = FirebaseFirestore.instance; 

    //Get Entries
    Stream<List<EntryEvent>> getEntries(){
      return _db
        .collection('Event')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => EntryEvent.fromJson(doc.data()))
        .toList());
    }

    //Upsert
    Future<void> setEntryEvent(EntryEvent entryEvent){
      var options = SetOptions(merge:true);

      return _db
        .collection('Event')
        .doc(entryEvent.id)
        .set(entryEvent.toMap(),options);
    }

    //Delete
    Future<void> removeEntryEvent(String id){
      return _db
        .collection('Event')
        .doc(id)
        .delete();
    }

}