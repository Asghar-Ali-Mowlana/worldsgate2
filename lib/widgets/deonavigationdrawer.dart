import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worldsgate/screens/dataentryoperator/cars/deomanagecars.dart';
import 'package:worldsgate/screens/dataentryoperator/hotels/deomanagehotels.dart';

import '../screens/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart' as u;

class DeoNavigationDrawer extends StatelessWidget {
  //const DeoNavigationDrawer({Key? key}) : super(key: key);

  String? uid;

  // //constructor
  DeoNavigationDrawer(
    this.uid,
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF262626),
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
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      );
  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            Text(
              "Booking",
              style: TextStyle(color: Colors.white),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text(
                'Hotel',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DeoManageHotels(uid),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text(
                'Apartments',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => DeoManageApartments(uid),
                // ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text(
                'Cars',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DeoManageCars(uid),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text(
                'Yachts',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text(
                'Bars',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text(
                'Restaurants',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            Text(
              "Delivery",
              style: TextStyle(color: Colors.white),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            Text(
              "Online Shopping",
              style: TextStyle(color: Colors.white),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
                logout(context);
              },
            ),
          ],
        ),
      );

  //logout function
  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await u.FirebaseAuth.instance.signOut();
    print("Signed out Successfully");

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
