import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class addEventEntry extends StatefulWidget {
  DocumentSnapshot docid;
  addEventEntry({@required this.docid});

  @override
  _addEventEntry createState() => _addEventEntry();
}

class _addEventEntry extends State<addEventEntry> {
  CollectionReference ref = FirebaseFirestore.instance.collection('Event');

  TextEditingController eventImage = new TextEditingController();
  TextEditingController eventTitle = new TextEditingController();
  TextEditingController eventDate = new TextEditingController();
  TextEditingController eventLink = new TextEditingController();
  TextEditingController eventFee = new TextEditingController();
  Map Event;

  @override
  void initState() {
    eventImage.text = 'https://upload.wikimedia.org/wikipedia/commons/1/14/Dpmmnews.png';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        elevation: 0.0,
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
      body: SafeArea(
        child: Theme(
          data: ThemeData(primaryColor: Color(0xff0d47a1)),
          child: ListView(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: eventImage,
                            decoration: InputDecoration(labelText: 'Pautan Gambar (Jika Ada)'),
                          ),
                          // onChanged: (val){
                          //   email = val;
                          //
                          // },
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: eventTitle,
                            decoration: InputDecoration(labelText: 'Tajuk Program'),
                            // onChanged: (val){
                            //   password = val;
                            //
                            // },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: eventDate,
                            decoration: InputDecoration(labelText: 'Tarikh Program'),
                            // onChanged: (val){
                            //   password = val;
                            //
                            // },
                          ),
                          TextField(
                            controller: eventLink,
                            decoration: InputDecoration(labelText: 'Pautan Program'),
                            // onChanged: (val){
                            //   password = val;
                            //
                            // },
                          ),
                          TextField(
                            controller: eventFee,
                            decoration: InputDecoration(labelText: 'Yuran Program serta Terma & Syarat'),
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
                        if(eventImage.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan pautan gambar')));
                          Navigator.of(context).pop();
                        }else if (eventTitle.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan tajuk program')));
                        }else if (eventDate.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan tarikh program')));
                        }else if (eventLink.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan pautan program')));
                        }else if (eventFee.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan yuran program')));
                        } else {
                          ref.add({
                            'eventImage': eventImage.text,
                            'eventTitle': eventTitle.text,
                            'eventDate': eventDate.text,
                            'eventLink': eventLink.text,
                            'eventFee': eventFee.text,
                            'eventCreated':DateTime.now(),
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 30.0),
                        padding: EdgeInsets.all(15.0),
                        width: double.infinity,
                        color: Color(0xff0d47a1),
                        child: Text(
                          'Simpan',
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