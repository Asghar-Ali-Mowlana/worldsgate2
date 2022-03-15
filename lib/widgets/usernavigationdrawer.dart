import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worldsgate/screens/user/userhomepage.dart';
import 'package:worldsgate/screens/user/userhotelbooking.dart';

class UserNavigationDrawer extends StatelessWidget {
  //const UserNavigationDrawer({Key? key}) : super(key: key);

  String? uid;
  String? city;

  // //constructor
  UserNavigationDrawer(
      this.uid,
      this.city
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),

          ],
        ),
      ),
    );


  }
  Widget buildHeader(BuildContext context) => Container(
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top
    ),
  );
  Widget buildMenuItems(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserHomePage(uid, city!),
            ));

          },
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Hotel Booking'),
          onTap: (){

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserHotelBooking(uid, city!),
            ));

          },
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          onTap: (){

          },
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          onTap: (){

          },
        ),
      ],
    ),
  );
}
