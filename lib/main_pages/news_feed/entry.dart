import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/models/entry.dart';
import 'package:flutter_test_login_register/provider/entry_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EntryScreen extends StatefulWidget {
  DocumentSnapshot docid;
  EntryScreen({@required this.docid});

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    titleController = TextEditingController(text: widget.docid.get('newsTitle'));
    dateController = TextEditingController(text: widget.docid.get('newsDate'));
    linkController = TextEditingController(text: widget.docid.get('newsLink'));
    imageController = TextEditingController(text: widget.docid.get('newsImage'));
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
                              labelText: 'Tajuk Berita',
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
                              labelText: 'Tarikh Berita',
                            ),
                            controller: dateController,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Pautan Berita',
                            ),
                            controller: linkController,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if(imageController.text.isNotEmpty && titleController.text.isNotEmpty && dateController.text.isNotEmpty && linkController.text.isNotEmpty) {
                          widget.docid.reference.update({
                            'newsImage': imageController.text,
                            'newsTitle': titleController.text,
                            'newsDate': dateController.text,
                            'newsLink': linkController.text,
                          });
                          Navigator.of(context).pop();
                        }else if (imageController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan gambar berita')));
                        }else if (titleController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan tajuk berita')));
                        }else if (dateController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan tarikh berita')));
                        }else if (linkController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan pautan berita')));
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