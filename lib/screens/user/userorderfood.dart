import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worldsgate/helper/responsive_helper.dart';
import 'package:worldsgate/screens/user/userviewhoteldetails.dart';
import 'package:worldsgate/widgets/header.dart';
import 'package:worldsgate/widgets/usernavigationdrawer.dart';

class UserOrderFood extends StatefulWidget {
  //const UserOrderFood({Key? key}) : super(key: key);

  String? uid;
  String? city;

  UserOrderFood(this.uid, this.city);

  @override
  State<UserOrderFood> createState() => _UserOrderFoodState();
}

class _UserOrderFoodState extends State<UserOrderFood> {
  var _scaffoldState = new GlobalKey<ScaffoldState>();

  var _controller = TextEditingController();

  String? cusname;

  getname() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get()
        .then((myDocuments) {
      cusname = myDocuments.data()!['name'].toString();
    });
  }

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
  Widget build(BuildContext context) {
    final CollectionReference packageCollection =
        FirebaseFirestore.instance.collection('hotels');
    final Query unpicked = packageCollection.where('city',
        isEqualTo: city != null ? city : widget.city);

    final start = dateRange.start;
    final end = dateRange.end;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      key: _scaffoldState,
      endDrawer: new UserNavigationDrawer(widget.uid, widget.city),
      drawer: new UserNavigationDrawer(widget.uid, widget.city),
      backgroundColor: Color(0xFF000000),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ResponsiveWidget(
              mobile: buildColumnContent(
                  start, end, context, unpicked, height, width),
              tab: buildColumnContent(
                  start, end, context, unpicked, height, width),
              desktop: buildColumnContent(
                  start, end, context, unpicked, height, width),
            ),
          ),
          Positioned(
              left: 0.0,
              top: 0.0,
              right: 0.0,
              child: Container(
                  child: VendomeHeader.cus(
                drawer: _scaffoldState,
                cusname: cusname == null ? "Loading" : cusname,
                cusaddress: widget.city,
              ))),
        ],
      ),
    ));
  }

  Column buildColumnContent(DateTime start, DateTime end, BuildContext context,
      Query<Object?> unpicked, double height, double width) {
    return Column(
      children: [
        SizedBox(
          height: 50.0,
        ),
        Container(
          margin: const EdgeInsets.only(top: 125.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                "Order your favourite food",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.02),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 220.0,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                primary: false,
                children: <Widget>[
                  favouriteFoodMethod(height, width, "KFC",
                      'assets/images/restaurentimages/KFC.png', Colors.red),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: favouriteFoodMethod(
                        height,
                        width,
                        "Papa John's",
                        'assets/images/restaurentimages/Papa Jhones.png',
                        Colors.green),
                  ),
                  favouriteFoodMethod(height, width, "Domino's",
                      'assets/images/restaurentimages/Dominos.png', Colors.red),
                ],
              ),
            ),
          ),
        ),
        Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                "Favourite Choice",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.02, horizontal: width * 0.02),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 160.0,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                primary: false,
                children: <Widget>[
                  favouriteChoiceMethod(height, width, "Pizza", 19),
                  favouriteChoiceMethod(height, width, "Biriyani", 19),
                  favouriteChoiceMethod(height, width, "Burger", 19),
                  favouriteChoiceMethod(height, width, "Pizza", 19),
                  favouriteChoiceMethod(height, width, "Pizza", 19),
                ],
              ),
            ),
          ),
        ),
        Container(
          //margin: const EdgeInsets.only(top: 25.0, bottom: 0.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                "200 Restaurents Nearby You",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Container(
            //height: 2400.0,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: unpicked.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: snapshot.data!.docs.map((doc) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserViewHotelDetails(
                                  widget.uid, doc.id, widget.city)));
                        },
                        child: Padding(
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
                                    border:
                                        Border.all(color: Color(0xFFBA780F)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, right: 10.0, bottom: 16.0),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              height: 186.0,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              decoration: BoxDecoration(),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Fern El Balad",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text("3.2 KM",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white))
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3.0),
                                                    child: Text(
                                                      "Marina Dubai",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xFFBA780F),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3.0),
                                                    child: Text(
                                                      "Healthy food, Lebanese, Sandwhiches, Pasta",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xFFBA780F),
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 2.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/restaurentimages/DeliveryBike.png",
                                                          height: height * 0.06,
                                                          width: width * 0.06,
                                                        ),
                                                        Text(
                                                          "  4 Live Tracking ",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Yes",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xFFBA780F)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      otherDetailsMethod(
                                                          "Deal Time",
                                                          "30 Min"),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    5.0),
                                                        child:
                                                            otherDetailsMethod(
                                                                "Delivery Fee",
                                                                "Free"),
                                                      ),
                                                      otherDetailsMethod(
                                                          "Min Order", "15 AED")
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 180.0,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border:
                                        Border.all(color: Color(0xFFBA780F)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          doc['coverimage'] == null
                                              ? ""
                                              : doc['coverimage']),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  //conta
                                  /*child: Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 113.0, right: 0.0),
                                        height: 220.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: LinearGradient(
                                                begin:
                                                    FractionalOffset.topCenter,
                                                end: FractionalOffset
                                                    .bottomCenter,
                                                colors: [
                                                  Colors.white70
                                                      .withOpacity(0.0),
                                                  Colors.orange
                                                      .withOpacity(0.8),
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
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Text(
                                                        "${doc['promotion']}% off",
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
                                  ),*/
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Container otherDetailsMethod(String otherDetailsHeading, String otherDetail) {
    return Container(
      height: 70,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFFBA780F)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(otherDetailsHeading),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: Color(0xFFBA780F),
            ),
          ),
          Text(otherDetail)
        ],
      ),
    );
  }

  Padding favouriteChoiceMethod(
      double height, double width, String foodType, int numOfRestaurents) {
    return Padding(
      padding: EdgeInsets.only(right: width * 0.0),
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              height: height * 0.15,
              width: width * 0.18,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFFBA780F)),
                  color: Color(0xFF000000)),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                child: Image.asset(
                  'assets/images/restaurentimages/FoodCatageryImages.png',
                  height: 100,
                  width: 80,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 43.0),
              height: height * 0.15,
              width: width * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 63.0),
                      child: Column(
                        children: [
                          Text(
                            foodType,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFBA780F),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            numOfRestaurents.toString() + "+ Places",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
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
    );
  }

  Align favouriteFoodMethod(double height, double width, String restaurentName,
      String restaurentBrandImage, Color color) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            height: height * 0.3,
            width: width * 0.3,
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
          Padding(
            padding: EdgeInsets.only(left: width * 0.22, top: height * 0.01),
            child: Container(
              height: height * 0.03,
              width: width * 0.06,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(restaurentBrandImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 93.0),
            height: height * 0.3,
            width: width * 0.3,
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
                    margin: const EdgeInsets.only(top: 73.0),
                    child: Column(
                      children: [
                        Text(
                          "Indulge in delicious duo combos starting at 69 AED",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          restaurentName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            color: color,
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
    );
  }
}
