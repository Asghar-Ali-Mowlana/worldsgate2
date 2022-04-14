import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart' as u;
import 'package:worldsgate/screens/dataentryoperator/cars/deoaddcars.dart';
import 'package:worldsgate/screens/dataentryoperator/cars/deomanagecars.dart';
import 'package:worldsgate/screens/dataentryoperator/cars/deoupdatecardetails.dart';

import 'package:worldsgate/screens/dataentryoperator/delivery/restaurants/food/deoaddfoodcategorydetails.dart';
import 'package:worldsgate/screens/dataentryoperator/delivery/restaurants/food/deoorderfood.dart';
import 'package:worldsgate/screens/dataentryoperator/hotels/deoaddhoteldetails.dart';
import 'package:worldsgate/screens/loginpage.dart';
import 'package:worldsgate/screens/user/usercarbooking.dart';
import 'package:worldsgate/screens/user/userhomepage.dart';
import 'package:worldsgate/screens/user/userhotelbooking.dart';
import 'package:worldsgate/screens/user/userorderfood.dart';
import 'package:worldsgate/screens/user/userviewcardetails.dart';
import 'package:worldsgate/screens/user/userviewhoteldetails.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (u.Platform.operatingSystem == "android" ||
      u.Platform.operatingSystem == "ios") {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      // For Firebase JS SDK v7.20.0 and later, measurementId is optional
      options: const FirebaseOptions(
        apiKey: "AIzaSyDw9J5oQw3a1OrqBWAVgNmirp-7Es5gs8E",
        projectId: "worldgates-93f28",
        storageBucket: "worldgates-93f28.appspot.com",
        messagingSenderId: "1087644602140",
        appId: "1:1087644602140:web:4c5600a8e70960eaa6b4d9",
      ),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'worldsgate',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
            primary: const Color(0xFFBA780F),
            onSurface: const Color(0xFFBA780F)),
        primarySwatch: Colors.blue,
      ),
      home: DeoOrderFood("WpzPfHN360dyUtmpSo2a3yhXVak2"),
    );
  }
}
