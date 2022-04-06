import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart' as u;
import 'package:worldsgate/helper/responsive_helper.dart';

class VendomeHeader extends StatefulWidget {
  //const VendomeHeader({Key? key}) : super(key: key);

  GlobalKey<ScaffoldState> drawer;
  String? cusname;
  String? cusaddress;

  VendomeHeader({required this.drawer, required this.cusname});

  VendomeHeader.cus({required this.drawer, required this.cusname, required this.cusaddress});

  @override
  _VendomeHeaderState createState() => _VendomeHeaderState();
}

class _VendomeHeaderState extends State<VendomeHeader> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
          mobile: buildContainerHeaderContent("mobile", 60, 200, 20, 10, 13),
          tab: buildContainerHeaderContent("tab", 120, 350, 30, 20, 14),
          desktop: buildContainerHeaderContent("desktop",160, 470, 40, 30, 15),
        );
  }

  Container buildContainerHeaderContent(String platform, double headerheight, double worldsgatewidth, double logoradius, double avatarradius, double fontsize) {
    return Container(
            height: headerheight,
            decoration: BoxDecoration(
              color: Colors.black,

              // border: Border.all(color: Color(0xFFBA780F)),

              border: Border(
                bottom: BorderSide(width: 2.0, color: Color(0xFFBA780F)),
              ),
            ),
            child:
            (widget.cusaddress!="")
                ?Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: logoradius,
                        backgroundImage: AssetImage(
                          'assets/images/logo.jpeg',
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "assets/images/headerimages/worldgate.png",
                       // height: 100,
                        width: worldsgatewidth,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: avatarradius,
                          backgroundImage: AssetImage(
                            'assets/images/premiumbrands/premiumbrands1.jpeg',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          widget.drawer.currentState!.openEndDrawer();
                        },
                        child: Image.asset(
                          "assets/images/headerimages/bar.png",
                          width: 25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            widget.cusname.toString(),
                            style: TextStyle(color: Colors.white, fontSize: fontsize),
                          )),
                    ),

                  ],
                ),
              ],
            ):

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/images/headerimages/worldgate.png",
                      // height: 100,
                      width: worldsgatewidth,
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            widget.drawer.currentState!.openDrawer();
                          },
                          child: Image.asset(
                            "assets/images/headerimages/bar.png",
                            width: 25,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/headerimages/location.png",
                                width: 15,
                              ),
                              Text(
                                "  ${widget.cusaddress}",
                                style: TextStyle(color: Colors.white, fontSize: fontsize),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          );
  }
}
