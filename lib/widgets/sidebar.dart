import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/doctor/doctorlist.dart';
import 'package:flutter_test_login_register/root/root.dart';
import 'package:flutter_test_login_register/states/currentUser.dart';
import 'package:flutter_test_login_register/views/editProfile.dart';
import 'package:flutter_test_login_register/views/userQueries.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Sidebar extends StatefulWidget {

  // FirebaseAuth auth = FirebaseAuth.instance;

  // logOut() async {
  //   User user = auth.signOut() as User;
  // }

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {

  TextEditingController profileImageController = TextEditingController();

  File _fileProfileImage;

  final FirebaseAuth auth = FirebaseAuth.instance;

  Timer _timer;

  void _schedule() {
    _timer = Timer(Duration(seconds: 0), () {
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    // refresh();
    _schedule();



  }

  currentUser() {
    final User user = auth.currentUser;
    final uid = user.uid.toString();
    return uid;
  }

//   refresh() {
//     setState(() {
// //all the reload processes
//     });
//   }

  getUser() async {
    currentUser();
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser())
        .get()
        .then((DocumentSnapshot documentSnapshot){
      Map<String, dynamic> data = documentSnapshot.data();
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');

        profileImageController.text = data['profileImage'];

        // name = data['name'];
        // print(nameController.text);

      } else {
        print('Document does not exist on the database');
      }
    });

  }

  displayProfileImage() {

    // Future.delayed(const Duration(milliseconds: 2000), () {
    //   setState(() {
    //   });
    // });

    // SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {}));
    if (_fileProfileImage == null) {
      if (profileImageController.text.isEmpty) {
        return NetworkImage('https://www.pngkey.com/png/detail/950-9501315_katie-notopoulos-katienotopoulos-i-write-about-tech-user.png');

      } else {
        return NetworkImage(profileImageController.text);
      }
    } else {
      return FileImage(_fileProfileImage);
    }
  }


  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {



    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    // //
    // Future<DocumentSnapshot> getData = FirebaseFirestore.instance.collection("users").doc(_currentUser.getCurrentUser.email).get();

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    //show in firebase current user's email
    FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser.getCurrentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data();
        return Text(data['name'],);

      }
    });

    Size size = MediaQuery.of(context).size;

    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
        },

    child: MultiLevelDrawer(
            header: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Color(0xff0d47a1),

                        ),
                        accountEmail: FutureBuilder<DocumentSnapshot>(
                          future: users.doc(_currentUser.getCurrentUser.uid).get(),
                          builder:
                              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                            if (snapshot.hasError) {
                              return Text("Ralat telah berlaku");
                            }

                            if (snapshot.hasData && !snapshot.data.exists) {
                              return Text("Dokumen tidak wujud");
                            }

                            if (snapshot.connectionState == ConnectionState.done) {
                              Map<String, dynamic> data = snapshot.data.data();
                              return Text("${data['name']}", style: GoogleFonts.openSans(fontSize: 12),);
                            }

                            return Text("");
                          },
                        ),
                        currentAccountPicture: CircleAvatar(
                          radius: 100.0,
                          backgroundImage: displayProfileImage(),
                        )
                    ),
                  ],
                ),
              ),
            ),
            children: [
              MLMenuItem(
                  leading: Icon(Icons.person, color: Colors.red, size: 18,),
                  content: Text(
                      " Profil", style: GoogleFonts.openSans(color: Color(0xff0d47a1), fontSize: 12)
                  ),
                  onClick: (){
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: EditProfile(),
                      ),
                    ).then((value) => setState(() {}));
                  }),
              MLMenuItem(
                  leading: Icon(Icons.add_business_rounded, color: Colors.red, size: 18,),
                  trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.red, size: 18,),
                  subMenuItems: [
                    MLSubmenu(submenuContent: Text(
                        "Certificate of Origin", style: GoogleFonts.openSans(color: Color(0xff0d47a1), fontSize: 12)
                    ),
                        onClick: (){
                          Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: Doctor_List()),);
                        }),
                  ],
                  content: Text(
                      " Servis Kami", style: GoogleFonts.openSans(color: Color(0xff0d47a1), fontSize: 12)
                  ),
                  ),
              // MLMenuItem(
              //     leading: Icon(Icons.chat_bubble_outline_outlined, color: Colors.red, size: 18,),
              //     content: Text(
              //         " Messaging", style: GoogleFonts.openSans(color: Color(0xff0d47a1), fontSize: 12)
              //     ),
              //     onClick: (){
              //       Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ChatBottomBar()),);
              //     }),
              MLMenuItem(
                leading: Icon(Icons.money_rounded, color: Colors.red, size: 18,),
                trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.red, size: 18,),
                subMenuItems: [
                  MLSubmenu(submenuContent: Text(
                      "Wakaf Ekonomi", style: GoogleFonts.openSans(color: Color(0xff0d47a1), fontSize: 12)
                  ),
                      onClick: (){
                        const url = 'https://app.senangpay.my/shop/wakafekonomi';
                        launchURL(url);
                      }),
                  MLSubmenu(submenuContent: Text(
                      "Cenderahati DPMM", style: GoogleFonts.openSans(color: Color(0xff0d47a1), fontSize: 12)
                  ),
                      onClick: (){
                        const url = 'https://app.senangpay.my/shop/cenderahati';
                        launchURL(url);
                      }),
                ],
                content: Text(
                    " Pembayaran", style: GoogleFonts.openSans(color: Color(0xff0d47a1), fontSize: 12)
                ),
              ),
              MLMenuItem(
                leading: Icon(Icons.ad_units_rounded, color: Colors.red, size: 18,),
                trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.red, size: 18,),
                subMenuItems: [
                  MLSubmenu(submenuContent: Text(
                      "Facebook DPMM", style: GoogleFonts.openSans(color: Color(0xff0d47a1), fontSize: 12)
                  ),
                      onClick: (){
                        const url = 'https://www.facebook.com/dpmm.org.my/';
                        launchURL(url);
                      }),
                  MLSubmenu(submenuContent: Text(
                      "YouTube DPMM", style: GoogleFonts.openSans(color: Color(0xff0d47a1), fontSize: 12)
                  ),
                      onClick: (){
                        const url = 'https://www.youtube.com/channel/UC8VtWHFzDxMb7K1VYj-mpEA';
                        launchURL(url);
                      }),
                ],
                content: Text(
                    " Media Sosial DPMM", style: GoogleFonts.openSans(color: Color(0xff0d47a1), fontSize: 12)
                ),
              ),
              MLMenuItem(
                  leading: Icon(Icons.question_answer_rounded, color: Colors.red, size: 18,),
                  content: Text(
                      " Cadangan/Pertanyaan", style: GoogleFonts.openSans(color: Color(0xff0d47a1), fontSize: 12)
                  ),
                  onClick: (){
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: userQueries(),
                      ),
                    ).then((value) => setState(() {}));

                  }),
              MLMenuItem(
                  leading: Icon(Icons.logout, color: Colors.red, size: 18,),
                  content: Text(
                      " Log Keluar", style: GoogleFonts.openSans(color: Color(0xff0d47a1), fontSize: 12)
                  ),
                  onClick: () async {
                    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
                    String _returnString = await _currentUser.signOut();
                    if(_returnString == "success"){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OurRoot()), (route) => false);
                    };
                  }),

            ],
          ),
    );



    // final loginProvider = Provider.of<AuthServices>(context);
    // return Drawer(
    //   child:
    //   ListView(
    //     padding: EdgeInsets.zero,
    //     children: [
    //
    //
    //       //Fetch data and show in list
    //
    //       // StreamBuilder<QuerySnapshot>(
    //       //   stream: FirebaseFirestore.instance.collection('users').snapshots(),
    //       //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
    //       //     if(snapshot.hasError){
    //       //       return Text(snapshot.error);
    //       //     }
    //       //
    //       //     switch (snapshot.connectionState){
    //       //       case ConnectionState.waiting : return Center(child: CircularProgressIndicator());
    //       //       default : return ListView(
    //       //         shrinkWrap: true,
    //       //         children: snapshot.data.docs.map((DocumentSnapshot document) {
    //       //
    //       //           return Text(document['email']);
    //       //
    //       //         }).toList(),
    //       //       );
    //       //     }
    //       //   },
    //       //
    //       // ),
    //
    //       UserAccountsDrawerHeader(
    //         decoration: BoxDecoration(
    //             color: Color(0xff0d47a1),
    //             borderRadius: BorderRadius.only(
    //                 bottomLeft: Radius.circular(20),
    //                 bottomRight: Radius.circular(20)
    //             ),
    //
    //         ),
    //         accountEmail: FutureBuilder<DocumentSnapshot>(
    //           future: users.doc(_currentUser.getCurrentUser.uid).get(),
    //           builder:
    //               (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //
    //             if (snapshot.hasError) {
    //               return Text("Ralat telah berlaku");
    //             }
    //
    //             if (snapshot.hasData && !snapshot.data.exists) {
    //               return Text("Dokumen tidak wujud");
    //             }
    //
    //             if (snapshot.connectionState == ConnectionState.done) {
    //               Map<String, dynamic> data = snapshot.data.data();
    //               return Text("Emel: ${data['email']}", style: GoogleFonts.openSans(),);
    //             }
    //
    //             return Text("");
    //           },
    //         ),
    //         currentAccountPicture: CircleAvatar(
    //           radius: 100.0,
    //           backgroundImage: displayProfileImage(),
    //         )
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.person, color: Colors.red,),
    //         title: Text('Profil', style: GoogleFonts.openSans(),),
    //         onTap: () {
    //           Navigator.push(
    //             context,
    //             PageTransition(
    //               type: PageTransitionType.rightToLeft,
    //               child: EditProfile(),
    //             ),
    //           ).then((value) => setState(() {}));
    //         },
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.add_business_rounded, color: Colors.red,),
    //         title: Text('Servis Kami', style: GoogleFonts.openSans(),),
    //         onTap: () {
    //           Navigator.push(
    //             context,
    //             PageTransition(
    //               type: PageTransitionType.rightToLeft,
    //               child: Speciality(),
    //             ),
    //           ).then((value) => setState(() {}));
    //         },
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.pin_drop, color: Colors.red,),
    //         title: Text("Lokasi Ahli-Ahli DPMM", style: GoogleFonts.openSans(),),
    //           onTap: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => ManualMapScreen()),
    //             ).then((value) => setState(() {}));
    //           },
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.money, color: Colors.red,),
    //         title: Text('Wakaf Ekonomi', style: GoogleFonts.openSans(),),
    //         onTap: () {
    //           // Navigator.push(
    //           //   context,
    //           //   MaterialPageRoute(builder: (context) => PaymentGatewayStripe()),
    //           // );
    //           const url = 'https://wakafbelia.mydpmms.com/product/wakaf-ekonomi/';
    //           launchURL(url);
    //         },
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.supervisor_account_sharp, color: Colors.red,),
    //         title: Text('Kenali Ahli-Ahli DPMM', style: GoogleFonts.openSans(),),
    //         onTap: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => Members()),
    //           ).then((value) => setState(() {}));
    //         },
    //       ),
    //       // ListTile(
    //       //   leading: Icon(Icons.card_membership),
    //       //   title: Text('Daftar Ahli'),
    //       //   onTap: () {
    //       //     // Navigator.push(
    //       //     //   context,
    //       //     //   MaterialPageRoute(builder: (context) => PaymentGatewayStripe()),
    //       //     // );
    //       //     const url = 'https://mydpmms.com/form_kelab.html';
    //       //     launchURL(url);
    //       //   },
    //       // ),
    //       Divider(),
    //       // FutureBuilder(
    //       //   future: _fetch(),
    //       //   builder: (context, snapshot) {
    //       //     if(snapshot.connectionState != ConnectionState.done)
    //       //       return Text("$Email");
    //       //   },
    //       // ),
    //       FlatButton.icon(
    //         onPressed: () async {
    //           CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    //           String _returnString = await _currentUser.signOut();
    //           if(_returnString == "success"){
    //             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OurRoot()), (route) => false);
    //           }
    //
    //         },
    //         icon: Icon(Icons.logout, color: Colors.red,),
    //         label: Text("Log Keluar", style: GoogleFonts.openSans(),),
    //       ),
    //       SizedBox(height: 30,),
    //       Row(
    //         children: [
    //           Expanded(child: IconButton(
    //             icon: Icon(FontAwesomeIcons.facebook, color: Colors.blue,),
    //             onPressed: () {
    //               const url = 'https://www.facebook.com/dpmm.org.my/';
    //               launchURL(url);
    //             },
    //           ),),
    //           SizedBox(width: 5,),
    //           Expanded(child: IconButton(
    //             icon: Icon(FontAwesomeIcons.instagram, color: Colors.red,),
    //             onPressed: () {
    //               const url = 'https://www.instagram.com/dpmm.official/';
    //               launchURL(url);
    //             },
    //           ),),
    //           SizedBox(width: 5,),
    //           Expanded(child: IconButton(
    //             icon: Icon(FontAwesomeIcons.twitter, color: Colors.lightBlueAccent,),
    //             onPressed: () {
    //               const url = 'https://twitter.com/DewanMelayu';
    //               launchURL(url);
    //             },
    //           ),),
    //           SizedBox(width: 5,),
    //           Expanded(child: IconButton(
    //             icon: Icon(FontAwesomeIcons.youtube, color: Colors.red,),
    //             onPressed: () {
    //               const url = 'https://www.youtube.com/channel/UC8VtWHFzDxMb7K1VYj-mpEA';
    //               launchURL(url);
    //             },
    //           ),),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
  void moveToLastScreen() {
    Navigator.pop(context);
  }
}

// _fetch() async {
//   String Email;
//   final User = await FirebaseAuth.instance.currentUser;
//   if(User!=null)
//     await FirebaseFirestore.instance
//       .collection('users')
//       .doc(User.uid)
//       .get()
//       .then((ds){
//         Email = ds.data()['email'];
//     });
//
//
// }