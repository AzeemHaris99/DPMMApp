import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/main_pages/ahli/ahli_screen_admin.dart';
import 'package:flutter_test_login_register/main_pages/events/event_screen_admin.dart';
import 'package:flutter_test_login_register/main_pages/news_feed/news_screen_admin.dart';
import 'package:flutter_test_login_register/views/adminEventRegister_list.dart';
import 'package:flutter_test_login_register/views/adminQuery_list.dart';
import 'package:flutter_test_login_register/views/manual_mapscreenAdmin.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class NavScreenAdmin extends StatefulWidget {
  @override
  _NavScreenAdminState createState() => _NavScreenAdminState();
}

class _NavScreenAdminState extends State<NavScreenAdmin> {
  int _selectedIndex = 0;

  //Bottom navigation pages

  final _screens = [
    NewsScreenAdmin(),
    EventScreenAdmin(),
    AdminEventRegisterList(),
    AhliScreenAdmin(),
    AdminQueryList(),
    ManualMapScreenAdmin()
  ];

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
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
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Log Keluar',
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
          bottomNavigationBar: StyleProvider(
            style: Style(),
            child: ConvexAppBar(
              items: [
                TabItem(icon: Icons.web_outlined, title: 'Berita'),
                TabItem(icon: Icons.event, title: 'Program'),
                TabItem(icon: Icons.assignment_outlined, title: 'Pendaftaran'),
                TabItem(icon: Icons.people_alt_rounded, title: 'Ahli'),
                TabItem(icon: Icons.question_answer_rounded, title: 'Cadangan/Pertanyaan'),
                TabItem(icon: Icons.pin_drop, title: 'Ahli DPMM'),
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