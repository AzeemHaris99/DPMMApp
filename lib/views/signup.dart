import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/states/currentUser.dart';
import 'package:flutter_test_login_register/views/signin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}



class _SignUpState extends State<SignUp> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  String name = "";
  String bio = "";
  String address = "";
  String dob = "";
  String job = "";

  void _signUpUser(String email, String password, BuildContext context, String phone, String name, String bio, String address, String dob, String job) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try{
      String _returnString = await _currentUser.signUpUser(email, password, phone, name, bio, address, dob, job);
      if(_returnString == "success"){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>SignIn()),
        );
      }else if (email.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan emel anda')));
      }else if (password.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan kata laluan anda')));
      }else if (phone.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan nombor telefon anda')));
      }
    }catch(e){
      print(e);
    }
  }

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
                            height: 20.0,
                          ),
                          Text(
                            'Selamat Datang,',
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold, fontSize: 30.0, color: Color(0xff0d47a1)),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                              'Daftar sekarang! Pelbagai manfaat menanti anda.',
                            style: GoogleFonts.openSans(
                              color: Color(0xff0d47a1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.fromSTEB(25, 1, 10, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
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
                          TextField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: _viewPassword,
                                  color: Colors.red,
                                ),
                                labelText: 'Kata Laluan'),
                            // onChanged: (val){
                            //   password = val;
                            //
                            // },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextField(
                            controller: _phoneController,
                            decoration: InputDecoration(labelText: 'No. Telefon'),
                          ),
                          // onChanged: (val){
                          //   email = val;
                          //
                          // },
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        // if(_formKey.currentState.validate()){
                        //   print("Email: ${_emailController.text}");
                        //   print("Password: ${_passwordController.text}");
                        //   await loginProvider.signIn(
                        //     _emailController.text.trim(),
                        //     _passwordController.text.trim(),
                        //   );
                        // }

                        // signIn();

                        _signUpUser(_emailController.text, _passwordController.text, context, _phoneController.text, name, bio, address, dob, job);


                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 30.0),
                        padding: EdgeInsets.all(15.0),
                        width: double.infinity,
                        color: Color(0xff0d47a1),
                        child: Text(
                          'Daftar',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'Telah mempunyai akaun?',
                            style: GoogleFonts.openSans(),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) => SignIn()));

                            },
                            child: Text(
                              'Log Masuk',
                              style: GoogleFonts.openSans(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700),
                            ),
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
}
