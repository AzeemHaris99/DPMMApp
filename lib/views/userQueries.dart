import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test_login_register/models/uModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class userQueries extends StatefulWidget {
  final UserModel user;

  const userQueries({Key key, this.user}) : super(key: key);

  @override
  _userQueries createState() => _userQueries();
}

class _userQueries extends State<userQueries> {
  TextEditingController queryName = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController query = new TextEditingController();
  Map Event;

  final FirebaseAuth auth = FirebaseAuth.instance;

  String _currentSelectedEvents;

  var _query = [
    "Aduan",
    "Cadangan",
    "Pertanyaan",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  addData() {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm:ss");

    String string = dateFormat.format(DateTime.now());

    Map<String, dynamic> demoData = {
      "Query Type": queryName.text,
      "User Name": name.text,
      "User Email": email.text,
      "User Query": query.text,
      "Query Sent": string,
    };
    if (queryName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila buat pilihan')));
    } else if (query.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila letakkan cadangan/pertanyaan')));
    } else {
      CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Query');

      collectionReference.add(demoData);

      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: Text('Mesej Berjaya Dihantar!'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Tutup')),
          ],
        ),
      );
    }
  }

  currentUser() {
    final User user = auth.currentUser;
    final uid = user.uid.toString();
    return uid;
  }

  getUser() async {
    currentUser();
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser()) //get the uid from currentUser() function
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data();
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');

        name.text = data['name'];
        email.text = data['email'];
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        elevation: 0.0,
        title: Text(
            'Cadangan/Pertanyaan',
            style: GoogleFonts.openSans(
              fontSize: 18.0,
              color: Color(0xff0d47a1),
              fontWeight: FontWeight.w500,
            )
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff0d47a1),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Theme(
          data: ThemeData(primaryColor: Color(0xff0d47a1)),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.fromSTEB(25, 30, 10, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding:
                            EdgeInsets.only(right: 20.0, left: 20.0, top: 1.0, bottom: 1.0),
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Color(0xff0d47a1)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text("Pilih"),
                                value: _currentSelectedEvents,
                                underline: SizedBox(),
                                isExpanded: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _currentSelectedEvents = newValue;
                                    queryName.text = _currentSelectedEvents;
                                  });
                                },
                                items: _query.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: name,
                            decoration: InputDecoration(labelText: 'Nama'),
                          ),
                          // onChanged: (val){
                          //   email = val;
                          //
                          // },
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: email,
                            decoration: InputDecoration(labelText: 'Emel'),
                            // onChanged: (val){
                            //   password = val;
                            //
                            // },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: query,
                            decoration: InputDecoration(labelText: 'Aduan/Cadangan/Pertanyaan'),
                            // onChanged: (val){
                            //   password = val;
                            //
                            // },
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        addData();


                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 30.0),
                        padding: EdgeInsets.all(15.0),
                        width: double.infinity,
                        color: Color(0xff0d47a1),
                        child: Text(
                          'Hantar',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}