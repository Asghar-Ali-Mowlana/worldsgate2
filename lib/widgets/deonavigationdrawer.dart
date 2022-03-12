import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeoNavigationDrawer extends StatelessWidget {
  const DeoNavigationDrawer({Key? key}) : super(key: key);

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
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top
    ),
  );
  Widget buildMenuItems(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 16,
      children: [
        Text("Booking", style: TextStyle(
            color: Colors.white
        ),),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Hotel', style: TextStyle(
            color: Colors.white
          ),),
          onTap: (){

          },
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Apartments', style: TextStyle(
              color: Colors.white
          ),),
          onTap: (){

          },
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Cars', style: TextStyle(
              color: Colors.white
          ),),
          onTap: (){

          },
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Yachts', style: TextStyle(
              color: Colors.white
          ),),
          onTap: (){

          },
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Bars', style: TextStyle(
              color: Colors.white
          ),),
          onTap: (){

          },
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Restaurants', style: TextStyle(
              color: Colors.white
          ),),
          onTap: (){

          },
        ),
        Text("Delivery", style: TextStyle(
            color: Colors.white
        ),),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home', style: TextStyle(
              color: Colors.white
          ),),
          onTap: (){

          },
        ),
        Text("Online Shopping", style: TextStyle(
            color: Colors.white
        ),),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home', style: TextStyle(
              color: Colors.white
          ),),
          onTap: (){

          },
        ),
      ],
    ),
  );
}
