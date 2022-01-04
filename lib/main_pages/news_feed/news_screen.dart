import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/main_pages/news_feed/news_list.dart';
import 'package:flutter_test_login_register/views/signin.dart';
import 'package:flutter_test_login_register/widgets/sidebar.dart';
import 'package:page_transition/page_transition.dart';

class NewsScreen extends StatelessWidget {

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
        child: NewsList(),
      ),
    );
  }
}
