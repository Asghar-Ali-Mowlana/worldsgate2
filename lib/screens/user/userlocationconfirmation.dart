import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:worldsgate/screens/user/userhomepage.dart';

class LocationConfirmation extends StatefulWidget {
  //const LocationConfirmation({Key? key}) : super(key: key);
  String userUID;

  LocationConfirmation(this.userUID);

  @override
  _LocationConfirmationState createState() => _LocationConfirmationState();
}

class _LocationConfirmationState extends State<LocationConfirmation> {
  final auth = FirebaseAuth.instance.currentUser;
  User? user;

  final _formkey = GlobalKey<FormState>();

  String? city;

  final places = [
    'Deira',
    'Bur Dubai',
    'Beach & Coast',
    'Garhoud',
    'Palm Jumeirah',
    'Barsha Heights (Tecom)',
    'Sheikh Zayed Road',
    'Al Barsha',
    'Dubai Creek',
    'Jumeirah Beach Residence',
    'Dubai Marina',
    'Trade Centre',
    'Old Dubai',
    'Downtown Dubai',
    'Business Bay',
    "Guests' favourite area",
    'Jadaf',
    'Al Qusais',
    'Oud Metha',
    'Dubai Investment Park',
    'Dubai Festival City',
    'Dubai World Central',
    'Umm Suqeim',
    'Discovery Gardens',
    'Dubai Production City',
    'Jumeirah Lakes Towers',
  ];

  DropdownMenuItem<String> buildMenuItem(String place) => DropdownMenuItem(
        value: place,
        child: Text(
          place,
          style: const TextStyle(fontSize: 16.0),
        ),
      );

  bool _isLocationSelected = false;

  @override
  void initState() {
    user = auth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xFF000000),
          body: Container(
            child: Stack(
              fit: StackFit.expand,
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(25.08559163749154, 55.14159403093483),
                      zoom: 14.47),
                )
              ],
            ),
          ) /*Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "CONFIRM LOCATION",
                  style: TextStyle(color: Color(0xFFdb9e1f), fontSize: 20),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Form(
                      key: _formkey,
                      child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: "Select place in UAE",
                            hintStyle: TextStyle(color: Colors.white70),
                            //labelText: 'City',
                            labelStyle:
                                TextStyle(color: Colors.white70, height: 0.1),
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Color(0xFFdb9e1f)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Color(0xFFdb9e1f)),
                            ),
                          ),
                          dropdownColor: Color(0xFF000000),
                          //focusColor: Color(0xFFdb9e1f),
                          style: TextStyle(color: Colors.white),
                          isExpanded: true,
                          value: city,
                          items: places.map(buildMenuItem).toList(),
                          onChanged: (value) => setState(() {
                                this.city = value as String?;
                                setState(() {
                                  _isLocationSelected = true;
                                });
                              }))),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width / 2,
                          MediaQuery.of(context).size.height / 15),
                      primary: Color(0xFF000000),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          side: BorderSide(
                              color: _isLocationSelected
                                  ? Color(0xFFdb9e1f)
                                  : Colors.grey)),
                      side: BorderSide(
                        width: 2.5,
                        color:
                            _isLocationSelected ? Color(0xFFdb9e1f) : Colors.grey,
                      ),
                      textStyle: const TextStyle(fontSize: 18)),
                  onPressed: () {
                    _isLocationSelected
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UserHomePage(widget.userUID, city!)))
                        : null;
                  },
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),*/
          ),
    );
  }
}
