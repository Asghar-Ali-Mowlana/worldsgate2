import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_io/io.dart' as u;
import 'package:path/path.dart';

import '../../widgets/deonavigationdrawer.dart';
import '../../widgets/header.dart';
import '../../widgets/usernavigationdrawer.dart';
import 'deomanagehotels.dart';

class AddHotelDetails extends StatefulWidget {
  //const AddHotelDetails({Key? key}) : super(key: key);

  String? uid;

  // //constructor
  AddHotelDetails(
      this.uid,
      );

  @override
  _AddHotelDetailsState createState() => _AddHotelDetailsState();
}

class _AddHotelDetailsState extends State<AddHotelDetails> {
  final _formkey = GlobalKey<FormState>();
  var _scaffoldState = new GlobalKey<ScaffoldState>();



  final TextEditingController hotelNameController = TextEditingController();
  final TextEditingController hotelAddressController = TextEditingController();
  final TextEditingController startingPriceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? city;

  final places = [
    'Deira',
    'Bur Dubai',
    'Beach & Coast',
    'Garhoud',
    'Palm Jumeirah',
    'Barsha Heights (Tecom)',
    'Sheikh Zayed Road',
    'Al Barsha',
    'Dubai Creek',
    'Jumeirah Beach Residence',
    'Dubai Marina',
    'Trade Centre',
    'Old Dubai',
    'Downtown Dubai',
    'Business Bay',
    "Guests' favourite area",
    'Jadaf',
    'Al Qusais',
    'Oud Metha',
    'Dubai Investment Park',
    'Dubai Festival City',
    'Dubai World Central',
    'Umm Suqeim',
    'Discovery Gardens',
    'Dubai Production City',
    'Jumeirah Lakes Towers',
  ];

  DropdownMenuItem<String> buildMenuItem(String place) => DropdownMenuItem(
        value: place,
        child: Text(
          place,
          style: const TextStyle(fontSize: 16.0),
        ),
      );

  List<String> mainFacilities = [];

  bool _isLoading = true;

  bool swimmingValue = true;
  bool fitnessCenterValue = true;
  bool airportShuttleValue = true;
  bool nonSmokingRoomsValue = true;
  bool spaValue = true;
  bool restaurentValue = true;
  bool roomServiceValue = true;
  bool barValue = true;
  bool breakfastValue = true;
  bool wifiValue = true;
  bool teaCoffeeMakerValue = true;
  bool disabledGuestsValue = true;

  bool bathroomValue = false;
  final List<String> bathroomFacilities = <String>[];
  final TextEditingController bathroomFacilitiesController =
      TextEditingController();

  bool bedroomValue = false;
  final List<String> bedroomFacilities = <String>[];
  final TextEditingController bedroomFacilitiesController =
      TextEditingController();

  bool viewValue = false;
  final List<String> viewFacilities = <String>[];
  final TextEditingController viewFacilitiesController =
      TextEditingController();

  bool outdoorsValue = false;
  final List<String> outdoorsFacilities = <String>[];
  final TextEditingController outdoorsFacilitiesController =
      TextEditingController();

  bool kitchenValue = false;
  final List<String> kitchenFacilities = <String>[];
  final TextEditingController kitchenFacilitiesController =
      TextEditingController();

  bool roomAmenitiesValue = false;
  final List<String> roomAmenitiesFacilities = <String>[];
  final TextEditingController roomAmenitiesFacilitiesController =
      TextEditingController();

  bool activitiesValue = false;
  final List<String> activitiesFacilities = <String>[];
  final TextEditingController activitiesFacilitiesController =
      TextEditingController();

  bool livingAreaValue = false;
  final List<String> livingAreaFacilities = <String>[];
  final TextEditingController livingAreaFacilitiesController =
      TextEditingController();

  bool mediaAndTechnologyValue = false;
  final List<String> mediaAndTechnologyFacilities = <String>[];
  final TextEditingController mediaAndTechnologyFacilitiesController =
      TextEditingController();

  bool foodAndDrinkValue = false;
  final List<String> foodAndDrinkFacilities = <String>[];
  final TextEditingController foodAndDrinkFacilitiesController =
      TextEditingController();

  bool internetValue = false;
  final List<String> internetFacilities = <String>[];
  final TextEditingController internetFacilitiesController =
      TextEditingController();

  bool parkingValue = false;
  final List<String> parkingFacilities = <String>[];
  final TextEditingController parkingFacilitiesController =
      TextEditingController();

  bool transportationValue = false;
  final List<String> transportationFacilities = <String>[];
  final TextEditingController transportationFacilitiesController =
      TextEditingController();

  bool frontDeskServicesValue = false;
  final List<String> frontDeskServicesFacilities = <String>[];
  final TextEditingController frontDeskServicesFacilitiesController =
      TextEditingController();

  bool entertainmentValue = false;
  final List<String> entertainmentFacilities = <String>[];
  final TextEditingController entertainmentFacilitiesController =
      TextEditingController();

  bool cleaningServicesValue = false;
  final List<String> cleaningServicesFacilities = <String>[];
  final TextEditingController cleaningServicesFacilitiesController =
      TextEditingController();

  bool businessValue = false;
  final List<String> businessFacilities = <String>[];
  final TextEditingController businessFacilitiesController =
      TextEditingController();

  bool safetyAndSecurityValue = false;
  final List<String> safetyAndSecurityFacilities = <String>[];
  final TextEditingController safetyAndSecurityFacilitiesController =
      TextEditingController();

  bool generalValue = false;
  final List<String> generalFacilities = <String>[];
  final TextEditingController generalFacilitiesController =
      TextEditingController();

  bool accessibilityValue = false;
  final List<String> accessibilityFacilities = <String>[];
  final TextEditingController accessibilityFacilitiesController =
      TextEditingController();

  bool swimmingPoolValue = false;
  final List<String> swimmingPoolFacilities = <String>[];
  final TextEditingController swimmingPoolFacilitiesController =
      TextEditingController();

  bool subSpaValue = false;
  final List<String> subSpaFacilities = <String>[];
  final TextEditingController subSpaFacilitiesController =
      TextEditingController();

  /*final ImagePicker _mainPicker = ImagePicker();
  List<XFile> _mainSelectedFile = [];
  //FirebaseStorage _storageRef = FirebaseStorage.instance;

  Future<void> mainSelectedImage() async {
    if (_mainSelectedFile != null) {
      _mainSelectedFile.clear();
    }
    try {
      final List<XFile>? imgs = await _mainPicker.pickMultiImage();
      if (imgs!.isNotEmpty) {
        _mainSelectedFile.addAll(imgs);
      }
      print('List of selected images: ' + imgs.length.toString());
    } catch (e) {
      print('Something went wrong.' + e.toString());
    }
    setState(() {});
  }

  Future<void> uploadHotelCoverPhoto(XFile _image) async {}

  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedFile = [];
  FirebaseStorage _storageRef = FirebaseStorage.instance;
  List<String> _arrOtherImageUrls = [];

  Future<void> selectImage() async {
    if (_selectedFile != null) {
      _selectedFile.clear();
    }
    try {
      final List<XFile>? imgs = await _picker.pickMultiImage();
      if (imgs!.isNotEmpty) {
        _selectedFile.addAll(imgs);
      }
      print('List of selected images: ' + imgs.length.toString());
    } catch (e) {
      print('Something went wrong.' + e.toString());
    }
    setState(() {});
  }

  void uploadMainFunction(List<XFile> _images) {
    for (int i = 0; i < _images.length; i++) {
      var imageUrl = uploadOtherHotelPhotos(_images[i]);
      _arrOtherImageUrls.add(imageUrl.toString());
    }
  }

  Future<String> uploadOtherHotelPhotos(XFile _image) async {
    try {
      print("1");
      Reference reference =
          _storageRef.ref().child('/hotelimages/hotelsub').child(_image.name);
      print("2");
      UploadTask uploadTask = reference.putFile(File(_image.path));
      print("3");
      uploadTask.whenComplete(() {
        print(reference.getDownloadURL());
      });
      print("4");
      return await reference.getDownloadURL();
    } catch (e) {
      print(e);
    }
    return "Unsuccessful";
  }*/

  bool _isUploadingLoading = false;

  FilePickerResult? result;
  String? file;
  UploadTask? task;
  var coverImageLink;
  List<Uint8List> coverImage = [];

  Future selectFileandUpload() async {
    print('OS: ${u.Platform.operatingSystem}');
    try {
      result = await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: false);
      setState(() => result = result);
      String filename = basename(result!.files.single.name);
      setState(() => file = filename);

      if (result == null) {
        print("Result is null!");
      }

      if (result != null) {
        try {
          print("Start of upload file method");
          Uint8List uploadfile = result!.files.single.bytes!;
          setState(() {
            coverImage.add(uploadfile);
          });
          String filename = basename(result!.files.single.name);

          //final fileName = basename(file!.path);
          final destination = '/hotelimages/hotelmain/$filename';
          print("the destination is $destination");

          final ref = FirebaseStorage.instance.ref(destination);
          task = ref.putData(uploadfile);
          setState(() {
            _isUploadingLoading = true;
          });
          setState(() {});
          print("Total bytes $task");
          print("Total bytes ${task!.snapshot.totalBytes}");

          if (task == null) return;
          final snapshot = await task!.whenComplete(() {
            setState(() {
              _isUploadingLoading = false;
            });
          });
          final urlDownload = await snapshot.ref.getDownloadURL();

          print('Download-Link: $urlDownload');

          coverImageLink = urlDownload;

          setState(() => coverImageLink = urlDownload);
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  // String? cusname;
  //
  // getname() async {
  //   FirebaseFirestore.instance.collection('users') .doc(widget.uid)
  //       .get().then((myDocuments){
  //     cusname = myDocuments.data()!['name'].toString();
  //   });}
  FilePickerResult? otherResult;
  String? otherFile;
  UploadTask? otherTask;
  var otherImageLink;
  List<Uint8List> otherImage = [];
  List<String> OtherHotelImagesUrl = [];

  Future selectOtherFileandUpload() async {
    print('OS: ${u.Platform.operatingSystem}');
    try {
      otherResult = await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: false);
      setState(() => otherResult = otherResult);
      String filename = basename(otherResult!.files.single.name);
      setState(() => otherFile = filename);

      if (otherResult == null) {
        print("Result is null!");
      }

      if (otherResult != null) {
        try {
          print("Start of upload file method");
          Uint8List uploadfile = otherResult!.files.single.bytes!;
          setState(() {
            otherImage.add(uploadfile);
          });
          String filename = basename(otherResult!.files.single.name);

          //final fileName = basename(file!.path);
          final destination = '/hotelimages/hotelsub/$filename';
          print("the destination is $destination");

          final ref = FirebaseStorage.instance.ref(destination);
          otherTask = ref.putData(uploadfile);
          setState(() {
            _isUploadingLoading = true;
          });
          print("Total bytes $otherTask");
          print("Total bytes ${otherTask!.snapshot.totalBytes}");

          if (otherTask == null) return;
          final snapshot = await otherTask!.whenComplete(() {
            setState(() {
              _isUploadingLoading = false;
            });
          });
          final urlDownload = await snapshot.ref.getDownloadURL();

          print('Download-Link: $urlDownload');

          otherImageLink = urlDownload;

          setState(() => otherImageLink = urlDownload);
          OtherHotelImagesUrl.add(otherImageLink);
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  /*Future selectFile() async {
    print('OS: ${u.Platform.operatingSystem}');
    try {
      result = await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: false);

      setState(() => result = result);
      String filename = basename(result!.files.single.name);
      setState(() => file = filename);
    } catch (e) {
      print(e);
    }
  }

  Future uploadFile() async {
    if (result == null) {
      print("Result is null!");
    }

    if (result != null) {
      try {
        print("Start of upload file method");
        Uint8List uploadfile = result!.files.single.bytes!;

        String filename = basename(result!.files.single.name);

        //final fileName = basename(file!.path);
        final destination = '/hotelimages/hotelsub/$filename';
        print("the destination is $destination");

        final ref = FirebaseStorage.instance.ref(destination);
        task = ref.putData(uploadfile);
        setState(() {});
        print("Total bytes $task");
        print("Total bytes ${task!.snapshot.totalBytes}");

        if (task == null) return;
        final snapshot = await task!.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();

        print('Download-Link: $urlDownload');

        imagelink = urlDownload;

        setState(() => imagelink = urlDownload);
      } catch (e) {
        print(e);
      }
    }
  }

  List<File>? files;
  uploadFileToCloud() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      files = result.paths.map((path) => File(path!)).toList();
      setState(() {
        this.files = files;
      });
      print(files);
    } else {
      // User canceled the picker
    }

    /*if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;

      // Upload file
      await FirebaseStorage.instance
          .ref('/hotelimages/hotelsub/$fileName')
          .putData(fileBytes!);
    }*/
  }*/

  _uploadHotelData() async {
    String bathroomCategory = "Bathroom - ",
        bedroomCategory = "Bedroom - ",
        viewCategory = "View - ",
        outdoorsCategory = "Outdoors - ",
        kitchenCategory = "Kitchen - ",
        roomAmenitiesCategory = "Room Amenities - ",
        activitiesCategory = "Activities - ",
        livingAreaCategory = "Living Area - ",
        mediaAndTechnologyCategory = "Media & Technology - ",
        foodCategory = "Food & Drink - ",
        internetCategory = "Internet - ",
        parkingCategory = "Parking - ",
        transportationCategory = "Transportation - ",
        frontDeskCategory = "Front Desk Services - ",
        entertainmentCategory = "Entertainment & Family Services - ",
        cleaningCategory = "Cleaning Services - ",
        businessCategory = "Business Facilities - ",
        safetyCategory = "Safety & Security Facilities - ",
        generalCategory = "General Facilities - ",
        accessibilityCategory = "Accessibility Facilities - ",
        swimmingPoolCategory = "Swimming Pool Facilities - ",
        spaCategory = "Spa Facilities - ";

    for (int i = 0; i < bathroomFacilities.length; i++) {
      setState(() {
        bathroomCategory = bathroomCategory + ", " + bathroomFacilities[i];
      });
    }
    for (int i = 0; i < bedroomFacilities.length; i++) {
      setState(() {
        bedroomCategory = bedroomCategory + ", " + bedroomFacilities[i];
      });
    }
    for (int i = 0; i < viewFacilities.length; i++) {
      setState(() {
        viewCategory = viewCategory + ", " + viewFacilities[i];
      });
    }
    for (int i = 0; i < outdoorsFacilities.length; i++) {
      setState(() {
        outdoorsCategory = outdoorsCategory + ", " + outdoorsFacilities[i];
      });
    }
    for (int i = 0; i < kitchenFacilities.length; i++) {
      setState(() {
        kitchenCategory = kitchenCategory + ", " + kitchenFacilities[i];
      });
    }
    for (int i = 0; i < roomAmenitiesFacilities.length; i++) {
      setState(() {
        roomAmenitiesCategory =
            roomAmenitiesCategory + ", " + roomAmenitiesFacilities[i];
      });
    }
    for (int i = 0; i < activitiesFacilities.length; i++) {
      setState(() {
        activitiesCategory =
            activitiesCategory + ", " + activitiesFacilities[i];
      });
    }
    for (int i = 0; i < livingAreaFacilities.length; i++) {
      setState(() {
        livingAreaCategory =
            livingAreaCategory + ", " + livingAreaFacilities[i];
      });
    }
    for (int i = 0; i < mediaAndTechnologyFacilities.length; i++) {
      setState(() {
        mediaAndTechnologyCategory =
            mediaAndTechnologyCategory + ", " + mediaAndTechnologyFacilities[i];
      });
    }

    for (int i = 0; i < internetFacilities.length; i++) {
      setState(() {
        internetCategory = internetCategory + ", " + internetFacilities[i];
      });
    }
    for (int i = 0; i < parkingFacilities.length; i++) {
      setState(() {
        parkingCategory = parkingCategory + ", " + parkingFacilities[i];
      });
    }
    for (int i = 0; i < transportationFacilities.length; i++) {
      setState(() {
        transportationCategory =
            transportationCategory + ", " + transportationFacilities[i];
      });
    }
    for (int i = 0; i < frontDeskServicesFacilities.length; i++) {
      setState(() {
        frontDeskCategory =
            frontDeskCategory + ", " + frontDeskServicesFacilities[i];
      });
    }
    for (int i = 0; i < entertainmentFacilities.length; i++) {
      setState(() {
        entertainmentCategory =
            entertainmentCategory + ", " + entertainmentFacilities[i];
      });
    }
    for (int i = 0; i < cleaningServicesFacilities.length; i++) {
      setState(() {
        cleaningCategory =
            cleaningCategory + ", " + cleaningServicesFacilities[i];
      });
    }
    for (int i = 0; i < businessFacilities.length; i++) {
      setState(() {
        businessCategory = businessCategory + ", " + businessFacilities[i];
      });
    }
    for (int i = 0; i < safetyAndSecurityFacilities.length; i++) {
      setState(() {
        safetyCategory = safetyCategory + ", " + safetyAndSecurityFacilities[i];
      });
    }
    for (int i = 0; i < generalFacilities.length; i++) {
      setState(() {
        generalCategory = generalCategory + ", " + generalFacilities[i];
      });
    }
    for (int i = 0; i < accessibilityFacilities.length; i++) {
      setState(() {
        accessibilityCategory =
            accessibilityCategory + ", " + accessibilityFacilities[i];
      });
    }
    for (int i = 0; i < swimmingPoolFacilities.length; i++) {
      setState(() {
        swimmingPoolCategory =
            swimmingPoolCategory + ", " + swimmingPoolFacilities[i];
      });
    }
    for (int i = 0; i < subSpaFacilities.length; i++) {
      setState(() {
        spaCategory = spaCategory + ", " + subSpaFacilities[i];
      });
    }

    List<String> subFacilities = [
      bathroomCategory,
      bedroomCategory,
      viewCategory,
      outdoorsCategory,
      kitchenCategory,
      roomAmenitiesCategory,
      activitiesCategory,
      livingAreaCategory,
      mediaAndTechnologyCategory,
      foodCategory,
      internetCategory,
      parkingCategory,
      transportationCategory,
      frontDeskCategory,
      entertainmentCategory,
      cleaningCategory,
      businessCategory,
      safetyCategory,
      generalCategory,
      accessibilityCategory,
      swimmingPoolCategory,
      spaCategory
    ];

    try {
      await FirebaseFirestore.instance.collection('hotels').doc().set({
        'name': hotelNameController.text,
        'city': city,
        'address': hotelAddressController.text,
        'price': double.parse(startingPriceController.text),
        'promotion': double.parse(discountController.text),
        'description': descriptionController.text,
        'mainfacilities': mainFacilities,
        //'subfacilities': subFacilities,
        'datecreated': DateTime.now(),
        'dataentryuid': widget.uid,
        'coverimage': coverImageLink,
        'otherhotelimages': OtherHotelImagesUrl,
        'cancellationfee': null,
     //   'promotion': null,
        'taxandcharges': null
      });
    } catch (e) {
      print(e);
    }
  }


  String? cusname;

  getname() async {
    FirebaseFirestore.instance.collection('users') .doc(widget.uid)
        .get().then((myDocuments){
      cusname = myDocuments.data()!['name'].toString();
    });}


  @override
  void initState() {
    // TODO: implement initState
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
        drawer: new DeoNavigationDrawer(widget.uid),
        backgroundColor: Color(0xFF000000),
        body:
        (_isLoading==true)
            ?
        Center(child: CircularProgressIndicator())
            :
        Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.6,
                      color: Color(0xFF000000),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 120,
                              right: 120,
                              bottom: 120,
                              top: MediaQuery.of(context).size.height * 0.25),
                          child: Form(
                              key: _formkey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    controller: hotelNameController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.cancel,
                                            color: Color(0xFFdb9e1f),
                                          ),
                                          onPressed: () {
                                            hotelNameController..text = "";
                                          }),
                                      hintText: "Enter hotel name",
                                      labelText: "Hotel Name",
                                      hintStyle:
                                          TextStyle(color: Colors.white70),
                                      labelStyle: new TextStyle(
                                          color: Colors.white70, height: 0.1),
                                      enabled: true,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.white70),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Color(0xFFdb9e1f)),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.length == 0) {
                                        return "Hotel name cannot be empty";
                                      }
                                    },
                                    onSaved: (value) {
                                      hotelNameController.text = value!;
                                    },
                                    keyboardType: TextInputType.text,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        hintText: "Select place in UAE",
                                        hintStyle:
                                            TextStyle(color: Colors.white70),
                                        labelText: 'Hotel City',
                                        labelStyle: TextStyle(
                                            color: Colors.white70, height: 0.1),
                                        enabled: true,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.white70),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color(0xFFdb9e1f)),
                                        ),
                                      ),
                                      dropdownColor: Color(0xFF000000),
                                      //focusColor: Color(0xFFdb9e1f),
                                      style: TextStyle(color: Colors.white),
                                      isExpanded: true,
                                      value: city,
                                      items: places.map(buildMenuItem).toList(),
                                      onChanged: (value) => setState(() {
                                            this.city = value as String?;
                                          })),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    controller: hotelAddressController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.cancel,
                                            color: Color(0xFFdb9e1f),
                                          ),
                                          onPressed: () {
                                            hotelAddressController..text = "";
                                          }),
                                      hintText: "Enter hotel address",
                                      labelText: "Hotel Address",
                                      hintStyle:
                                          TextStyle(color: Colors.white70),
                                      labelStyle: new TextStyle(
                                          color: Colors.white70, height: 0.1),
                                      enabled: true,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.white70),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Color(0xFFdb9e1f)),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.length == 0) {
                                        return "Hotel address cannot be empty";
                                      }
                                    },
                                    onSaved: (value) {
                                      hotelAddressController.text = value!;
                                    },
                                    keyboardType: TextInputType.text,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    controller: startingPriceController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.cancel,
                                            color: Color(0xFFdb9e1f),
                                          ),
                                          onPressed: () {
                                            startingPriceController..text = "";
                                          }),
                                      hintText: "Enter starting price",
                                      labelText: "Starting Price",
                                      hintStyle:
                                          TextStyle(color: Colors.white70),
                                      labelStyle: new TextStyle(
                                          color: Colors.white70, height: 0.1),
                                      enabled: true,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.white70),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Color(0xFFdb9e1f)),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.length == 0) {
                                        return "Starting price cannot be empty";
                                      }
                                    },
                                    onSaved: (value) {
                                      startingPriceController.text = value!;
                                    },
                                    keyboardType: TextInputType.number,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    controller: discountController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.cancel,
                                            color: Color(0xFFdb9e1f),
                                          ),
                                          onPressed: () {
                                            discountController..text = "";
                                          }),
                                      hintText: "Enter discounts",
                                      labelText: "Discounts",
                                      hintStyle:
                                          TextStyle(color: Colors.white70),
                                      labelStyle: new TextStyle(
                                          color: Colors.white70, height: 0.1),
                                      enabled: true,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.white70),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Color(0xFFdb9e1f)),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.length == 0) {
                                        return "Discounts cannot be empty";
                                      }
                                    },
                                    onSaved: (value) {
                                      discountController.text = value!;
                                    },
                                    keyboardType: TextInputType.number,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    maxLines: null,
                                    controller: descriptionController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.cancel,
                                            color: Color(0xFFdb9e1f),
                                          ),
                                          onPressed: () {
                                            descriptionController..text = "";
                                          }),
                                      hintText: "Enter hotel description",
                                      labelText: "Hotel Description",
                                      hintStyle:
                                          TextStyle(color: Colors.white70),
                                      labelStyle: new TextStyle(
                                          color: Colors.white70, height: 0.1),
                                      enabled: true,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.white70),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Color(0xFFdb9e1f)),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.length == 0) {
                                        return "Hotel description cannot be empty";
                                      }
                                    },
                                    onSaved: (value) {
                                      descriptionController.text = value!;
                                    },
                                    keyboardType: TextInputType.multiline,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Hotel Cover Photos",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              //mainSelectedImage();
                                              //uploadFileToCloud();
                                              selectFileandUpload();
                                            },
                                            child: Container(
                                              height: 100.0,
                                              width: 100.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Color(0xFFdb9e1f))),
                                              child: Icon(Icons.add),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  coverImage.length != 0
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.6,
                                          height: 160,
                                          child: GridView.builder(
                                              itemCount: coverImage.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 7),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Container(
                                                      height: 100,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: MemoryImage(
                                                                  coverImage[
                                                                      index]),
                                                              fit: BoxFit
                                                                  .cover))),
                                                );
                                                //Text('Image : ' + index.toString());
                                              }),
                                        )
                                      : SizedBox(
                                          height: 10,
                                        ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Other Hotel Photos",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              //selectImage();
                                              //selectFile();
                                              selectOtherFileandUpload();
                                            },
                                            child: Container(
                                              height: 100.0,
                                              width: 100.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Color(0xFFdb9e1f))),
                                              child: Icon(Icons.add),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              //selectImage();
                                              //selectFile();
                                              selectOtherFileandUpload();
                                            },
                                            child: Container(
                                              height: 100.0,
                                              width: 100.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Color(0xFFdb9e1f))),
                                              child: Icon(Icons.add),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              //selectImage();
                                              //selectFile();
                                              selectOtherFileandUpload();
                                            },
                                            child: Container(
                                              height: 100.0,
                                              width: 100.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Color(0xFFdb9e1f))),
                                              child: Icon(Icons.add),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              //selectImage();
                                              //selectFile();
                                              selectOtherFileandUpload();
                                            },
                                            child: Container(
                                              height: 100.0,
                                              width: 100.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Color(0xFFdb9e1f))),
                                              child: Icon(Icons.add),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              //selectImage();
                                              //selectFile();
                                              selectOtherFileandUpload();
                                            },
                                            child: Container(
                                              height: 100.0,
                                              width: 100.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Color(0xFFdb9e1f))),
                                              child: Icon(Icons.add),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              //selectImage();
                                              //selectFile();
                                              selectOtherFileandUpload();
                                            },
                                            child: Container(
                                              height: 100.0,
                                              width: 100.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Color(0xFFdb9e1f))),
                                              child: Icon(Icons.add),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              //selectImage();
                                              //selectFile();
                                              selectOtherFileandUpload();
                                            },
                                            child: Container(
                                              height: 100.0,
                                              width: 100.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Color(0xFFdb9e1f))),
                                              child: Icon(Icons.add),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              //selectImage();
                                              //selectFile();
                                              selectOtherFileandUpload();
                                            },
                                            child: Container(
                                              height: 100.0,
                                              width: 100.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Color(0xFFdb9e1f))),
                                              child: Icon(Icons.add),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  otherImage.length != 0
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.6,
                                          height: 160,
                                          child: GridView.builder(
                                              itemCount: otherImage.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 8),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                        height: 100,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: MemoryImage(
                                                                    otherImage[
                                                                        index]),
                                                                fit: BoxFit
                                                                    .cover))),
                                                  ),
                                                );
                                                //Text('Image : ' + index.toString());
                                              }),
                                        )
                                      : SizedBox(
                                          height: 10,
                                        ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Main Facilities",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Wrap(
                                    direction: Axis.vertical,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            child: CheckboxListTile(
                                              title: Text(
                                                "Swimming Pool",
                                                style: TextStyle(
                                                    color: Colors.white70),
                                              ),
                                              //secondary: Icon(
                                              //Icons.person,
                                              //color: Colors.white70,
                                              //),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              value: swimmingValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  this.swimmingValue = value!;
                                                });
                                                if (swimmingValue) {
                                                  mainFacilities
                                                      .add('Swimming Pool');
                                                } else {
                                                  mainFacilities.removeAt(
                                                      mainFacilities.indexOf(
                                                          'Swimming Pool'));
                                                }
                                              },
                                              activeColor: Color(0xFFdb9e1f),
                                              checkColor: Colors.white,
                                              side: BorderSide(
                                                color: Colors.white70,
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            child: CheckboxListTile(
                                              title: Text(
                                                "Fitness Center",
                                                style: TextStyle(
                                                    color: Colors.white70),
                                              ),
                                              //secondary: Icon(
                                              //Icons.person,
                                              //color: Colors.white70,
                                              //),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              value: fitnessCenterValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  this.fitnessCenterValue =
                                                      value!;
                                                });
                                                if (fitnessCenterValue) {
                                                  mainFacilities
                                                      .add('Fitness Center');
                                                } else {
                                                  mainFacilities.removeAt(
                                                      mainFacilities.indexOf(
                                                          'Fitness Center'));
                                                }
                                              },
                                              activeColor: Color(0xFFdb9e1f),
                                              checkColor: Colors.white,
                                              side: BorderSide(
                                                color: Colors.white70,
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            child: CheckboxListTile(
                                              title: Text(
                                                "Airport Shuttle",
                                                style: TextStyle(
                                                    color: Colors.white70),
                                              ),
                                              //secondary: Icon(
                                              //Icons.person,
                                              //color: Colors.white70,
                                              //),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              value: airportShuttleValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  this.airportShuttleValue =
                                                      value!;
                                                });
                                                if (airportShuttleValue) {
                                                  mainFacilities
                                                      .add('Airport Shuttle');
                                                } else {
                                                  mainFacilities.removeAt(
                                                      mainFacilities.indexOf(
                                                          'Airport Shuttle'));
                                                }
                                              },
                                              activeColor: Color(0xFFdb9e1f),
                                              checkColor: Colors.white,
                                              side: BorderSide(
                                                color: Colors.white70,
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            child: CheckboxListTile(
                                              title: Text(
                                                "Non-smoking rooms",
                                                style: TextStyle(
                                                    color: Colors.white70),
                                              ),
                                              //secondary: Icon(
                                              //Icons.person,
                                              //color: Colors.white70,
                                              //),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              value: nonSmokingRoomsValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  this.nonSmokingRoomsValue =
                                                      value!;
                                                });
                                                if (nonSmokingRoomsValue) {
                                                  mainFacilities
                                                      .add('Non-smoking rooms');
                                                } else {
                                                  mainFacilities.removeAt(
                                                      mainFacilities.indexOf(
                                                          'Non-smoking rooms'));
                                                }
                                              },
                                              activeColor: Color(0xFFdb9e1f),
                                              checkColor: Colors.white,
                                              side: BorderSide(
                                                color: Colors.white70,
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            child: CheckboxListTile(
                                              title: Text(
                                                "Spa",
                                                style: TextStyle(
                                                    color: Colors.white70),
                                              ),
                                              //secondary: Icon(
                                              //Icons.person,
                                              //color: Colors.white70,
                                              //),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              value: spaValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  this.spaValue = value!;
                                                });
                                                if (spaValue) {
                                                  mainFacilities.add('Spa');
                                                } else {
                                                  mainFacilities.removeAt(
                                                      mainFacilities
                                                          .indexOf('Spa'));
                                                }
                                              },
                                              activeColor: Color(0xFFdb9e1f),
                                              checkColor: Colors.white,
                                              side: BorderSide(
                                                color: Colors.white70,
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            child: CheckboxListTile(
                                              title: Text(
                                                "Restaurant",
                                                style: TextStyle(
                                                    color: Colors.white70),
                                              ),
                                              //secondary: Icon(
                                              //Icons.person,
                                              //color: Colors.white70,
                                              //),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              value: restaurentValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  this.restaurentValue = value!;
                                                });
                                                if (restaurentValue) {
                                                  mainFacilities
                                                      .add('Restaurant');
                                                } else {
                                                  mainFacilities.removeAt(
                                                      mainFacilities.indexOf(
                                                          'Restaurant'));
                                                }
                                              },
                                              activeColor: Color(0xFFdb9e1f),
                                              checkColor: Colors.white,
                                              side: BorderSide(
                                                color: Colors.white70,
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            child: CheckboxListTile(
                                              title: Text(
                                                "Room service",
                                                style: TextStyle(
                                                    color: Colors.white70),
                                              ),
                                              //secondary: Icon(
                                              //Icons.person,
                                              //color: Colors.white70,
                                              //),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              value: roomServiceValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  this.roomServiceValue =
                                                      value!;
                                                });
                                                if (roomServiceValue) {
                                                  mainFacilities
                                                      .add('Room service');
                                                } else {
                                                  mainFacilities.removeAt(
                                                      mainFacilities.indexOf(
                                                          'Room service'));
                                                }
                                              },
                                              activeColor: Color(0xFFdb9e1f),
                                              checkColor: Colors.white,
                                              side: BorderSide(
                                                color: Colors.white70,
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            child: CheckboxListTile(
                                              title: Text(
                                                "Bar",
                                                style: TextStyle(
                                                    color: Colors.white70),
                                              ),
                                              //secondary: Icon(
                                              //Icons.person,
                                              //color: Colors.white70,
                                              //),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              value: barValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  this.barValue = value!;
                                                });
                                                if (barValue) {
                                                  mainFacilities.add('Bar');
                                                } else {
                                                  mainFacilities.removeAt(
                                                      mainFacilities
                                                          .indexOf('Bar'));
                                                }
                                              },
                                              activeColor: Color(0xFFdb9e1f),
                                              checkColor: Colors.white,
                                              side: BorderSide(
                                                color: Colors.white70,
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            child: CheckboxListTile(
                                              title: Text(
                                                "Breakfast",
                                                style: TextStyle(
                                                    color: Colors.white70),
                                              ),
                                              //secondary: Icon(
                                              //Icons.person,
                                              //color: Colors.white70,
                                              //),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              value: breakfastValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  this.breakfastValue = value!;
                                                });
                                                if (breakfastValue) {
                                                  mainFacilities
                                                      .add('Breakfast');
                                                } else {
                                                  mainFacilities.removeAt(
                                                      mainFacilities.indexOf(
                                                          'Breakfast'));
                                                }
                                              },
                                              activeColor: Color(0xFFdb9e1f),
                                              checkColor: Colors.white,
                                              side: BorderSide(
                                                color: Colors.white70,
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            child: CheckboxListTile(
                                              title: Text(
                                                "WiFi in all areas",
                                                style: TextStyle(
                                                    color: Colors.white70),
                                              ),
                                              //secondary: Icon(
                                              //Icons.person,
                                              //color: Colors.white70,
                                              //),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              value: wifiValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  this.wifiValue = value!;
                                                });
                                                if (wifiValue) {
                                                  mainFacilities
                                                      .add('WiFi in all areas');
                                                } else {
                                                  mainFacilities.removeAt(
                                                      mainFacilities.indexOf(
                                                          'WiFi in all areas'));
                                                }
                                              },
                                              activeColor: Color(0xFFdb9e1f),
                                              checkColor: Colors.white,
                                              side: BorderSide(
                                                color: Colors.white70,
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            child: CheckboxListTile(
                                              title: Text(
                                                "Tea/Coffee Maker in All Rooms",
                                                style: TextStyle(
                                                    color: Colors.white70),
                                              ),
                                              //secondary: Icon(
                                              //Icons.person,
                                              //color: Colors.white70,
                                              //),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              value: teaCoffeeMakerValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  this.teaCoffeeMakerValue =
                                                      value!;
                                                });
                                                if (teaCoffeeMakerValue) {
                                                  mainFacilities.add(
                                                      'Tea/Coffee Maker in All Rooms');
                                                } else {
                                                  mainFacilities.removeAt(
                                                      mainFacilities.indexOf(
                                                          'Tea/Coffee Maker in All Rooms'));
                                                }
                                              },
                                              activeColor: Color(0xFFdb9e1f),
                                              checkColor: Colors.white,
                                              side: BorderSide(
                                                color: Colors.white70,
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            child: CheckboxListTile(
                                              title: Text(
                                                "Facilities for disabled guests",
                                                style: TextStyle(
                                                    color: Colors.white70),
                                              ),
                                              //secondary: Icon(
                                              //Icons.person,
                                              //color: Colors.white70,
                                              //),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              value: disabledGuestsValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  this.disabledGuestsValue =
                                                      value!;
                                                });
                                                if (disabledGuestsValue) {
                                                  mainFacilities.add(
                                                      'Facilities for disabled guests');
                                                } else {
                                                  mainFacilities.removeAt(
                                                      mainFacilities.indexOf(
                                                          'Facilities for disabled guests'));
                                                }
                                                print(mainFacilities);
                                              },
                                              activeColor: Color(0xFFdb9e1f),
                                              checkColor: Colors.white,
                                              side: BorderSide(
                                                color: Colors.white70,
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  /*const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Sub-Facilities",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.bathroomValue =
                                            !this.bathroomValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Bathroom",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                bathroomValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            bathroomValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            bathroomFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      bathroomFacilities.add(
                                                                          bathroomFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter bathroom facilities",
                                                          labelText:
                                                              "Bathroom Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Bathroom facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          bathroomFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            bathroomValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                bathroomFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  bathroomFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            bathroomFacilities.remove(bathroomFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.bedroomValue = !this.bedroomValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Bedroom",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                bedroomValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            bedroomValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            bedroomFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      bedroomFacilities.add(
                                                                          bedroomFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter bedroom facilities",
                                                          labelText:
                                                              "Bedroom Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Bedroom facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          bedroomFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            bedroomValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                bedroomFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  bedroomFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            bedroomFacilities.remove(bedroomFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.viewValue = !this.viewValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "View",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                viewValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            viewValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            viewFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      viewFacilities.add(
                                                                          viewFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter view facilities",
                                                          labelText:
                                                              "View Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "View facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          viewFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            viewValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                viewFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  viewFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            viewFacilities.remove(viewFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.outdoorsValue =
                                            !this.outdoorsValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Outdoors",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                outdoorsValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            outdoorsValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            outdoorsFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      outdoorsFacilities.add(
                                                                          outdoorsFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter outdoor facilities",
                                                          labelText:
                                                              "Outdoor Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "View facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          outdoorsFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            outdoorsValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                outdoorsFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  outdoorsFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            outdoorsFacilities.remove(outdoorsFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.kitchenValue = !this.kitchenValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Kitchen",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                kitchenValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            kitchenValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            kitchenFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      kitchenFacilities.add(
                                                                          kitchenFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter kitchen facilities",
                                                          labelText:
                                                              "Kitchen Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Kitchen facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          kitchenFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            kitchenValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                kitchenFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  kitchenFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            kitchenFacilities.remove(kitchenFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.roomAmenitiesValue =
                                            !this.roomAmenitiesValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Rooms Amenities",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                roomAmenitiesValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            roomAmenitiesValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            roomAmenitiesFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      roomAmenitiesFacilities.add(
                                                                          roomAmenitiesFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter rooms amenities facilities",
                                                          labelText:
                                                              "Rooms Amenities Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Rooms amenities facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          roomAmenitiesFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            roomAmenitiesValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                roomAmenitiesFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  roomAmenitiesFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            roomAmenitiesFacilities.remove(roomAmenitiesFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.activitiesValue =
                                            !this.activitiesValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Activities",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                activitiesValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            activitiesValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            activitiesFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      activitiesFacilities.add(
                                                                          activitiesFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter activities facilities",
                                                          labelText:
                                                              "Activities Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Activities facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          activitiesFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            activitiesValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                activitiesFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  activitiesFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            activitiesFacilities.remove(activitiesFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.livingAreaValue =
                                            !this.livingAreaValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Living Area",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                livingAreaValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            livingAreaValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            livingAreaFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      livingAreaFacilities.add(
                                                                          livingAreaFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter living area facilities",
                                                          labelText:
                                                              "Living Area Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Living area facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          livingAreaFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            livingAreaValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                livingAreaFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  livingAreaFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            livingAreaFacilities.remove(livingAreaFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.mediaAndTechnologyValue =
                                            !this.mediaAndTechnologyValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Media & Technology",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                mediaAndTechnologyValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            mediaAndTechnologyValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            mediaAndTechnologyFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      mediaAndTechnologyFacilities.add(
                                                                          mediaAndTechnologyFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter media & technology facilities",
                                                          labelText:
                                                              "Media & Technology Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Media & technology facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          mediaAndTechnologyFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            mediaAndTechnologyValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                mediaAndTechnologyFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  mediaAndTechnologyFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            mediaAndTechnologyFacilities.remove(mediaAndTechnologyFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.foodAndDrinkValue =
                                            !this.foodAndDrinkValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Food & Drink",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                foodAndDrinkValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            foodAndDrinkValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            foodAndDrinkFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      foodAndDrinkFacilities.add(
                                                                          foodAndDrinkFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter food & drink facilities",
                                                          labelText:
                                                              "Food & Drink Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Food & drink facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          foodAndDrinkFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            foodAndDrinkValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                foodAndDrinkFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  foodAndDrinkFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            foodAndDrinkFacilities.remove(foodAndDrinkFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.internetValue =
                                            !this.internetValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Internet",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                internetValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            internetValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            internetFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      internetFacilities.add(
                                                                          internetFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter internet facilities",
                                                          labelText:
                                                              "Internet Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Internet facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          internetFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            internetValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                internetFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  internetFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            internetFacilities.remove(internetFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.parkingValue = !this.parkingValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Parking",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                parkingValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            parkingValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            parkingFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      parkingFacilities.add(
                                                                          parkingFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter parking facilities",
                                                          labelText:
                                                              "Parking Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Parking facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          parkingFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            parkingValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                parkingFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  parkingFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            parkingFacilities.remove(parkingFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.transportationValue =
                                            !this.transportationValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Transportation",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                transportationValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            transportationValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            transportationFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      transportationFacilities.add(
                                                                          transportationFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter transportation facilities",
                                                          labelText:
                                                              "Transportation Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Transportation facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          transportationFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            transportationValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                transportationFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  transportationFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            transportationFacilities.remove(transportationFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.frontDeskServicesValue =
                                            !this.frontDeskServicesValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Front Desk Services",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                frontDeskServicesValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            frontDeskServicesValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            frontDeskServicesFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      frontDeskServicesFacilities.add(
                                                                          frontDeskServicesFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter front desk services facilities",
                                                          labelText:
                                                              "Front Desk Services Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Front desk services facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          frontDeskServicesFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            frontDeskServicesValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                frontDeskServicesFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  frontDeskServicesFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            frontDeskServicesFacilities.remove(frontDeskServicesFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.entertainmentValue =
                                            !this.entertainmentValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Entertainment & Family Services",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                entertainmentValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            entertainmentValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            entertainmentFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      entertainmentFacilities.add(
                                                                          entertainmentFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter entertainment & family services facilities",
                                                          labelText:
                                                              "Entertainment & Family Services Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Entertainment & family services facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          entertainmentFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            entertainmentValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                entertainmentFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  entertainmentFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            entertainmentFacilities.remove(entertainmentFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.cleaningServicesValue =
                                            !this.cleaningServicesValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Cleaning Services",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                cleaningServicesValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            cleaningServicesValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            cleaningServicesFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      cleaningServicesFacilities.add(
                                                                          cleaningServicesFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter cleaning services facilities",
                                                          labelText:
                                                              "Cleaning Services Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Cleaning services facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          cleaningServicesFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            cleaningServicesValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                cleaningServicesFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  cleaningServicesFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            cleaningServicesFacilities.remove(cleaningServicesFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.businessValue =
                                            !this.businessValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Business Facilities",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                businessValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            businessValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            businessFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      businessFacilities.add(
                                                                          businessFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter business facilities",
                                                          labelText:
                                                              "Business Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Business facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          businessFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            businessValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                businessFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  businessFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            businessFacilities.remove(businessFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.safetyAndSecurityValue =
                                            !this.safetyAndSecurityValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Safety & Security Facilities",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                safetyAndSecurityValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            safetyAndSecurityValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            safetyAndSecurityFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      safetyAndSecurityFacilities.add(
                                                                          safetyAndSecurityFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter safety & security facilities",
                                                          labelText:
                                                              "Safety & Security Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Safety & security facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          safetyAndSecurityFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            safetyAndSecurityValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                safetyAndSecurityFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  safetyAndSecurityFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            safetyAndSecurityFacilities.remove(safetyAndSecurityFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.generalValue = !this.generalValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "General Facilities",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                generalValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            generalValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            generalFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      generalFacilities.add(
                                                                          generalFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter general facilities",
                                                          labelText:
                                                              "General Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "General facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          generalFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            generalValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                generalFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  generalFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            generalFacilities.remove(generalFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.accessibilityValue =
                                            !this.accessibilityValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Accessibility Facilities",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                accessibilityValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            accessibilityValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            accessibilityFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      accessibilityFacilities.add(
                                                                          accessibilityFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter accessibility facilities",
                                                          labelText:
                                                              "Accessibility Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Accessibility facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          generalFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            accessibilityValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                accessibilityFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  accessibilityFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            accessibilityFacilities.remove(accessibilityFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.swimmingPoolValue =
                                            !this.swimmingPoolValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Swimming Pool Facilities",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                swimmingPoolValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            swimmingPoolValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            swimmingPoolFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      swimmingPoolFacilities.add(
                                                                          swimmingPoolFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter swimming pool facilities",
                                                          labelText:
                                                              "Swimming Pool Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Swimming pool facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          swimmingPoolFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            swimmingPoolValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                swimmingPoolFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  swimmingPoolFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            swimmingPoolFacilities.remove(swimmingPoolFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        this.subSpaValue = !this.subSpaValue;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white70))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Spa Facilities",
                                                  style: TextStyle(
                                                      color: Color(0xFFdb9e1f)),
                                                ),
                                                subSpaValue == false
                                                    ? Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xFFdb9e1f),
                                                      )
                                                    : Icon(Icons.arrow_drop_up,
                                                        color:
                                                            Color(0xFFdb9e1f))
                                              ],
                                            ),
                                            subSpaValue == true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        controller:
                                                            subSpaFacilitiesController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: Color(
                                                                        0xFFdb9e1f),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      subSpaFacilities.add(
                                                                          subSpaFacilitiesController
                                                                              .text);
                                                                    });
                                                                  }),
                                                          hintText:
                                                              "Enter spa facilities",
                                                          labelText:
                                                              "Spa Facilities",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                          labelStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 0.1),
                                                          enabled: true,
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .white70),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xFFdb9e1f)),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.length ==
                                                              0) {
                                                            return "Spa facilities cannot be empty";
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          subSpaFacilitiesController
                                                              .text = value!;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                            subSpaValue == true
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 150.0,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFFdb9e1f))),
                                                        child: ListView.builder(
                                                            itemCount:
                                                                subSpaFacilities
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return new ListTile(
                                                                title: Text(
                                                                  subSpaFacilities[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                                trailing:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Color(0xFFdb9e1f),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            subSpaFacilities.remove(subSpaFacilities[index]);
                                                                          });
                                                                        }),
                                                              );
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),*/
                                  _isUploadingLoading
                                      ? Padding(
                                          padding: const EdgeInsets.only(top: 16.0),
                                          child: SizedBox(
                                              height: 80.0,
                                              width: 80.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        Color(0xFFdb9e1f)),
                                              )),
                                        )
                                      : Container(
                                          width: 300.0,
                                          height: 50.0,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Color(0xFF000000),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.0)),
                                                    side: BorderSide(
                                                        color:
                                                            Color(0xFFdb9e1f))),
                                                side: BorderSide(
                                                  width: 2.5,
                                                  color: Color(0xFFdb9e1f),
                                                ),
                                                textStyle: const TextStyle(
                                                    fontSize: 16)),
                                            onPressed: () {
                                              //uploadMainFunction(_selectedFile);
                                              //uploadFile();
                                              _uploadHotelData();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DeoManageHotels(widget.uid)));
                                            },
                                            child: const Text(
                                              'Save',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                left: 0.0,
                top: 0.0,
                right: 0.0,
                child: Container(child: VendomeHeader(drawer: _scaffoldState, cusname: cusname,))),
          ],
        ),
      ),
    );
  }
}
