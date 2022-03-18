import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserViewHotelDetails extends StatefulWidget {
  //const UserViewHotelDetails({Key? key}) : super(key: key);
  String? uid;
  String? hotelid;

  UserViewHotelDetails(this.uid, this.hotelid);

  @override
  _UserViewHotelDetailsState createState() =>
      _UserViewHotelDetailsState(hotelid);
}

class _UserViewHotelDetailsState extends State<UserViewHotelDetails> {
  String? hotelid;
  _UserViewHotelDetailsState(this.hotelid);

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

  List<Widget> imageBuilderOne() {
    List<Widget> m = [];
    m.add(
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 4.45,
              width: MediaQuery.of(context).size.width / 2.85,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(otherHotelImages[0].toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 4.45,
              width: MediaQuery.of(context).size.width / 2.85,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(otherHotelImages[1].toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
                width: MediaQuery.of(context).size.width / 3.52,
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
            backgroundColor: Color(0xFF000000),
            body: Column(
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
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
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 18.0),
                                    child: Icon(
                                      Icons.location_on,
                                      color: Color(0xFFdb9e1f),
                                      size: width * 0.032,
                                    ),
                                  ),
                                  Flexible(
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
