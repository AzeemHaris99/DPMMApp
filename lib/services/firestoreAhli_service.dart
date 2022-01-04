import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test_login_register/models/entryAhli.dart';

class FirestoreAhliService {
    FirebaseFirestore _db = FirebaseFirestore.instance; 

    //Get Entries
    Stream<List<EntryAhli>> getEntries(){
      return _db
        .collection('ahliKelab list')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => EntryAhli.fromJson(doc.data()))
        .toList());
    }

    //Upsert
    Future<void> setEntryAhli(EntryAhli entryAhli){
      var options = SetOptions(merge:true);

      return _db
        .collection('ahliKelab list')
        .doc(entryAhli.id)
        .set(entryAhli.toMap(),options);
    }

    //Delete
    Future<void> removeEntryAhli(String id){
      return _db
        .collection('ahliKelab list')
        .doc(id)
        .delete();
    }

}