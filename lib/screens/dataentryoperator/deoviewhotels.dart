import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worldsgate/widgets/deonavigationdrawer.dart';
import 'package:worldsgate/widgets/header.dart';
import '../../widgets/sidelayout.dart';
import 'deoaddhoteldetails.dart';

class DeoViewHotels extends StatefulWidget {
  //const DeoViewHotels({Key? key}) : super(key: key);

  String? uid;
  String? hotelid;

  // constructor
  DeoViewHotels(this.uid, this.hotelid);

  @override
  _DeoViewHotelsState createState() => _DeoViewHotelsState(uid, hotelid);
}

class _DeoViewHotelsState extends State<DeoViewHotels> {
  String? uid;
  String? hotelid;

  _DeoViewHotelsState(this.uid, this.hotelid);

  String? cusname;

  bool _isLoading = true;

  var _scaffoldState = new GlobalKey<ScaffoldState>();

  getname() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get()
        .then((myDocuments) {
      cusname = myDocuments.data()!['name'].toString();
    });
  }

  List<dynamic> dategroupbylist = <dynamic>[];

  var lisst;
  var x = [];
  var y;
  var name;
  var address;
  var description;
  var otherHotelImages;

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

  //
  // List<Widget> newbuilder() {
  //   List<Widget> m = [];
  //
  //
  //   for (int i = 0; i < lisst.length; i++) {
  //
  //
  //     m.add( Image.network(lisst[i][0].toString(), width: 560.0,));
  //     print("Index running time $i");
  //     print(lisst[i][1]);
  //
  //   }
  //
  //   return m;
  //
  // }

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
                width: MediaQuery.of(context).size.width / 5.85,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(otherHotelImages[i].toString()),
                    fit: BoxFit.cover,
                  ),
                ),
                //child: Image.network(otherHotelImages[0].toString(),
                //  height: MediaQuery.of(context).size.height / 4.45,
                //width: MediaQuery.of(context).size.width / 5.85),
              ),
            ),

            //Padding(
            //padding: const EdgeInsets.all(5.0),
            //child: Image.network(otherHotelImages[1].toString(),
            //  height: MediaQuery.of(context).size.height / 4.45,
            //width: MediaQuery.of(context).size.width / 5.85),
            //),
          ],
        ),
      );
    }

    return m;
  }

  List<Widget> imageBuilderTwo() {
    List<Widget> m = [];
    int numberOfImagesDisplayed =
        otherHotelImages.length >= 7 ? 7 : otherHotelImages.length;
    for (int i = 2; i < numberOfImagesDisplayed; i++) {
      m.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 7.5,
                width: MediaQuery.of(context).size.width / 9.95,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(otherHotelImages[i].toString()),
                    fit: BoxFit.cover,
                  ),
                ),
                //child: Image.network(otherHotelImages[0].toString(),
                //  height: MediaQuery.of(context).size.height / 4.45,
                //width: MediaQuery.of(context).size.width / 5.85),
              ),
              //Image.network(otherHotelImages[i].toString(),
              //  height: MediaQuery.of(context).size.height / 7.5,
              //width: MediaQuery.of(context).size.width / 9.95),
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
                    width: MediaQuery.of(context).size.width / 2.85,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(y.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                    //child: Image.network(otherHotelImages[0].toString(),
                    //  height: MediaQuery.of(context).size.height / 4.45,
                    //width: MediaQuery.of(context).size.width / 5.85),
                  ),
                  //Image.network(y.toString(),
                  //  height: MediaQuery.of(context).size.height / 2.18,
                  //width: MediaQuery.of(context).size.width / 2.85),
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

  /*List<Widget> newbuilder() {
    List<Widget> m = [];

    for (int i = 0; i < lisst.length; i++) {
      m.add(
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.network(
                          lisst[i][0].toString().isEmpty
                              ? as
                              : lisst[i][0].toString(),
                          width: MediaQuery.of(context).size.width / 5.85),
                    ),
                    //Image.network(dategroupbylist.elementAt(1).toString(),    width: 280.0,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.network(
                          lisst[i][1].toString().isEmpty
                              ? as
                              : lisst[i][1].toString(),
                          width: MediaQuery.of(context).size.width / 5.85),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.network(y.toString(),
                          width: MediaQuery.of(context).size.width / 2.85),
                    )
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.network(
                      lisst[i][2].toString().isEmpty
                          ? ""
                          : lisst[i][2].toString(),
                      width: MediaQuery.of(context).size.width / 9.95),
                ),
                /*Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(as),
                      //whatever image you can put here
                      fit: BoxFit.cover,
                    ),
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.network(
                      lisst[i][3].toString().isEmpty
                          ? ""
                          : lisst[i][3].toString(),
                      width: MediaQuery.of(context).size.width / 9.95),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.network(
                      lisst[i][4].toString().isEmpty
                          ? ""
                          : lisst[i][4].toString(),
                      width: MediaQuery.of(context).size.width / 9.95),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.network(
                      lisst[i][5].toString().isEmpty
                          ? ""
                          : lisst[i][5].toString(),
                      width: MediaQuery.of(context).size.width / 9.95),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.network(
                      lisst[i][6].toString().isEmpty
                          ? ""
                          : lisst[i][6].toString(),
                      width: MediaQuery.of(context).size.width / 9.95),
                ),
              ],
            ),
          ],
        ),
      );

      //m.add( Image.network(lisst[i][0].toString(), width: 560.0,));
      print("Index running time $i");
      print(lisst[i][1]);
    }

    return m;
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getname();
    getyo();
    //newbuilder();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //final double height = MediaQuery.of(context).size.height;

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
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                80,
                                            top: 30.0),
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              name,
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                    ),
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
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      80),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Color(0xFFdb9e1f),
                                                    size: width * 0.015,
                                                  ),
                                                  Text(
                                                    "  ${address} - Great location - show map",
                                                    style: TextStyle(
                                                      fontSize: width * 0.008,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    80),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    side: BorderSide(
                                                        color:
                                                            Color(0xFFdb9e1f))),
                                                elevation: 5.0,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    18,
                                                minWidth: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    30,
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              // TaskCardWidget(id: user.id, name: user.ingredients,)
                                                              AddHotelDetails(
                                                                  widget.uid)));
                                                },
                                                child: Text(
                                                  "Reserve",
                                                  style: TextStyle(
                                                    fontSize: width * 0.013,
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
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                80),
                                        child: Column(
                                          children: imageBuilderThree(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50.0,
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                80,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4.9,
                                            bottom: 30),
                                        child: Text(
                                          description,
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                80,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4.9,
                                            bottom: 30),
                                        child: Container(
                                          width: 200.0,
                                          height: 50.0,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Color(0xFF000000),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.0)),
                                                    side: BorderSide(
                                                        color:
                                                            Color(0xFFdb9e1f))),
                                                side: BorderSide(
                                                  width: 2.5,
                                                  color: Color(0xFFdb9e1f),
                                                ),
                                                textStyle: const TextStyle(
                                                    fontSize: 16)),
                                            onPressed: () {},
                                            child: const Text(
                                              'Update',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
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
                        child: VendomeHeader(
                      drawer: _scaffoldState,
                      cusname: cusname,
                    ))),
              ],
            ),
    ));
  }
}
