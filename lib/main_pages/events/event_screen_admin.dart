import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/main_pages/events/addEvent_entry.dart';
import 'package:flutter_test_login_register/main_pages/events/event_list_admin.dart';
import 'package:page_transition/page_transition.dart';

class EventScreenAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: EventListAdmin(),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Color(0xff0d47a1),
        onPressed: () {
          Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: addEventEntry()),);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}