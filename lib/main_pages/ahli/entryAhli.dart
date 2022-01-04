import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/models/entryAhli.dart';
import 'package:flutter_test_login_register/provider/entryAhli_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EntryAhliScreen extends StatefulWidget {
  DocumentSnapshot docid;
  EntryAhliScreen({@required this.docid});

  @override
  _EntryAhliScreenState createState() => _EntryAhliScreenState();
}

class _EntryAhliScreenState extends State<EntryAhliScreen> {

  TextEditingController userName = TextEditingController();
  TextEditingController userIc = TextEditingController();
  TextEditingController userAddress = TextEditingController();
  TextEditingController userLat = TextEditingController();
  TextEditingController userLong = TextEditingController();
  TextEditingController userCompany = TextEditingController();
  TextEditingController userCompanyNo = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userJob = TextEditingController();
  TextEditingController userCawDPMM = TextEditingController();

  @override
  void initState() {
    userName = TextEditingController(text: widget.docid.get('Nama'));
    userIc = TextEditingController(text: widget.docid.get('Ic'));
    userAddress = TextEditingController(text: widget.docid.get('Alamat'));
    userLat = TextEditingController(text: widget.docid.get('Lat'));
    userLong = TextEditingController(text: widget.docid.get('Long'));
    userCompany = TextEditingController(text: widget.docid.get('Syarikat'));
    userCompanyNo = TextEditingController(text: widget.docid.get('No syarikat'));
    userEmail = TextEditingController(text: widget.docid.get('Emel'));
    userPhone = TextEditingController(text: widget.docid.get('Telefon'));
    userJob = TextEditingController(text: widget.docid.get('KerjaPendidikan'));
    userCawDPMM = TextEditingController(text: widget.docid.get('Caw DPMM'));
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
                              labelText: 'Nama',
                            ),
                            controller: userName,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'No. Kad Pengenalan',
                            ),
                            controller: userIc,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'No. Telefon',
                            ),
                            controller: userPhone,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Emel',
                            ),
                            controller: userEmail,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Ahli DPMM Cawangan Negeri',
                            ),
                            controller: userCawDPMM,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Pekerjaan/Tahap Pendidikan',
                            ),
                            controller: userJob,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Alamat',
                            ),
                            controller: userAddress,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Latitud',
                            ),
                            controller: userLat,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Longitud',
                            ),
                            controller: userLong,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Nama Syarikat (Jika ada)',
                            ),
                            controller: userCompany,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'No. Pendaftaran Syarikat (Jika ada)',
                            ),
                            controller: userCompanyNo,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if(userName.text.isNotEmpty && userIc.text.isNotEmpty && userAddress.text.isNotEmpty && userLat.text.isNotEmpty && userLong.text.isNotEmpty && userJob.text.isNotEmpty && userEmail.text.isNotEmpty && userPhone.text.isNotEmpty && userCawDPMM.text.isNotEmpty) {
                          widget.docid.reference.update({
                            'Alamat': userAddress.text,
                            'Lat': userLat.text,
                            'Long': userLong.text,
                            'Caw DPMM': userCawDPMM.text,
                            'Emel': userEmail.text,
                            'Ic': userIc.text,
                            'KerjaPendidikan': userJob.text,
                            'Nama': userName.text,
                            'No syarikat': userCompanyNo.text,
                            'Syarikat': userCompany.text,
                            'Telefon': userPhone.text,
                          });
                          Navigator.of(context).pop();
                        }else if(userName.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan nama ahli')));
                          Navigator.of(context).pop();
                        }else if (userIc.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan nombor kad pengenalan ahli')));
                        }else if (userAddress.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan alamat ahli')));
                        }else if (userLat.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan latitud alamat ahli')));
                        }else if (userLong.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan longitud alamat ahli')));
                        }else if (userJob.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan pekerjaan/tahap pendidikan ahli')));
                        }else if (userEmail.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan emel ahli')));
                        }else if (userPhone.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan nombor telefon ahli')));
                        }else if (userCawDPMM.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan ahli DPMM cawangan negeri')));
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
                    SizedBox(
                      height: 10.0,
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