import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:worldsgate/helper/responsive_helper.dart';
import 'package:worldsgate/widgets/usernavigationdrawer.dart';

import '../../widgets/cusheader.dart';

class UserViewRestaurantDetails extends StatefulWidget {
  //const UserViewRestaurantDetails({Key? key}) : super(key: key);

  String? uid;
  String? city;

  UserViewRestaurantDetails(this.uid, this.city);

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      key: _scaffoldState,
      drawer: new UserNavigationDrawer(widget.uid, widget.city),
      backgroundColor: Color(0xFF000000),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ResponsiveWidget(
              mobile: buildColumnContent(context, height, width, "mobile"),
              tab: buildColumnContent(context, height, width, "tab"),
              desktop: buildColumnContent(context, height, width, "desktop"),
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
                  ? width * 0.1
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
                        ? height * 0.1
                        : device == "desktop"
                            ? height * 0.13
                            : 0),
          ),
          Container(
            height: height * 0.1,
            child: Row(
              children: [
                AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Container(
                      color: Colors.greenAccent,
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
                        "Sofreh Kitchen & Grill",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        "in Dubai Marina, UAE   ",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text("Iranian, Kebab, Grills       ",
                          style: TextStyle(fontSize: 13)),
                      Text("Min. order: AED 10.00     ",
                          style: TextStyle(fontSize: 13))
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Container(
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  device == "desktop"
                      ? Container(
                          width: width * 0.12,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  width: width * 0.11,
                                  height: height * 0.4,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          ),
                        )
                      : SizedBox(),
                  Container(
                    width: device == "mobile"
                        ? width * 0.96
                        : device == "tab"
                            ? width * 0.24
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
                              labelStyle: new TextStyle(color: Colors.white70),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: width * 0.215,
                                    height: height * 0.05,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Most Selling",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
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
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                                title: Text("Juje Masti"),
                                subtitle: Text(
                                    "Beef tikka slider, koobideh slider, juje mastislider, 12 pieces"),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("AED 60.00"),
                                    Icon(Icons.add_circle),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: width * 0.215,
                                    height: height * 0.05,
                                    color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Chef's Daily Special",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
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
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                                title: Text("Juje Masti"),
                                subtitle: Text(
                                    "Beef tikka slider, koobideh slider, juje mastislider, 12 pieces"),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("AED 60.00"),
                                    Icon(Icons.add_circle),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: width * 0.215,
                                    height: height * 0.05,
                                    color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Starters",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
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
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                                title: Text("Juje Masti"),
                                subtitle: Text(
                                    "Beef tikka slider, koobideh slider, juje mastislider, 12 pieces"),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("AED 60.00"),
                                    Icon(Icons.add_circle),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: width * 0.215,
                                    height: height * 0.05,
                                    color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Salads",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
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
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                                title: Text("Juje Masti"),
                                subtitle: Text(
                                    "Beef tikka slider, koobideh slider, juje mastislider, 12 pieces"),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("AED 60.00"),
                                    Icon(Icons.add_circle),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                            ],
                          )
                        ],
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
