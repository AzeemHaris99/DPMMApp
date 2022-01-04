import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test_login_register/models/uModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class eventRegister extends StatefulWidget {
  final UserModel user;

  const eventRegister({Key key, this.user}) : super(key: key);

  @override
  _eventRegister createState() => _eventRegister();
}

class _eventRegister extends State<eventRegister> {
  TextEditingController eventName = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  Map Event;

  final FirebaseAuth auth = FirebaseAuth.instance;

  String _currentSelectedEvents;

  var _events = [
    "Wacana EKONIAGA Siri 3",
    "TAK TAHU NAK BUAT KONTEN MARKETING",
    "Perjanjian Perdagangan Bebas",
    "Wacana EKONIAGA Siri 4",
    "CAVENEMEX",
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
      "Event Name": eventName.text,
      "Participant Name": name.text,
      "Participant Email": email.text,
      "Participant Phone Number": phoneNumber.text,
      "Event Register Timestamp": string,
    };
    if (eventName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila pilih program untuk mendaftar.')));
    } else {
      CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Event Registration');

      collectionReference.add(demoData);

      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: Text('Pendaftaran Berjaya!\n\n(NOTA: Jika program didaftar ialah program berbayar, sila tunggu pihak DPMM menghantar pautan platform pembayaran melalui emel)'),
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
        phoneNumber.text = data['phone'];
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
            'Daftar Program',
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
                                hint: Text("Pilih Program"),
                                value: _currentSelectedEvents,
                                underline: SizedBox(),
                                isExpanded: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _currentSelectedEvents = newValue;
                                    eventName.text = _currentSelectedEvents;
                                  });
                                },
                                items: _events.map((String value) {
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
                            controller: phoneNumber,
                            decoration: InputDecoration(labelText: 'Nombor Telefon'),
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
                          'Daftar',
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