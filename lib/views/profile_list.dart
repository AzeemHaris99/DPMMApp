import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/views/profile_detail.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class ProfileList extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileList> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
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
                    return GestureDetector(
                      child: Column(
                        children: [
                          ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ProfileDetail(docid: data)),);
                            },
                          ),
                        ],
                      ),
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