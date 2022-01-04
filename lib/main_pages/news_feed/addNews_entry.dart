import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class addNewsEntry extends StatefulWidget {
  DocumentSnapshot docid;
  addNewsEntry({@required this.docid});

  @override
  _addNewsEntry createState() => _addNewsEntry();
}

class _addNewsEntry extends State<addNewsEntry> {
  CollectionReference ref = FirebaseFirestore.instance.collection('NewsFeed');

  TextEditingController newsImage = new TextEditingController();
  TextEditingController newsTitle = new TextEditingController();
  TextEditingController newsDate = new TextEditingController();
  TextEditingController newsLink = new TextEditingController();
  Map News;

  @override
  void initState() {
    newsImage.text = 'https://upload.wikimedia.org/wikipedia/commons/1/14/Dpmmnews.png';
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
                            controller: newsImage,
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
                            controller: newsTitle,
                            decoration: InputDecoration(labelText: 'Tajuk Berita'),
                            // onChanged: (val){
                            //   password = val;
                            //
                            // },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: newsDate,
                            decoration: InputDecoration(labelText: 'Tarikh Berita'),
                            // onChanged: (val){
                            //   password = val;
                            //
                            // },
                          ),
                          TextField(
                            controller: newsLink,
                            decoration: InputDecoration(labelText: 'Pautan Berita'),
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
                        if(newsImage.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan pautan gambar')));
                          Navigator.of(context).pop();
                        }else if (newsTitle.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan tajuk berita')));
                        }else if (newsDate.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan tarikh berita')));
                        }else if (newsLink.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan pautan berita')));
                        } else {
                          ref.add({
                            'newsImage': newsImage.text,
                            'newsTitle': newsTitle.text,
                            'newsDate': newsDate.text,
                            'newsLink': newsLink.text,
                            'newsCreated':DateTime.now(),
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