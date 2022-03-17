import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worldsgate/widgets/deonavigationdrawer.dart';
import 'package:worldsgate/widgets/header.dart';
import '../../widgets/sidelayout.dart';
import 'addhoteldetails.dart';

class DeoViewHotels extends StatefulWidget {
  //const DeoViewHotels({Key? key}) : super(key: key);

  String? uid;
  String? hotelid;


  // //constructor
  // DeoViewHotels(
  //   this.uid,
  // );

  @override
  _DeoViewHotelsState createState() => _DeoViewHotelsState();
}

class _DeoViewHotelsState extends State<DeoViewHotels> {
  bool _isLoading = true;

  var _scaffoldState = new GlobalKey<ScaffoldState>();

  String as = "https://www.thedesignwork.com/wp-content/uploads/2011/10/Random-Pictures-of-Conceptual-and-Creative-Ideas-02.jpg";



  // getname() async {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(widget.uid)
  //       .get()
  //       .then((myDocuments) {
  //     cusname = myDocuments.data()!['name'].toString();
  //   });
  // }



  List<dynamic> dategroupbylist =<dynamic>[];

  var lisst;
  var x = [];
  var y;

  getyo() async{

   await FirebaseFirestore.instance
        .collection('hotels')
        .where('hotelid', isEqualTo: "0ebHtKvN3xT17v3L1fL9")
      // .where('hotelid', isEqualTo: widget.hotelid)
        .get()
        .then((QuerySnapshot querySnapshot) =>
    {

      querySnapshot.docs.forEach((doc) {

        x = doc['otherhotelimages'].toList();
        dategroupbylist.add(
          doc['otherhotelimages'],

        );
        y = doc['coverimage'];
  }),


});
    try {

      setState(() {
        lisst = dategroupbylist.toList();
      });

      //print(testList[0].key);
    } catch (e) {
      print(e);
    }
  }


  //
  // List<Widget> newbuilder() {
  //   List<Widget> m = [];
  //
  //
  //   for (int i = 0; i < lisst.length; i++) {
  //
  //
  //     m.add( Image.network(lisst[i][0].toString(), width: 560.0,));
  //     print("Index running time $i");
  //     print(lisst[i][1]);
  //
  //   }
  //
  //   return m;
  //
  // }



  List<Widget> newbuilder() {
    List<Widget> m = [];


    for (int i = 0; i < lisst.length; i++) {

      m.add(Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.network(
                        lisst[i][0].toString().isEmpty
                            ? lisst[i][1].toString():lisst[i][0].toString(),
                   width: MediaQuery.of(context).size.width / 5.85),
                  ),
                  //Image.network(dategroupbylist.elementAt(1).toString(),    width: 280.0,),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.network(


                        lisst[i][1].toString().isEmpty
                            ? lisst[i][1].toString():lisst[i][1].toString(),  width: MediaQuery.of(context).size.width / 5.85),
                  )

                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.network(
                        y.toString(), width: MediaQuery.of(context).size.width /2.85),
                  )
                ],
              ),
            ],

          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.network(lisst[i][2].toString().isEmpty
                    ? lisst[i][4].toString():lisst[i][1].toString(), width: MediaQuery.of(context).size.width / 9.95),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.network(
                    lisst[i][3].toString().isEmpty
   ? lisst[i][1].toString():lisst[i][1].toString(), width: MediaQuery.of(context).size.width / 9.95),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.network( lisst[i][4].toString().isEmpty
                    ? lisst[i][1].toString():lisst[i][4].toString(), width: MediaQuery.of(context).size.width / 9.95),
              ),  Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.network( lisst[i][5].toString().isEmpty
                    ? lisst[i][1].toString():lisst[i][5].toString(), width: MediaQuery.of(context).size.width / 9.95),
              ),  Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.network( lisst[i][6].toString().isEmpty
                    ? lisst[i][1].toString():lisst[i][6].toString(), width: MediaQuery.of(context).size.width / 9.95),
              ),

            ],

          ),
        ],
      ),);


      //m.add( Image.network(lisst[i][0].toString(), width: 560.0,));
      print("Index running time $i");
      print(lisst[i][1]);

    }

    return m;

  }



  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    // getname();
    getyo();
    //newbuilder();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //final double height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      key: _scaffoldState,

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   iconTheme: IconThemeData(color: Color(0xFFdb9e1f)),
      // ),

      //endDrawer: new DeoNavigationDrawer(),

      drawer: new DeoNavigationDrawer(widget.uid),

      backgroundColor: Color(0xFF000000),
      body:

      (_isLoading == true)
          ? Center(child: CircularProgressIndicator())
          :


      Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  children: [
                    SizedBox(
                      height: 160.0,
                    ),

                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SideLayout(),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                child: Column(
                                  children: [
                                    //row for button and booking hotel heading
                                    Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.width / 80),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Color(0xFFdb9e1f),
                                                    size: width*0.015,
                                                  ),
                                                  Text(
                                                    "  CheRiz Boutique Villa Hotel - Great location - show map",
                                                    style: TextStyle(
                                                      fontSize: width*0.013,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: MediaQuery.of(context).size.width / 80),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    side: BorderSide(
                                                        color:
                                                            Color(0xFFdb9e1f))),
                                                elevation: 5.0,
                                                height: MediaQuery.of(context).size.height / 18,
                                                minWidth: MediaQuery.of(context).size.width / 30,
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              // TaskCardWidget(id: user.id, name: user.ingredients,)
                                                              AddHotelDetails(
                                                                  widget.uid)));
                                                },
                                                child: Text(
                                                  "Reserve",
                                                  style: TextStyle(
                                                    fontSize: width*0.013,
                                                    color: Color(0xFFdb9e1f),
                                                  ),
                                                ),
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child:
                                      Padding(
                                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 80),
                                        child: Column(
                                          children: newbuilder(),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),

                          ),

                        ],
                      ),
                    ),

                  ],
                ),
                Positioned(
                    left: 0.0,
                    top: 0.0,
                    right: 0.0,
                    child: Container(
                        child: VendomeHeader(
                      drawer: _scaffoldState,
                      cusname: "cusname",
                    ))),
              ],
            ),
    ));
  }
}
