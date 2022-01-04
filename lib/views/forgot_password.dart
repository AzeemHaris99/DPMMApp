import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();

  String email='';
  var _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },

      child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xff0d47a1)),
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(
          Icons.arrow_back, color: Color(0xff0d47a1),),
          onPressed: () {
            moveToLastScreen();
          }
        ),
      ),
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
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
                        key: _formKey,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lupa Kata Laluan',
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold, fontSize: 30.0, color: Color(0xff0d47a1)),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                              'Masukkan emel anda. Anda akan menerima notifikasi melalui emel untuk menukar kata laluan.',
                            style: GoogleFonts.openSans(color: Color(0xff0d47a1)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(labelText: 'Emel'),
                          ),
                          // onChanged: (val){
                          //   email = val;
                          //
                          // },
                          SizedBox(
                            height: 20.0,
                          ),
                          MaterialButton(
                            onPressed: () {
                              if (_emailController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan emel anda')));
                              }else{
                                FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text).then((value) => print('Semak peti masuk emel anda'));

                                return showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    content: Text('Sila semak peti masuk emel anda', style: GoogleFonts.openSans(),),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Text('Tutup', style: GoogleFonts.openSans(),)
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 30.0),
                              padding: EdgeInsets.all(15.0),
                              width: double.infinity,
                              color: Color(0xff0d47a1),
                              child: Text(
                                  'Tukar Kata Laluan',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(color: Colors.white),

                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        if(_formKey.currentState.validate()){
                          FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) => print('Semak peti masuk emel anda'));

                          return showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              content: Text('Sila semak peti masuk emel anda', style: GoogleFonts.openSans(),),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text('Tutup', style: GoogleFonts.openSans(),)
                                ),
                              ],
                            ),
                          );



                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
  void moveToLastScreen() {
    Navigator.pop(context);
  }

}