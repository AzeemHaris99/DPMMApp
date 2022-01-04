import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  String uid;
  String address;
  String dob;
  String job;
  String email;
  String phone;
  String name;
  String bio;
  Timestamp accountCreated;

  OurUser({
    this.uid,
    this.address,
    this.dob,
    this.job,
    this.email,
    this.phone,
    this.name,
    this.bio,
    this.accountCreated,

  });

}