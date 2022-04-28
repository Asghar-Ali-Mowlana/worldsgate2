import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worldsgate/screens/user/usercarbooking.dart';
import 'package:worldsgate/screens/user/userhotelbooking.dart';
import 'package:worldsgate/screens/user/userrestaurantorder.dart';
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
                fontFamily: 'crimson.italic',
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
                    child: containerMethod(heig, wi, imagewi,
                        "assets/images/homepageicons/Hotel.png", "Hotels"),
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
                    child: containerMethod(
                        heig,
                        wi,
                        imagewi,
                        "assets/images/homepageicons/Appartment.png",
                        "Apartments"),
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
                    child: containerMethod(heig, wi, imagewi,
                        "assets/images/homepageicons/Car.png", "Cars"),
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
                    child: containerMethod(heig, wi, imagewi,
                        "assets/images/homepageicons/Yacht.png", "Yacht"),
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
                    child: containerMethod(
                        heig,
                        wi,
                        imagewi,
                        "assets/images/homepageicons/restaurant.png",
                        "Restaurants"),
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
                    child: containerMethod(heig, wi, imagewi,
                        "assets/images/homepageicons/Bar.png", "Bars"),
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                // TaskCardWidget(id: user.id, name: user.ingredients,)
                                UserOrderFood(widget.uid, widget.city)));
                      },
                      child: containerMethod(heig, wi, imagewi,
                          "assets/images/homepageicons/Food.png", "Food")),
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
                      child: containerMethod(
                          heig,
                          wi,
                          imagewi,
                          "assets/images/homepageicons/Grocery.png",
                          "Groceries")),
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
                      child: containerMethod(
                          heig,
                          wi,
                          imagewi,
                          "assets/images/homepageicons/pharmecy.png",
                          "Pharmaceuticals")),
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
                      child: containerMethod(
                          heig,
                          wi,
                          imagewi,
                          "assets/images/homepageicons/Electronics.png",
                          "Electronics")),
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
                      child: containerMethod(heig, wi, imagewi,
                          "assets/images/homepageicons/Dress.png", "Clothes")),
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
                      child: containerMethod(
                          heig,
                          wi,
                          imagewi,
                          "assets/images/homepageicons/Cosmetics.png",
                          "Cosmetics")),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container containerMethod(
    double heig,
    double wi,
    double imagewi,
    String image,
    String name,
  ) {
    return Container(
      height: heig,
      width: wi,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(colors: [
          Color(0xFFd7a827),
          Color(0xFFffe08c),
          Color(0xFFefc65f),
          Color(0xFFe7bd50),
          Color(0xFFffe9ae),
          Color(0xFFe2b13c),
          Color(0xFFbe8b0d),
        ]),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF000000),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    image,
                    width: imagewi,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 18.0,
                ),
                child: Text(
                  name,
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
