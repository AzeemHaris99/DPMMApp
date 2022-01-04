import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserEventRegisterDetail extends StatefulWidget {
  DocumentSnapshot docid;
  UserEventRegisterDetail({@required this.docid});

  @override
  _UserEventRegisterDetailState createState() => _UserEventRegisterDetailState();
}

class _UserEventRegisterDetailState extends State<UserEventRegisterDetail> {
  TextEditingController eventName = TextEditingController();
  TextEditingController participantName = TextEditingController();
  TextEditingController participantEmail = TextEditingController();
  TextEditingController participantNumber = TextEditingController();

  @override
  void initState() {
    eventName = TextEditingController(text: widget.docid.get('Event Name'));
    participantName = TextEditingController(text: widget.docid.get('Participant Name'));
    participantEmail = TextEditingController(text: widget.docid.get('Participant Email'));
    participantNumber = TextEditingController(text: widget.docid.get('Participant Phone Number'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xff0d47a1)),
        actions: [
          MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                moveToLastScreen();
              });
            },
            child: Icon(Icons.delete_rounded, color: Colors.red,),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 30),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nama Program',
              ),
              controller: eventName,
              readOnly: true,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nama Pendaftar',
              ),
              controller: participantName,
              readOnly: true,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email Pendaftar',
              ),
              controller: participantEmail,
              readOnly: true,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nombor Telefon Pendaftar',
              ),
              controller: participantNumber,
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
  void moveToLastScreen() {
    Navigator.pop(context);
  }
}