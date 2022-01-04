import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test_login_register/main.dart';
import 'package:flutter_test_login_register/states/currentUser.dart';
import 'package:flutter_test_login_register/views/navScreen.dart';
import 'package:flutter_test_login_register/views/signin.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}

class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    //get the state, check current User, set AuthStatus based on state
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.onStartUp();
    if(_returnString == "success"){
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch(_authStatus){
      case AuthStatus.notLoggedIn:
        retVal = SignIn();
        break;
      case AuthStatus.loggedIn:
        retVal = NavScreen();
        break;
      default :
    }

    return retVal;
  }
}
