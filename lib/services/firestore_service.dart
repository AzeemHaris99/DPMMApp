import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test_login_register/models/entry.dart';

class FirestoreService {
    FirebaseFirestore _db = FirebaseFirestore.instance; 

    //Get Entries
    Stream<List<Entry>> getEntries(){
      return _db
        .collection('NewsFeed')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Entry.fromJson(doc.data()))
        .toList());
    }

    //Upsert
    Future<void> setEntry(Entry entry){
      var options = SetOptions(merge:true);

      return _db
        .collection('NewsFeed')
        .doc(entry.id)
        .set(entry.toMap(),options);
    }

    //Delete
    Future<void> removeEntry(String id){
      return _db
        .collection('NewsFeed')
        .doc(id)
        .delete();
    }

}