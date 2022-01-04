import 'package:flutter/material.dart';
import 'package:flutter_test_login_register/models/entryAhli.dart';
import 'package:flutter_test_login_register/services/firestoreAhli_service.dart';
import 'package:uuid/uuid.dart';

class EntryAhliProvider with ChangeNotifier {
  final firestoreService = FirestoreAhliService();
  String _userName;
  String _userIc;
  String _userAddress;
  String _userLat;
  String _userLong;
  String _userCompany;
  String _userCompanyNo;
  String _userEmail;
  String _userPhone;
  String _userJob;
  String _userCawDPMM;
  String _id;
  var uuid = Uuid();

  //Getters
  String get userName => _userName;
  String get userIc => _userIc;
  String get userAddress => _userAddress;
  String get userLat => _userLat;
  String get userLong => _userLong;
  String get userCompany => _userCompany;
  String get userCompanyNo => _userCompanyNo;
  String get userEmail => _userEmail;
  String get userPhone => _userPhone;
  String get userJob => _userJob;
  String get userCawDPMM => _userCawDPMM;
  Stream<List<EntryAhli>> get entries => firestoreService.getEntries();

  //Setters
  set changeName(String userName){
    _userName = userName;
    notifyListeners();
  }

  set changeIc(String userIc){
    _userIc = userIc;
    notifyListeners();
  }

  set changeAddress(String userAddress){
    _userAddress = userAddress;
    notifyListeners();
  }

  set changeLat(String userLat){
    _userLat = userLat;
    notifyListeners();
  }

  set changeLong(String userLong){
    _userLong = userLong;
    notifyListeners();
  }

  set changeCompany(String userCompany){
    _userCompany = userCompany;
    notifyListeners();
  }

  set changeCompanyNo(String userCompanyNo){
    _userCompanyNo = userCompanyNo;
    notifyListeners();
  }

  set changeEmail(String userEmail){
    _userEmail = userEmail;
    notifyListeners();
  }

  set changePhone(String userPhone){
    _userPhone = userPhone;
    notifyListeners();
  }

  set changeJob(String userJob){
    _userJob = userJob;
    notifyListeners();
  }

  set changeCawDPMM(String userCawDPMM){
    _userCawDPMM = userCawDPMM;
    notifyListeners();
  }

  //Functions
  loadAll(EntryAhli entryAhli){
    if (entryAhli != null){
      _userName = entryAhli.userName;
      _userIc =entryAhli.userIc;
      _userAddress =entryAhli.userAddress;
      _userLat =entryAhli.userLat;
      _userLong =entryAhli.userLong;
      _userCompany =entryAhli.userCompany;
      _userCompanyNo =entryAhli.userCompanyNo;
      _userEmail =entryAhli.userEmail;
      _userPhone =entryAhli.userPhone;
      _userJob =entryAhli.userJob;
      _userCawDPMM =entryAhli.userCawDPMM;
      _id = entryAhli.id;
    } else {

    }
  }

  saveEntry(){
    if (_id == null){
      //Add
      var newEntryAhli = EntryAhli(userName: _userName, userIc: _userIc, userAddress: _userAddress, userLat: _userLat, userLong: _userLong, userCompany: _userCompany, userCompanyNo: _userCompanyNo, userEmail: _userEmail, userPhone: _userPhone, userJob: _userJob, userCawDPMM: _userCawDPMM, id: uuid.v1());
      print(newEntryAhli.userName);
      print(newEntryAhli.userIc);
      print(newEntryAhli.userAddress);
      print(newEntryAhli.userLat);
      print(newEntryAhli.userLong);
      print(newEntryAhli.userCompany);
      print(newEntryAhli.userCompanyNo);
      print(newEntryAhli.userEmail);
      print(newEntryAhli.userPhone);
      print(newEntryAhli.userJob);
      print(newEntryAhli.userCawDPMM);
      firestoreService.setEntryAhli(newEntryAhli);
    } else {
      //Edit
      var updatedEntryAhli = EntryAhli(userName: _userName, userLat: _userLat, userLong: _userLong, userIc: _userIc, userAddress: _userAddress, userCompany: _userCompany, userCompanyNo: _userCompanyNo, userEmail: _userEmail, userPhone: _userPhone, userJob: _userJob, userCawDPMM: _userCawDPMM, id: _id);
      firestoreService.setEntryAhli(updatedEntryAhli);
    }
  }

  removeEntryAhli(String id){
    firestoreService.removeEntryAhli(id);
  }

}