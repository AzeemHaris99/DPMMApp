import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/models/entryEvent.dart';
import 'package:flutter_test_login_register/provider/entryEvent_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EntryEventScreen extends StatefulWidget {
  DocumentSnapshot docid;
  EntryEventScreen({@required this.docid});

  @override
  _EntryEventScreenState createState() => _EntryEventScreenState();
}

class _EntryEventScreenState extends State<EntryEventScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController feeController = TextEditingController();

  @override
  void initState() {
    titleController = TextEditingController(text: widget.docid.get('eventTitle'));
    dateController = TextEditingController(text: widget.docid.get('eventDate'));
    linkController = TextEditingController(text: widget.docid.get('eventLink'));
    imageController = TextEditingController(text: widget.docid.get('eventImage'));
    feeController = TextEditingController(text: widget.docid.get('eventFee'));
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
                            decoration: InputDecoration(
                              labelText: 'Pautan Gambar',
                            ),
                            controller: imageController,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Tajuk Program',
                            ),
                            maxLines: 4,
                            minLines: 1,
                            controller: titleController,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Tarikh Program',
                            ),
                            controller: dateController,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Pautan Program',
                            ),
                            controller: linkController,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Yuran Program serta Terma & Syarat',
                            ),
                            controller: feeController,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if(imageController.text.isNotEmpty && titleController.text.isNotEmpty && dateController.text.isNotEmpty && linkController.text.isNotEmpty && feeController.text.isNotEmpty) {
                          widget.docid.reference.update({
                            'eventImage': imageController.text,
                            'eventTitle': titleController.text,
                            'eventDate': dateController.text,
                            'eventLink': linkController.text,
                            'eventFee': feeController.text,
                          });
                          Navigator.of(context).pop();
                        }else if (imageController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan gambar program')));
                        }else if (titleController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan tajuk program')));
                        }else if (dateController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan tarikh program')));
                        }else if (linkController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan pautan program')));
                        }else if (feeController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan yuran program')));
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
  void moveToLastScreen() {
    Navigator.pop(context);
  }

}