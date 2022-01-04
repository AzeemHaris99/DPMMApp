import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/main_pages/events/event_list.dart';
import 'package:flutter_test_login_register/views/eventRegistration.dart';
import 'package:flutter_test_login_register/widgets/sidebar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: EventList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: eventRegister(),
            ),
          );
          // Add your onPressed code here!
        },
        label: Text("Daftar Program Di Sini!", style: GoogleFonts.openSans(fontWeight: FontWeight.w500)),
        backgroundColor: Color(0xff0d47a1),
        foregroundColor: Colors.white,
      ),
    );
  }
}