import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test_login_register/models/uModel.dart';
import 'package:flutter_test_login_register/services/storageServices.dart';
import 'package:flutter_test_login_register/states/currentUser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final UserModel user;

  const EditProfile({Key key, this.user}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();

}

class _EditProfileState extends State<EditProfile> {

  TextEditingController bioController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController locationController2 = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController educationController = TextEditingController();

  TextEditingController profileImageController = TextEditingController();

  File _fileProfileImage;

  GoogleMapController mapController;

  Location location = new Location();

  double currentposition;

  double currentposition2;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Sila aktifkan butang lokasi pada telefon anda');
    }

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if(permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Permohonan lokasi pada telefon anda dibatalkan');
      }
    }
    if(permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Permohonan lokasi pada telefon anda dibatalkan sepenuhnya');
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        currentposition = position.latitude;
        currentposition2 = position.longitude;
        locationController.text = currentposition.toString();
        locationController2.text = currentposition2.toString();
      });
    } catch(e) {
      print(e);
    }
  }

  Geoflutterfire geo = Geoflutterfire();

  Set<Marker> markers;

  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;

  String _currentSelectedEducation;

  //Change education level here

  final _education = [
    'SPM',
    'Diploma',
    'Ijazah Sarjana Muda',
    'Master',

  ];

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    getUser();
    markers = Set.from([]);

  }

  currentUser() {
    final User user = auth.currentUser;
    final uid = user.uid.toString();
    return uid;
  }

  //Get user's information from the database and set it to text editing controller

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

              bioController.text = data['bio'];
              nameController.text = data['name'];
              dobController.text = data['dob'];
              locationController.text = data['locationLat'];
              locationController2.text = data['locationLang'];
              addressController.text = data['address'];
              jobController.text = data['job'];
              profileImageController.text = data['profileImage'];

              // _currentSelectedEducation = educationController.text;

          } else {
             print('Document does not exist on the database');
          }
        });

  }

  //Pick profile image from gallery

  final picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _fileProfileImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //Display profile image

  displayProfileImage() {

    String profileImage = profileImageController.text;

    if (_fileProfileImage == null) {
      if (profileImage.isEmpty) {
        return NetworkImage('https://www.pngkey.com/png/detail/950-9501315_katie-notopoulos-katienotopoulos-i-write-about-tech-user.png');
      } else {
        return NetworkImage(profileImage);
      }
    } else {
      return FileImage(_fileProfileImage);
    }
  }

  // saveProfile() async {
  //   _formKey.currentState.save();
  //   if (_formKey.currentState.validate() && !_isLoading) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     String profilePictureUrl = '';
  //     String coverPictureUrl = '';
  //     if (_profileImage == null) {
  //       profilePictureUrl = widget.user.profileImage;
  //     } else {
  //       profilePictureUrl = await StorageService.uploadProfilePicture(
  //           widget.user.profileImage, _profileImage);
  //     }
  //     if (_coverImage == null) {
  //       coverPictureUrl = widget.user.coverImage;
  //     } else {
  //       coverPictureUrl = await StorageService.uploadCoverPicture(
  //           widget.user.coverImage, _coverImage);
  //     }
  //     UserModel user = UserModel(
  //       id: widget.user.id,
  //       name: _name,
  //       profilePicture: profilePictureUrl,
  //       bio: _bio,
  //       coverImage: coverPictureUrl,
  //     );
  //
  //     DatabaseServices.updateUserData(user);
  //     Navigator.pop(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {}));//To refresh the page

    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    // Future<DocumentSnapshot> getData = FirebaseFirestore.instance.collection("users").doc(_currentUser.getCurrentUser.email).get();

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    //update through text field
    updateProfile() async {

      String profileImage = profileImageController.text;

      String profilePictureUrl = '';

      if (_fileProfileImage == null) {
        profilePictureUrl = profileImage;
      } else {
        profilePictureUrl = await StorageService.uploadProfilePicture(
            profileImage, _fileProfileImage);
      }

      if (bioController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan Tentang Anda')));
      }else if (nameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan nama anda')));
      }else if (dobController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan tarikh lahir anda')));
      }else if (locationController.text.isEmpty && locationController2.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan koordinat rumah anda')));
      }else if (addressController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan alamat rumah anda')));
      }else if (jobController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sila masukkan pekerjaan/tahap pendidikan anda')));
      }

      FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser.getCurrentUser.uid)
          .update({
        "bio" : bioController.text,
        "name": nameController.text,
        "dob" : dobController.text,
        "locationLat" : locationController.text,
        "locationLang" : locationController2.text,
        "address": addressController.text,
        "job": jobController.text,
        "profileImage": profilePictureUrl,

      });

    }

    //manual update (old)
    Future<void> updateUser() {
      return users
          .doc(_currentUser.getCurrentUser.uid)
          .update({'phone': '01301289102'})
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
    }

    // var _currencies = [
    //   "SPM",
    //   "Diploma",
    //   "Degree",
    //   "Master",
    //   "PhD",
    // ];
    //
    // String _currentSelectedValue;

    // var educationType;
    //
    // List<String> _education = <String>[
    //   'SPM',
    //   'Diploma',
    //   'Degree',
    //   'Master',
    // ];

    // String dropdownValue = 'One';

    // var currentSelectedValue;
    // const deviceTypes = ["Mac", "Windows", "Mobile"];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        elevation: 0.0,
        title: Text(
            'Profil Anda',
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: ListView(
            children: [
              imageProfile(),
              SizedBox(height: 20,),
              bioTextField(),
              SizedBox(height: 20,),
              nameTextField(),
              SizedBox(height: 20,),
              locationTextField(),
              SizedBox(height: 20,),
              locationTextField2(),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  _determinePosition();
                },
                child: Text(
                  'Kenal Pasti Koordinat Rumah Anda',
                  style: GoogleFonts.openSans(
                      color: Colors.white
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
              // FutureBuilder<DocumentSnapshot>(
              //   future: users.doc(_currentUser.getCurrentUser.uid).get(),
              //   builder:
              //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              //
              //     if (snapshot.hasError) {
              //       return Text("Something went wrong");
              //     }
              //
              //     if (snapshot.hasData && !snapshot.data.exists) {
              //       return Text("Document does not exist");
              //     }
              //
              //     if (snapshot.connectionState == ConnectionState.done) {
              //       Map<String, dynamic> data = snapshot.data.data();
              //       String uPhone = data['phone'];
              //       return Text("Phone: ${data['phone']}");
              //     }
              //
              //     return Text("loading");
              //   },
              // ),
              SizedBox(height: 20,),
              SizedBox(height: 20,),
              dateTextField(),
              SizedBox(height: 20,),
              addressTextField(),
              SizedBox(height: 20,),
              jobTextField(),
              SizedBox(height: 10,),
              Text(
                  '*Jika anda pelajar, masukkan tahap pendidikan anda, cth: SPM, Diploma',
                  style: GoogleFonts.openSans(
                    color: Color(0xff0d47a1),
                  )
              ),
              // SizedBox(height: 20,),
              // Row(
              //   children: [
              //
              //     educationTextField(),
              //     SizedBox(width: 20,),
              //
              //     Container(
              //       width:35,
              //       child: FormField<String>(
              //         // validator: (val){ return val.isEmpty ? "Enter Education Level": null;},
              //         builder: (FormFieldState<String> state) {
              //           return InputDecorator(
              //             decoration: InputDecoration(
              //                 prefixIcon: Icon(Icons.school),
              //                 errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
              //                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
              //             isEmpty: _currentSelectedEducation?.isEmpty ?? true,
              //             child: DropdownButtonHideUnderline(
              //               child: DropdownButton<String>(
              //                 hint: Text("Select education level"),
              //                 value: _currentSelectedEducation,
              //                 isDense: true,
              //                 onChanged: (String newValue) {
              //                   setState(() {
              //                     _currentSelectedEducation = newValue;
              //                     educationController.text = _currentSelectedEducation;
              //                     state.didChange(newValue);
              //                   });
              //                 },
              //                 items: _education.map((String value) {
              //                   return DropdownMenuItem<String>(
              //                     value: value,
              //                     child: Text(value),
              //                   );
              //                 }).toList(),
              //               ),
              //             ),
              //           );
              //         },
              //       ),
              //     ),
              //
              //
              //
              //
              //   ],
              // ),

              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState.validate()){
                    updateProfile();

                    return showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        content: Text('Profil Berjaya Dikemas Kini!', style: GoogleFonts.openSans(),),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text(
                                  'Tutup',
                                style: GoogleFonts.openSans(
                                    color: Colors.red,
                                ),
                              ),
                          ),
                        ],
                      ),
                    );

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Profile()),
                    // );
                  }

                },
                child: Text(
                  'Kemas Kini Profil',
                  style: GoogleFonts.openSans(
                      color: Colors.white
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundImage: displayProfileImage(),
            radius: 80.0,
            // backgroundImage: AssetImage(''),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                getProfileImage();
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.red,
                size: 28.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bioTextField() {
    return TextFormField(
      validator: (val){ return val.isEmpty ? "Masukkan Tentang Anda": null;},
      controller: bioController,
      maxLines: 3,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff0d47a1))
          ),
          labelText: 'Tentang Anda',
          hintText: 'Nyatakan latar belakang anda'
      ),
    );
  }

  Widget nameTextField() {
    return TextFormField(
      validator: (val){ return val.isEmpty ? "Masukkan Nama Penuh": null;},
      controller: nameController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff0d47a1))
          ),
          prefixIcon: Icon(Icons.person, color: Color(0xff0d47a1),),
          labelText: 'Nama Penuh',
          hintText: 'Ali Bin Abu'
      ),
    );
  }

  Widget dateTextField() {
    return TextFormField(
      validator: (val){ return val.isEmpty ? "Masukkan Tarikh Lahir": null;},
      controller: dobController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff0d47a1))
          ),
          prefixIcon: Icon(Icons.calendar_today, color: Color(0xff0d47a1),),
          labelText: 'Tarikh Lahir',
          hintText: 'XX/X/XXXX'
      ),
    );
  }

  Widget locationTextField() {
    return TextFormField(
      validator: (val){ return val.isEmpty ? "Masukkan Latitud Rumah Anda": null;},
      controller: locationController,
      readOnly: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff0d47a1))
          ),
          prefixIcon: Icon(Icons.pin_drop, color: Color(0xff0d47a1),),
          labelText: 'Latitud Rumah Anda',
          hintText: '000.000, 000.000'
      ),
    );
  }

  Widget locationTextField2() {
    return TextFormField(
      validator: (val){ return val.isEmpty ? "Masukkan Longitud Rumah Anda": null;},
      controller: locationController2,
      readOnly: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff0d47a1))
          ),
          prefixIcon: Icon(Icons.pin_drop, color: Color(0xff0d47a1),),
          labelText: 'Longitud Rumah Anda',
          hintText: '000.000, 000.000'
      ),
    );
  }

  Widget addressTextField() {
    return TextFormField(
      validator: (val){ return val.isEmpty ? "Masukkan Alamat": null;},
      controller: addressController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff0d47a1))
          ),
          prefixIcon: Icon(Icons.home, color: Color(0xff0d47a1),),
          labelText: 'Alamat',
          hintText: 'T2, Taman Kelana, Selangor'
      ),
    );
  }

  Widget jobTextField() {
    return TextFormField(
      controller: jobController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff0d47a1))
          ),
          prefixIcon: Icon(Icons.business_center_rounded, color: Color(0xff0d47a1),),
          labelText: 'Nama Pekerjaan',
          hintText: 'Pekerjaan'
      ),
    );
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }

}

// class AppDropdownInput<T> extends StatelessWidget {
//   final String hintText;
//   final List<T> options;
//   final T value;
//   final String Function(T) getLabel;
//   final void Function(T) onChanged;
//
//   AppDropdownInput({
//     this.hintText = 'Please select an Option',
//     this.options = const [],
//     this.getLabel,
//     this.value,
//     this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return FormField<T>(
//       builder: (FormFieldState<T> state) {
//         return InputDecorator(
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(
//                 horizontal: 20.0, vertical: 15.0),
//             labelText: hintText,
//             border:
//             OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
//           ),
//           isEmpty: value == null || value == '',
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<T>(
//               value: value,
//               isDense: true,
//               onChanged: onChanged,
//               items: options.map((T value) {
//                 return DropdownMenuItem<T>(
//                   value: value,
//                   child: Text(getLabel(value)),
//                 );
//               }).toList(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//


