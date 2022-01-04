import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/views/navScreen_admin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class SignInAdmin extends StatefulWidget {
  @override
  _SignInAdminState createState() => _SignInAdminState();
}


class _SignInAdminState extends State<SignInAdmin> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  bool _obscureText = true;

  void _viewPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        elevation: 0.0,
        title: Text(
            'Admin',
            style: GoogleFonts.openSans(
              fontSize: 18.0,
              color: Color(0xff0d47a1),
              fontWeight: FontWeight.w500,
            )
        ),
        centerTitle: true,
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
      backgroundColor: Colors.white,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/Logo_Dewan_Perniagaan_Melayu_Malaysia.png',
                            height: 70.0,
                            width: 200.0,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Selamat Kembali Admin,',
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold, fontSize: 30.0, color: Color(0xff0d47a1)),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                              'Log masuk untuk teruskan',
                            style: GoogleFonts.openSans(
                                color: Color(0xff0d47a1),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(labelText: 'Nama'),
                          ),
                          // onChanged: (val){
                          //   email = val;
                          //
                          // },
                          SizedBox(
                            height: 15.0,
                          ),
                          TextField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye, color: Colors.red,),
                                  onPressed: _viewPassword,
                                  color: Color(0xff0d47a1),
                                ),
                                labelText: 'Kata Laluan'),
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
                        // if(_formKey.currentState.validate()){
                        //   print("Email: ${_emailController.text}");
                        //   print("Password: ${_passwordController.text}");
                        //   await loginProvider.signIn(
                        //     _emailController.text.trim(),
                        //     _passwordController.text.trim(),
                        //   );
                        // }

                        // signIn();
                        if(_emailController.text == "admin" && _passwordController.text == "dpmm2021") {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: NavScreenAdmin(),
                            ),
                          ).then((value) => setState(() {}));
                        }else if(_emailController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan nama anda')));
                        }else if(_passwordController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan kata laluan anda')));
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Nama atau kata laluan anda tidak sah')));
                        }


                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 30.0),
                        padding: EdgeInsets.all(15.0),
                        width: double.infinity,
                        color: Color(0xff0d47a1),
                        child: Text(
                          'Log Masuk',
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


