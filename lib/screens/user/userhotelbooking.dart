import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worldsgate/widgets/header.dart';
import 'package:worldsgate/widgets/usernavigationdrawer.dart';

class UserHotelBooking extends StatefulWidget {
  //const UserHotelBooking({Key? key}) : super(key: key);

  String? uid;
  String? city;

  //constructor
  UserHotelBooking(
      this.uid,
      this.city
      );

  @override
  _UserHotelBookingState createState() => _UserHotelBookingState();
}

class _UserHotelBookingState extends State<UserHotelBooking> {
  var _scaffoldState = new GlobalKey<ScaffoldState>();

  var _controller = TextEditingController();


  String? cusname;

  getname() async {
    FirebaseFirestore.instance.collection('users') .doc(widget.uid)
        .get().then((myDocuments){
      cusname = myDocuments.data()!['name'].toString();
    });}

  DateTimeRange dateRange = DateTimeRange(
      start: DateTime.now(),
      end: (DateTime.now()).add(const Duration(days: 1)));

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    builder:
    (context, child) => Theme(
        data: ThemeData.dark().copyWith(
            colorScheme:
                ColorScheme.dark().copyWith(primary: Color(0xFF000000))),
        child: child);

    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange);
  }

  @override
  Widget build(BuildContext context) {
    //final double height = MediaQuery.of(context).size.height;
    final start = dateRange.start;
    final end = dateRange.end;
    return SafeArea(
        child: Scaffold(
      key: _scaffoldState,

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   iconTheme: IconThemeData(color: Color(0xFFdb9e1f)),
      // ),

      endDrawer: new UserNavigationDrawer(widget.uid, widget.city),

      backgroundColor: Color(0xFF000000),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 125.0, bottom: 5.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Text(
                        "Hotel Booking",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 220.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Color(0xFFBA780F))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Color(0xFFBA780F)),
                              ),
                            ),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: _controller,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF000000),
                                hintText: "ibis Styles Sharajah",
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 15.0),
                                hintStyle: TextStyle(color: Colors.white),
                                enabled: true,
                                prefixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  color: Color(0xFFdb9e1f),
                                  onPressed: () {
                                    //_controller..text = "";
                                  },
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.keyboard_voice_outlined),
                                  color: Color(0xFFdb9e1f),
                                  onPressed: () {
                                    //_controller..text = "";
                                  },
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Color(0xFF000000)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Color(0xFFdb9e1f)),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Hotel name cannot be empty";
                                }
                              },
                              onSaved: (value) {
                                _controller.text = value!;
                              },
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Color(0xFFBA780F).withOpacity(0.6)),
                              ),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.calendar_today_outlined),
                                  color: Color(0xFFdb9e1f),
                                  onPressed: () {
                                    pickDateRange();
                                  },
                                ),
                                Text(
                                    "${DateFormat.EEEE().format(start)} ${DateFormat.d().format(start)} ${DateFormat.MMMM().format(start)} - ${DateFormat.EEEE().format(end)} ${DateFormat.d().format(end)} ${DateFormat.MMMM().format(end)}",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Color(0xFFBA780F)),
                              ),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.person_outline_outlined),
                                  color: Color(0xFFdb9e1f),
                                  onPressed: () {},
                                ),
                                Text("1 room . 2 adults . 0 children",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(56.0, 0.0, 56.0, 0.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFF000000),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    side: BorderSide(color: Color(0xFFdb9e1f))),
                                side: BorderSide(
                                  width: 2.5,
                                  color: Color(0xFFdb9e1f),
                                ),
                                textStyle: const TextStyle(fontSize: 16)),
                            onPressed: () {},
                            child: const Text(
                              'Search',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25.0, bottom: 0.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Text(
                        "Stay with Premium Brands",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 180.0,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    primary: false,
                    children: <Widget>[
                      //Image.network('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg', height: 30.0, ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 10.0, right: 0.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Stack(
                            children: [
                              Container(
                                height: 190.0,
                                width: 250.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/premiumbrands/premiumbrands1.jpeg',
                                    ),
                                    fit: BoxFit.fill,
                                    // colorFilter: new ColorFilter.mode(
                                    //     Colors.black.withOpacity(0.3),
                                    //     BlendMode.colorBurn),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 73.0, right: 10.0),
                                height: 90.0,
                                width: 250.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    //border: Border.all(color: Color(0xFFBA780F)),
                                    // color: Colors.black,
                                    gradient: LinearGradient(
                                        begin: FractionalOffset.topCenter,
                                        end: FractionalOffset.bottomCenter,
                                        colors: [
                                          Colors.black87.withOpacity(0.0),
                                          Colors.black87,
                                        ],
                                        stops: [
                                          0.0,
                                          0.7
                                        ])),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 53.0, right: 10.0),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                "Ramada Hotel & Suites",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                "Dubai UAE",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 10.0, right: 0.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Stack(
                            children: [
                              Container(
                                height: 190.0,
                                width: 250.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/premiumbrands/premiumbrands1.jpeg',
                                    ),
                                    fit: BoxFit.fill,
                                    // colorFilter: new ColorFilter.mode(
                                    //     Colors.black.withOpacity(0.3),
                                    //     BlendMode.colorBurn),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 73.0, right: 10.0),
                                height: 90.0,
                                width: 250.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    //border: Border.all(color: Color(0xFFBA780F)),
                                    // color: Colors.black,
                                    gradient: LinearGradient(
                                        begin: FractionalOffset.topCenter,
                                        end: FractionalOffset.bottomCenter,
                                        colors: [
                                          Colors.black87.withOpacity(0.0),
                                          Colors.black87,
                                        ],
                                        stops: [
                                          0.0,
                                          0.7
                                        ])),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 53.0, right: 10.0),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                "Ramada Hotel & Suites",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                "Dubai UAE",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 10.0, right: 0.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Stack(
                            children: [
                              Container(
                                height: 190.0,
                                width: 250.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/premiumbrands/premiumbrands1.jpeg',
                                    ),
                                    fit: BoxFit.fill,
                                    // colorFilter: new ColorFilter.mode(
                                    //     Colors.black.withOpacity(0.3),
                                    //     BlendMode.colorBurn),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 73.0, right: 10.0),
                                height: 90.0,
                                width: 250.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    //border: Border.all(color: Color(0xFFBA780F)),
                                    // color: Colors.black,
                                    gradient: LinearGradient(
                                        begin: FractionalOffset.topCenter,
                                        end: FractionalOffset.bottomCenter,
                                        colors: [
                                          Colors.black87.withOpacity(0.0),
                                          Colors.black87,
                                        ],
                                        stops: [
                                          0.0,
                                          0.7
                                        ])),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 53.0, right: 10.0),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                "Ramada Hotel & Suites",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                "Dubai UAE",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25.0, bottom: 0.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Text(
                        "Nearby Hotels",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 2400.0,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    //scrollDirection: Axis.vertical,
                    //shrinkWrap: true,
                    //primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 10.0, right: 10.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Stack(
                            children: [
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, right: 10.0, bottom: 16.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              "GIO Hotel Apartments - Dubai",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 82.0, top: 2.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Icon(
                                                  Icons.arrow_upward_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Text(
                                                  " 4 Km From Center",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Price for 1 night 2 adults",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFBA780F),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, bottom: 2.0),
                                            child: Text(
                                              "Price 450 AED",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "-51 AED Taxes and Charges",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: Text(
                                              "10% for Cancellation",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFBA780F),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/premiumbrands/premiumbrands1.jpeg',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 113.0, right: 0.0),
                                      height: 220.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              colors: [
                                                Colors.white70.withOpacity(0.0),
                                                Colors.orange.withOpacity(0.8),
                                              ],
                                              stops: [
                                                0.0,
                                                0.7
                                              ])),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 68.0, right: 0.0),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text(
                                                      "20% off",
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 10.0, right: 10.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Stack(
                            children: [
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, right: 10.0, bottom: 16.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              "GIO Hotel Apartments - Dubai",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 82.0, top: 2.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Icon(
                                                  Icons.arrow_upward_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Text(
                                                  " 4 Km From Center",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Price for 1 night 2 adults",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFBA780F),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, bottom: 2.0),
                                            child: Text(
                                              "Price 450 AED",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "-51 AED Taxes and Charges",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: Text(
                                              "10% for Cancellation",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFBA780F),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/premiumbrands/premiumbrands1.jpeg',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 113.0, right: 0.0),
                                      height: 220.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              colors: [
                                                Colors.white70.withOpacity(0.0),
                                                Colors.orange.withOpacity(0.8),
                                              ],
                                              stops: [
                                                0.0,
                                                0.7
                                              ])),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 68.0, right: 0.0),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text(
                                                      "20% off",
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 10.0, right: 10.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Stack(
                            children: [
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, right: 10.0, bottom: 16.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              "GIO Hotel Apartments - Dubai",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 82.0, top: 2.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Icon(
                                                  Icons.arrow_upward_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Text(
                                                  " 4 Km From Center",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Price for 1 night 2 adults",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFBA780F),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, bottom: 2.0),
                                            child: Text(
                                              "Price 450 AED",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "-51 AED Taxes and Charges",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: Text(
                                              "10% for Cancellation",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFBA780F),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/premiumbrands/premiumbrands1.jpeg',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 113.0, right: 0.0),
                                      height: 220.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              colors: [
                                                Colors.white70.withOpacity(0.0),
                                                Colors.orange.withOpacity(0.8),
                                              ],
                                              stops: [
                                                0.0,
                                                0.7
                                              ])),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 68.0, right: 0.0),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text(
                                                      "20% off",
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 10.0, right: 10.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Stack(
                            children: [
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, right: 10.0, bottom: 16.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              "GIO Hotel Apartments - Dubai",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 82.0, top: 2.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Icon(
                                                  Icons.arrow_upward_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Text(
                                                  " 4 Km From Center",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Price for 1 night 2 adults",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFBA780F),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, bottom: 2.0),
                                            child: Text(
                                              "Price 450 AED",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "-51 AED Taxes and Charges",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: Text(
                                              "10% for Cancellation",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFBA780F),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/premiumbrands/premiumbrands1.jpeg',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 113.0, right: 0.0),
                                      height: 220.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              colors: [
                                                Colors.white70.withOpacity(0.0),
                                                Colors.orange.withOpacity(0.8),
                                              ],
                                              stops: [
                                                0.0,
                                                0.7
                                              ])),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 68.0, right: 0.0),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text(
                                                      "20% off",
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 10.0, right: 10.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Stack(
                            children: [
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, right: 10.0, bottom: 16.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              "GIO Hotel Apartments - Dubai",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 82.0, top: 2.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Icon(
                                                  Icons.arrow_upward_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Text(
                                                  " 4 Km From Center",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Price for 1 night 2 adults",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFBA780F),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, bottom: 2.0),
                                            child: Text(
                                              "Price 450 AED",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "-51 AED Taxes and Charges",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: Text(
                                              "10% for Cancellation",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFBA780F),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/premiumbrands/premiumbrands1.jpeg',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 113.0, right: 0.0),
                                      height: 220.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              colors: [
                                                Colors.white70.withOpacity(0.0),
                                                Colors.orange.withOpacity(0.8),
                                              ],
                                              stops: [
                                                0.0,
                                                0.7
                                              ])),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 68.0, right: 0.0),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text(
                                                      "20% off",
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 10.0, right: 10.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Stack(
                            children: [
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, right: 10.0, bottom: 16.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              "GIO Hotel Apartments - Dubai",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 82.0, top: 2.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Icon(
                                                  Icons.arrow_upward_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Text(
                                                  " 4 Km From Center",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Price for 1 night 2 adults",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFBA780F),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, bottom: 2.0),
                                            child: Text(
                                              "Price 450 AED",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "-51 AED Taxes and Charges",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: Text(
                                              "10% for Cancellation",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFBA780F),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/premiumbrands/premiumbrands1.jpeg',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 113.0, right: 0.0),
                                      height: 220.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              colors: [
                                                Colors.white70.withOpacity(0.0),
                                                Colors.orange.withOpacity(0.8),
                                              ],
                                              stops: [
                                                0.0,
                                                0.7
                                              ])),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 68.0, right: 0.0),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text(
                                                      "20% off",
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 10.0, right: 10.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Stack(
                            children: [
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, right: 10.0, bottom: 16.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              "GIO Hotel Apartments - Dubai",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 82.0, top: 2.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Icon(
                                                  Icons.arrow_upward_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Text(
                                                  " 4 Km From Center",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Price for 1 night 2 adults",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFBA780F),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, bottom: 2.0),
                                            child: Text(
                                              "Price 450 AED",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "-51 AED Taxes and Charges",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: Text(
                                              "10% for Cancellation",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFBA780F),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/premiumbrands/premiumbrands1.jpeg',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 113.0, right: 0.0),
                                      height: 220.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              colors: [
                                                Colors.white70.withOpacity(0.0),
                                                Colors.orange.withOpacity(0.8),
                                              ],
                                              stops: [
                                                0.0,
                                                0.7
                                              ])),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 68.0, right: 0.0),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text(
                                                      "20% off",
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 10.0, right: 10.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Stack(
                            children: [
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, right: 10.0, bottom: 16.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              "GIO Hotel Apartments - Dubai",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 82.0, top: 2.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Icon(
                                                  Icons.arrow_upward_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Text(
                                                  " 4 Km From Center",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Price for 1 night 2 adults",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFBA780F),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, bottom: 2.0),
                                            child: Text(
                                              "Price 450 AED",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "-51 AED Taxes and Charges",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: Text(
                                              "10% for Cancellation",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFBA780F),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/premiumbrands/premiumbrands1.jpeg',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 113.0, right: 0.0),
                                      height: 220.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              colors: [
                                                Colors.white70.withOpacity(0.0),
                                                Colors.orange.withOpacity(0.8),
                                              ],
                                              stops: [
                                                0.0,
                                                0.7
                                              ])),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 68.0, right: 0.0),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text(
                                                      "20% off",
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 10.0, right: 10.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Stack(
                            children: [
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, right: 10.0, bottom: 16.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              "GIO Hotel Apartments - Dubai",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 82.0, top: 2.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Icon(
                                                  Icons.arrow_upward_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Text(
                                                  " 4 Km From Center",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Price for 1 night 2 adults",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFBA780F),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, bottom: 2.0),
                                            child: Text(
                                              "Price 450 AED",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "-51 AED Taxes and Charges",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: Text(
                                              "10% for Cancellation",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFBA780F),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/premiumbrands/premiumbrands1.jpeg',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 113.0, right: 0.0),
                                      height: 220.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              colors: [
                                                Colors.white70.withOpacity(0.0),
                                                Colors.orange.withOpacity(0.8),
                                              ],
                                              stops: [
                                                0.0,
                                                0.7
                                              ])),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 68.0, right: 0.0),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text(
                                                      "20% off",
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 10.0, right: 10.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Stack(
                            children: [
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, right: 10.0, bottom: 16.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              "GIO Hotel Apartments - Dubai",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 82.0, top: 2.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Icon(
                                                  Icons.arrow_upward_outlined,
                                                  color: Color(0xFFBA780F),
                                                  size: 15.0,
                                                ),
                                                Text(
                                                  " 4 Km From Center",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Price for 1 night 2 adults",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFBA780F),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, bottom: 2.0),
                                            child: Text(
                                              "Price 450 AED",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "-51 AED Taxes and Charges",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: Text(
                                              "10% for Cancellation",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFBA780F),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 220.0,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFFBA780F)),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/premiumbrands/premiumbrands1.jpeg',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 113.0, right: 0.0),
                                      height: 220.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              colors: [
                                                Colors.white70.withOpacity(0.0),
                                                Colors.orange.withOpacity(0.8),
                                              ],
                                              stops: [
                                                0.0,
                                                0.7
                                              ])),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 68.0, right: 0.0),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text(
                                                      "20% off",
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              left: 0.0,
              top: 0.0,
              right: 0.0,
              child: Container(child: VendomeHeader.cus(drawer: _scaffoldState, cusname: cusname, cusaddress:widget.city,))),
        ],
      ),
    ));
  }
}
