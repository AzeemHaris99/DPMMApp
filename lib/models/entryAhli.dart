import 'package:flutter/material.dart';

class EntryAhliField {

}

class EntryAhli {

  final String id;
  final String userName;
  final String userIc;
  final String userAddress;
  final String userLat;
  final String userLong;
  final String userCompany;
  final String userCompanyNo;
  final String userEmail;
  final String userPhone;
  final String userJob;
  final String userCawDPMM;

  EntryAhli({this.userName, this.userIc, this.userAddress, this.userLat, this.userLong, this.userCompany, this.userCompanyNo, this.userEmail, this.userPhone, this.userJob, this.userCawDPMM, @required this.id});

  factory EntryAhli.fromJson(Map<String, dynamic> json){
    return EntryAhli(
      userName: json['Nama'],
      userIc: json['Ic'],
      userAddress: json['Alamat'],
      userLat: json['Lat'],
      userLong: json['Long'],
      userCompany: json['Syarikat'],
      userCompanyNo: json['No syarikat'],
      userEmail: json['Emel'],
      userPhone: json['Telefon'],
      userJob: json['KerjaPendidikan'],
      userCawDPMM: json['Caw DPMM'],
      id: json['id'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'Nama': userName,
      'Ic':userIc,
      'Alamat':userAddress,
      'Lat':userLat,
      'Long':userLong,
      'Syarikat':userCompany,
      'No syarikat':userCompanyNo,
      'Emel':userEmail,
      'Telefon':userPhone,
      'KerjaPendidikan':userJob,
      'Caw DPMM':userCawDPMM,
      'id':id
    };
  }
}