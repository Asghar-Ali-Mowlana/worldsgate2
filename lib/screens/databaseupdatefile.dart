import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_io/io.dart' as u;
import 'package:path/path.dart';

import '../../../widgets/deonavigationdrawer.dart';
import '../../../widgets/header.dart';
import '../../../widgets/usernavigationdrawer.dart';

class UpdateDatabase extends StatefulWidget {
  const UpdateDatabase({Key? key}) : super(key: key);

  @override
  State<UpdateDatabase> createState() => _UpdateDatabaseState();
}

var address;
var cancellationfee;
var city;
var coverimage;
var dataentryuid;
var datecreated;
var description;
var hotelid;
var mainfacilities;
var name;
var otherHotelImages;
var price;
var promotion;
var rooms;
var stars;
var subfacilities;
var taxandcharges;

class _UpdateDatabaseState extends State<UpdateDatabase> {
  _updateHotel() async {
    await FirebaseFirestore.instance
        .collection('hotels')
        .doc("0C8GwpvgHLuguLd0ySnI")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          if ((documentSnapshot.data() as Map<String, dynamic>)
              .containsKey('address')) {
            address = documentSnapshot['address'];
          }
          if ((documentSnapshot.data() as Map<String, dynamic>)
              .containsKey('cancellationfee')) {
            cancellationfee = documentSnapshot['cancellationfee'];
          }
          if ((documentSnapshot.data() as Map<String, dynamic>)
              .containsKey('city')) {
            city = documentSnapshot['city'];
          }
          if ((documentSnapshot.data() as Map<String, dynamic>)
              .containsKey('coverimage')) {
            coverimage = documentSnapshot['coverimage'];
          }
          if ((documentSnapshot.data() as Map<String, dynamic>)
              .containsKey('dataentryuid')) {
            dataentryuid = documentSnapshot['dataentryuid'];
          }
          if ((documentSnapshot.data() as Map<String, dynamic>)
              .containsKey('datecreated')) {
            datecreated = documentSnapshot['datecreated'];
          }
          if ((documentSnapshot.data() as Map<String, dynamic>)
              .containsKey('description')) {
            description = documentSnapshot['description'];
          }
          if ((documentSnapshot.data() as Map<String, dynamic>)
              .containsKey('hotelid')) {
            hotelid = documentSnapshot['hotelid'];
          }
          if ((documentSnapshot.data() as Map<String, dynamic>)
              .containsKey('mainfacilities')) {
            mainfacilities = documentSnapshot['mainfacilities'];
          }
          if ((documentSnapshot.data() as Map<String, dynamic>)
              .containsKey('name')) {
            name = documentSnapshot['name'];
          }
          if ((documentSnapshot.data() as Map<String, dynamic>)
              .containsKey('otherhotelimages')) {
            otherHotelImages = documentSnapshot['otherhotelimages'];
          }
          if ((documentSnapshot.data() as Map<String, dynamic>)
              .containsKey('price')) {
            price = documentSnapshot['price'].toString();
          }
          if ((documentSnapshot.data() as Map<String, dynamic>)
              .containsKey('promotion')) {
            promotion = documentSnapshot['promotion'].toString();
          }
          if ((documentSnapshot.data() as Map<String, dynamic>)
              .containsKey('rooms')) {
            rooms = documentSnapshot['rooms'];
          }
          if ((documentSnapshot.data() as Map<String, dynamic>)
              .containsKey('stars')) {
            stars = documentSnapshot['stars'];
          }
          if ((documentSnapshot.data() as Map<String, dynamic>)
              .containsKey('subfacilities')) {
            subfacilities = documentSnapshot['subfacilities'];
          }
          if ((documentSnapshot.data() as Map<String, dynamic>)
              .containsKey('taxandcharges')) {
            taxandcharges = documentSnapshot['taxandcharges'];
          }
        });

        FirebaseFirestore.instance
            .collection('booking')
            .doc('aGAm7T71ShOqGUhYphfc')
            .collection('hotels')
            .doc(hotelid)
            .set({
          'name': name,
          'city': city,
          'address': address,
          'price': null,
          //'price': double.parse(startingPriceController.text),
          'promotion': double.parse(promotion),
          'description': description,
          'mainfacilities': mainfacilities,
          'subfacilities': subfacilities,
          'rooms': rooms,
          'datecreated': datecreated,
          'dataentryuid': dataentryuid,
          'coverimage': coverimage,
          'otherhotelimages': otherHotelImages,
          'cancellationfee': null,
          'stars': stars,
          'taxandcharges': null,
          'hotelid': hotelid,
        });
      } else {
        print("Document does not exists");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: Center(
        child: Container(
          width: 300.0,
          height: 50.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color(0xFF000000),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    side: BorderSide(color: Color(0xFFdb9e1f))),
                side: BorderSide(
                  width: 2.5,
                  color: Color(0xFFdb9e1f),
                ),
                textStyle: const TextStyle(fontSize: 16)),
            onPressed: () {
              _updateHotel();
              print("Database Updated");
            },
            child: const Text(
              'Update Database',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
