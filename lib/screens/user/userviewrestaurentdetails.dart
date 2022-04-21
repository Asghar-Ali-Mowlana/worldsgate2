import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:worldsgate/helper/responsive_helper.dart';
import 'package:worldsgate/widgets/usernavigationdrawer.dart';

import '../../widgets/cusheader.dart';

class UserViewRestaurantDetails extends StatefulWidget {
  //const UserViewRestaurantDetails({Key? key}) : super(key: key);

  String? uid;
  String? city;
  String? restaurantid;

  UserViewRestaurantDetails(this.uid, this.city, this.restaurantid);

  @override
  State<UserViewRestaurantDetails> createState() =>
      _UserViewRestaurantDetailsState();
}

class _UserViewRestaurantDetailsState extends State<UserViewRestaurantDetails> {
  var _scaffoldState = new GlobalKey<ScaffoldState>();

  var _controller = TextEditingController();

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

  var name = "";
  var coverimage = "";
  var city = "";
  int minPriceOrder = 0;

  bool _isLoading = true;

  _getRestaurantDetails() async {
    await FirebaseFirestore.instance
        .collection('delivery')
        .doc("9WRNvPkoftSw4o2rHGUI")
        .collection('restaurants')
        .doc(widget.restaurantid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          name = documentSnapshot['name'];
          coverimage = documentSnapshot['coverimage'];
          city = documentSnapshot['city'];
          minPriceOrder = documentSnapshot['minimumorderprice'];
        });
      } else {
        print("Document does not exist");
      }
    });
    setState(() {
      this._isLoading = false;
    });
  }

  @override
  void initState() {
    _getRestaurantDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : SafeArea(
            child: Scaffold(
            key: _scaffoldState,
            drawer: new UserNavigationDrawer(widget.uid, widget.city),
            backgroundColor: Color(0xFF000000),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.shopping_cart),
              backgroundColor: Color(0xFFdb9e1f),
              //mini: true,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: ResponsiveWidget(
                    mobile:
                        buildColumnContent(context, height, width, "mobile"),
                    tab: buildColumnContent(context, height, width, "tab"),
                    desktop:
                        buildColumnContent(context, height, width, "desktop"),
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

  Padding buildColumnContent(
      BuildContext context, double height, double width, String device) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: device == "mobile"
              ? width * 0.02
              : device == "tab"
                  ? width * 0.02
                  : device == "desktop"
                      ? width * 0.25
                      : width * 0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: device == "mobile"
                    ? height * 0.09
                    : device == "tab"
                        ? height * 0.09
                        : device == "desktop"
                            ? height * 0.13
                            : 0),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: height * 0.1,
              child: Row(
                children: [
                  AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(coverimage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                  SizedBox(
                    width: device == "mobile"
                        ? width * 0.05
                        : device == "tab"
                            ? width * 0.05
                            : device == "desktop"
                                ? width * 0.05
                                : width * 0,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name + "             ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          "in ${city}, UAE             ".toString(),
                          style: TextStyle(fontSize: 14),
                        ),
                        Text("Iranian, Kebab, Grills  ".toString(),
                            style: TextStyle(fontSize: 13)),
                        Text("Min. order: AED ${minPriceOrder}.00".toString(),
                            style: TextStyle(fontSize: 13))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Container(
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  device == "desktop"
                      ? Container(
                          width: width * 0.12,
                          child: Column(
                            children: [
                              Container(
                                width: width * 0.11,
                                height: height * 0.4,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Categories",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Most Selling"),
                                    Text("Chef's Daily Special"),
                                    Text("Starters"),
                                    Text("Salads"),
                                    Text("Kebab Wraps"),
                                    Text("Speciality Wraps"),
                                    Text(
                                        "From The Char Grill - Kebab & Nan Duo"),
                                    Text("Pizza"),
                                    Text("Mana'eesh"),
                                    Text("Saj"),
                                    Text("Desserts"),
                                    Text("Drinks"),
                                    Text("Extras"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  SingleChildScrollView(
                    child: Container(
                      width: device == "mobile"
                          ? width * 0.96
                          : device == "tab"
                              ? width * 0.96
                              : device == "desktop"
                                  ? width * 0.24
                                  : width * 0.24,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: _controller,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Color(0xFFdb9e1f),
                                    ),
                                    onPressed: () {
                                      _controller..text = "";
                                    }),
                                hintText: "Enter menu item",
                                labelText: "Search Menu Item",
                                hintStyle: TextStyle(color: Colors.white70),
                                labelStyle:
                                    new TextStyle(color: Colors.white70),
                                enabled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white70),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Color(0xFFdb9e1f)),
                                ),
                              ),
                              validator: (value) {
                                if (value!.length == 0) {
                                  return "Menu item cannot be empty";
                                }
                              },
                              onSaved: (value) {
                                _controller.text = value!;
                              },
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Column(
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('delivery')
                                        .doc("9WRNvPkoftSw4o2rHGUI")
                                        .collection('restaurants')
                                        .doc(widget.restaurantid)
                                        .collection('foodcategory')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        return Wrap(
                                          direction: Axis.vertical,
                                          children:
                                              snapshot.data!.docs.map((doc) {
                                            return Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: width * 0.215,
                                                      height: height * 0.05,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "${doc['name']}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Icon(Icons.arrow_drop_up)
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                StreamBuilder<QuerySnapshot>(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection('delivery')
                                                      .doc(
                                                          "9WRNvPkoftSw4o2rHGUI")
                                                      .collection('restaurants')
                                                      .doc(widget.restaurantid)
                                                      .collection(
                                                          'foodcategory')
                                                      .doc(
                                                          doc['foodcategoryid'])
                                                      .collection('food')
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    } else {
                                                      return Container(
                                                        height: 200,
                                                        width: width,
                                                        child: ListView(
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            primary: false,
                                                            children: snapshot
                                                                .data!.docs
                                                                .map((doc) {
                                                              return ListTile(
                                                                leading:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 50,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                title: Text(
                                                                    "${doc['name']}"),
                                                                subtitle: Text(
                                                                    "${doc['description']}"),
                                                                trailing:
                                                                    Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        "AED ${doc['price']}.00"),
                                                                    Icon(Icons
                                                                        .add_circle),
                                                                  ],
                                                                ),
                                                              );
                                                            }).toList()),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                        );
                                      }
                                    }),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  device == "desktop"
                      ? Container(
                          width: width * 0.14,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  width: width * 0.15,
                                  height: height * 0.05,
                                  color: Color(0xFFdb9e1f),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Your Cart",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: width * 0.15,
                                  height: height * 0.2,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xFFdb9e1f))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          Icons.shopping_bag,
                                          size: width * 0.07,
                                        ),
                                        Text(
                                          "There are no items in your cart",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
