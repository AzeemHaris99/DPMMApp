import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/views/navScreen.dart';
import 'package:flutter_test_login_register/views/signin.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user != null){
      return NavScreen();
    }else {
      return SignIn();
    }
  }
}