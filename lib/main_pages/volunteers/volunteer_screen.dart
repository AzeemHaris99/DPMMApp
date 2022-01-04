import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/widgets/sidebar.dart';
import 'package:polls/polls.dart';

class VolunteerScreen extends StatefulWidget {
  @override
  _VolunteerScreenState createState() => _VolunteerScreenState();
}

class _VolunteerScreenState extends State<VolunteerScreen> {

  // @override
  // void initState() {
  //
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.red,
      //   title: Row(
      //     children: [
      //       Image.asset(
      //         'lib/assets/belia_selangor.png',
      //         height: 40.0,
      //         width: 40.0,
      //       ),
      //       SizedBox(width: 13,),
      //       Container(
      //         child: Text('Survey'),
      //       ),
      //     ],
      //   ),
      //   iconTheme: IconThemeData(color: Colors.white),
      //
      // ),
      // drawer: Sidebar(),
      body:

      ListView(
        padding: EdgeInsets.all(10),
        children: [
          survey1(),
          survey2(),
          survey3(),
          survey4(),
          survey5(),
          survey6(),
          survey7(),
          survey8(),
          survey9(),
          survey10(),
          survey11(),
          survey12(),
          survey13(),
          survey14(),
          survey15(),
          survey16(),
          survey17(),
          survey18(),
        ],
      ),
    );
  }

}



class survey1 extends StatefulWidget {
  @override
  _survey1State createState() => _survey1State();
}

class _survey1State extends State<survey1> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey1')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    // int getVote2() {
    //
    //   FirebaseFirestore.instance
    //       .collection('Survey')
    //       .doc('survey1')
    //       .get()
    //       .then((DocumentSnapshot documentSnapshot){
    //     Map<String, dynamic> data = documentSnapshot.data();
    //     if (documentSnapshot.exists) {
    //
    //       print(data['vote2']);
    //       dVote2 = data['vote2'];
    //       print(dVote2);
    //       // print("Vote: $vote");
    //
    //
    //     } else {
    //       print('Document does not exist on the database');
    //     }
    //   });
    //
    //
    //   return dVote2;
    //
    // }
    //
    // getVote();
    // getVote2();

    getTotalVote();


  }


  // int getVote() {
  //   int vote;
  //   FirebaseFirestore.instance
  //       .collection('Survey')
  //       .doc('survey1')
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot){
  //     Map<String, dynamic> data = documentSnapshot.data();
  //     if (documentSnapshot.exists) {
  //
  //       vote = data['vote1'];
  //       // print("Vote: $vote");
  //
  //
  //     } else {
  //       print('Document does not exist on the database');
  //     }
  //   });
  //
  //   return vote;
  //
  // }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;


  int voteA;
  int voteB;
  int totalVote;


  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
            width: 1000,
            height: 210,
            child: Polls(
              children: [
                // This cannot be less than 2, else will throw an exception
                Polls.options(title: 'a. Ya', value: option1),
                Polls.options(title: 'b. Tidak', value: option2),

              ],
              question: Text('1) Adakah anda bersetuju dengan keputusan kerajaan untuk melaksanakan PKP 3.0 dari 12 Mei hingga 7 Jun?'),
              currentUser: this.user,
              creatorID: this.creator,
              voteData: usersWhoVoted,
              userChoice: usersWhoVoted[this.user],
              onVoteBackgroundColor: Colors.red[200],
              leadingBackgroundColor: Colors.red[400],
              backgroundColor: Colors.white,
              outlineColor: Colors.red,
              onVote: (choice) {
                print(choice);
                setState(() {
                  this.usersWhoVoted[this.user] = choice;
                });
                if (choice == 1) {
                  setState(() {

                    option1 += 1.0;

                    // Future<String> getSpecie(String petId) async {
                    //   DocumentReference documentReference = petCollection.document(petId);
                    //   String specie;
                    //   await documentReference.get().then((snapshot) {
                    //     specie = snapshot['scout'].toString();
                    //   });
                    //   return specie;
                    // }




                    FirebaseFirestore.instance
                        .collection('Survey')
                        .doc('survey1')
                        .get()
                        .then((DocumentSnapshot documentSnapshot){
                      Map<String, dynamic> data = documentSnapshot.data();
                      if (documentSnapshot.exists) {

                        print(data['voteA']);
                        voteA = data['voteA'];
                        voteA += 1;

                        totalVote = data['totalVote'];
                        totalVote += 1;
                        print(voteA);
                        // print("Vote: $vote");

                        FirebaseFirestore.instance
                            .collection('Survey')
                            .doc('survey1')
                            .update({
                          'voteA' : voteA,
                        });



                        FirebaseFirestore.instance
                            .collection('Survey')
                            .doc('survey1')
                            .update({
                          'totalVote' : totalVote,
                        });


                      } else {
                        print('Document does not exist on the database');
                      }
                    });



                  });
                }
                if (choice == 2) {
                  setState(() {
                    option2 += 1.0;

                    FirebaseFirestore.instance
                        .collection('Survey')
                        .doc('survey1')
                        .get()
                        .then((DocumentSnapshot documentSnapshot){
                      Map<String, dynamic> data = documentSnapshot.data();
                      if (documentSnapshot.exists) {

                        print(data['voteB']);
                        voteB = data['voteB'];
                        voteB += 1;

                        totalVote = data['totalVote'];
                        totalVote += 1;
                        print(voteB);
                        // print("Vote: $vote");

                        FirebaseFirestore.instance
                            .collection('Survey')
                            .doc('survey1')
                            .update({
                          'voteB' : voteB,
                        });

                        FirebaseFirestore.instance
                            .collection('Survey')
                            .doc('survey1')
                            .update({
                          'totalVote' : totalVote,
                        });


                      } else {
                        print('Document does not exist on the database');
                      }
                    });

                  });
                }
              },
            ),
          ),

          Text('Jumlah Responden: $totalVote'),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}



class survey2 extends StatefulWidget {
  @override
  _survey2State createState() => _survey2State();
}

class _survey2State extends State<survey2> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey2')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          option3 += data['voteC'];
          option4 += data['voteD'];
          option5 += data['voteE'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    getTotalVote();


  }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;
  double option3 = 0.0;
  double option4 = 0.0;
  double option5 = 0.0;

  int voteA;
  int voteB;
  int voteC;
  int voteD;
  int voteE;
  int totalVote;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
            width: 1000,
            height: 301,
            child: Polls(
              children: [
                // This cannot be less than 2, else will throw an exception
                Polls.options(title: 'a. Tiada perbezaan', value: option1),
                Polls.options(title: 'b. Perniagaan jatuh 25%', value: option2),
                Polls.options(title: 'c. Perniagaan jatuh 50%', value: option3),
                Polls.options(title: 'd. Perniagaan jatuh 75%', value: option4),
                Polls.options(title: 'e. Perniagaan jatuh 100%', value: option5),
              ],
              question: Text('2) Apa yang anda harapkan prestasi perniagaan anda dengan pelaksanaan PKP'
                  ' 3.0 berbanding dengan keadaan sebelumnya PKP 2.0?'),
              currentUser: this.user,
              creatorID: this.creator,
              voteData: usersWhoVoted,
              userChoice: usersWhoVoted[this.user],
              onVoteBackgroundColor: Colors.red[200],
              leadingBackgroundColor: Colors.red[400],
              backgroundColor: Colors.white,
              outlineColor: Colors.red,
              onVote: (choice) {
                print(choice);
                setState(() {
                  this.usersWhoVoted[this.user] = choice;
                });
                if (choice == 1) {
                  setState(() {
                    option1 += 1.0;

                    FirebaseFirestore.instance
                        .collection('Survey')
                        .doc('survey2')
                        .get()
                        .then((DocumentSnapshot documentSnapshot){
                      Map<String, dynamic> data = documentSnapshot.data();
                      if (documentSnapshot.exists) {

                        print(data['voteA']);
                        voteA = data['voteA'];
                        voteA += 1;

                        totalVote = data['totalVote'];
                        totalVote += 1;
                        print(voteA);
                        // print("Vote: $vote");

                        FirebaseFirestore.instance
                            .collection('Survey')
                            .doc('survey2')
                            .update({
                          'voteA' : voteA,
                        });

                        FirebaseFirestore.instance
                            .collection('Survey')
                            .doc('survey2')
                            .update({
                          'totalVote' : totalVote,
                        });


                      } else {
                        print('Document does not exist on the database');
                      }
                    });
                  });
                }
                if (choice == 2) {
                  setState(() {
                    option2 += 1.0;

                    FirebaseFirestore.instance
                        .collection('Survey')
                        .doc('survey2')
                        .get()
                        .then((DocumentSnapshot documentSnapshot){
                      Map<String, dynamic> data = documentSnapshot.data();
                      if (documentSnapshot.exists) {

                        print(data['voteB']);
                        voteB = data['voteB'];
                        voteB += 1;

                        totalVote = data['totalVote'];
                        totalVote += 1;
                        print(voteB);
                        // print("Vote: $vote");

                        FirebaseFirestore.instance
                            .collection('Survey')
                            .doc('survey2')
                            .update({
                          'voteB' : voteB,
                        });

                        FirebaseFirestore.instance
                            .collection('Survey')
                            .doc('survey2')
                            .update({
                          'totalVote' : totalVote,
                        });


                      } else {
                        print('Document does not exist on the database');
                      }
                    });
                  });
                }
                if (choice == 3) {
                  setState(() {
                    option3 += 1.0;

                    FirebaseFirestore.instance
                        .collection('Survey')
                        .doc('survey2')
                        .get()
                        .then((DocumentSnapshot documentSnapshot){
                      Map<String, dynamic> data = documentSnapshot.data();
                      if (documentSnapshot.exists) {

                        print(data['voteC']);
                        voteC = data['voteC'];
                        voteC += 1;

                        totalVote = data['totalVote'];
                        totalVote += 1;
                        print(voteC);
                        // print("Vote: $vote");

                        FirebaseFirestore.instance
                            .collection('Survey')
                            .doc('survey2')
                            .update({
                          'voteC' : voteC,
                        });

                        FirebaseFirestore.instance
                            .collection('Survey')
                            .doc('survey2')
                            .update({
                          'totalVote' : totalVote,
                        });


                      } else {
                        print('Document does not exist on the database');
                      }
                    });
                  });
                }
                if (choice == 4) {
                  setState(() {
                    option4 += 1.0;

                    FirebaseFirestore.instance
                        .collection('Survey')
                        .doc('survey2')
                        .get()
                        .then((DocumentSnapshot documentSnapshot){
                      Map<String, dynamic> data = documentSnapshot.data();
                      if (documentSnapshot.exists) {

                        print(data['voteD']);
                        voteD = data['voteD'];
                        voteD += 1;

                        totalVote = data['totalVote'];
                        totalVote += 1;
                        print(voteD);
                        // print("Vote: $vote");

                        FirebaseFirestore.instance
                            .collection('Survey')
                            .doc('survey2')
                            .update({
                          'voteD' : voteD,
                        });

                        FirebaseFirestore.instance
                            .collection('Survey')
                            .doc('survey2')
                            .update({
                          'totalVote' : totalVote,
                        });


                      } else {
                        print('Document does not exist on the database');
                      }
                    });
                  });
                }
                if (choice == 5) {
                  setState(() {
                    option5 += 1.0;

                    FirebaseFirestore.instance
                        .collection('Survey')
                        .doc('survey2')
                        .get()
                        .then((DocumentSnapshot documentSnapshot){
                      Map<String, dynamic> data = documentSnapshot.data();
                      if (documentSnapshot.exists) {

                        print(data['voteE']);
                        voteE = data['voteE'];
                        voteE += 1;

                        totalVote = data['totalVote'];
                        totalVote += 1;
                        print(voteE);
                        // print("Vote: $vote");

                        FirebaseFirestore.instance
                            .collection('Survey')
                            .doc('survey2')
                            .update({
                          'voteE' : voteE,
                        });

                        FirebaseFirestore.instance
                            .collection('Survey')
                            .doc('survey2')
                            .update({
                          'totalVote' : totalVote,
                        });


                      } else {
                        print('Document does not exist on the database');
                      }
                    });
                  });
                }
              },
            ),
          ),
          Text('Jumlah Responden: $totalVote'),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}



class survey3 extends StatefulWidget {
  @override
  _survey3State createState() => _survey3State();
}

class _survey3State extends State<survey3> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey3')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          option3 += data['voteC'];
          option4 += data['voteD'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    getTotalVote();


  }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;
  double option3 = 0.0;
  double option4 = 0.0;

  int voteA;
  int voteB;
  int voteC;
  int voteD;
  int totalVote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
          width: 1000,
          height: 250,
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'a. Tiada tindakan, kekalkan operasi', value: option1),
              Polls.options(title: 'b. Kurangkan kos operasi', value: option2),
              Polls.options(title: 'c. Mungkin tutup perniagaan', value: option3),
              Polls.options(title: 'd. Tutup perniagaan segera', value: option4),

            ],
            question: Text('3) Sekiranya perniagaan lebih teruk daripada PKP 2.0, apakah tindakan '
                'anda seterusnya semasa atau selepas PKP 3.0 ini?'),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Colors.red[200],
            leadingBackgroundColor: Colors.red[400],
            backgroundColor: Colors.white,
            outlineColor: Colors.red,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey3')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteA']);
                      voteA = data['voteA'];
                      voteA += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteA);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey3')
                          .update({
                        'voteA' : voteA,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey3')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey3')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteB']);
                      voteB = data['voteB'];
                      voteB += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteB);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey3')
                          .update({
                        'voteB' : voteB,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey3')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 3) {
                setState(() {
                  option3 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey3')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteC']);
                      voteC = data['voteC'];
                      voteC += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteC);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey3')
                          .update({
                        'voteC' : voteC,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey3')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 4) {
                setState(() {
                  option4 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey3')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteD']);
                      voteD = data['voteD'];
                      voteD += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteD);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey3')
                          .update({
                        'voteD' : voteD,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey3')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
            },
          ),
        ),
        Text('Jumlah Responden: $totalVote'),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

class survey4 extends StatefulWidget {
  @override
  _survey4State createState() => _survey4State();
}

class _survey4State extends State<survey4> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey4')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          option3 += data['voteC'];
          option4 += data['voteD'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    getTotalVote();


  }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;
  double option3 = 0.0;
  double option4 = 0.0;

  int voteA;
  int voteB;
  int voteC;
  int voteD;
  int totalVote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
          width: 1000,
          height: 250,
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'a. Tidak', value: option1),
              Polls.options(title: 'b. Hentikan kurang 30% pekerja', value: option2),
              Polls.options(title: 'c. Hentikan 30%-50% pekerja', value: option3),
              Polls.options(title: 'd. Hentikan lebih 50% pekerja ', value: option4),

            ],
            question: Text('4) Adakah anda merancang untuk memberhentikan pekerja anda semasa'
                ' atau selepas PKP 3.0?'),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Colors.red[200],
            leadingBackgroundColor: Colors.red[400],
            backgroundColor: Colors.white,
            outlineColor: Colors.red,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey4')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteA']);
                      voteA = data['voteA'];
                      voteA += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteA);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey4')
                          .update({
                        'voteA' : voteA,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey4')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey4')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteB']);
                      voteB = data['voteB'];
                      voteB += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteB);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey4')
                          .update({
                        'voteB' : voteB,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey4')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 3) {
                setState(() {
                  option3 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey4')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteC']);
                      voteC = data['voteC'];
                      voteC += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteC);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey4')
                          .update({
                        'voteC' : voteC,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey4')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 4) {
                setState(() {
                  option4 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey4')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteD']);
                      voteD = data['voteD'];
                      voteD += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteD);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey4')
                          .update({
                        'voteD' : voteD,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey4')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
            },
          ),
        ),
        Text('Jumlah Responden: $totalVote'),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

class survey5 extends StatefulWidget {
  @override
  _survey5State createState() => _survey5State();
}

class _survey5State extends State<survey5> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey5')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          option3 += data['voteC'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    getTotalVote();


  }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;
  double option3 = 0.0;

  int voteA;
  int voteB;
  int voteC;
  int totalVote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
          width: 1000,
          height: 240,
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'a. Ya', value: option1),
              Polls.options(title: 'b. Tutup sementara', value: option2),
              Polls.options(title: 'c. Tidak', value: option3),

            ],
            question: Text('5) Walaupon anda dapat mengekalkan operasi perniagaan anda sekarang'
                ' tetapi adakah anda akan mempertimbangkan untuk memberhentikan perniagaan anda'
                ' secara kekal dalam beberapa bulan ke depan?'),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Colors.red[200],
            leadingBackgroundColor: Colors.red[400],
            backgroundColor: Colors.white,
            outlineColor: Colors.red,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey5')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteA']);
                      voteA = data['voteA'];
                      voteA += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteA);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey5')
                          .update({
                        'voteA' : voteA,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey5')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey5')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteB']);
                      voteB = data['voteB'];
                      voteB += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteB);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey5')
                          .update({
                        'voteB' : voteB,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey5')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 3) {
                setState(() {
                  option3 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey5')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteC']);
                      voteC = data['voteC'];
                      voteC += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteC);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey5')
                          .update({
                        'voteC' : voteC,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey5')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
            },
          ),
        ),
        Text('Jumlah Responden: $totalVote'),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}



class survey6 extends StatefulWidget {
  @override
  _survey6State createState() => _survey6State();
}

class _survey6State extends State<survey6> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey6')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          option3 += data['voteC'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    getTotalVote();


  }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;
  double option3 = 0.0;

  int voteA;
  int voteB;
  int voteC;
  int totalVote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
          width: 1000,
          height: 270,
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'a. Ya', value: option1),
              Polls.options(title: 'b. Kurang pasti', value: option2),
              Polls.options(title: 'c. Tidak', value: option3),

            ],
            question: Text('6) Menteri Kewangan mengatakan PKP 3.0 tidak diharapkan akan memberi kesan yang'
                ' signifikan terhadap pertumbuhan ekonomi kerana hampir semua sektor ekonomi dibiarkan terus'
                ' beroperasi, adakah anda setuju?'),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Colors.red[200],
            leadingBackgroundColor: Colors.red[400],
            backgroundColor: Colors.white,
            outlineColor: Colors.red,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey6')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteA']);
                      voteA = data['voteA'];
                      voteA += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteA);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey6')
                          .update({
                        'voteA' : voteA,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey6')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey6')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteB']);
                      voteB = data['voteB'];
                      voteB += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteB);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey6')
                          .update({
                        'voteB' : voteB,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey6')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 3) {
                setState(() {
                  option3 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey6')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteC']);
                      voteC = data['voteC'];
                      voteC += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteC);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey6')
                          .update({
                        'voteC' : voteC,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey6')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
            },
          ),
        ),
        Text('Jumlah Responden: $totalVote'),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

class survey7 extends StatefulWidget {
  @override
  _survey7State createState() => _survey7State();
}

class _survey7State extends State<survey7> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey7')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          option3 += data['voteC'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    getTotalVote();


  }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;
  double option3 = 0.0;

  int voteA;
  int voteB;
  int voteC;
  int totalVote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
          width: 1000,
          height: 300,
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'a. Ya', value: option1),
              Polls.options(title: 'b. Kurang pasti', value: option2),
              Polls.options(title: 'c. Tidak', value: option3),

            ],
            question: Text('7) Bank Negara Malaysia (BNM) mengatakan moratorium pinjaman automatik'
                ' secara menyeluruh bukanlah penyelesaian terbaik untuk semua memandangkan langkah-'
                'langkah pengekangan baru-baru ini yang diumumkan oleh kerajaan pusat kerana kebanyakan'
                ' sektor ekonomi kini dibenarkan beroperasi berbanding tahun sebelumnya. Adakah anda'
                ' bersetuju?'),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Colors.red[200],
            leadingBackgroundColor: Colors.red[400],
            backgroundColor: Colors.white,
            outlineColor: Colors.red,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey7')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteA']);
                      voteA = data['voteA'];
                      voteA += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteA);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey7')
                          .update({
                        'voteA' : voteA,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey7')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey7')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteB']);
                      voteB = data['voteB'];
                      voteB += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteB);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey7')
                          .update({
                        'voteB' : voteB,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey7')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 3) {
                setState(() {
                  option3 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey7')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteC']);
                      voteC = data['voteC'];
                      voteC += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteC);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey7')
                          .update({
                        'voteC' : voteC,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey7')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
            },
          ),
        ),
        Text('Jumlah Responden: $totalVote'),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}



class survey8 extends StatefulWidget {
  @override
  _survey8State createState() => _survey8State();
}

class _survey8State extends State<survey8> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey8')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          option3 += data['voteC'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    getTotalVote();


  }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;
  double option3 = 0.0;

  int voteA;
  int voteB;
  int voteC;
  int totalVote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
          width: 1000,
          height: 220,
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'a. Ya', value: option1),
              Polls.options(title: 'b. Kurang pasti', value: option2),
              Polls.options(title: 'c. Tidak', value: option3),

            ],
            question: Text('8) Adakah anda fikir perlaksanaan HIDE terlalu mendadak dengan pertimbangan'
                ' yang tidak mencukupi?'),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Colors.red[200],
            leadingBackgroundColor: Colors.red[400],
            backgroundColor: Colors.white,
            outlineColor: Colors.red,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey8')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteA']);
                      voteA = data['voteA'];
                      voteA += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteA);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey8')
                          .update({
                        'voteA' : voteA,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey8')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey8')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteB']);
                      voteB = data['voteB'];
                      voteB += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteB);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey8')
                          .update({
                        'voteB' : voteB,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey8')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 3) {
                setState(() {
                  option3 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey8')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteC']);
                      voteC = data['voteC'];
                      voteC += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteC);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey8')
                          .update({
                        'voteC' : voteC,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey8')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
            },
          ),
        ),
        Text('Jumlah Responden: $totalVote'),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}



class survey9 extends StatefulWidget {
  @override
  _survey9State createState() => _survey9State();
}

class _survey9State extends State<survey9> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey9')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          option3 += data['voteC'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    getTotalVote();


  }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;
  double option3 = 0.0;

  int voteA;
  int voteB;
  int voteC;
  int totalVote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
          width: 1000,
          height: 220,
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'a. Ya', value: option1),
              Polls.options(title: 'b. Kurang pasti', value: option2),
              Polls.options(title: 'c. Tidak', value: option3),

            ],
            question: Text('9) Adakah HIDE mempengaruhi perniagaan anda dan menambah beban pemulihan perniagaaan anda dari PKP 3.0?'),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Colors.red[200],
            leadingBackgroundColor: Colors.red[400],
            backgroundColor: Colors.white,
            outlineColor: Colors.red,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey9')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteA']);
                      voteA = data['voteA'];
                      voteA += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteA);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey9')
                          .update({
                        'voteA' : voteA,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey9')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey9')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteB']);
                      voteB = data['voteB'];
                      voteB += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteB);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey9')
                          .update({
                        'voteB' : voteB,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey9')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 3) {
                setState(() {
                  option3 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey9')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteC']);
                      voteC = data['voteC'];
                      voteC += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteC);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey9')
                          .update({
                        'voteC' : voteC,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey9')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
            },
          ),
        ),
        Text('Jumlah Responden: $totalVote'),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}



class survey10 extends StatefulWidget {
  @override
  _survey10State createState() => _survey10State();
}

class _survey10State extends State<survey10> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey10')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          option3 += data['voteC'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    getTotalVote();


  }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;
  double option3 = 0.0;

  int voteA;
  int voteB;
  int voteC;
  int totalVote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
          width: 1000,
          height: 220,
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'a. Ya', value: option1),
              Polls.options(title: 'b. Kurang pasti', value: option2),
              Polls.options(title: 'c. Tidak', value: option3),

            ],
            question: Text('10) Adakah anda fikir kita harus mengesyorkan kepada Kerajaan untuk menangguhkan HIDE?'),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Colors.red[200],
            leadingBackgroundColor: Colors.red[400],
            backgroundColor: Colors.white,
            outlineColor: Colors.red,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey10')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteA']);
                      voteA = data['voteA'];
                      voteA += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteA);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey10')
                          .update({
                        'voteA' : voteA,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey10')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey10')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteB']);
                      voteB = data['voteB'];
                      voteB += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteB);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey10')
                          .update({
                        'voteB' : voteB,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey10')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 3) {
                setState(() {
                  option3 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey10')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteC']);
                      voteC = data['voteC'];
                      voteC += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteC);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey10')
                          .update({
                        'voteC' : voteC,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey10')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
            },
          ),
        ),
        Text('Jumlah Responden: $totalVote'),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

class survey11 extends StatefulWidget {
  @override
  _survey11State createState() => _survey11State();
}

class _survey11State extends State<survey11> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey11')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          option3 += data['voteC'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    getTotalVote();


  }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;
  double option3 = 0.0;

  int voteA;
  int voteB;
  int voteC;
  int totalVote;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
          width: 1000,
          height: 220,
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'a. Ya', value: option1),
              Polls.options(title: 'b. Kurang pasti', value: option2),
              Polls.options(title: 'c. Tidak', value: option3),

            ],
            question: Text('11) Sekiranya Program Imunisasi Nasional Covid-19 (NIP) ditangguhkan, adakah ia akan memberi kesan'
                ' kepada perniagaan anda?'),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Colors.red[200],
            leadingBackgroundColor: Colors.red[400],
            backgroundColor: Colors.white,
            outlineColor: Colors.red,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey11')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteA']);
                      voteA = data['voteA'];
                      voteA += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteA);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey11')
                          .update({
                        'voteA' : voteA,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey11')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey11')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteB']);
                      voteB = data['voteB'];
                      voteB += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteB);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey11')
                          .update({
                        'voteB' : voteB,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey11')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 3) {
                setState(() {
                  option3 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey11')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteC']);
                      voteC = data['voteC'];
                      voteC += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteC);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey11')
                          .update({
                        'voteC' : voteC,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey11')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
            },
          ),
        ),
        Text('Jumlah Responden: $totalVote'),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

class survey12 extends StatefulWidget {
  @override
  _survey12State createState() => _survey12State();
}

class _survey12State extends State<survey12> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey12')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    getTotalVote();


  }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;

  int voteA;
  int voteB;
  int totalVote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
          width: 1000,
          height: 170,
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'a. Ya', value: option1),
              Polls.options(title: 'b. Tidak', value: option2),

            ],
            question: Text('12) Sekiranya kerajaan mengizinkan program vaksinasi swasta untuk'
                ' komuniti perniagaan, adakah anda setuju untuk menanggung kos anda sendiri'
                ' (Kira-kira RM 400)?'),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Colors.red[200],
            leadingBackgroundColor: Colors.red[400],
            backgroundColor: Colors.white,
            outlineColor: Colors.red,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey12')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteA']);
                      voteA = data['voteA'];
                      voteA += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteA);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey12')
                          .update({
                        'voteA' : voteA,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey12')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey12')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteB']);
                      voteB = data['voteB'];
                      voteB += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteB);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey12')
                          .update({
                        'voteB' : voteB,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey12')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
            },
          ),
        ),
        Text('Jumlah Responden: $totalVote'),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

class survey13 extends StatefulWidget {
  @override
  _survey13State createState() => _survey13State();
}

class _survey13State extends State<survey13> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey13')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          option3 += data['voteC'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    getTotalVote();


  }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;
  double option3 = 0.0;

  int voteA;
  int voteB;
  int voteC;
  int totalVote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
          width: 1000,
          height: 220,
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'a. Ya', value: option1),
              Polls.options(title: 'b. Kurang pasti', value: option2),
              Polls.options(title: 'c. Tidak', value: option3),

            ],
            question: Text('13) Adakah anda setuju bahawa Kerajaan harus segera memberikan'
                ' lebih banyak insentif untuk membantu PKS dalam pelaksanaan PKP 3.0?'),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Colors.red[200],
            leadingBackgroundColor: Colors.red[400],
            backgroundColor: Colors.white,
            outlineColor: Colors.red,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey13')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteA']);
                      voteA = data['voteA'];
                      voteA += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteA);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey13')
                          .update({
                        'voteA' : voteA,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey13')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey13')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteB']);
                      voteB = data['voteB'];
                      voteB += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteB);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey13')
                          .update({
                        'voteB' : voteB,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey13')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 3) {
                setState(() {
                  option3 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey13')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteC']);
                      voteC = data['voteC'];
                      voteC += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteC);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey13')
                          .update({
                        'voteC' : voteC,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey13')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
            },
          ),
        ),
        Text('Jumlah Responden: $totalVote'),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}


class survey14 extends StatefulWidget {
  @override
  _survey14State createState() => _survey14State();
}

class _survey14State extends State<survey14> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey14')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          option3 += data['voteC'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    getTotalVote();


  }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;
  double option3 = 0.0;

  int voteA;
  int voteB;
  int voteC;
  int totalVote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
          width: 1000,
          height: 220,
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'a. Ya', value: option1),
              Polls.options(title: 'b. Kurang pasti', value: option2),
              Polls.options(title: 'c. Tidak', value: option3),

            ],
            question: Text('14) Adakah anda bersetuju bahawa membenarkan pengeluaran KWSP/ KWSP'
                ' akan menjadi kaedah yang berkesan untuk mengekalkan ekonomi di PKP 3.0?'),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Colors.red[200],
            leadingBackgroundColor: Colors.red[400],
            backgroundColor: Colors.white,
            outlineColor: Colors.red,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey14')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteA']);
                      voteA = data['voteA'];
                      voteA += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteA);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey14')
                          .update({
                        'voteA' : voteA,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey14')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey14')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteB']);
                      voteB = data['voteB'];
                      voteB += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteB);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey14')
                          .update({
                        'voteB' : voteB,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey14')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 3) {
                setState(() {
                  option3 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey14')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteC']);
                      voteC = data['voteC'];
                      voteC += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteC);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey14')
                          .update({
                        'voteC' : voteC,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey14')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
            },
          ),
        ),
        Text('Jumlah Responden: $totalVote'),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

class survey15 extends StatefulWidget {
  @override
  _survey15State createState() => _survey15State();
}

class _survey15State extends State<survey15> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey15')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          option3 += data['voteC'];
          option4 += data['voteD'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    getTotalVote();


  }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;
  double option3 = 0.0;
  double option4 = 0.0;

  int voteA;
  int voteB;
  int voteC;
  int voteD;
  int totalVote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
          width: 1000,
          height: 220,
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'a. Tidak buat apa-apa', value: option1),
              Polls.options(title: 'b. Kegunaan sendiri', value: option2),
              Polls.options(title: 'c. Modal berniaga', value: option3),
              Polls.options(title: 'd. Tambah pelaburan', value: option4),

            ],
            question: Text('15) Adakah anda gunakan i-Sinar sebagai ;'),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Colors.red[200],
            leadingBackgroundColor: Colors.red[400],
            backgroundColor: Colors.white,
            outlineColor: Colors.red,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey15')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteA']);
                      voteA = data['voteA'];
                      voteA += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteA);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey15')
                          .update({
                        'voteA' : voteA,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey15')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey15')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteB']);
                      voteB = data['voteB'];
                      voteB += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteB);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey15')
                          .update({
                        'voteB' : voteB,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey15')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 3) {
                setState(() {
                  option3 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey15')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteC']);
                      voteC = data['voteC'];
                      voteC += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteC);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey15')
                          .update({
                        'voteC' : voteC,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey15')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 4) {
                setState(() {
                  option4 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey15')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteD']);
                      voteD = data['voteD'];
                      voteD += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteD);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey15')
                          .update({
                        'voteD' : voteD,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey15')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
            },
          ),
        ),
        Text('Jumlah Responden: $totalVote'),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}


class survey16 extends StatefulWidget {
  @override
  _survey16State createState() => _survey16State();
}

class _survey16State extends State<survey16> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey16')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    getTotalVote();


  }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;


  int voteA;
  int voteB;
  int totalVote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
          width: 1000,
          height: 170,
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'a. Ya', value: option1),
              Polls.options(title: 'b. Tidak', value: option2),

            ],
            question: Text('16) Adakah penutupan Bazaar Ramadhan dan Bazaar Hari Raya memberikan kesan kepada anda?'),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Colors.red[200],
            leadingBackgroundColor: Colors.red[400],
            backgroundColor: Colors.white,
            outlineColor: Colors.red,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey16')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteA']);
                      voteA = data['voteA'];
                      voteA += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteA);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey16')
                          .update({
                        'voteA' : voteA,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey16')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey16')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteB']);
                      voteB = data['voteB'];
                      voteB += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteB);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey16')
                          .update({
                        'voteB' : voteB,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey16')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
            },
          ),
        ),
        Text('Jumlah Responden: $totalVote'),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

class survey17 extends StatefulWidget {
  @override
  _survey17State createState() => _survey17State();
}

class _survey17State extends State<survey17> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey17')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    getTotalVote();


  }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;


  int voteA;
  int voteB;
  int totalVote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
          width: 1000,
          height: 170,
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'a. Ya', value: option1),
              Polls.options(title: 'b. Tidak', value: option2),

            ],
            question: Text('17) Adakah anda bersetuju dengan kenyataan daripada Perdana Menteri,'
                ' Menteri Kewangan dan Bank Negara Malaysia?'),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Colors.red[200],
            leadingBackgroundColor: Colors.red[400],
            backgroundColor: Colors.white,
            outlineColor: Colors.red,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey17')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteA']);
                      voteA = data['voteA'];
                      voteA += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteA);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey17')
                          .update({
                        'voteA' : voteA,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey17')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey17')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteB']);
                      voteB = data['voteB'];
                      voteB += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteB);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey17')
                          .update({
                        'voteB' : voteB,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey17')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
            },
          ),
        ),
        Text('Jumlah Responden: $totalVote'),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}


class survey18 extends StatefulWidget {
  @override
  _survey18State createState() => _survey18State();
}

class _survey18State extends State<survey18> {

  @override
  void initState() {

    int getTotalVote() {

      FirebaseFirestore.instance
          .collection('Survey')
          .doc('survey18')
          .get()
          .then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data();
        if (documentSnapshot.exists) {

          print(data['totalVote']);
          totalVote = data['totalVote'] + 1;
          print(totalVote);
          // print("Vote: $vote");
          option1 += data['voteA'];
          option2 += data['voteB'];
          // print(option1);
          // print(option2);


        } else {
          print('Document does not exist on the database');
        }
      });

      return totalVote;

    }

    getTotalVote();


  }

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  double option1 = 0.0;
  double option2 = 0.0;


  int voteA;
  int voteB;
  int totalVote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
          width: 1000,
          height: 118,
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'a. Ya', value: option1),
              Polls.options(title: 'b. Tidak', value: option2),

            ],
            question: Text('18) Adakah anda Ahli DPMM?'),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Colors.red[200],
            leadingBackgroundColor: Colors.red[400],
            backgroundColor: Colors.white,
            outlineColor: Colors.red,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey18')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteA']);
                      voteA = data['voteA'];
                      voteA += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteA);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey18')
                          .update({
                        'voteA' : voteA,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey18')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;

                  FirebaseFirestore.instance
                      .collection('Survey')
                      .doc('survey18')
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    Map<String, dynamic> data = documentSnapshot.data();
                    if (documentSnapshot.exists) {

                      print(data['voteB']);
                      voteB = data['voteB'];
                      voteB += 1;

                      totalVote = data['totalVote'];
                      totalVote += 1;
                      print(voteB);
                      // print("Vote: $vote");

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey18')
                          .update({
                        'voteB' : voteB,
                      });

                      FirebaseFirestore.instance
                          .collection('Survey')
                          .doc('survey18')
                          .update({
                        'totalVote' : totalVote,
                      });


                    } else {
                      print('Document does not exist on the database');
                    }
                  });
                });
              }
            },
          ),
        ),
        Text('Jumlah Responden: $totalVote'),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}















