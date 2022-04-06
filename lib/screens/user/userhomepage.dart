import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worldsgate/screens/user/usercarbooking.dart';
import 'package:worldsgate/screens/user/userhotelbooking.dart';
import 'package:worldsgate/widgets/header.dart';
import 'package:worldsgate/widgets/usernavigationdrawer.dart';

import '../../helper/responsive_helper.dart';
import '../../widgets/cusheader.dart';

class UserHomePage extends StatefulWidget {
  //const UserHomePage({Key? key}) : super(key: key);

  String? uid;
  String city;

  //constructor
  UserHomePage(this.uid, this.city);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  var _scaffoldState = new GlobalKey<ScaffoldState>();
  CarouselController _carouselController = CarouselController();

  //List<String> imageURLs = ["assets/images/promo/promo1.jpeg", "http://cdn.srilanka-promotions.com/wp-content/uploads/2012/12/Fashion-Bug-21-Dec-2012.jpg", "https://www.swaart.com/wp-content/uploads/2021/01/Swaart-Main.jpg"];

  List imageList = [
    'assets/images/promo/promo1.jpeg',
    'assets/images/promo/promo2.jpeg',
    'assets/images/promo/promo3.jpeg',
  ];


  String? cusname;
  String? role;

  getname() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get()
        .then((myDocuments) {
      cusname = myDocuments.data()!['name'].toString();
      role = myDocuments.data()!['role'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    //final double height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      key: _scaffoldState,

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   iconTheme: IconThemeData(color: Color(0xFFdb9e1f)),
      // ),

      drawer: new UserNavigationDrawer(widget.uid, widget.city),

      backgroundColor: Color(0xFF000000),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ResponsiveWidget(
              mobile: buildColumnContent(context, "mobile", 120, 120, 50),
              tab: buildColumnContent(context, "tab", 120, 120, 50),
              desktop: buildColumnContent(context, "desktop", 180, 180, 100),
            ),
          ),
          Positioned(
              left: 0.0,
              top: 0.0,
              right: 0.0,
              child: Container(
                  child: VendomeHeaderCustomer(
                    drawer: _scaffoldState,
                    cusname: cusname,
                    cusaddress: widget.city,
                    role: role,
                  ))),
        ],
      ),
    ));
  }

  Column buildColumnContent(BuildContext context, String tex, double wi,
      double heig, double imagewi) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 7.95),
          child: CarouselSlider(
            items: imageList
                .map((imageList) => Container(
                      width: double.infinity,
                      child: Center(
                          child: Image(
                        image: AssetImage(imageList),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 300.0,
                      )),
                    ))
                .toList(),
            carouselController: _carouselController,
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              height: 250.0,
              viewportFraction: 1.0,
            ),
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 10.95),
            child: Text(
              "What would you like to order, $cusname?",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 20.95, bottom: 20.0),
            child: Text(
              "Explore",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0, top: 20.0),
            child: Text(
              "Booking $tex",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
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
              //hotel
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 10.0, right: 0.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              // TaskCardWidget(id: user.id, name: user.ingredients,)
                              UserHotelBooking(widget.uid, widget.city)));
                    },
                    child: Container(
                      height: heig,
                      width: wi,
                      decoration: BoxDecoration(
                        color: Color(0xFF262626),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                "assets/images/homepageicons/Hotel.png",
                                width: imagewi,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 18.0,
                            ),
                            child: Text(
                              "Hotels",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //apartment
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 10.0, right: 0.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //     // TaskCardWidget(id: user.id, name: user.ingredients,)
                      //     UserHotelBooking(
                      //
                      //
                      //     )));
                    },
                    child: Container(
                      height: heig,
                      width: wi,
                      decoration: BoxDecoration(
                        color: Color(0xFF262626),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                "assets/images/homepageicons/Appartment.png",
                                width: imagewi,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 18.0,
                            ),
                            child: Text(
                              "Apartments",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //cars
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 10.0, right: 0.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //     // TaskCardWidget(id: user.id, name: user.ingredients,)
                      //     UserHotelBooking(
                      //
                      //
                      //     )));
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            UserCarBooking(widget.uid, widget.city),
                      ));
                    },
                    child: Container(
                      height: heig,
                      width: wi,
                      decoration: BoxDecoration(
                        color: Color(0xFF262626),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 35.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                "assets/images/homepageicons/Car.png",
                                width: imagewi - 10,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 18.0,
                            ),
                            child: Text(
                              "Cars",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //yacht
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 10.0, right: 0.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //     // TaskCardWidget(id: user.id, name: user.ingredients,)
                      //     UserHotelBooking(
                      //
                      //
                      //     )));
                    },
                    child: Container(
                      height: heig,
                      width: wi,
                      decoration: BoxDecoration(
                        color: Color(0xFF262626),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 35.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                "assets/images/homepageicons/Yacht.png",
                                width: imagewi - 10,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 18.0,
                            ),
                            child: Text(
                              "Yacht",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //restaurant
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 10.0, right: 0.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //     // TaskCardWidget(id: user.id, name: user.ingredients,)
                      //     UserHotelBooking(
                      //
                      //
                      //     )));
                    },
                    child: Container(
                      height: heig,
                      width: wi,
                      decoration: BoxDecoration(
                        color: Color(0xFF262626),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                "assets/images/homepageicons/restaurant.png",
                                width: imagewi,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 12.0,
                            ),
                            child: Text(
                              "Restaurants",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //bar
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 10.0, right: 0.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //     // TaskCardWidget(id: user.id, name: user.ingredients,)
                      //     UserHotelBooking(
                      //
                      //
                      //     )));
                    },
                    child: Container(
                      height: heig,
                      width: wi,
                      decoration: BoxDecoration(
                        color: Color(0xFF262626),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                "assets/images/homepageicons/Bar.png",
                                width: imagewi - 10,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 18.0,
                            ),
                            child: Text(
                              "Bars",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0, top: 20.0),
            child: Text(
              "Delivery",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
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
              //Food
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 10.0, right: 0.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //     // TaskCardWidget(id: user.id, name: user.ingredients,)
                      //     UserHotelBooking(
                      //
                      //
                      //     )));
                    },
                    child: Container(
                      height: heig,
                      width: wi,
                      decoration: BoxDecoration(
                        color: Color(0xFF262626),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                "assets/images/homepageicons/Food.png",
                                width: imagewi,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 18.0,
                            ),
                            child: Text(
                              "Food",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //Groceries
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 10.0, right: 0.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //     // TaskCardWidget(id: user.id, name: user.ingredients,)
                      //     UserHotelBooking(
                      //
                      //
                      //     )));
                    },
                    child: Container(
                      height: heig,
                      width: wi,
                      decoration: BoxDecoration(
                        color: Color(0xFF262626),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                "assets/images/homepageicons/Grocery.png",
                                width: imagewi - 5,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15.0,
                            ),
                            child: Text(
                              "Groceries",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //pharmaceuticals
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 10.0, right: 0.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //     // TaskCardWidget(id: user.id, name: user.ingredients,)
                      //     UserHotelBooking(
                      //
                      //
                      //     )));
                    },
                    child: Container(
                      height: heig,
                      width: wi,
                      decoration: BoxDecoration(
                        color: Color(0xFF262626),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                "assets/images/homepageicons/pharmecy.png",
                                width: imagewi - 5,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 19.0,
                            ),
                            child: Text(
                              "Pharmaceuticals",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0, top: 20.0),
            child: Text(
              "Online Shopping",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
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
              //electronics
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 10.0, right: 0.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //     // TaskCardWidget(id: user.id, name: user.ingredients,)
                      //     UserHotelBooking(
                      //
                      //
                      //     )));
                    },
                    child: Container(
                      height: heig,
                      width: wi,
                      decoration: BoxDecoration(
                        color: Color(0xFF262626),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                "assets/images/homepageicons/Electronics.png",
                                width: imagewi,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 18.0,
                            ),
                            child: Text(
                              "Electronics",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //clothes
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 10.0, right: 0.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //     // TaskCardWidget(id: user.id, name: user.ingredients,)
                      //     UserHotelBooking(
                      //
                      //
                      //     )));
                    },
                    child: Container(
                      height: heig,
                      width: wi,
                      decoration: BoxDecoration(
                        color: Color(0xFF262626),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                "assets/images/homepageicons/Dress.png",
                                width: imagewi,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 18.0,
                            ),
                            child: Text(
                              "Clothes",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //cosmetics
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 10.0, right: 0.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //     // TaskCardWidget(id: user.id, name: user.ingredients,)
                      //     UserHotelBooking(
                      //
                      //
                      //     )));
                    },
                    child: Container(
                      height: heig,
                      width: wi,
                      decoration: BoxDecoration(
                        color: Color(0xFF262626),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                "assets/images/homepageicons/Cosmetics.png",
                                width: imagewi,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 18.0,
                            ),
                            child: Text(
                              "Cosmetics",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
