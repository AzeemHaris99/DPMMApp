import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/main_pages/ahli/entryAhli.dart';
import 'package:flutter_test_login_register/main_pages/news_feed/news_ui.dart';
import 'package:flutter_test_login_register/models/entryAhli.dart';
import 'package:flutter_test_login_register/provider/entryAhli_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AhliListAdmin extends StatefulWidget {
  @override
  _AhliListAdminState createState() => _AhliListAdminState();
}

class _AhliListAdminState extends State<AhliListAdmin> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Card(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded, color: Colors.red,), hintText: 'Cari...'),
              onChanged: (val) => initiateSearch(val),
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: (name != "" && name != null)
                ? FirebaseFirestore.instance.collection('ahliKelab list').where('Nama', isGreaterThanOrEqualTo: name).orderBy('Nama').startAt([name,]).endAt([name+'\uf8ff',]).snapshots()
                : FirebaseFirestore.instance.collection('ahliKelab list').orderBy('Nama', descending: false).snapshots(),
            builder: (ctx, snapshot) {
              return (snapshot.connectionState == ConnectionState.waiting)
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.docs[index];
                    return ListTile(
                      trailing:
                      Icon(Icons.edit, color: Theme.of(context).accentColor),
                      title: Text(
                        data['Nama'],
                        style: GoogleFonts.openSans(

                        ),
                      ),
                      subtitle: Text(
                        data['Emel'],
                        style: GoogleFonts.openSans(

                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: EntryAhliScreen(docid: data)),);
                      },
                    );
                  }
              );
            }
        )
    );
  }

  void initiateSearch(String val) {
    setState(() {
      name = val.toLowerCase().trim();
    });
  }
}
