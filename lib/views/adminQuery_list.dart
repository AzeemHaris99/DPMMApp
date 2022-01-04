import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/views/userQuery_detail.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class AdminQueryList extends StatefulWidget {
  @override
  _AdminQueryState createState() => _AdminQueryState();
}

class _AdminQueryState extends State<AdminQueryList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Query').orderBy('Query Sent', descending: true).snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),
            );
          }
          final listQuery = snapshot.data.docs;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: listQuery.length,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  child: Column(
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text(
                          listQuery[index]['User Query'],
                          style: GoogleFonts.openSans(

                          ),
                        ),
                        subtitle: Text(
                          listQuery[index]['Query Sent'],
                          style: GoogleFonts.openSans(

                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: UserQueryDetail(docid: listQuery[index])),);
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