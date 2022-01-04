import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileDetail extends StatefulWidget {
  DocumentSnapshot docid;
  ProfileDetail({@required this.docid});

  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  TextEditingController userName = TextEditingController();
  TextEditingController userIc = TextEditingController();
  TextEditingController userAddress = TextEditingController();
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color(0xff0d47a1)),
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
                            decoration: InputDecoration(
                              labelText: 'Nama',
                            ),
                            controller: userName,
                            readOnly: true,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'No. Kad Pengenalan',
                            ),
                            controller: userIc,
                            readOnly: true,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'No. Telefon',
                            ),
                            controller: userPhone,
                            readOnly: true,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Emel',
                            ),
                            controller: userEmail,
                            readOnly: true,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Ahli DPMM Cawangan Negeri',
                            ),
                            controller: userCawDPMM,
                            readOnly: true,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Pekerjaan/Tahap Pendidikan',
                            ),
                            controller: userJob,
                            readOnly: true,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Alamat',
                            ),
                            controller: userAddress,
                            readOnly: true,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Nama Syarikat',
                            ),
                            controller: userCompany,
                            readOnly: true,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'No. Pendaftaran Syarikat',
                            ),
                            controller: userCompanyNo,
                            readOnly: true,
                          ),
                        ],
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

