import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test_login_register/main.dart';
import 'package:flutter_test_login_register/main_pages/events/event_screen.dart';
import 'package:flutter_test_login_register/main_pages/news_feed/news_screen.dart';
import 'package:flutter_test_login_register/main_pages/volunteers/volunteer_screen.dart';
import 'package:flutter_test_login_register/views/manual_mapscreen.dart';
import 'package:flutter_test_login_register/views/profile_list.dart';
import 'package:flutter_test_login_register/views/signin_admin.dart';
import 'package:flutter_test_login_register/widgets/sidebar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';


class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;

  //Bottom navigation pages

  final _screens = [
    NewsScreen(),
    EventScreen(),
    VolunteerScreen(),
    ProfileList(),
    ManualMapScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xff0d47a1)),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'lib/assets/Logo_Dewan_Perniagaan_Melayu_Malaysia.png',
              height: 150.0,
              width: 150.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: SignInAdmin(),
                  ),
                ).then((value) => setState(() {}));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Admin',
                    style: GoogleFonts.openSans(
                        fontSize: 14.0, color: Color(0xff0d47a1)
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      drawer: Sidebar(),
      bottomNavigationBar: StyleProvider(
        style: Style(),
        child: ConvexAppBar(
          items: [
            TabItem(icon: Icons.web_outlined, title: 'Berita'),
            TabItem(icon: Icons.event, title: 'Program'),
            TabItem(icon: Icons.assignment_outlined, title: 'Soal Selidik'),
            TabItem(icon: Icons.people_alt_rounded, title: 'Senarai Ahli'),
            TabItem(icon: Icons.pin_drop, title: 'Cawangan DPMM'),
          ],
          initialActiveIndex: _selectedIndex,
          height: 50,
          top: -30,
          curveSize: 100,
          curve: Curves.easeInCirc,
          onTap: (i) => setState(() => _selectedIndex = i),
          backgroundColor: Color(0xff0d47a1),
          elevation: 0.0,
        ),
      ),
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 30;

  @override
  double get activeIconMargin => 15;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 10.0, color: Colors.white);
  }
}