import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:worldsgate/widgets/deonavigationdrawer.dart';
import 'package:worldsgate/widgets/header.dart';
import '../../widgets/sidelayout.dart';
import 'deoaddhoteldetails.dart';
import 'deoupdatehoteldetails.dart';

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
  List<Map> hotelrooms = <Map>[];
  List<Map> rooms = <Map>[];

  var lisst;
  var x = [];
  var mainfacilities = [];
  var y;
  var name;
  var address;
  var description;
  var stars;
  var otherHotelImages;

  var again = [];

  // /var rooms = [];

  getyo() async {
    print("The hotel ID is " + hotelid.toString());



    await FirebaseFirestore.instance
        .collection('hotels')
        .where('hotelid', isEqualTo: hotelid.toString())
        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {

        name = doc['name'];
        address = doc['address'];
        description = doc['description'];
        stars = doc['stars'];
        x = doc['otherhotelimages'].toList();
        mainfacilities = doc['mainfacilities'].toList();
       // rooms = doc['rooms'].toList();
        hotelrooms.add(
          doc['rooms'],
        );
        rooms.add(
          doc['rooms'],
        );




        // hotelrooms.add(
        //   documentSnapshot['otherhotelimages'],
        // );
        y = doc['coverimage'];


      })
    });

    //print(x);
    try {
      setState(() {
        otherHotelImages = x;
        again = hotelrooms.toList();
        //lisst = dategroupbylist.toList();
      });

      //print(testList[0].key);
    } catch (e) {
      print(e);
    }









  }
  List<Widget> roominfo() {
    List<Widget> m = [];

    for (int i = 0; i < rooms.length; i++) {
     // print(rooms[i].entries);

      var entryList = rooms[i].entries.toList()..sort((e1, e2) => e2.key.compareTo(e1.key));

      for (int j = 0; j < entryList.length; j++) {
        //each list -  room name
        print(entryList[j].key);
        print(entryList[j].value);

        m.add(Column(
          children: [
            Align(
              alignment:
              Alignment
                  .topLeft,
              child: Text(
                "${entryList[j].key.toString()}",
                style: TextStyle(
                    color: Colors
                        .white,
                    fontWeight:
                    FontWeight
                        .bold),
              ),
            ),
            Row(
              children: [
                Text(
                  "${entryList[j].value[2]}     ",
                  style: TextStyle(
                      color: Colors
                          .white,
                      fontWeight:
                      FontWeight
                          .bold),
                ),
                Icon(
                  Icons
                      .king_bed_outlined,
                  color: Color(
                      0xFFdb9e1f),
                  size: 30.0,
                ),
              ],
            ),

          ],
        ),);

        for (int q = 0; q < entryList[j].value.length; q++) {

         // print(entryList[j].value[q]);




        }

      }
    }
    return m;
  }

  List<Widget> mainfacilitiez() {
    List<Widget> m = [];

    for (int i = 0; i < mainfacilities.length; i++) {
      print(mainfacilities[i]);
      m.add(Wrap(
        children: [
          Icon(
            Icons.check,
            color: Colors.greenAccent,

          ),
          Text(mainfacilities[i].toString(), style: TextStyle(
            color: Colors.white
          ),),
        ],
      ));
    }
    return m;
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
    //newbuilderz();
    Future.delayed(Duration(seconds: 1), () {
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
                                margin: EdgeInsets.only(left: MediaQuery.of(context)
                                    .size
                                    .width /
                                    80,),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            children: [
                                              Text(
                                                name,
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              RatingBar.builder(
                                                initialRating: stars == 1 ?1 : stars == 2 ?2 : stars == 3 ?3 : stars == 4 ?4 : stars == 5 ?5 : 0,
                                                direction: Axis.horizontal,
                                                ignoreGestures: true,
                                                itemCount: 5,
                                                itemSize: width * 0.016,
                                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
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
                                    //row for button and booking hotel heading
                                    Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
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
                                          Align(
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
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: imageBuilderThree(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50.0,
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(

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
                                    //table
                                    Padding(
                                      padding: EdgeInsets.only(

                                          bottom: 24.0,
                                          top: 8.0),
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
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      ),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              6.01,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              10,
                                                      child: Center(
                                                        child: Text(
                                                          "Room Type",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        //border: Border.all(color: Color(0xFFdb9e1f)),
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      ),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              6.01,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              10,
                                                      child: Center(
                                                        child: Text(
                                                          "Sleeps",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        //border: Border.all(color: Color(0xFFdb9e1f)),
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      ),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              6.01,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              10,
                                                      child: Center(
                                                        child: Text(
                                                          "Price",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    //4th column
                                                    // Container(
                                                    //   decoration: BoxDecoration(
                                                    //     //border: Border.all(color: Color(0xFFdb9e1f)),
                                                    //     color:
                                                    //         Color(0xFFdb9e1f),
                                                    //   ),
                                                    //   width:
                                                    //       MediaQuery.of(context)
                                                    //               .size
                                                    //               .width /
                                                    //           6.01,
                                                    //   height:
                                                    //       MediaQuery.of(context)
                                                    //               .size
                                                    //               .height /
                                                    //           10,
                                                    //   child: Center(
                                                    //     child: Text(
                                                    //       "Room Type",
                                                    //       style: TextStyle(
                                                    //           color:
                                                    //               Colors.white,
                                                    //           fontWeight:
                                                    //               FontWeight
                                                    //                   .bold),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                                StreamBuilder(
                                                  stream: null,
                                                  builder: (context, snapshot) {
                                                    return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xFFb38219))),
                                                          width:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  6.01,
                                                          height:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .height /
                                                                  10,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              children: roominfo(),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xFFb38219))),
                                                          width:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  6.01,
                                                          height:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .height /
                                                                  10,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              children: [
                                                                // Align(
                                                                //   alignment: Alignment.topLeft,
                                                                //   child: Text(
                                                                //     "Room Name",
                                                                //     style: TextStyle(
                                                                //         color: Colors.white,
                                                                //         fontWeight: FontWeight.bold
                                                                //     ),
                                                                //   ),
                                                                // ),

                                                                Icon(
                                                                  Icons
                                                                      .supervisor_account,
                                                                  color: Color(
                                                                      0xFFdb9e1f),
                                                                  size: 30.0,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xFFb38219))),
                                                          width:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  6.01,
                                                          height:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .height /
                                                                  10,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Text(
                                                                    "AED 8 800",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Text(
                                                                    "Includes Taxes and Fees",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w100),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        //4th column
                                                        // Container(
                                                        //   decoration: BoxDecoration(
                                                        //       border: Border.all(
                                                        //           color: Color(
                                                        //               0xFFdb9e1f))),
                                                        //   width:
                                                        //       MediaQuery.of(context)
                                                        //               .size
                                                        //               .width /
                                                        //           6.01,
                                                        //   height:
                                                        //       MediaQuery.of(context)
                                                        //               .size
                                                        //               .height /
                                                        //           10,
                                                        //   child: Column(
                                                        //     children: [],
                                                        //   ),
                                                        // ),
                                                      ],
                                                    );
                                                  }
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "Facilities of $name",
                                      style: TextStyle(
                                          color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    Text(
                                      "Most popular facilities",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16.0
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Wrap(
                                      spacing: 20.0,
                                      children: mainfacilitiez(),
                                    ),
                                    SizedBox(height: 20.0),
                                    Text(
                                      "Other facilities",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16.0
                                      ),
                                    ),

                                    SizedBox(height: 20.0),
                                    Center(
                                      child: Container(
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
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateHotelDetails(
                                                              widget
                                                                  .uid, widget.hotelid)));
                                            },
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
