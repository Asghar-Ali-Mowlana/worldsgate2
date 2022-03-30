import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worldsgate/screens/user/userviewcardetails.dart';

import '../../helper/responsive_helper.dart';
import '../../widgets/header.dart';
import '../../widgets/usernavigationdrawer.dart';

class UserCarBooking extends StatefulWidget {

  String? uid;
  String city;
  //constructor
  UserCarBooking(this.uid, this.city);
  //const UserCarBooking({Key? key}) : super(key: key);

  @override
  _UserCarBookingState createState() => _UserCarBookingState();
}

class _UserCarBookingState extends State<UserCarBooking> {

  var _scaffoldState = new GlobalKey<ScaffoldState>();


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


  @override
  Widget build(BuildContext context) {
    final CollectionReference packageCollection =
    FirebaseFirestore.instance.collection('cars');

    return SafeArea(
     

        
        child: Scaffold(
          key: _scaffoldState,
          backgroundColor: Color(0xFF000000),

          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0.0,
          //   iconTheme: IconThemeData(color: Color(0xFFdb9e1f)),
          // ),

          endDrawer: new UserNavigationDrawer(widget.uid, widget.city),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: ResponsiveWidget(
                  mobile: buildColumnContent(context, "mobile", packageCollection),
                  tab: buildColumnContent(context, "tab", packageCollection),
                  desktop: buildColumnContent(context, "desktop", packageCollection),
                ),
              ),
              Positioned(
                  left: 0.0,
                  top: 0.0,
                  right: 0.0,
                  child: Container(
                      child:
                      VendomeHeader.cus(drawer: _scaffoldState, cusname: cusname, cusaddress: widget.city,))),
            ],
          ),
        ));
  }

  Column buildColumnContent(BuildContext context, String tex, Query<Object?> packageCollection ) {
    return Column(

      children: [
        Container(
          margin: const EdgeInsets.only(top: 200.0, bottom: 5.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                "Car Booking $tex",
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
          child: Align(
            alignment: Alignment.topLeft,
            child: LayoutBuilder(

                builder: (context, constraints) {
                  return
                    (constraints.maxWidth >= 920 && constraints.maxWidth < 1380)
                        ?StreamBuilder<QuerySnapshot>(
                        stream: packageCollection.snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Wrap(
                              direction: Axis.horizontal,
                              spacing: (constraints.maxWidth >= 1120 && constraints.maxWidth < 1240) ? 100.0 : (constraints.maxWidth >= 1240 && constraints.maxWidth < 1400)? 200.0 : 30.0,
                              runSpacing: 40.0,
                              children: snapshot.data!.docs.map((doc)
                              {
                                return  InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                        // TaskCardWidget(id: user.id, name: user.ingredients,)
                                        UserViewCarDetails(widget.uid, doc['carid'], widget.city)));
                                  },
                                  child: Container(
                                    height: 235.0,
                                    width: 450,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      // border: Border.all(color: Color(0xFFBA780F)),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${doc['coverimage']}'),
                                          fit: BoxFit.cover
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Column(
                                        children: [
                                          Container(

                                            // margin: const EdgeInsets.only(
                                            //     right: 1.0, left: 2.0),
                                            height: 90.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  20),
                                              //border: Border.all(color: Color(0xFFBA780F)),
                                              // color: Colors.black,
                                              gradient: LinearGradient(
                                                  begin: FractionalOffset
                                                      .bottomCenter,
                                                  end: FractionalOffset.topCenter,
                                                  colors: [
                                                    Colors.black87.withOpacity(
                                                        0.0),
                                                    Colors.black87,
                                                  ],
                                                  stops: [
                                                    0.0,
                                                    0.7
                                                  ]),


                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .end,
                                                children: [
                                                  Align(
                                                    alignment: Alignment.topRight,
                                                    child: Text(
                                                      "${doc['name']}"
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0),),),
                                                  Align(
                                                    alignment: Alignment.topRight,
                                                    child: Text("${doc['model']}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0),),),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            clipBehavior: Clip.antiAlias,
                                            margin: const EdgeInsets.only(
                                                top: 60.0),
                                            height: 85.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20.0),
                                                bottomRight: Radius.circular(
                                                    20.0),),
                                              //border: Border.all(color: Color(0xFFBA780F)),
                                              // color: Colors.black,
                                              gradient: LinearGradient(
                                                  begin: FractionalOffset
                                                      .topCenter,
                                                  end: FractionalOffset
                                                      .bottomCenter,
                                                  colors: [
                                                    Color(0xFFf2f2f2).withOpacity(
                                                        0.3),
                                                    Color(0xFFb3b3b3).withOpacity(
                                                        0.9),
                                                  ],
                                                  stops: [
                                                    0.0,
                                                    1.0
                                                  ]),


                                            ),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 3, sigmaY: 3),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 12.0,),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,

                                                  children: [
                                                    Align(
                                                      alignment: Alignment
                                                          .topLeft,
                                                      child: Container(
                                                        width: 100.0,

                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .end,

                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                  top: MediaQuery
                                                                      .of(context)
                                                                      .size
                                                                      .height *
                                                                      0.02),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .end,

                                                                children: [
                                                                  Text("${doc['topspeed']}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize: 20.0),),
                                                                  Text("km/h",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white54,
                                                                        fontSize: 16.0),)
                                                                ],
                                                              ),
                                                            ),
                                                            Text("Top Speed",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize: 14.0),),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment
                                                          .topCenter,
                                                      child: Container(
                                                        width: 230.0,

                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,

                                                          children: [

                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: 65.0,

                                                                  decoration: BoxDecoration(

                                                                    border: Border
                                                                        .all(
                                                                        color: Color(
                                                                            0xFFBA780F),
                                                                        width: 1.5),
                                                                  ),
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                      top: 2.0),

                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment
                                                                        .spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Icon(
                                                                          Icons
                                                                              .star,
                                                                          size: 20.0,
                                                                          color: Color(
                                                                              0xFFBA780F),),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Text(
                                                                          "Delivery",
                                                                          style: TextStyle(
                                                                              color: Color(
                                                                                  0xFFBA780F),
                                                                              fontSize: 14.0,
                                                                              decoration: TextDecoration
                                                                                  .underline),),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Text(
                                                                          "${doc['delivery']}",
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontSize: 13.0),),
                                                                      ),

                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(

                                                                  width: 65.0,
                                                                  decoration: BoxDecoration(

                                                                    border: Border
                                                                        .all(
                                                                        color: Color(
                                                                            0xFFBA780F),
                                                                        width: 1.5),
                                                                  ),
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                      top: 2.0),

                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment
                                                                        .spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Icon(
                                                                          Icons
                                                                              .directions_car_rounded,
                                                                          size: 20.0,
                                                                          color: Color(
                                                                              0xFFBA780F),),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Text(
                                                                          "Model",
                                                                          style: TextStyle(
                                                                              color: Color(
                                                                                  0xFFBA780F),
                                                                              fontSize: 14.0,
                                                                              decoration: TextDecoration
                                                                                  .underline),),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Text(
                                                                          "${doc['model']}",
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontSize: 13.0),),
                                                                      ),

                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 65.0,

                                                                  decoration: BoxDecoration(

                                                                    border: Border
                                                                        .all(
                                                                        color: Color(
                                                                            0xFFBA780F),
                                                                        width: 1.5),
                                                                  ),
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                      top: 2.0),

                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment
                                                                        .spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Icon(
                                                                          Icons
                                                                              .add_road,
                                                                          size: 20.0,
                                                                          color: Color(
                                                                              0xFFBA780F),),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Text(
                                                                          "${doc['distance']} KM",
                                                                          style: TextStyle(
                                                                              color: Color(
                                                                                  0xFFBA780F),
                                                                              fontSize: 14.0,
                                                                              decoration: TextDecoration
                                                                                  .underline),),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Text(
                                                                          "Included",
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontSize: 13.0),),
                                                                      ),

                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment
                                                          .topRight,
                                                      child: Container(
                                                        width: 80.0,
                                                        margin: EdgeInsets.only(
                                                            top: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.02,
                                                            bottom: 7.0),
                                                        decoration: BoxDecoration(
                                                          border: Border(

                                                            left: BorderSide(
                                                                width: 1.0,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .end,

                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .end,

                                                              children: [
                                                                Text("${doc['price']}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black87,
                                                                      fontSize: 20.0),),
                                                                Text("\$",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: 20.0),)
                                                              ],
                                                            ),
                                                            Text("Rent Price",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize: 14.0),),
                                                            // Row(
                                                            //   children: [
                                                            //     Text("Rent Price", style: TextStyle(color: Colors.black87, fontSize: 14.0),),
                                                            //   ],
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );



                              }).toList(),

                            );
                          }
                        }
                    )
                        : (constraints.maxWidth >= 1380)
                        ?StreamBuilder<QuerySnapshot>(
                        stream: packageCollection.snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Wrap(
                              direction: Axis.horizontal,
                              spacing: 30.0,
                              runSpacing: 40.0,
                              children: snapshot.data!.docs.map((doc)
                            {
                            return  InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                    // TaskCardWidget(id: user.id, name: user.ingredients,)
                                    UserViewCarDetails(widget.uid, doc['carid'].toString(), widget.city)));
                              },
                              child: Container(
                                  height: 235.0,
                                  width: 450,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    // border: Border.all(color: Color(0xFFBA780F)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            '${doc['coverimage']}'),
                                        fit: BoxFit.cover
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Column(
                                      children: [
                                        Container(

                                          // margin: const EdgeInsets.only(
                                          //     right: 1.0, left: 2.0),
                                          height: 90.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                20),
                                            //border: Border.all(color: Color(0xFFBA780F)),
                                            // color: Colors.black,
                                            gradient: LinearGradient(
                                                begin: FractionalOffset
                                                    .bottomCenter,
                                                end: FractionalOffset.topCenter,
                                                colors: [
                                                  Colors.black87.withOpacity(
                                                      0.0),
                                                  Colors.black87,
                                                ],
                                                stops: [
                                                  0.0,
                                                  0.7
                                                ]),


                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .end,
                                              children: [
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text(
                                                    "${doc['name']}"
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0),),),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text("${doc['model']}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0),),),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          clipBehavior: Clip.antiAlias,
                                          margin: const EdgeInsets.only(
                                              top: 60.0),
                                          height: 85.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20.0),
                                              bottomRight: Radius.circular(
                                                  20.0),),
                                            //border: Border.all(color: Color(0xFFBA780F)),
                                            // color: Colors.black,
                                            gradient: LinearGradient(
                                                begin: FractionalOffset
                                                    .topCenter,
                                                end: FractionalOffset
                                                    .bottomCenter,
                                                colors: [
                                                  Color(0xFFf2f2f2).withOpacity(
                                                      0.3),
                                                  Color(0xFFb3b3b3).withOpacity(
                                                      0.9),
                                                ],
                                                stops: [
                                                  0.0,
                                                  1.0
                                                ]),


                                          ),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 3, sigmaY: 3),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                right: 12.0,),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,

                                                children: [
                                                  Align(
                                                    alignment: Alignment
                                                        .topLeft,
                                                    child: Container(
                                                      width: 100.0,

                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .end,

                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets
                                                                .only(
                                                                top: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height *
                                                                    0.02),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .end,

                                                              children: [
                                                                Text("${doc['topspeed']}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: 20.0),),
                                                                Text("km/h",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white54,
                                                                      fontSize: 16.0),)
                                                              ],
                                                            ),
                                                          ),
                                                          Text("Top Speed",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 14.0),),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment
                                                        .topCenter,
                                                    child: Container(
                                                      width: 230.0,

                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .start,

                                                        children: [

                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Container(
                                                                width: 65.0,

                                                                decoration: BoxDecoration(

                                                                  border: Border
                                                                      .all(
                                                                      color: Color(
                                                                          0xFFBA780F),
                                                                      width: 1.5),
                                                                ),
                                                                margin: EdgeInsets
                                                                    .only(
                                                                    top: 2.0),

                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          4.0),
                                                                      child: Icon(
                                                                        Icons
                                                                            .star,
                                                                        size: 20.0,
                                                                        color: Color(
                                                                            0xFFBA780F),),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          4.0),
                                                                      child: Text(
                                                                        "Delivery",
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xFFBA780F),
                                                                            fontSize: 14.0,
                                                                            decoration: TextDecoration
                                                                                .underline),),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          4.0),
                                                                      child: Text(
                                                                        "${doc['delivery']}",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize: 13.0),),
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),
                                                              Container(

                                                                width: 65.0,
                                                                decoration: BoxDecoration(

                                                                  border: Border
                                                                      .all(
                                                                      color: Color(
                                                                          0xFFBA780F),
                                                                      width: 1.5),
                                                                ),
                                                                margin: EdgeInsets
                                                                    .only(
                                                                    top: 2.0),

                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          4.0),
                                                                      child: Icon(
                                                                        Icons
                                                                            .directions_car_rounded,
                                                                        size: 20.0,
                                                                        color: Color(
                                                                            0xFFBA780F),),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          4.0),
                                                                      child: Text(
                                                                        "Model",
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xFFBA780F),
                                                                            fontSize: 14.0,
                                                                            decoration: TextDecoration
                                                                                .underline),),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          4.0),
                                                                      child: Text(
                                                                        "${doc['model']}",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize: 13.0),),
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 65.0,

                                                                decoration: BoxDecoration(

                                                                  border: Border
                                                                      .all(
                                                                      color: Color(
                                                                          0xFFBA780F),
                                                                      width: 1.5),
                                                                ),
                                                                margin: EdgeInsets
                                                                    .only(
                                                                    top: 2.0),

                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          4.0),
                                                                      child: Icon(
                                                                        Icons
                                                                            .add_road,
                                                                        size: 20.0,
                                                                        color: Color(
                                                                            0xFFBA780F),),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          4.0),
                                                                      child: Text(
                                                                        "${doc['distance']} KM",
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xFFBA780F),
                                                                            fontSize: 14.0,
                                                                            decoration: TextDecoration
                                                                                .underline),),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          4.0),
                                                                      child: Text(
                                                                        "Included",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize: 13.0),),
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment
                                                        .topRight,
                                                    child: Container(
                                                      width: 80.0,
                                                      margin: EdgeInsets.only(
                                                          top: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.02,
                                                          bottom: 7.0),
                                                      decoration: BoxDecoration(
                                                        border: Border(

                                                          left: BorderSide(
                                                              width: 1.0,
                                                              color: Colors
                                                                  .black),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .end,

                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .end,

                                                            children: [
                                                              Text("${doc['price']}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontSize: 20.0),),
                                                              Text("\$",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: 20.0),)
                                                            ],
                                                          ),
                                                          Text("Rent Price",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 14.0),),
                                                          // Row(
                                                          //   children: [
                                                          //     Text("Rent Price", style: TextStyle(color: Colors.black87, fontSize: 14.0),),
                                                          //   ],
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            );



                        }).toList(),

                            );
                          }
                        }
                        )

                        :StreamBuilder<QuerySnapshot>(
                        stream: packageCollection.snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Wrap(
                              direction: Axis.horizontal,
                              spacing: 30.0,
                              runSpacing: 40.0,
                              children: snapshot.data!.docs.map((doc)
                              {
                                return  InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                        // TaskCardWidget(id: user.id, name: user.ingredients,)
                                        UserViewCarDetails(widget.uid, doc['carid'], widget.city)));
                                  },
                                  child: Container(
                                    height: 235.0,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      // border: Border.all(color: Color(0xFFBA780F)),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${doc['coverimage']}'),
                                          fit: BoxFit.cover
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Column(
                                        children: [
                                          Container(

                                            // margin: const EdgeInsets.only(
                                            //     right: 1.0, left: 2.0),
                                            height: 90.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  20),
                                              //border: Border.all(color: Color(0xFFBA780F)),
                                              // color: Colors.black,
                                              gradient: LinearGradient(
                                                  begin: FractionalOffset
                                                      .bottomCenter,
                                                  end: FractionalOffset.topCenter,
                                                  colors: [
                                                    Colors.black87.withOpacity(
                                                        0.0),
                                                    Colors.black87,
                                                  ],
                                                  stops: [
                                                    0.0,
                                                    0.7
                                                  ]),


                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .end,
                                                children: [
                                                  Align(
                                                    alignment: Alignment.topRight,
                                                    child: Text(
                                                      "${doc['name']}"
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0),),),
                                                  Align(
                                                    alignment: Alignment.topRight,
                                                    child: Text("${doc['model']}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0),),),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            clipBehavior: Clip.antiAlias,
                                            margin: const EdgeInsets.only(
                                                top: 60.0),
                                            height: 85.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20.0),
                                                bottomRight: Radius.circular(
                                                    20.0),),
                                              //border: Border.all(color: Color(0xFFBA780F)),
                                              // color: Colors.black,
                                              gradient: LinearGradient(
                                                  begin: FractionalOffset
                                                      .topCenter,
                                                  end: FractionalOffset
                                                      .bottomCenter,
                                                  colors: [
                                                    Color(0xFFf2f2f2).withOpacity(
                                                        0.3),
                                                    Color(0xFFb3b3b3).withOpacity(
                                                        0.9),
                                                  ],
                                                  stops: [
                                                    0.0,
                                                    1.0
                                                  ]),


                                            ),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 3, sigmaY: 3),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 12.0,),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,

                                                  children: [
                                                    Align(
                                                      alignment: Alignment
                                                          .topLeft,
                                                      child: Container(
                                                        width: 100.0,

                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .end,

                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                  top: MediaQuery
                                                                      .of(context)
                                                                      .size
                                                                      .height *
                                                                      0.02),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .end,

                                                                children: [
                                                                  Text("${doc['topspeed']}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize: 20.0),),
                                                                  Text("km/h",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white54,
                                                                        fontSize: 16.0),)
                                                                ],
                                                              ),
                                                            ),
                                                            Text("Top Speed",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize: 14.0),),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment
                                                          .topCenter,
                                                      child: Container(
                                                        width: 230.0,

                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,

                                                          children: [

                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: 65.0,

                                                                  decoration: BoxDecoration(

                                                                    border: Border
                                                                        .all(
                                                                        color: Color(
                                                                            0xFFBA780F),
                                                                        width: 1.5),
                                                                  ),
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                      top: 2.0),

                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment
                                                                        .spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Icon(
                                                                          Icons
                                                                              .star,
                                                                          size: 20.0,
                                                                          color: Color(
                                                                              0xFFBA780F),),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Text(
                                                                          "Delivery",
                                                                          style: TextStyle(
                                                                              color: Color(
                                                                                  0xFFBA780F),
                                                                              fontSize: 14.0,
                                                                              decoration: TextDecoration
                                                                                  .underline),),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Text(
                                                                          "${doc['delivery']}",
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontSize: 13.0),),
                                                                      ),

                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(

                                                                  width: 65.0,
                                                                  decoration: BoxDecoration(

                                                                    border: Border
                                                                        .all(
                                                                        color: Color(
                                                                            0xFFBA780F),
                                                                        width: 1.5),
                                                                  ),
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                      top: 2.0),

                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment
                                                                        .spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Icon(
                                                                          Icons
                                                                              .directions_car_rounded,
                                                                          size: 20.0,
                                                                          color: Color(
                                                                              0xFFBA780F),),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Text(
                                                                          "Model",
                                                                          style: TextStyle(
                                                                              color: Color(
                                                                                  0xFFBA780F),
                                                                              fontSize: 14.0,
                                                                              decoration: TextDecoration
                                                                                  .underline),),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Text(
                                                                          "${doc['model']}",
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontSize: 13.0),),
                                                                      ),

                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 65.0,

                                                                  decoration: BoxDecoration(

                                                                    border: Border
                                                                        .all(
                                                                        color: Color(
                                                                            0xFFBA780F),
                                                                        width: 1.5),
                                                                  ),
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                      top: 2.0),

                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment
                                                                        .spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Icon(
                                                                          Icons
                                                                              .add_road,
                                                                          size: 20.0,
                                                                          color: Color(
                                                                              0xFFBA780F),),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Text(
                                                                          "${doc['distance']} KM",
                                                                          style: TextStyle(
                                                                              color: Color(
                                                                                  0xFFBA780F),
                                                                              fontSize: 14.0,
                                                                              decoration: TextDecoration
                                                                                  .underline),),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Text(
                                                                          "Included",
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontSize: 13.0),),
                                                                      ),

                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment
                                                          .topRight,
                                                      child: Container(
                                                        width: 80.0,
                                                        margin: EdgeInsets.only(
                                                            top: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.02,
                                                            bottom: 7.0),
                                                        decoration: BoxDecoration(
                                                          border: Border(

                                                            left: BorderSide(
                                                                width: 1.0,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .end,

                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .end,

                                                              children: [
                                                                Text("${doc['price']}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black87,
                                                                      fontSize: 20.0),),
                                                                Text("\$",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: 20.0),)
                                                              ],
                                                            ),
                                                            Text("Rent Price",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize: 14.0),),
                                                            // Row(
                                                            //   children: [
                                                            //     Text("Rent Price", style: TextStyle(color: Colors.black87, fontSize: 14.0),),
                                                            //   ],
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );



                              }).toList(),

                            );
                          }
                        }
                    );
                }
            ),
          ),
        ),

      ],
    );
  }
}
