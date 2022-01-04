import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/main_pages/events/event_ui.dart';

class EventList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Event').orderBy('eventCreated', descending: true).snapshots(),
        builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),
            );
          }
          final listNews = snapshot.data?.docs;
          return ListView.builder(
            itemCount: listNews?.length,
            itemBuilder: (ctx, index) =>
                EventUI(
                  listNews[index]['eventTitle'],
                  listNews[index]['eventDate'],
                  listNews[index]['eventLink'],
                  listNews[index]['eventImage'],
                  listNews[index]['eventFee'],
                ),
          );
        },
      ),
    );
  }
}
