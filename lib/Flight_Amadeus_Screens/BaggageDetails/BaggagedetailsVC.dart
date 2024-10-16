
import 'package:flutter/material.dart';
//import 'package:tourstravels/ApartVC/Add_Apartment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'dart:convert';
import 'package:tourstravels/ApartVC/Addaprtment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/UserDashboard_Screens/Apartbooking_Model.dart';
import 'package:tourstravels/UserDashboard_Screens/PivoteVC.dart';
import 'package:tourstravels/UserDashboard_Screens/newDashboard.dart';
import 'package:tourstravels/tabbar.dart';
import 'package:tourstravels/My_Apartments/My_AprtmetsVC.dart';
import 'package:tourstravels/My_Apartments/ViewApartmentVC.dart';

import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';


class BaggageDetailsVC extends StatefulWidget {
  const BaggageDetailsVC({super.key});

  @override
  State<BaggageDetailsVC> createState() => _userDashboardState();
}

class _userDashboardState extends State<BaggageDetailsVC> {
  final baseDioSingleton = BaseSingleton();
  bool isLoading = false;
  String flightTokenstr = '';
  List travelersArray = [];
  List Convert_segmentArray = [];
  List Convert_AirlineArray = [];
  var travelerPricingslistArray = [];
  var totalPricevaluesArray = [];
  var cabintrvalue_Array = [];
  List validatingAirlineCodestrArray = [];


  List convert_travelerPricingsArray = [];
  Map<String, dynamic> convert_Currency_PriceArray = {};
  Map<String, dynamic> fareRulesArray = {};

  late final RetrivedSegment_Array ;
  late final validatingAirlineCodestr ;


//Retrived values
  String flight_ID = '';
  String sourcestr = '';
  String lastTicketing_Datestr = '';
  String lastTicketingDate_Timestr = '';
  String numberOfBookableSeatsstr = '';
  String durationstr = '';
  String Careercodestr = '';
  String RetrivedOneway_Oneway_Destinationiatacodestr = '';
  String RetrivedOnew_Oneway_DestinationCitynamestr = '';
  String Retrived_Oneway_Citynamestr = '';
  String Retrived_Oneway_iatacodestr = '';
  String Depterminal = '';
  String Arrivalterminal = '';
  String totalpricevalues = '';
  String cabintrvalue = '';
  //Baggage
  int weight = 0;
  int quantity = 0;
  //Cabin Baggage
  int Cabin_weight = 0;
  int Cabin_quantity = 0;

  String Baggagestr = '';
  String Cabin_Baggagestr = '';




  var flight_offer_Array = [];
  var OnwardJourney_Segmentrray = [];
  var Currency_Price_Array = [];







  String depiataCode = '';
  String Datestr = '';
  String arrivalCode = '';
  String Deptimeconvert = '';
  String Arrivaltimeconvert = '';
  String trimedDuration = '';
  String CurrencyCodestr = '';
  String totalpriceSignvalues = '';
  String airlinestr = '';
  String logostr = '';



  var Departuretextstr = '';
  var flight_departurests = '';


  late final  segmentDataArray;

//@override
  initState() {
    // TODO: implement initState
    super.initState();

    // _retrieveValues();
    // _postData();

    Map<String, dynamic> _portaInfoMap = {
      "name": "Vitalflux.com",
      "domains": ["Data Science", "Mobile", "Web"],
      "noOfArticles": [
        {"type": "data science", "count": 50},
        {"type": "web", "count": 75}
      ]
    };

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.lightGreen,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Colors.white, Colors.green]),
                ),
              ),
              actions: <Widget>[
              ],
              centerTitle: true,
              iconTheme: IconThemeData(
                  color: Colors.white
              ),
              title: Text(
                  'Baggage Allowances & Policies', textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,
                      fontFamily: 'Baloo',
                      fontWeight: FontWeight.w900,
                      fontSize: 20)),
            ),
            body: Center(
              child: isLoading ?
              CircularProgressIndicator() :
              Column(
                children: <Widget>[
                  //Container(color: Colors.red, height: 50),
                  // new Padding(
                  //   padding: EdgeInsets.symmetric(
                  //       horizontal: 6.0, vertical: 6.0),
                  //   child: Container(
                  //       width: 320,
                  //       child: CircleAvatar(
                  //         backgroundColor: Colors.white,
                  //         radius: 50.0,
                  //         child: Image.asset(
                  //             "images/aeroplane_image.png",
                  //             height: 125.0,
                  //             width: 320.0,
                  //             fit: BoxFit.fill
                  //         ),
                  //       )
                  //   ),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Container(
                      // color: Colors.pinkAccent,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[Colors.white, Colors.white]),
                      ),

                      child: LayoutBuilder(
                        builder: (context, constraint) {

                          return SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(
                              children: <Widget>[
                                //Text('Your Apartments'),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  height: 900,
                                  width: 340,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 800,
                                        width: 340,
                                        color: Colors.white10,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 800,
                                              width: 340,
                                              color: Colors.black12,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 100,
                                                    width: 320,
                                                    //color: Colors.white,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: Colors.white,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                       // Text('Booking Information',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.black),)
                                                       SizedBox(
                                                         height: 8,
                                                       ),
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              "Ticket Issuing Time",
                                                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),
                                                              textAlign: TextAlign.center
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              "Once payment is confirmed,tickets will be issued within 45 minutes",
                                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black38),
                                                              textAlign: TextAlign.left
                                                          ),
                                                        )

                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                        "  Baggage Allowance",
                                                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),
                                                        textAlign: TextAlign.center
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    height: 440,
                                                    width: 320,
                                                    //color: Colors.white,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: Colors.white,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        // Text('Booking Information',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.black),)
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              "Personal Item",
                                                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),
                                                              textAlign: TextAlign.left
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              "1 piece per person.",
                                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black38),
                                                              textAlign: TextAlign.left
                                                          ),
                                                        ),

                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Align(
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                              "Total dimentions(length + width + height) of each piece cannot exceed 115 cm.Must be placed under the seat in front of you",
                                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black38),
                                                              textAlign: TextAlign.left
                                                          ),
                                                        ),

                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              "Cabin Baggage",
                                                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),
                                                              textAlign: TextAlign.left
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              "The total weight per person cannot exceed 8 kg",
                                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black38),
                                                              textAlign: TextAlign.left
                                                          ),
                                                        ),

                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              "Each piece cannot exceed 56*36*23 cm in size.",
                                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black38),
                                                              textAlign: TextAlign.left
                                                          ),
                                                        ),


                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              "Checked Baggage",
                                                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),
                                                              textAlign: TextAlign.left
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              " The total weight per person cannot exceed 40 kg",
                                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black38),
                                                              textAlign: TextAlign.left
                                                          ),
                                                        ),

                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              "Each piece cannot exceed 90*72*45 cm in size.",
                                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black38),
                                                              textAlign: TextAlign.left
                                                          ),
                                                        )


                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 140,
                                                    width: 320,
                                                    //color: Colors.white,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: Colors.white,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        // Text('Booking Information',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.black),)
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              "Regulations on Special Baggage Allowance",
                                                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),
                                                              textAlign: TextAlign.left
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              "Each airline has different regulations on special baggage (such as musical instruments,sports.)",
                                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black38),
                                                              textAlign: TextAlign.left
                                                          ),
                                                        )

                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        // child: Column(
                                        //   children: [
                                        //     Container(
                                        //       height: 65,
                                        //       width: 320,
                                        //       color: Colors.grey,
                                        //          ),
                                        //         ],
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 1,
                                        itemBuilder: (context, index) {
                                          return Text('', style: TextStyle(
                                              fontSize: 22),);
                                        }),

                                  ],
                                )
                              ],

                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}
