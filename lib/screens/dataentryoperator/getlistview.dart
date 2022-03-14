import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';
import 'package:worldsgate/screens/user/userhotelbooking.dart';
import 'package:worldsgate/widgets/deonavigationdrawer.dart';
import 'package:worldsgate/widgets/header.dart';
import 'package:intl/intl.dart';
import '../../widgets/sidelayout.dart';

class DeoManageHotels extends StatefulWidget {
  //const DeoManageHotels({Key? key}) : super(key: key);


  String? uid;

  // //constructor
  // DeoManageHotels(
  //     this.uid,
  //     );

  @override
  _DeoManageHotelsState createState() => _DeoManageHotelsState();
}

class _DeoManageHotelsState extends State<DeoManageHotels> {


  var _scaffoldState = new GlobalKey<ScaffoldState>();

  String? datecreated;
  String? hotelname;

  List<Map> dategroupbylist = <Map>[];

  getyo() async {


    await FirebaseFirestore.instance
        .collection('hotels')

        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {


        DateTime dt = (doc['datecreated'] as Timestamp).toDate();
        String formattedDate = DateFormat('yyyy/MM/dd').format(dt);



        dategroupbylist.add({"hotel_name": '${doc['name']}', "added_date": '${formattedDate}',});

     })
    });

    final maps = dategroupbylist.groupBy<String, Map>((item) =>
    item['added_date'],
      valueTransform: (item) => item..remove('added_date'),
    );
    print(maps);






  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getyo();
  }

  @override
  Widget build(BuildContext context) {
    //final double height = MediaQuery.of(context).size.height;



    return SafeArea(child: Scaffold(
      key: _scaffoldState,

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   iconTheme: IconThemeData(color: Color(0xFFdb9e1f)),
      // ),

      endDrawer: new DeoNavigationDrawer(),

      drawer: new DeoNavigationDrawer(),



      backgroundColor: Color(0xFF000000),
      body: Stack(
        children: [
          Column(
            children: [







              SizedBox(
                height: 160.0,
              ),




              Expanded(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SideLayout(),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            //row for button and booking hotel heading
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 14.0),
                                      child: Text(
                                        "Booking > Hotel",
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
                                            side: BorderSide(color: Color(0xFFdb9e1f))
                                        ),

                                        elevation: 5.0,
                                        height: 40,
                                        onPressed: () {
                                          // Navigator.of(context).push(MaterialPageRoute(
                                          //     builder: (context) =>
                                          //     // TaskCardWidget(id: user.id, name: user.ingredients,)
                                          //     UserHomePage(
                                          //
                                          //
                                          //     )));


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
                                child: Column(
                                  children: [


                                    Text("10/02/2022", style: TextStyle(
                                      color: Colors.white
                                    ),),
                                    StreamBuilder(

                                      stream: FirebaseFirestore.instance
                                          .collection('hotels')
                                          .snapshots(),
                                      builder:
                                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                                        if (!snapshot.hasData) {
                                          return Center(child: CircularProgressIndicator());
                                        }

                                        return ListView.builder(

                                            shrinkWrap: true,
                                            itemCount: snapshot.data?.docs.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16.0, left: 10.0, right: 10.0),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Stack(
                                                    children: [
                                                      InkWell(
                                                        onTap: (){

                                                        },
                                                        child: Container(
                                                          height: MediaQuery.of(context).size.height /8,
                                                          width: MediaQuery.of(context).size.width,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                            border: Border.all(color: Color(0xFFBA780F)),
                                                          ),
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
                                                                      "${snapshot.data!.docs[index]['name']
                                                                          .toString()}",
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Row(
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


                                                                  Text(
                                                                    "Price for 1 night 2 adults",
                                                                    style: TextStyle(
                                                                      fontSize: 12,
                                                                      color: Color(0xFFBA780F),
                                                                    ),
                                                                  ),
                                                                  //price
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(
                                                                        top: 2.0, bottom: 2.0),
                                                                    child: Text(
                                                                      "Price ${snapshot.data!.docs[index]['price']} AED",
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  //taxcharge
                                                                  // Text(
                                                                  //   "${snapshot.data!.docs[index]['taxandcharges']} AED Taxes and Charges",
                                                                  //   style: TextStyle(
                                                                  //     fontSize: 12,
                                                                  //     color: Colors.white,
                                                                  //   ),
                                                                  // ),
                                                                  // //cancellation fee
                                                                  // Padding(
                                                                  //   padding:
                                                                  //   const EdgeInsets.only(top: 2.0),
                                                                  //   child: Text(
                                                                  //     "${snapshot.data!.docs[index]['cancellationfee']}% for Cancellation",
                                                                  //     style: TextStyle(
                                                                  //       fontSize: 12,
                                                                  //       color: Color(0xFFBA780F),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ],
                                                              ),

                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: MediaQuery.of(context).size.height /8,
                                                        width: MediaQuery.of(context).size.width/9,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20),
                                                          image: DecorationImage(
                                                            image: NetworkImage(snapshot.data!.docs[index]['coverimage']),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              margin: const EdgeInsets.only(
                                                                  top: 60.0, right: 0.0),
                                                              height: 80.0,
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
                                                                          top:6.0, right: 0.0),
                                                                      child: Column(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                            Alignment.bottomCenter,
                                                                            child: Text(
                                                                              "${snapshot.data!.docs[index]['promotion']}% off",
                                                                              style: TextStyle(
                                                                                fontSize: 20,
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
                                              );
                                            });
                                      },
                                    ),

                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('hotels')
                                          .snapshots(),
                                      builder:
                                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(child: CircularProgressIndicator());
                                        }
                                        return ListView.builder(

                                            shrinkWrap: true,
                                            itemCount: snapshot.data?.docs.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16.0, left: 10.0, right: 10.0),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Stack(
                                                    children: [
                                                      InkWell(
                                                        onTap: (){

                                                        },
                                                        child: Container(
                                                          height: MediaQuery.of(context).size.height /8,
                                                          width: MediaQuery.of(context).size.width,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                            border: Border.all(color: Color(0xFFBA780F)),
                                                          ),
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
                                                                      "${snapshot.data!.docs[index]['name']
                                                                          .toString()}",
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Row(
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


                                                                  Text(
                                                                    "Price for 1 night 2 adults",
                                                                    style: TextStyle(
                                                                      fontSize: 12,
                                                                      color: Color(0xFFBA780F),
                                                                    ),
                                                                  ),
                                                                  //price
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(
                                                                        top: 2.0, bottom: 2.0),
                                                                    child: Text(
                                                                      "Price ${snapshot.data!.docs[index]['price']} AED",
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  //taxcharge
                                                                  // Text(
                                                                  //   "${snapshot.data!.docs[index]['taxandcharges']} AED Taxes and Charges",
                                                                  //   style: TextStyle(
                                                                  //     fontSize: 12,
                                                                  //     color: Colors.white,
                                                                  //   ),
                                                                  // ),
                                                                  // //cancellation fee
                                                                  // Padding(
                                                                  //   padding:
                                                                  //   const EdgeInsets.only(top: 2.0),
                                                                  //   child: Text(
                                                                  //     "${snapshot.data!.docs[index]['cancellationfee']}% for Cancellation",
                                                                  //     style: TextStyle(
                                                                  //       fontSize: 12,
                                                                  //       color: Color(0xFFBA780F),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ],
                                                              ),

                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: MediaQuery.of(context).size.height /8,
                                                        width: MediaQuery.of(context).size.width/9,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20),
                                                          image: DecorationImage(
                                                            image: NetworkImage(snapshot.data!.docs[index]['coverimage']),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              margin: const EdgeInsets.only(
                                                                  top: 60.0, right: 0.0),
                                                              height: 80.0,
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
                                                                          top:6.0, right: 0.0),
                                                                      child: Column(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                            Alignment.bottomCenter,
                                                                            child: Text(
                                                                              "${snapshot.data!.docs[index]['promotion']}% off",
                                                                              style: TextStyle(
                                                                                fontSize: 20,
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
                                              );
                                            });
                                      },
                                    ),

                                    Text("10/02/2022", style: TextStyle(
                                        color: Colors.white
                                    ),),

                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('hotels')
                                          .snapshots(),
                                      builder:
                                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(child: CircularProgressIndicator());
                                        }
                                        return ListView.builder(

                                            shrinkWrap: true,
                                            itemCount: snapshot.data?.docs.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16.0, left: 10.0, right: 10.0),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Stack(
                                                    children: [
                                                      InkWell(
                                                        onTap: (){

                                                        },
                                                        child: Container(
                                                          height: MediaQuery.of(context).size.height /8,
                                                          width: MediaQuery.of(context).size.width,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                            border: Border.all(color: Color(0xFFBA780F)),
                                                          ),
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
                                                                      "${snapshot.data!.docs[index]['name']
                                                                          .toString()}",
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Row(
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


                                                                  Text(
                                                                    "Price for 1 night 2 adults",
                                                                    style: TextStyle(
                                                                      fontSize: 12,
                                                                      color: Color(0xFFBA780F),
                                                                    ),
                                                                  ),
                                                                  //price
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(
                                                                        top: 2.0, bottom: 2.0),
                                                                    child: Text(
                                                                      "Price ${snapshot.data!.docs[index]['price']} AED",
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  //taxcharge
                                                                  // Text(
                                                                  //   "${snapshot.data!.docs[index]['taxandcharges']} AED Taxes and Charges",
                                                                  //   style: TextStyle(
                                                                  //     fontSize: 12,
                                                                  //     color: Colors.white,
                                                                  //   ),
                                                                  // ),
                                                                  // //cancellation fee
                                                                  // Padding(
                                                                  //   padding:
                                                                  //   const EdgeInsets.only(top: 2.0),
                                                                  //   child: Text(
                                                                  //     "${snapshot.data!.docs[index]['cancellationfee']}% for Cancellation",
                                                                  //     style: TextStyle(
                                                                  //       fontSize: 12,
                                                                  //       color: Color(0xFFBA780F),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ],
                                                              ),

                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: MediaQuery.of(context).size.height /8,
                                                        width: MediaQuery.of(context).size.width/9,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20),
                                                          image: DecorationImage(
                                                            image: NetworkImage(snapshot.data!.docs[index]['coverimage']),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              margin: const EdgeInsets.only(
                                                                  top: 60.0, right: 0.0),
                                                              height: 80.0,
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
                                                                          top:6.0, right: 0.0),
                                                                      child: Column(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                            Alignment.bottomCenter,
                                                                            child: Text(
                                                                              "${snapshot.data!.docs[index]['promotion']}% off",
                                                                              style: TextStyle(
                                                                                fontSize: 20,
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
                                              );
                                            });
                                      },
                                    ),

                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('hotels')
                                          .snapshots(),
                                      builder:
                                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(child: CircularProgressIndicator());
                                        }
                                        return ListView.builder(

                                            shrinkWrap: true,
                                            itemCount: snapshot.data?.docs.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16.0, left: 10.0, right: 10.0),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Stack(
                                                    children: [
                                                      InkWell(
                                                        onTap: (){

                                                        },
                                                        child: Container(
                                                          height: MediaQuery.of(context).size.height /8,
                                                          width: MediaQuery.of(context).size.width,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                            border: Border.all(color: Color(0xFFBA780F)),
                                                          ),
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
                                                                      "${snapshot.data!.docs[index]['name']
                                                                          .toString()}",
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Row(
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


                                                                  Text(
                                                                    "Price for 1 night 2 adults",
                                                                    style: TextStyle(
                                                                      fontSize: 12,
                                                                      color: Color(0xFFBA780F),
                                                                    ),
                                                                  ),
                                                                  //price
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(
                                                                        top: 2.0, bottom: 2.0),
                                                                    child: Text(
                                                                      "Price ${snapshot.data!.docs[index]['price']} AED",
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  //taxcharge
                                                                  // Text(
                                                                  //   "${snapshot.data!.docs[index]['taxandcharges']} AED Taxes and Charges",
                                                                  //   style: TextStyle(
                                                                  //     fontSize: 12,
                                                                  //     color: Colors.white,
                                                                  //   ),
                                                                  // ),
                                                                  // //cancellation fee
                                                                  // Padding(
                                                                  //   padding:
                                                                  //   const EdgeInsets.only(top: 2.0),
                                                                  //   child: Text(
                                                                  //     "${snapshot.data!.docs[index]['cancellationfee']}% for Cancellation",
                                                                  //     style: TextStyle(
                                                                  //       fontSize: 12,
                                                                  //       color: Color(0xFFBA780F),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ],
                                                              ),

                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: MediaQuery.of(context).size.height /8,
                                                        width: MediaQuery.of(context).size.width/9,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20),
                                                          image: DecorationImage(
                                                            image: NetworkImage(snapshot.data!.docs[index]['coverimage']),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              margin: const EdgeInsets.only(
                                                                  top: 60.0, right: 0.0),
                                                              height: 80.0,
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
                                                                          top:6.0, right: 0.0),
                                                                      child: Column(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                            Alignment.bottomCenter,
                                                                            child: Text(
                                                                              "${snapshot.data!.docs[index]['promotion']}% off",
                                                                              style: TextStyle(
                                                                                fontSize: 20,
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
                                              );
                                            });
                                      },
                                    ),

                                    Text("10/02/2022", style: TextStyle(
                                        color: Colors.white
                                    ),),

                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('hotels')
                                          .snapshots(),
                                      builder:
                                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(child: CircularProgressIndicator());
                                        }
                                        return ListView.builder(

                                            shrinkWrap: true,
                                            itemCount: snapshot.data?.docs.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16.0, left: 10.0, right: 10.0),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Stack(
                                                    children: [
                                                      InkWell(
                                                        onTap: (){

                                                        },
                                                        child: Container(
                                                          height: MediaQuery.of(context).size.height /8,
                                                          width: MediaQuery.of(context).size.width,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                            border: Border.all(color: Color(0xFFBA780F)),
                                                          ),
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
                                                                      "${snapshot.data!.docs[index]['name']
                                                                          .toString()}",
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Row(
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


                                                                  Text(
                                                                    "Price for 1 night 2 adults",
                                                                    style: TextStyle(
                                                                      fontSize: 12,
                                                                      color: Color(0xFFBA780F),
                                                                    ),
                                                                  ),
                                                                  //price
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(
                                                                        top: 2.0, bottom: 2.0),
                                                                    child: Text(
                                                                      "Price ${snapshot.data!.docs[index]['price']} AED",
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  //taxcharge
                                                                  // Text(
                                                                  //   "${snapshot.data!.docs[index]['taxandcharges']} AED Taxes and Charges",
                                                                  //   style: TextStyle(
                                                                  //     fontSize: 12,
                                                                  //     color: Colors.white,
                                                                  //   ),
                                                                  // ),
                                                                  // //cancellation fee
                                                                  // Padding(
                                                                  //   padding:
                                                                  //   const EdgeInsets.only(top: 2.0),
                                                                  //   child: Text(
                                                                  //     "${snapshot.data!.docs[index]['cancellationfee']}% for Cancellation",
                                                                  //     style: TextStyle(
                                                                  //       fontSize: 12,
                                                                  //       color: Color(0xFFBA780F),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ],
                                                              ),

                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: MediaQuery.of(context).size.height /8,
                                                        width: MediaQuery.of(context).size.width/9,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20),
                                                          image: DecorationImage(
                                                            image: NetworkImage(snapshot.data!.docs[index]['coverimage']),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              margin: const EdgeInsets.only(
                                                                  top: 60.0, right: 0.0),
                                                              height: 80.0,
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
                                                                          top:6.0, right: 0.0),
                                                                      child: Column(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                            Alignment.bottomCenter,
                                                                            child: Text(
                                                                              "${snapshot.data!.docs[index]['promotion']}% off",
                                                                              style: TextStyle(
                                                                                fontSize: 20,
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
                                              );
                                            });
                                      },
                                    ),

                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('hotels')
                                          .snapshots(),
                                      builder:
                                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(child: CircularProgressIndicator());
                                        }
                                        return ListView.builder(

                                            shrinkWrap: true,
                                            itemCount: snapshot.data?.docs.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16.0, left: 10.0, right: 10.0),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Stack(
                                                    children: [
                                                      InkWell(
                                                        onTap: (){

                                                        },
                                                        child: Container(
                                                          height: MediaQuery.of(context).size.height /8,
                                                          width: MediaQuery.of(context).size.width,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                            border: Border.all(color: Color(0xFFBA780F)),
                                                          ),
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
                                                                      "${snapshot.data!.docs[index]['name']
                                                                          .toString()}",
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Row(
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


                                                                  Text(
                                                                    "Price for 1 night 2 adults",
                                                                    style: TextStyle(
                                                                      fontSize: 12,
                                                                      color: Color(0xFFBA780F),
                                                                    ),
                                                                  ),
                                                                  //price
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(
                                                                        top: 2.0, bottom: 2.0),
                                                                    child: Text(
                                                                      "Price ${snapshot.data!.docs[index]['price']} AED",
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  //taxcharge
                                                                  // Text(
                                                                  //   "${snapshot.data!.docs[index]['taxandcharges']} AED Taxes and Charges",
                                                                  //   style: TextStyle(
                                                                  //     fontSize: 12,
                                                                  //     color: Colors.white,
                                                                  //   ),
                                                                  // ),
                                                                  // //cancellation fee
                                                                  // Padding(
                                                                  //   padding:
                                                                  //   const EdgeInsets.only(top: 2.0),
                                                                  //   child: Text(
                                                                  //     "${snapshot.data!.docs[index]['cancellationfee']}% for Cancellation",
                                                                  //     style: TextStyle(
                                                                  //       fontSize: 12,
                                                                  //       color: Color(0xFFBA780F),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ],
                                                              ),

                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: MediaQuery.of(context).size.height /8,
                                                        width: MediaQuery.of(context).size.width/9,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20),
                                                          image: DecorationImage(
                                                            image: NetworkImage(snapshot.data!.docs[index]['coverimage']),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              margin: const EdgeInsets.only(
                                                                  top: 60.0, right: 0.0),
                                                              height: 80.0,
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
                                                                          top:6.0, right: 0.0),
                                                                      child: Column(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                            Alignment.bottomCenter,
                                                                            child: Text(
                                                                              "${snapshot.data!.docs[index]['promotion']}% off",
                                                                              style: TextStyle(
                                                                                fontSize: 20,
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
                                              );
                                            });
                                      },
                                    ),

                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('hotels')
                                          .snapshots(),
                                      builder:
                                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(child: CircularProgressIndicator());
                                        }
                                        return ListView.builder(

                                            shrinkWrap: true,
                                            itemCount: snapshot.data?.docs.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16.0, left: 10.0, right: 10.0),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Stack(
                                                    children: [
                                                      InkWell(
                                                        onTap: (){

                                                        },
                                                        child: Container(
                                                          height: MediaQuery.of(context).size.height /8,
                                                          width: MediaQuery.of(context).size.width,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                            border: Border.all(color: Color(0xFFBA780F)),
                                                          ),
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
                                                                      "${snapshot.data!.docs[index]['name']
                                                                          .toString()}",
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Row(
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


                                                                  Text(
                                                                    "Price for 1 night 2 adults",
                                                                    style: TextStyle(
                                                                      fontSize: 12,
                                                                      color: Color(0xFFBA780F),
                                                                    ),
                                                                  ),
                                                                  //price
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(
                                                                        top: 2.0, bottom: 2.0),
                                                                    child: Text(
                                                                      "Price ${snapshot.data!.docs[index]['price']} AED",
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  //taxcharge
                                                                  // Text(
                                                                  //   "${snapshot.data!.docs[index]['taxandcharges']} AED Taxes and Charges",
                                                                  //   style: TextStyle(
                                                                  //     fontSize: 12,
                                                                  //     color: Colors.white,
                                                                  //   ),
                                                                  // ),
                                                                  // //cancellation fee
                                                                  // Padding(
                                                                  //   padding:
                                                                  //   const EdgeInsets.only(top: 2.0),
                                                                  //   child: Text(
                                                                  //     "${snapshot.data!.docs[index]['cancellationfee']}% for Cancellation",
                                                                  //     style: TextStyle(
                                                                  //       fontSize: 12,
                                                                  //       color: Color(0xFFBA780F),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ],
                                                              ),

                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: MediaQuery.of(context).size.height /8,
                                                        width: MediaQuery.of(context).size.width/9,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20),
                                                          image: DecorationImage(
                                                            image: NetworkImage(snapshot.data!.docs[index]['coverimage']),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              margin: const EdgeInsets.only(
                                                                  top: 60.0, right: 0.0),
                                                              height: 80.0,
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
                                                                          top:6.0, right: 0.0),
                                                                      child: Column(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                            Alignment.bottomCenter,
                                                                            child: Text(
                                                                              "${snapshot.data!.docs[index]['promotion']}% off",
                                                                              style: TextStyle(
                                                                                fontSize: 20,
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
                                              );
                                            });
                                      },
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












            ],
          ),
          Positioned(
              left: 0.0,
              top: 0.0,
              right: 0.0,

              child: Container(
                  child: VendomeHeader(drawer: _scaffoldState))),
        ],
      ),

    ));
  }
}
