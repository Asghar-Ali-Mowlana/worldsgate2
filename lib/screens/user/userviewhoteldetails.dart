import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:worldsgate/widgets/header.dart';

import '../../widgets/usernavigationdrawer.dart';

class UserViewHotelDetails extends StatefulWidget {
  //const UserViewHotelDetails({Key? key}) : super(key: key);
  String? uid;
  String? hotelid;
  String? city;

  UserViewHotelDetails(this.uid, this.hotelid, this.city);

  @override
  _UserViewHotelDetailsState createState() =>
      _UserViewHotelDetailsState(hotelid);
}

class _UserViewHotelDetailsState extends State<UserViewHotelDetails> {
  var _scaffoldState = new GlobalKey<ScaffoldState>();
  String? hotelid;
  _UserViewHotelDetailsState(this.hotelid);

  bool _isLoading = true;

  var lisst;
  var x = [];
  var y;
  var name;
  var stars;
  var address;
  var description;
  var otherHotelImages;
  var mainfacilities = [];
  var subFacilities;

  List<Map> rooms = <Map>[];

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

  getyo() async {
    print("The hotel ID is " + hotelid.toString());
    await FirebaseFirestore.instance
        .collection('hotels')
        .doc(hotelid.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        name = documentSnapshot['name'];
        address = documentSnapshot['address'];
        description = documentSnapshot['description'];

        if ((documentSnapshot.data() as Map<String, dynamic>)
            .containsKey('otherhotelimages')) {
          x = documentSnapshot['otherhotelimages'].toList();
        }
        if ((documentSnapshot.data() as Map<String, dynamic>)
            .containsKey('coverimage')) {
          y = documentSnapshot['coverimage'];
        }

        if ((documentSnapshot.data() as Map<String, dynamic>)
            .containsKey('stars')) {
          stars = documentSnapshot['stars'];
        }
        if ((documentSnapshot.data() as Map<String, dynamic>)
            .containsKey('mainfacilities')) {
          mainfacilities = documentSnapshot['mainfacilities'].toList();
        }
        if ((documentSnapshot.data() as Map<String, dynamic>)
            .containsKey('subfacilities')) {
          subFacilities = documentSnapshot['subfacilities'];
        }
        if ((documentSnapshot.data() as Map<String, dynamic>)
            .containsKey('rooms')) {
          rooms.add(
            documentSnapshot['rooms'],
          );
        }
      } else {
        print("The document does not exist");
      }
    });

    try {
      setState(() {
        otherHotelImages = x;
      });
    } catch (e) {
      print(e);
    }
  }

  List<Widget> imageBuilderOne() {
    List<Widget> m = [];
    int numberOfImagesDisplayed =
        otherHotelImages.length >= 2 ? 2 : otherHotelImages.length;
    for (int i = 0; i < numberOfImagesDisplayed; i++) {
      m.add(
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 4.45,
                width: MediaQuery.of(context).size.width / 3.05,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(otherHotelImages[i].toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return m;
  }

  List<Widget> imageBuilderTwo() {
    List<Widget> m = [];
    int numberOfImagesDisplayed =
        otherHotelImages.length >= 5 ? 5 : otherHotelImages.length;
    for (int i = 2; i < numberOfImagesDisplayed; i++) {
      m.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 7.5,
                width: MediaQuery.of(context).size.width / 3.62,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(otherHotelImages[i].toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return m;
  }

  List<Widget> imageBuilderThree() {
    List<Widget> m = [];

    m.add(Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: imageBuilderOne(),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.18,
                    width: MediaQuery.of(context).size.width / 1.90,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(y.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        Row(
          children: imageBuilderTwo(),
        )
      ],
    ));
    return m;
  }

  List<Widget> mainfacilitiez() {
    List<Widget> m = [];
    for (int i = 0; i < mainfacilities.length; i++) {
      m.add(Container(
        width: MediaQuery.of(context).size.width / 2.28,
        child: Row(
          children: [
            Icon(
              Icons.check,
              color: Color(0xFFb38219),
            ),
            SizedBox(
              width: 10.0,
            ),
            Flexible(
              child: Text(
                mainfacilities[i].toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ));
    }
    return m;
  }

  // Sub-Facilities Start
  List<Widget> allSubFacilitiesKeys() {
    List<Widget> m = [];
    subFacilities.forEach((k, v) {
      print('{ key: $k, value: $v }');
      m.add(Container(
        child: Column(
          children: [
            Container(
                //width: MediaQuery.of(context).size.width / 5.00,
                height: MediaQuery.of(context).size.height / 19,
                //decoration: BoxDecoration(
                //border: Border.all(color: Color(0xFFdb9e1f)),
                //color: Color(0xFFdb9e1f),
                //),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "$k",
                      style: TextStyle(color: Colors.white70, fontSize: 16.0),
                    ))),
            Container(
              //width: MediaQuery.of(context).size.width / 5.00,
              //decoration:
              //BoxDecoration(border: Border.all(color: Color(0xFFb38219))),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                children: allSubFacilitiesValues(v),
              ),
            )
          ],
        ),
      ));
    });
    return m;
  }

  List<Widget> allSubFacilitiesValues(v) {
    List<Widget> m = [];
    for (int i = 0; i < v.length; i++) {
      m.add(Container(
        width: MediaQuery.of(context).size.width / 2.28,
        child: Row(
          children: [
            Icon(
              Icons.check,
              color: Color(0xFFdb9e1f),
            ),
            SizedBox(
              width: 10.0,
            ),
            Flexible(child: Text("${v[i]}")),
          ],
        ),
      ));
    }
    return m;
  }
  // Sub-Facilities End

  List<Widget> roomall() {
    List<Widget> m = [];

    for (int i = 0; i < rooms.length; i++) {
      // print(rooms[i].entries);

      var entryList = rooms[i].entries.toList()
        ..sort((e1, e2) => e2.key.compareTo(e1.key));

      for (int j = 0; j < entryList.length; j++) {
        //each list -  room name
        // print(entryList[j].key);
        // print(entryList[j].value);

        m.add(IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Color(0xFFb38219))),
                width: MediaQuery.of(context).size.width / 2.8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${entryList[j].key.toString()}",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${entryList[j].value[2]}     ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.king_bed_outlined,
                            color: Color(0xFFdb9e1f),
                            size: 30.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Color(0xFFb38219))),
                width: MediaQuery.of(context).size.width / 3.9,
                // height:
                //     MediaQuery.of(context)
                //             .size
                //             .height /
                //         10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Tooltip(
                        message:
                            '${entryList[j].value[0]} Adults and ${entryList[j].value[1]} Children',
                        child: Icon(
                          Icons.supervisor_account,
                          color: Color(0xFFdb9e1f),
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Color(0xFFb38219))),
                width: MediaQuery.of(context).size.width / 3.3,
                // height:
                //     MediaQuery.of(context)
                //             .size
                //             .height /
                //         10,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "AED ${entryList[j].value[3]}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Includes Taxes and Fees",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ));
      }
    }
    return m;
  }

  @override
  void initState() {
    getyo();
    getname();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            key: _scaffoldState,
            endDrawer: new UserNavigationDrawer(widget.uid, widget.city),
            backgroundColor: Color(0xFF000000),
            body: Column(
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 5.95),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              children: [
                                Container(
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Wrap(
                                        children: [
                                          Text(
                                            name,
                                            style: TextStyle(
                                                fontSize: width * 0.06,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          RatingBar.builder(
                                            initialRating: stars == 1
                                                ? 1
                                                : stars == 2
                                                    ? 2
                                                    : stars == 3
                                                        ? 3
                                                        : stars == 4
                                                            ? 4
                                                            : stars == 5
                                                                ? 5
                                                                : 0,
                                            direction: Axis.horizontal,
                                            ignoreGestures: true,
                                            itemCount: 5,
                                            itemSize: width * 0.056,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                //row for button and booking hotel heading
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        width: width * 0.032,
                                        child: Icon(
                                          Icons.location_on,
                                          color: Color(0xFFdb9e1f),
                                          size: width * 0.04,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "  ${address} - Great location - show map",
                                          style: TextStyle(
                                            fontSize: width * 0.032,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  child: Column(
                                    children: imageBuilderThree(),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Property Description",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white70),
                                          )),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        description,
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Facilities",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white70),
                                          )),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Wrap(
                                        spacing: 20.0,
                                        children: mainfacilitiez(),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Wrap(
                                          spacing: 20.0,
                                          children: subFacilities != null
                                              ? allSubFacilitiesKeys()
                                              : []),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),

                                //table
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 24.0, top: 8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    //border: Border.all(color: Color(0xFFdb9e1f)),
                                                    color: Color(0xFFdb9e1f),
                                                  ),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.8,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      10,
                                                  child: Center(
                                                    child: Text(
                                                      "Room Type",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    //border: Border.all(color: Color(0xFFdb9e1f)),
                                                    color: Color(0xFFdb9e1f),
                                                  ),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3.9,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      10,
                                                  child: Center(
                                                    child: Text(
                                                      "Sleeps",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    //border: Border.all(color: Color(0xFFdb9e1f)),
                                                    color: Color(0xFFdb9e1f),
                                                  ),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3.3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      10,
                                                  child: Center(
                                                    child: Text(
                                                      "Price",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            IntrinsicHeight(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: roomall(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 0.0,
                          top: 0.0,
                          right: 0.0,
                          child: Container(
                              child: VendomeHeader.cus(
                            drawer: _scaffoldState,
                            cusname: cusname,
                            cusaddress: widget.city,
                          ))),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
