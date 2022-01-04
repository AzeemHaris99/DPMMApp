import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/views/userEventRegister_detail.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class AdminEventRegisterList extends StatefulWidget {
  @override
  _AdminEventRegisterState createState() => _AdminEventRegisterState();
}

class _AdminEventRegisterState extends State<AdminEventRegisterList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Event Registration').orderBy('Event Register Timestamp', descending: true).snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),
            );
          }
          final listRegister = snapshot.data.docs;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: listRegister.length,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  child: Column(
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text(
                          listRegister[index]['Event Name'],
                          style: GoogleFonts.openSans(

                          ),
                        ),
                        subtitle: Text(
                          listRegister[index]['Event Register Timestamp'],
                          style: GoogleFonts.openSans(

                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: UserEventRegisterDetail(docid: listRegister[index])),);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}