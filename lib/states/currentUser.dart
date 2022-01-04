import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/models/userModel.dart';
import 'package:flutter_test_login_register/services/database.dart';

class CurrentUser extends ChangeNotifier{

  OurUser _currentUser = OurUser(); //Check userModel.dart

  OurUser get getCurrentUser => _currentUser;


  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";

    try{
      User _firebaseUser = await _auth.currentUser;
      _currentUser.uid = _firebaseUser.uid;
      _currentUser.email = _firebaseUser.email;
      retVal = "success";

    }catch(e){
      print(e);
    }

    return retVal;
  }

  //Sign out function

  Future<String> signOut() async {
    String retVal = "error";

    try{
      await _auth.signOut();
      _currentUser = OurUser(); //Check userModel.dart
      retVal = "success";

    }catch(e){
      print(e);
    }

    return retVal;
  }

  //Sign Up function

  Future<String> signUpUser (String email, String password, String phone, String name, String bio, String address, String dob, String job) async{
    String retVal = "error";

    OurUser _ourUser = OurUser(); //Check userModel.dart

    try{

      User _user = (await _auth.
      createUserWithEmailAndPassword(email: email, password: password))
          .user;
      _ourUser.uid = _user.uid;
      _ourUser.email = _user.email;
      _ourUser.phone = phone;
      _ourUser.name = name;
      _ourUser.bio = bio;
      _ourUser.address = address;
      _ourUser.dob = dob;
      _ourUser.job = job;

      String _returnString = await OurDatabase().createUser(_ourUser); //Check database.dart
      if(_returnString == "success"){
        retVal = "success";
      }

      retVal = "success";

    }catch(e){
      retVal = e.message;

    }

    return retVal;
  }

  //Log in function

  Future<String> loginUser (String email, String password) async{

    String retVal = "error";

    try{

      User _user = (await _auth.
      signInWithEmailAndPassword(email: email, password: password))
          .user;

      _currentUser.uid = _user.uid;
      _currentUser.email = _user.email;
      retVal = "success";

    }catch(e){
      retVal = e.message;
    }

    return retVal;

  }

}