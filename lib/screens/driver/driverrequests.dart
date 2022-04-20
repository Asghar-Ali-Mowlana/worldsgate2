import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:worldsgate/helper/responsive_helper.dart';
import 'package:worldsgate/widgets/drivernavigationdrawer.dart';
import '../../../../widgets/header.dart';


class DriverRequests extends StatefulWidget {
  String? uid;

  DriverRequests(this.uid);

  @override
  State<DriverRequests> createState() => _DriverRequestsState();
}

class _DriverRequestsState extends State<DriverRequests> {
  var _scaffoldState = new GlobalKey<ScaffoldState>();


  bool _isLoading = true;


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
  void initState() {
    super.initState();
    getname();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
        drawer: new DriverNavigationDrawer(widget.uid),
        backgroundColor: Color(0xFF000000),
        body: (_isLoading == true)
            ? Center(child: CircularProgressIndicator())
            : Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ResponsiveWidget(
                mobile: DriverRequestsContainer(context, "mobile"),
                tab: DriverRequestsContainer(context, "tab"),
                desktop:
                DriverRequestsContainer(context, "desktop"),
              ),
            ),
            Positioned(
                left: 0.0,
                top: 0.0,
                right: 0.0,
                child: Container(
                    child: VendomeHeader(
                      drawer: _scaffoldState,
                      cusname: cusname,
                      cusaddress: "",
                      role: role,
                    ))),
          ],
        ),
      ),
    );
  }

  Container DriverRequestsContainer(BuildContext context, String device) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.25,
          vertical: MediaQuery.of(context).size.height * 0.2,
        ),
        child: Column(
          children: [
            Container(

            )
          ],
        ),
      ),
    );
  }
}
