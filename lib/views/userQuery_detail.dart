import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserQueryDetail extends StatefulWidget {
  DocumentSnapshot docid;
  UserQueryDetail({@required this.docid});

  @override
  _UserQueryDetailState createState() => _UserQueryDetailState();
}

class _UserQueryDetailState extends State<UserQueryDetail> {
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userQuery = TextEditingController();

  @override
  void initState() {
    userName = TextEditingController(text: widget.docid.get('User Name'));
    userEmail = TextEditingController(text: widget.docid.get('User Email'));
    userQuery = TextEditingController(text: widget.docid.get('User Query'));
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
                labelText: 'Nama Pengguna',
              ),
              controller: userName,
              readOnly: true,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email Pengguna',
              ),
              controller: userEmail,
              readOnly: true,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Cadangan/Pertanyaan',
              ),
              maxLines: 4,
              minLines: 1,
              controller: userQuery,
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