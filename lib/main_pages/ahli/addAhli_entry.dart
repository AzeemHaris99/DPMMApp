import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class addAhliEntry extends StatefulWidget {
  DocumentSnapshot docid;
  addAhliEntry({@required this.docid});

  @override
  _addAhliEntry createState() => _addAhliEntry();
}

class _addAhliEntry extends State<addAhliEntry> {
  CollectionReference ref = FirebaseFirestore.instance.collection('ahliKelab list');

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
  Map Ahli;

  @override
  void initState() {
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
      body: Container(
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
                            controller: userName,
                            decoration: InputDecoration(labelText: 'Nama'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: userIc,
                            decoration: InputDecoration(labelText: 'No. Kad Pengenalan'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: userPhone,
                            decoration: InputDecoration(labelText: 'No. Telefon'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: userEmail,
                            decoration: InputDecoration(labelText: 'Emel'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: userCawDPMM,
                            decoration: InputDecoration(labelText: 'Ahli DPMM Cawangan Negeri'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: userJob,
                            decoration: InputDecoration(labelText: 'Pekerjaan/Tahap Pendidikan'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: userAddress,
                            decoration: InputDecoration(labelText: 'Alamat'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: userLat,
                            decoration: InputDecoration(labelText: 'Latitud'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: userLong,
                            decoration: InputDecoration(labelText: 'Longitud'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: userCompany,
                            decoration: InputDecoration(labelText: 'Nama Syarikat (Jika ada)'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: userCompanyNo,
                            decoration: InputDecoration(labelText: 'No. Pendaftaran Syarikat (Jika ada)'),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        if(userName.text.isEmpty) {
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
                        } else {
                          ref.add({
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
}