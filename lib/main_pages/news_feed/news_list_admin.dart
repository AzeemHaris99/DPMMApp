import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/main_pages/news_feed/entry.dart';
import 'package:flutter_test_login_register/main_pages/news_feed/news_ui.dart';
import 'package:flutter_test_login_register/models/entry.dart';
import 'package:flutter_test_login_register/provider/entry_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class NewsListAdmin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('NewsFeed').orderBy('newsCreated', descending: true).snapshots(),
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
                      listNews[index]['newsTitle'],
                      style: GoogleFonts.openSans(

                      ),
                    ),
                    subtitle: Text(
                      listNews[index]['newsDate'],
                      style: GoogleFonts.openSans(

                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: EntryScreen(docid: listNews[index])),);
                    },
                  );
                });
          }),
    );
  }
}
