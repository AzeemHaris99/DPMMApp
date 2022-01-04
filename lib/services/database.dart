import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/models/userModel.dart';

class OurDatabase{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser userModel) async {
    String retVal = "error";

    try{
      await _firestore.collection("users").doc(userModel.uid).set({
        "email" : userModel.email,
        "phone": userModel.phone,
        "name": userModel.name,
        "bio": userModel.bio,
        "address": userModel.address,
        "dob": userModel.dob,
        "job": userModel.job,
        "accountCreated" : Timestamp.now(),
      });
      retVal = "success";


    } catch (e){
      print(e);
    }

    return retVal;

  }

}