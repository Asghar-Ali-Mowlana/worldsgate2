import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worldsgate/helper/extended_responsive_helper.dart';
import 'package:worldsgate/screens/user/userviewcardetails.dart';

import '../../helper/responsive_helper.dart';
import '../../widgets/cusheader.dart';
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

      drawer: new UserNavigationDrawer(widget.uid, widget.city),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ExtendedResponsiveWidget(
              mobile: buildColumnContent(context, "mobile", packageCollection, 70),
              tab: buildColumnContent(context, "tab", packageCollection, 100),
              tabextended: buildColumnContent(context, "tabextended", packageCollection, 100),
              desktop:
                  buildColumnContent(context, "desktop", packageCollection, 120),
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

  Column buildColumnContent(
      BuildContext context, String tex, Query<Object?> packageCollection, double headergap) {
    return Column(
      children: [
        SizedBox(
          height: headergap,
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 5.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                "Car Booking",
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
            child: LayoutBuilder(builder: (context, constraints) {
              return StreamBuilder<QuerySnapshot>(
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
                                runSpacing: 20.0,
                                children: snapshot.data!.docs.map((doc) {
                                  return carContainer(
                                     tex, context, doc);
                                }).toList(),
                              );
                            }
                          });
            }),
          ),
        ),
      ],
    );
  }

  InkWell carContainer(String tex, BuildContext context, QueryDocumentSnapshot<Object?> doc,
      ) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                UserViewCarDetails(widget.uid, doc["carid"], widget.city)));
      },
      child: Container(
        constraints:
        BoxConstraints(
            maxWidth:
            (tex=="desktop" || tex=="tabextended")
                ?450.0:double.infinity
        ),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              Container(
                foregroundDecoration: BoxDecoration(
                  border: Border.all(
                    color:
                    Color(0xFFBA780F), //                   <--- border color
                  ),
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.transparent,
                      Colors.transparent,
                      Color(0xFFf2f2f2).withOpacity(0.3),
                      Color(0xFFb3b3b3).withOpacity(0.9)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 0.4, 0.75, 0, 1],
                  ),
                ),

                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                    Color(0xFFBA780F), //                   <--- border color
                  ),

                  borderRadius: BorderRadius.circular(30),
                  // border: Border.all(color: Color(0xFFBA780F)),
                  image: DecorationImage(
                      image:
                      NetworkImage('${doc["coverimage"]}'),
                      fit: BoxFit.cover),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, bottom: 5.0, top: 20.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${doc["name"]}".toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, bottom: 5.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${doc["model"]}",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child:
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "AED",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                            Text(
                              "  ${doc["price"].toString()}",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, bottom: 15.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Rent Price",
                        style: TextStyle(
                            color: Colors.black87, fontSize: 14.0),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 200.0,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1,
                            bottom: 7.0),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(width: 1.0, color: Colors.black),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 14.0, bottom: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Delivery - ${doc["delivery"]}",
                                style: TextStyle(
                                    color: Color(0xFFBA780F),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Included - ${doc["distance"].toString()} KM",
                                style: TextStyle(
                                    color: Color(0xFFBA780F),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
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
      ),
    );
  }
}
