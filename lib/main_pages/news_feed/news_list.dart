import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/main_pages/news_feed/news_ui.dart';

class NewsList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('NewsFeed').orderBy('newsCreated', descending: true).snapshots(),
        builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),
            );
          }
          final listNews = snapshot.data?.docs;
          return ListView.builder(
            itemCount: listNews?.length,
              itemBuilder: (ctx, index) =>
                  NewsUI(
                    listNews[index]['newsTitle'],
                    listNews[index]['newsDate'],
                    listNews[index]['newsLink'],
                    listNews[index]['newsImage'],
                  ),
          );
        },
      ),
    );
  }
}
