import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/main_pages/news_feed/addNews_entry.dart';
import 'package:flutter_test_login_register/main_pages/news_feed/news_list_admin.dart';
import 'package:page_transition/page_transition.dart';

class NewsScreenAdmin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.red,
      //   title: Text(
      //     'News Feed',
      //     style: TextStyle(
      //
      //     ),
      //   ),
      // ),
      // drawer: Sidebar(),
      body: Container(
        child: NewsListAdmin(),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Color(0xff0d47a1),
        onPressed: () {
          Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: addNewsEntry()),);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
