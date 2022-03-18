import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  var lisst;
  var x = [];
  var y;
  var name;
  var address;
  var description;
  var otherHotelImages;

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
        //.where('hotelid', isEqualTo: hotelid.toString())
        // .where('hotelid', isEqualTo: widget.hotelid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        name = documentSnapshot['name'];
        address = documentSnapshot['address'];
        description = documentSnapshot['description'];
        x = documentSnapshot['otherhotelimages'].toList();
        //dategroupbylist.add(
        //doc['otherhotelimages'],
        //);
        y = documentSnapshot['coverimage'];
      } else {
        print("The document does not exist");
      }
    });
    //print(x);
    try {
      setState(() {
        otherHotelImages = x;
        //lisst = dategroupbylist.toList();
      });

      //print(testList[0].key);
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

  bool _isLoading = true;

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
                          margin: EdgeInsets.only(top:  MediaQuery.of(context).size.height / 5.95),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              children: [
                                Container(
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        name,
                                        style: TextStyle(
                                            fontSize: width * 0.06,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                //row for button and booking hotel heading
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  child: Text(
                                    description,
                                    style: TextStyle(fontSize: 14.0),
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
                              child:
                              VendomeHeader.cus(drawer: _scaffoldState, cusname: cusname, cusaddress: widget.city,))),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
