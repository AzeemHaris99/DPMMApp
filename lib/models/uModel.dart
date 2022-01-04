import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String profileImage;
  String email;
  String bio;
  String phone;
  String dob;
  String address;
  String job;
  Timestamp accountCreated;

  UserModel(
      {this.id,
        this.name,
        this.profileImage,
        this.email,
        this.bio,
        this.phone,
        this.dob,
        this.address,
        this.job,
        this.accountCreated});

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      name: doc['name'],
      profileImage: doc['profileImage'],
      email: doc['email'],
      bio: doc['bio'],
      phone: doc['phone'],
      dob: doc['dob'],
      address: doc['address'],
      job: doc['job'],
      accountCreated: doc['accountCreated'],
    );
  }

  Map<String,dynamic> toDocument() {
    return {
      "name" :name,
      "uid" :id,
      "email" :email,
      "profileImage" :profileImage,
    };
  }
}