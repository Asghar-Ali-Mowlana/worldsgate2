import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:worldsgate/helper/responsive_helper.dart';
import 'package:worldsgate/widgets/header.dart';

import '../../widgets/usernavigationdrawer.dart';

class UserViewCarDetails extends StatefulWidget {
  //const UserViewCarDetails({Key? key}) : super(key: key);
  String? uid;
  String? carid;
  String? city;

  UserViewCarDetails(this.uid, this.carid, this.city);

  @override
  _UserViewCarDetailsState createState() =>
      _UserViewCarDetailsState(carid);
}

class _UserViewCarDetailsState extends State<UserViewCarDetails> {
  var _scaffoldState = new GlobalKey<ScaffoldState>();
  String? carid;
  _UserViewCarDetailsState(this.carid);

  bool _isLoading = true;

  var brand;
  var name;
  var model;

  var stars;

  var description;
  var carCoverImage;
  var othercarImages;
  var otherfeatures;




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
    print("The car ID is " + carid.toString());
    await FirebaseFirestore.instance
        .collection('cars')
        .doc(carid.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        name = documentSnapshot['name'];
        brand = documentSnapshot['brand'];
        model = documentSnapshot['model'];
        description = documentSnapshot['description'];

        if ((documentSnapshot.data() as Map<String, dynamic>)
            .containsKey('othercarimages')) {
          othercarImages = documentSnapshot['othercarimages'].toList();
        }
        if ((documentSnapshot.data() as Map<String, dynamic>)
            .containsKey('coverimage')) {
          carCoverImage = documentSnapshot['coverimage'];
        }


        if ((documentSnapshot.data() as Map<String, dynamic>)
            .containsKey('otherfeatures')) {
          otherfeatures = documentSnapshot['otherfeatures'];
        }

      } else {
        print("The document does not exist");
      }
    });
  }

  List<Widget> imageBuilderOne() {
    List<Widget> m = [];
    int numberOfImagesDisplayed =
        othercarImages.length >= 2 ? 2 : othercarImages.length;
    for (int i = 0; i < numberOfImagesDisplayed; i++) {
      m.add(
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.005,
                  bottom: MediaQuery.of(context).size.width * 0.005),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.366,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(othercarImages[i].toString()),
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
    int numberOfImagesDisplayed = othercarImages
            .length;
    for (int i = 2; i < numberOfImagesDisplayed; i++) {
      m.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.005),
              child: Container(
                height: MediaQuery.of(context).size.height / 7.5,
                width: MediaQuery.of(context).size.width / 3.62,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(othercarImages[i].toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    return m;
  }

  List<Widget> imageBuilderThree() {
    List<Widget> m = [];
    m.add(Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.width * 0.005),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.504,
                    width: MediaQuery.of(context).size.width * 0.549,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(carCoverImage.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: imageBuilderTwo(),
            ),
          ),
        )
      ],
    ));
    return m;
  }


  // Sub-Facilities Start
  List<Widget> allotherfeaturesKeys(width, height, device) {
    List<Widget> m = [];
    otherfeatures.forEach((k, v) {
      print('{ key: $k, value: $v }');
      m.add(Container(
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 19,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "$k",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: device == "mobile"
                              ? 15
                              : device == "tab"
                                  ? 16
                                  : device == "desktop"
                                      ? 17
                                      : 17),
                    ))),
            Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                children: allotherfeaturesValues(v, width, height, device),
              ),
            )
          ],
        ),
      ));
    });
    return m;
  }

  List<Widget> allotherfeaturesValues(v, width, height, device) {
    List<Widget> m = [];
    for (int i = 0; i < v.length; i++) {
      m.add(Container(
        width: device == "mobile"
            ? width * 0.46
            : device == "tab"
                ? width * 0.30
                : device == "desktop"
                    ? width * 0.23
                    : width * 0.23,
        child: RichText(
          maxLines: 5,
          text: TextSpan(children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.bottom,
              child: Icon(
                Icons.check,
                color: Color(0xFFb38219),
              ),
            ),
            TextSpan(
              text: "${v[i]}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ]),
        ),
      ));
    }
    return m;
  }
  // Sub-Facilities End


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
    final CollectionReference packageCollection =
    FirebaseFirestore.instance.collection('cars');

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        :SafeArea(



        child:

        Scaffold(
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
              // SingleChildScrollView(
              //   child: ResponsiveWidget(
              //     mobile: buildColumnContent(context, "mobile", packageCollection),
              //     tab: buildColumnContent(context, "tab", packageCollection),
              //     desktop: buildColumnContent(context, "desktop", packageCollection),
              //   ),
              // ),
              Container(
                width: double.infinity,
                height: double.infinity,

                margin: const EdgeInsets.only(top: 200.0, bottom: 5.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text("Book Now $brand $name $model", style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.93,
                          height: 400.0,
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(10),
                            // border: Border.all(color: Color(0xFFBA780F)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://stimg.cardekho.com/images/carexteriorimages/930x620/Lamborghini/Aventador/6721/Lamborghini-Aventador-SVJ/1621849426405/front-left-side-47.jpg'),
                                fit: BoxFit.cover
                            ),

                            gradient: LinearGradient(
                                begin: FractionalOffset
                                    .bottomCenter,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                                  Colors.amber,
                                  Colors.amber,
                                ],
                                stops: [
                                  0.0,
                                  1.0
                                ]),
                          ),

                        ),
                      ),

                    ],
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
        ));
  }

}
