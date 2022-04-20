import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';
import 'package:worldsgate/helper/extended_responsive_helper.dart';
import 'package:worldsgate/screens/dataentryoperator/booking/yacht/deoaddyachtdetails.dart';
import 'package:worldsgate/widgets/deonavigationdrawer.dart';
import 'package:worldsgate/widgets/header.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/sidelayout.dart';
//import 'deoaddyachtdetails.dart';

class DeoManageYachts extends StatefulWidget {
  // const DeoManageYachts({ Key? key }) : super(key: key);
  String? uid;

  DeoManageYachts(this.uid);

  @override
  State<DeoManageYachts> createState() => _DeoManageYachtsState();
}

class _DeoManageYachtsState extends State<DeoManageYachts> {
  bool _isLoading = true;

  var _scaffoldState = new GlobalKey<ScaffoldState>();
  String? datecreated;
  String? yachtname;

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
        .collection('booking').doc("aGAm7T71ShOqGUhYphfc")
        .collection('yachts')
        .where('dataentryuid', isEqualTo: widget.uid)
        .get()
        .then((myDocuments) {
      print("${myDocuments.docs.length}");
      totaladded = myDocuments.docs.length;
    });
    await FirebaseFirestore.instance
        .collection('booking').doc("aGAm7T71ShOqGUhYphfc")
        .collection('yachts')
        .where('dataentryuid', isEqualTo: widget.uid)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                DateTime dt = (doc['datecreated'] as Timestamp).toDate();
                String formattedDate = DateFormat('yyyy/MM/dd').format(dt);

                // if (querySnapshot.docs.contains("price")) {
                //   dategroupbylist.add({
                //     "yachtid": doc.id,
                //     "name": '${doc['name']}',
                //     "build": '${doc['build']}',
                //     "coverimage": '${doc['coverimage']}',
                //     "price": '${doc['price']}',
                //     "delivery": '${doc['delivery']}',
                //     "model": '${doc['model']}',
                //     "color": '${doc['color']}',
                //     "added_date": '${formattedDate}',
                //     "age": '${doc['age']}',
                //   });
                // } else {
                dategroupbylist.add({
                  "yachtid": doc.id,
                  "name": '${doc['name']}',
                  "build": '${doc['build']}',
                  "capacity": '${doc['capacity']}',
                  "length": '${doc['length']}',
                  "coverimage": '${doc['coverimage']}',
                  "perhourprice": '${doc['perhourprice']}',
                  "dailyprice": '${doc['dailyprice']}',
                  "overnightguests": '${doc['overnightguests']}',
                  "added_date": '${formattedDate}',
                });
                //}
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

  List<Widget> newbuilder(double fontsize, double columntextwidth, String tex) {
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
      print("Number of yachts added on a specific date : " +
          entryList[i].value.length.toString());

      //entryList[i].value[j]["coverimage"]
      for (int j = 0; j < entryList[i].value.length; j++) {
        m.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: yachtContainer(i, j, context, tex)
          ),
        );
      }
    }

    return m;
  }

  InkWell yachtContainer(int i, int j, BuildContext context, String tex) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) =>
        //         DeoViewyachtDetails(widget.uid, entryList[i].value[j]["yachtid"])));
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
                          NetworkImage('${entryList[i].value[j]["coverimage"]}'),
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
                        "${entryList[i].value[j]["name"]}".toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, bottom: 5.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${entryList[i].value[j]["build"]}",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child:
                    AspectRatio(
                      aspectRatio: 16/10,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                          "  ${entryList[i].value[j]["perhourprice"].toString()}",
                                          style: TextStyle(
                                              color: Colors.black87, fontSize: 20.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
                                          "  ${entryList[i].value[j]["dailyprice"].toString()}",
                                          style: TextStyle(
                                              color: Colors.black87, fontSize: 20.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 14.0, bottom: 15.0),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Per Hour Price",
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 14.0),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 14.0, bottom: 15.0),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Daily Price",
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 14.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
                        width: 150.0,
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
                                "Capacity - ${entryList[i].value[j]["capacity"]}",
                                style: TextStyle(
                                    color: Color(0xFFBA780F),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Length - ${entryList[i].value[j]["length"].toString()} ft",
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
                ExtendedResponsiveWidget(
                    mobile: buildColumnContent(context, "mobile", 14, 350.0, 70),
                    tab: buildColumnContent(context, "tab", 16, 800.0, 100),
                    tabextended: buildColumnContent(context, "tabextended", 16, 800.0, 100),
                    desktop: buildColumnContent(context, "desktop", 16, 800.0, 100)),
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
      BuildContext context, String tex, double fontshize, double columntextwidth, double headergap) {
    return Column(
      children: [
        SizedBox(
          height: headergap,
        ),

        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (tex == "desktop") ? SideLayout() : Container(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      //row for button and booking yacht heading
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
                                  "Booking > Yacht (${totaladded.toString()})  $tex",
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
                                        // TaskyachtdWidget(id: user.id, name: user.ingredients,)
                                        AddYachtDetails(widget.uid)));
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
                            children: newbuilder(fontshize, columntextwidth, tex),
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
    );
  }
}
