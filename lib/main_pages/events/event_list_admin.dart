import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/main_pages/events/entryEvent.dart';
import 'package:flutter_test_login_register/models/entryEvent.dart';
import 'package:flutter_test_login_register/provider/entryEvent_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class EventListAdmin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryEventProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Event').orderBy('eventCreated', descending: true).snapshots(),
          builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),
              );
            }
            final listNews = snapshot.data.docs;
            return ListView.builder(
                itemCount: listNews.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing:
                    Icon(Icons.edit, color: Theme.of(context).accentColor),
                    title: Text(
                      listNews[index]['eventTitle'],
                      style: GoogleFonts.openSans(

                      ),
                    ),
                    subtitle: Text(
                      listNews[index]['eventFee'],
                      style: GoogleFonts.openSans(

                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: EntryEventScreen(docid: listNews[index])),);
                    },
                  );
                });
          }),
    );
  }
}
