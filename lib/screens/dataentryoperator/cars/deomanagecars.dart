import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';
import 'package:worldsgate/helper/responsive_helper.dart';
import 'package:worldsgate/screens/dataentryoperator/cars/deoaddcars.dart';
import 'package:worldsgate/screens/dataentryoperator/cars/deoviewcars.dart';
import 'package:worldsgate/screens/user/usercarbooking.dart';
import 'package:worldsgate/widgets/deonavigationdrawer.dart';
import 'package:worldsgate/widgets/header.dart';
import 'package:intl/intl.dart';
import '../../../widgets/sidelayout.dart';
//import 'deoaddcardetails.dart';

class DeoManageCars extends StatefulWidget {
  // const DeoManageCars({ Key? key }) : super(key: key);
  String? uid;

  DeoManageCars(this.uid);

  @override
  State<DeoManageCars> createState() => _DeoManageCarsState();
}

class _DeoManageCarsState extends State<DeoManageCars> {
  bool _isLoading = true;

  var _scaffoldState = new GlobalKey<ScaffoldState>();
  String? datecreated;
  String? carname;

  List<Map> dategroupbylist = <Map>[];

  var entryList;
  var subEntryList;
  var testList;
  var newMap;
  var subNewMap;

  int? totaladded;

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

  getyo() async {
    FirebaseFirestore.instance
        .collection('cars')
        .where('dataentryuid', isEqualTo: widget.uid)
        .get()
        .then((myDocuments) {
      print("${myDocuments.docs.length}");
      totaladded = myDocuments.docs.length;
    });
    await FirebaseFirestore.instance
        .collection('cars')
        .where('dataentryuid', isEqualTo: widget.uid)
        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        DateTime dt = (doc['datecreated'] as Timestamp).toDate();
        String formattedDate = DateFormat('yyyy/MM/dd').format(dt);

        if (querySnapshot.docs.contains("price")) {
          dategroupbylist.add({
            "carid": doc.id,
            "name": '${doc['name']}',
            "brand": '${doc['brand']}',
            "coverimage": '${doc['coverimage']}',
            "price": '${doc['price']}',
            "delivery": '${doc['delivery']}',
            "model": '${doc['model']}',
            "color": '${doc['color']}',
            "added_date": '${formattedDate}',
            "age": '${doc['age']}',
          });
        } else {
          dategroupbylist.add({
            "carid": doc.id,
            "name": '${doc['name']}',
            "brand": '${doc['brand']}',
            "coverimage": '${doc['coverimage']}',
            "delivery": '${doc['delivery']}',
            "model": '${doc['model']}',
            "color": '${doc['color']}',
            "added_date": '${formattedDate}',
            "age": '${doc['age']}',
          });
        }
      })
    });

    final maps = dategroupbylist.groupBy<String, Map>(
          (item) => item['added_date'],
      valueTransform: (item) => item..remove('added_date'),
    );

    try {
      //print(maps);
      setState(() {
        newMap = maps;
        entryList = maps.entries.toList()
          ..sort((e1, e2) => e2.key.compareTo(e1.key));
        // var sortMapByValue = Map.fromEntries(
        //     maps.entries.toList()
        //       ..sort((e1, e2) => e1.key.compareTo(e2.key)));
      });

      setState(() {
        testList = entryList[0].value[0].entries.toList();
      });

      //print(testList[0].key);
    } catch (e) {
      print(e);
    }
  }





  List<Widget> newbuilder(double fontsize, double columntextwidth) {
    List<Widget> m = [];

    for (int i = 0; i < entryList.length; i++) {
      //print(entryList.length);

      m.add(Container(
        width: double.infinity,
        //heigh: double.infinity,
        margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Column(
          children: [
            Text(
              "${entryList[i].key} (${entryList[i].value.length.toString()})",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ));
      print("Number of cars added on a specific date : " +
          entryList[i].value.length.toString());

      //entryList[i].value[j]["coverimage"]
      for (int j = 0; j < entryList[i].value.length; j++) {
        m.add(
          Column(

            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LayoutBuilder(

                    builder: (context, constraints) {
                      return

                      //tab
                        (constraints.maxWidth >= 920 && constraints.maxWidth < 1380)
                            ?

                        CarContainer(i, j, context, 235.0, 450)


                            : (constraints.maxWidth >= 1380)
                            ?   CarContainer(i, j, context, 235.0, 450)

                            :   CarContainer(i, j, context, 235.0, double.infinity);
                    }
                ),
              ),

            ],
          ),
        );
      }
    }

    return m;
  }

  InkWell CarContainer(int i, int j, BuildContext context, double conheight, double conwidth) {
    return InkWell(
                        onTap: (){
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) =>
                          //     // TaskCardWidget(id: user.id, name: user.ingredients,)
                          //     UserViewCarDetails(widget.uid, doc['carid'], widget.city)));
                        },
                        child: Container(
                          height: conheight,
                          width: conwidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            // border: Border.all(color: Color(0xFFBA780F)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    '${entryList[i].value[j]["coverimage"]}'),
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
                                            "${entryList[i].value[j]["name"]}"
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0),),),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text("${entryList[i].value[j]["model"]}",
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
                                          // Align(
                                          //   alignment: Alignment
                                          //       .topLeft,
                                          //   child: Container(
                                          //     width: 100.0,
                                          //
                                          //     child: Column(
                                          //       crossAxisAlignment: CrossAxisAlignment
                                          //           .end,
                                          //
                                          //       children: [
                                          //         Container(
                                          //           margin: EdgeInsets
                                          //               .only(
                                          //               top: MediaQuery
                                          //                   .of(context)
                                          //                   .size
                                          //                   .height *
                                          //                   0.02),
                                          //           child: Row(
                                          //             mainAxisAlignment: MainAxisAlignment
                                          //                 .end,
                                          //
                                          //             children: [
                                          //               Text("${entryList[i].value[j]["topspeed"]}",
                                          //                 style: TextStyle(
                                          //                     color: Colors
                                          //                         .white,
                                          //                     fontSize: 20.0),),
                                          //               Text("km/h",
                                          //                 style: TextStyle(
                                          //                     color: Colors
                                          //                         .white54,
                                          //                     fontSize: 16.0),)
                                          //             ],
                                          //           ),
                                          //         ),
                                          //         Text("Top Speed",
                                          //           style: TextStyle(
                                          //               color: Colors
                                          //                   .black87,
                                          //               fontSize: 14.0),),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
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
                                                            top: 2.0, left: 20.0),

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
                                                                "${entryList[i].value[j]["delivery"]}",
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
                                                                "${entryList[i].value[j]["model"]}",
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
                                                                "${entryList[i].value[j]["distance"]} KM",
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
                                                      Text("${entryList[i].value[j]["price"]}",
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getyo();
    getname();

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key: _scaffoldState,

          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0.0,
          //   iconTheme: IconThemeData(color: Color(0xFFdb9e1f)),
          // ),

          //endDrawer: new DeoNavigationDrawer(),

          drawer: new DeoNavigationDrawer(widget.uid),

          backgroundColor: Color(0xFF000000),
          body: (_isLoading == true)
              ? Center(child: CircularProgressIndicator())
              : Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ResponsiveWidget(
                  mobile: buildColumnContent(context, 14, 350.0),
                  tab: buildColumnContent(context, 16, 800.0),
                  desktop: buildColumnContent(context, 16, 800.0)),
              Positioned(
                  left: 0.0,
                  top: 0.0,
                  right: 0.0,
                  child: Container(
                      child: VendomeHeader(
                        drawer: _scaffoldState,
                        cusname: cusname,
                        cusaddress: "",
                        role: role,
                      ))),
            ],
          ),
        ));
  }

  Column buildColumnContent(
      BuildContext context, double fontshize, double columntextwidth) {
    return Column(
      children: [
        SizedBox(
          height: 160.0,
        ),

        Expanded(
          child: LayoutBuilder(builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (constraints.maxWidth >= 1008) ? SideLayout() : Container(),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        //row for button and booking car heading
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 14.0),
                                  child: Text(
                                    "Booking > Car (${totaladded.toString()})",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        side: BorderSide(
                                            color: Color(0xFFdb9e1f))),
                                    elevation: 5.0,
                                    height: 40,
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                          // TaskCardWidget(id: user.id, name: user.ingredients,)
                                          AddCarDetails(widget.uid)));
                                    },
                                    child: Text(
                                      "+ Add new",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFFdb9e1f),
                                      ),
                                    ),
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Wrap(
                              direction: Axis.horizontal,
                              spacing: 10.0,
                              runSpacing: 10.0,
                              children: newbuilder(fontshize, columntextwidth),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),

        // Container(
        //   child: Column(
        //     children: newbuilder(),
        //   ),
        // ),
      ],
    );
  }
}
