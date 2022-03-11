import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VendomeHeader extends StatelessWidget {

 GlobalKey<ScaffoldState> drawer;

  VendomeHeader({required this.drawer});

  //const VendomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(right: 60.0),
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

    );
  }
}
