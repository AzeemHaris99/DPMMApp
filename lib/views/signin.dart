import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/states/currentUser.dart';
import 'package:flutter_test_login_register/views/forgot_password.dart';
import 'package:flutter_test_login_register/views/navScreen.dart';
import 'package:flutter_test_login_register/views/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}


class _SignInState extends State<SignIn> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  bool _obscureText = true;

  void _loginUser(String email, String password, BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    
    try{
      String _returnString = await _currentUser.loginUser(email, password);
      if(_returnString == "success"){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>NavScreen()), //Check navScreen.dart
        );
      }else if (email.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan emel anda')));
      }else if (password.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan kata laluan anda')));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Emel atau kata laluan anda tidak sah')));
      }
      
    }catch(e){
      print(e);
      
    }
    
  }

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
                            'Selamat Kembali,',
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
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(30.0),
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
                          SizedBox(
                            height: 20.0,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ForgotPassword()),);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                    'Lupa Kata Laluan?',
                                  style: GoogleFonts.openSans(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
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

                        _loginUser(_emailController.text, _passwordController.text, context);


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
                    Container(
                      padding: EdgeInsets.all(40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'Pengguna baharu?',
                            style: GoogleFonts.openSans(),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) => SignUp()));

                              },
                            child: Text(
                              'Daftar',
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


