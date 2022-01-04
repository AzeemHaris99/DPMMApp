import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ManualMapScreen extends StatefulWidget {
  @override
  _ManualMapScreenState createState() => _ManualMapScreenState();
}

class _ManualMapScreenState extends State<ManualMapScreen> {
  final hotelList = [
    {
      'name': 'Dewan Perniagaan Melayu Malaysia (Main)',
      'address': 'Bukit Petaling, Kuala Lumpur',
      'locationLat': 3.1312868,
      'locationLang': 101.7030222,
    },
    {
      'name': 'Dewan Perniagaan Melayu Malaysia Negeri Perlis',
      'address': 'Kangar, Perlis',
      'locationLat': 6.4402632,
      'locationLang': 100.1954792,
    },
    {
      'name': 'Dewan Perniagaan Melayu Malaysia Kedah',
      'address': 'Alor Setar, Kedah',
      'locationLat': 6.1178891,
      'locationLang': 100.3671284,
    },
    {
      'name': 'Penang Malay Chamber of Commerce',
      'address': 'George Town, Pulau Pinang',
      'locationLat': 5.4190085,
      'locationLang': 100.3441563,
    },
    {
      'name': 'Dewan Perniagaan Melayu Malaysia Terengganu',
      'address': 'Kuala Terengganu, Terengganu',
      'locationLat': 5.3297679,
      'locationLang': 103.1374971,
    },
    {
      'name': 'Dewan Perniagaan Melayu Malaysia Negeri Pahang',
      'address': 'Kuantan, Pahang',
      'locationLat': 3.8079169,
      'locationLang': 103.3302196,
    },
    {
      'name': 'Malay Chamber of Commerce Malaysia, Perak',
      'address': 'Ipoh, Perak',
      'locationLat': 4.5923406,
      'locationLang': 101.0895308,
    },
    {
      'name': 'DEWAN PERNIAGAAN MELAYU MALAYSIA NEGERI SEMBILAN',
      'address': 'Seremban, Negeri Sembilan',
      'locationLat': 2.7282519,
      'locationLang': 101.9381917,
    },
    {
      'name': 'DPMM Melaka',
      'address': 'Taman Semabok Perdana, Melaka',
      'locationLat': 2.2040874,
      'locationLang': 102.2744365,
    },
    {
      'name': 'DPMM Negeri Johor',
      'address': 'Johor Bahru, Johor',
      'locationLat': 1.4967472,
      'locationLang': 103.7403135,
    },
    {
      'name': 'Dewan Perniagaan Melayu Malaysia Labuan',
      'address': 'Labuan',
      'locationLat': 5.9511993,
      'locationLang': 116.0527305,
    },
  ];

  GoogleMapController _controller;

  List<Marker> allMarkers = [];

  PageController _pageController;

  int prevPage;

  @override
  void initState() {
    super.initState();
    hotelList.forEach((element) {
      print(element);
      allMarkers.add(Marker(
          markerId: MarkerId(element['name']),
          draggable: false,
          infoWindow:
          InfoWindow(title: element['name'], snippet: element['description']),
          position: LatLng(element['locationLat'], element['locationLang'])));
    });
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  _hotelFinalList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 175.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
                height: 175.0,
                width: 275.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0.0, 4.0),
                        blurRadius: 10.0,
                      ),
                    ]),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Hero(
                        tag: hotelList[index]['name'],
                        child: Container(
                          height: 175.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0)),

                          ),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Container(
                        width: 275.0 - 90.0 - 5.0 - 10.0,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                hotelList[index]['name'],
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                hotelList[index]['address'],
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(hotelList[0]['locationLat'],
                        hotelList[0]['locationLang']),
                    zoom: 12.0),
                markers: Set.from(allMarkers),
                onMapCreated: mapCreated,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapType: MapType.satellite,
              ),
            ),
            Positioned(
              bottom: 20.0,
              child: Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: hotelList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _hotelFinalList(index);
                  },
                ),
              ),
            )
          ],
        ));
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(hotelList[_pageController.page.toInt()]['locationLat'],
            hotelList[_pageController.page.toInt()]['locationLang']),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}