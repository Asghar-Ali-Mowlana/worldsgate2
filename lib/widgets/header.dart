import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart' as u;

class VendomeHeader extends StatelessWidget {

 GlobalKey<ScaffoldState> drawer;

  VendomeHeader({required this.drawer});

  //const VendomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      (u.Platform.operatingSystem == "android" ||
          u.Platform.operatingSystem == "ios")
     ? Container(
      height: 90.0,
      decoration: BoxDecoration(
        color: Colors.black,


        border: Border.all(color: Color(0xFFBA780F)),

      ),
      child: Column(
        children: [
          Center(
            child: Image.asset(
              "assets/images/headerimages/worldgate.png",
              height: 50,
              width: 270,
            ),
          ),
          Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/headerimages/location.png",
                        width: 15,
                      ),
                      Text(
                        "  Al Habbtoor Tower, Marina, Dubai",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
              ),


              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: (){
                    drawer.currentState!.openEndDrawer();
                  },
                  child: Image.asset(
                    "assets/images/headerimages/bar.png",
                    width: 25,
                  ),
                ),
              ),
            ],
          ),


        ],
      ),

    )
          :
      Container(
        height: 160.0,
        decoration: BoxDecoration(
          color: Colors.black,


          // border: Border.all(color: Color(0xFFBA780F)),

          border: Border(
            bottom: BorderSide(width: 2.0, color: Color(0xFFBA780F)),
          ),

        ),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 40,
                      backgroundImage: AssetImage(
                        'assets/images/logo.jpeg',
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/images/headerimages/worldgate.png",
                      height: 100,
                      width: 470,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, right: 18.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                        'assets/images/premiumbrands/premiumbrands1.jpeg',
                      ),
                    ),
                  ),
                ),

              ],
            ),

            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Text("Mohamed", style: TextStyle(
                    color: Colors.white
                  ),)),
            ),



            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0,top: 5.0),
                child: InkWell(
                  onTap: (){
                    drawer.currentState!.openDrawer();
                  },
                  child: Image.asset(
                    "assets/images/headerimages/bar.png",
                    width: 25,
                  ),
                ),
              ),
            ),




          ],
        ),

      );
  }
}
