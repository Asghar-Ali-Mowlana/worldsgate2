import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart' as u;
import 'package:worldsgate/screens/databaseupdatefile.dart';
import 'package:worldsgate/screens/dataentryoperator/delivery/restaurants/deomanagerestaurant.dart';
import 'package:worldsgate/screens/dataentryoperator/delivery/restaurants/food/deomanagefood.dart';
import 'package:worldsgate/screens/loginpage.dart';
import 'package:worldsgate/screens/user/userhomepage.dart';
import 'package:worldsgate/screens/user/userlocationconfirmation.dart';
import 'package:worldsgate/screens/user/userpharmacyorder.dart';
import 'package:worldsgate/screens/user/userrestaurantorder.dart';
import 'package:worldsgate/screens/user/usersupermarketorder.dart';
import 'package:worldsgate/screens/user/userviewrestaurentdetails.dart';

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
        home: /*UserPharmacyOrder("WpzPfHN360dyUtmpSo2a3yhXVak2",
            "Palm Jumeirah")*/ /*UserSupermarketOrder("WpzPfHN360dyUtmpSo2a3yhXVak2",
            "Garhoud")*/ /*UserHomePage("WpzPfHN360dyUtmpSo2a3yhXVak2",
            "Palm Jumeirah")*/
        /*UserViewRestaurantDetails("WpzPfHN360dyUtmpSo2a3yhXVak2",
                "Palm Jumeirah", "4SCpLsKsXscwmSZpyvXf")*/
        /*UpdateDatabase()*/ LoginPage() /*UserOrderFood(
                "WpzPfHN360dyUtmpSo2a3yhXVak2", "Deira")*/
        /*DeoManageFood("WpzPfHN360dyUtmpSo2a3yhXVak2", "4SCpLsKsXscwmSZpyvXf")*/ /*LocationConfirmation(
                "WpzPfHN360dyUtmpSo2a3yhXVak2")*/
        );
  }
}
