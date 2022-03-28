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
import 'package:worldsgate/helper/responsive_helper.dart';
import 'package:worldsgate/screens/dataentryoperator/hotels/deomanagehotels.dart';

import '../../../widgets/deonavigationdrawer.dart';
import '../../../widgets/header.dart';
import '../../../widgets/usernavigationdrawer.dart';

class UpdateCarDetails extends StatefulWidget {
  const UpdateCarDetails({Key? key}) : super(key: key);

  @override
  State<UpdateCarDetails> createState() => _UpdateCarDetailsState();
}

class _UpdateCarDetailsState extends State<UpdateCarDetails> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
