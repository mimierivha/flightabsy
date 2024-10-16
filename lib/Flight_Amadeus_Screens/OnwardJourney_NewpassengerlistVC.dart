
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
import 'OnwardJourney_PassengerlistVC.dart';
class OnwardJourney_NewPassengerListVC extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<OnwardJourney_NewPassengerListVC> {
  final baseDioSingleton = BaseSingleton();
  bool isLoading = false;
  String currency_code_dropdownvalue = 'Select Gender';
  String CurrencyCodestr = '';
  String totalpriceSignvalues = '';
  String totalpricevalues = '';
  String flightTokenstr = '';
  //bool isLoading = false;
  //String flightTokenstr = '';
  List travelersArray = [];
  List order_segArray = [];
  List convert_order_segArray = [];

  List Convert_AirlineArray = [];
  var travelerPricingslistArray = [];
  var totalPricevaluesArray = [];
  var cabintrvalue_Array = [];
  List<dynamic> travellers = [];

  Map<String, dynamic> offerlist = {};

  String jsonsDataString = ''; // toString of Response's body is assigned to jsonDataString


  List convert_travelerPricingsArray = [];
  // Map<String, dynamic> offerData = {};
  Map<String, dynamic> fareRulesArray = {};
  var offerData = '';

  var ab = [];

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
  // String totalpricevalues = '';
  String cabintrvalue = '';
  List Convert_offer_Array = [];
  // List Convert_AirlineArray = [];
  // var travelerPricingslistArray = [];
  // var totalPricevaluesArray = [];
  // var cabintrvalue_Array = [];
  //late final orderseg ;
  //orderseg? data;
  late String orderseg;








  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String tokenvalue = '';

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green),),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green),),
      onPressed:  () async{
        Navigator.of(context, rootNavigator: true).pop();
        await Navigator.of(context)
            .push(new MaterialPageRoute(builder: (context) => newuserDashboard()));
        setState((){
          //Navigator.pop(context);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Abisiniya",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 24,color: Colors.green),),
      content: Text("Do you want Login?",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.black54),),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final Retrivedsegment_Array;
    Retrivedsegment_Array = prefs.getString('segmentlistkey') ?? '';
    print('Retrivedsegment_Array...');
    print(Retrivedsegment_Array);


    //   final ordersegstr = prefs.getString('Segmentkey') ?? '';
    // print('order seg');
    // print(ordersegstr);
    convert_order_segArray = json.decode(Retrivedsegment_Array);
    print('conver order array...');
    print(convert_order_segArray);
  }

  @override
  void initState() {
    super.initState();
    for(int i = 1; i <= 1; i++){
      setState(() {
        _retrieveValues();
        //_postData();
      });

      if(CurrencyCodestr == "USD"){
        setState(() {
          _retrieveValues();
          totalpriceSignvalues = "\USD $totalpricevalues";

        });
        //totalpricevalues = totalPricevaluesArray[index].toString();
        //print("I have \$$dollars."); // I have $42.
        // totalpriceSignvalues = "\$$totalpricevalues";


      } else {
        setState(() {
          _retrieveValues();
          totalpriceSignvalues = "\ZAR $totalpricevalues";

        });
        // totalpricevalues = totalPricevaluesArray[index].toString();
        // print('totalpriceSignvalues..');
        // print(totalpriceSignvalues);
      }
    }
  }

  Future<void> _postData() async {
    setState(() {
      isLoading = true;
    });
    //tempList = List<String>();
    //List<String> tempList = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
    print(' Details Onward journey token1...');
    print(flightTokenstr);
    //{{API_URL}}/v1/shopping/flight-offers/pricing
    final response = await http.post(
      //v1/booking/flight-orders
      Uri.parse(
          'https://test.travel.api.amadeus.com/v1/booking/flight-orders'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Content-Type": "application/json",
        "Accept": "application/json",
        //"Authorization": "Bearer ${flightTokenstr}",
        "Authorization": "Bearer $flightTokenstr",

      },
      body: jsonEncode(<String, dynamic>
      {
        "data": {
      "type": "flight-order",
      "flightOffers": convert_order_segArray,
      // {
      //   "type": "flight-offer",
      //   "id": "1",
      //   "source": "GDS",
      //   "instantTicketingRequired": false,
      //   "nonHomogeneous": false,
      //   "paymentCardRequired": false,
      //   "lastTicketingDate": "2024-09-17",
      //   "itineraries": [
      //     {
      //        "segments": convert_order_segArray
      //
      //       // "segments": [
      //       //   {
      //       //     "departure": {
      //       //       "iataCode": "BLR",
      //       //       "terminal": "2",
      //       //       "at": "2024-09-17T11:30:00"
      //       //     },
      //       //     "arrival": {
      //       //       "iataCode": "DEL",
      //       //       "terminal": "3",
      //       //       "at": "2024-09-17T14:10:00"
      //       //     },
      //       //     "carrierCode": "AI",
      //       //     "number": "2816",
      //       //     "aircraft": {
      //       //       "code": "32N"
      //       //     },
      //       //     "operating": {
      //       //       "carrierCode": "AI"
      //       //     },
      //       //     "duration": "PT2H40M",
      //       //     "id": "1",
      //       //     "numberOfStops": 0,
      //       //     "co2Emissions": [
      //       //       {
      //       //         "weight": 120,
      //       //         "weightUnit": "KG",
      //       //         "cabin": "ECONOMY"
      //       //       }
      //       //     ]
      //       //   }
      //       // ]
      //     }
      //   ],
      //   "price": {
      //     "currency": "USD",
      //     "total": "96.60",
      //     "base": "80.00",
      //     "fees": [
      //       {
      //         "amount": "0.00",
      //         "type": "SUPPLIER"
      //       },
      //       {
      //         "amount": "0.00",
      //         "type": "TICKETING"
      //       },
      //       {
      //         "amount": "0.00",
      //         "type": "FORM_OF_PAYMENT"
      //       }
      //     ],
      //     "grandTotal": "96.60",
      //     "billingCurrency": "USD"
      //   },
      //   "pricingOptions": {
      //     "fareType": [
      //       "PUBLISHED"
      //     ],
      //     "includedCheckedBagsOnly": true
      //   },
      //   "validatingAirlineCodes": [
      //     "AI"
      //   ],
      //   "travelerPricings": [
      //     {
      //       "travelerId": "1",
      //       "fareOption": "STANDARD",
      //       "travelerType": "ADULT",
      //       "price": {
      //         "currency": "USD",
      //         "total": "96.60",
      //         "base": "80.00",
      //         "taxes": [
      //           {
      //             "amount": "2.80",
      //             "code": "P2"
      //           },
      //           {
      //             "amount": "7.70",
      //             "code": "IN"
      //           },
      //           {
      //             "amount": "4.10",
      //             "code": "K3"
      //           },
      //           {
      //             "amount": "2.00",
      //             "code": "YR"
      //           }
      //         ]
      //       },
      //       "fareDetailsBySegment": [
      //         {
      //           "segmentId": "1",
      //           "cabin": "ECONOMY",
      //           "fareBasis": "UIP",
      //           "brandedFare": "VECOCOMF",
      //           "class": "U",
      //           "includedCheckedBags": {
      //             "weight": 15,
      //             "weightUnit": "KG"
      //           }
      //         }
      //       ]
      //     }
      //   ]
      // }


          "travelers": [
            {
              "id": "1",
              "dateOfBirth": "1997-10-17",
              "name": {
                "firstName": "MEMBER",
                "lastName": "LOYTEST"
              },
              "gender": "MALE",
              "contact": {
                "emailAddress": "Member@Mustermann.com",
                "phones": [
                  {
                    "deviceType": "MOBILE",
                    "countryCallingCode": "33",
                    "number": "480080076"
                  }
                ]
              }
              // "loyaltyPrograms": [
              //     {
              //         "programOwner": "QF",
              //         "id": "1925825570"
              //     }
              // ]
            }
          ],
          "formOfPayments": [
            {
              "other": {
                "method": "CASH",
                "flightOfferIds": [
                  "1"
                ]
              }
            }
          ]
        }
      }
        // {
        //   "data": {
        //     "type": "flight-order",
        //     "flightOffers": [
        //       {
        //         "type": "flight-offer",
        //         "id": "1",
        //         "source": "GDS",
        //         "instantTicketingRequired": false,
        //         "nonHomogeneous": false,
        //         "oneWay": false,
        //         "isUpsellOffer": false,
        //         "lastTicketingDate": "2024-09-17",
        //         "lastTicketingDateTime": "2024-09-17",
        //         "numberOfBookableSeats": 9,
        //         "itineraries": [
        //           {
        //             "duration": "PT2H40M",
        //              //"segments": order_segArray.first
        //
        //             "segments": [
        //               {
        //                 "departure": {
        //                   "iataCode": "BLR",
        //                   "terminal": "2",
        //                   "at": "2024-09-17T11:30:00"
        //                 },
        //                 "arrival": {
        //                   "iataCode": "DEL",
        //                   "terminal": "3",
        //                   "at": "2024-09-17T14:10:00"
        //                 },
        //                 "carrierCode": "AI",
        //                 "number": "2816",
        //                 "aircraft": {
        //                   "code": "32N"
        //                 },
        //                 "operating": {
        //                   "carrierCode": "AI"
        //                 },
        //                 "duration": "PT2H40M",
        //                 "id": "1",
        //                 "numberOfStops": 0,
        //                 "blacklistedInEU": false
        //               }
        //             ]
        //           }
        //         ],
        //         "price": {
        //           "currency": "USD",
        //           "total": "95.70",
        //           "base": "79.00",
        //           "fees": [
        //             {
        //               "amount": "0.00",
        //               "type": "SUPPLIER"
        //             },
        //             {
        //               "amount": "0.00",
        //               "type": "TICKETING"
        //             }
        //           ],
        //           "grandTotal": "95.70"
        //         },
        //         "pricingOptions": {
        //           "fareType": [
        //             "PUBLISHED"
        //           ],
        //           "includedCheckedBagsOnly": true
        //         },
        //         "validatingAirlineCodes": [
        //           "AI"
        //         ],
        //         "travelerPricings": [
        //           {
        //             "travelerId": "1",
        //             "fareOption": "STANDARD",
        //             "travelerType": "ADULT",
        //             "price": {
        //               "currency": "USD",
        //               "total": "95.70",
        //               "base": "79.00"
        //             },
        //             "fareDetailsBySegment": [
        //               {
        //                 "segmentId": "1",
        //                 "cabin": "ECONOMY",
        //                 "fareBasis": "UIP",
        //                 "class": "U",
        //                 "includedCheckedBags": {
        //                   "weight": 15,
        //                   "weightUnit": "KG"
        //                 },
        //                 "includedCabinBags": {
        //                   "weight": 7,
        //                   "weightUnit": "KG"
        //                 }
        //               }
        //             ]
        //           }
        //         ],
        //         "fareRules": {
        //           "rules": [
        //             {
        //               "category": "EXCHANGE",
        //               "maxPenaltyAmount": "36.00"
        //             },
        //             {
        //               "category": "REFUND",
        //               "maxPenaltyAmount": "48.00"
        //             },
        //             {
        //               "category": "REVALIDATION",
        //               "notApplicable": true
        //             }
        //           ]
        //         }
        //       }
        //       ],
        //
        //     "travelers": [
        //       {
        //         "id": "1",
        //         "dateOfBirth": "1997-10-17",
        //         "name": {
        //           "firstName": "MEMBER",
        //           "lastName": "LOYTEST"
        //         },
        //         "gender": "MALE",
        //         "contact": {
        //           "emailAddress": "Member@Mustermann.com",
        //           "phones": [
        //             {
        //               "deviceType": "MOBILE",
        //               "countryCallingCode": "33",
        //               "number": "480080076"
        //             }
        //           ]
        //         }
        //         // "loyaltyPrograms": [
        //         //     {
        //         //         "programOwner": "QF",
        //         //         "id": "1925825570"
        //         //     }
        //         // ]
        //       }
        //     ],
        //     "formOfPayments": [
        //       {
        //         "other": {
        //           "method": "CASH",
        //           "flightOfferIds": [
        //             "1"
        //           ]
        //         }
        //       }
        //     ]
        //   }
        // },
      ),
    );

    print('list array....');

    print(response.statusCode);
    if (response.statusCode == 201) {
      // Successful POST request, handle the response here
      final responseData = jsonDecode(response.body);
      print('pass lis detailes data...');
      print(responseData);
      var flightData = responseData['data'];
      print('passenger list Response data...');
      print(flightData);

      var flightOffers = flightData['flightOffers'];
      print('flightOffers...');
      print(flightOffers);
      var travelers = flightData['travelers'];
      print('travelers...');
      print(travelers);
      // for (var travelerstr in flightData) {
      //   var travelerstr_Array = travelerstr['travelers'];
      //   print('travelers...');
      //   print(travelerstr_Array);
      // }
    }
    else {
      // throw Exception("Failed to load Dogs Breeds.");
      // final snackBar = SnackBar(
      //   content: Text('failed!,please try again'),
      // );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {
      isLoading = false;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Text('ABISINIYA',textAlign: TextAlign.center,
              style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
        ),
        body: Column(
          children: <Widget>[
            Container(color: Colors.white, height: 50),
            Expanded(
              child: Container(
                color: Colors.white,
                child: LayoutBuilder(
                  builder: (context, constraint) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              Container(
                                  height: 450.0,
                                  width: 325.0,
                                  decoration: const BoxDecoration(
                                    //color: Color(0xFFffffff),
                                    color: Colors.white70,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 15.0, // soften the shadow
                                        spreadRadius: 5.0, //extend the shadow
                                        offset: Offset(
                                          5.0, // Move to right 5  horizontally
                                          5.0, // Move to bottom 5 Vertically
                                        ),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                          width: 125,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 60.0,
                                            child: Image.asset(
                                                "images/logo2.png",
                                                height: 100.0,
                                                width: 125.0,
                                                fit: BoxFit.fill
                                            ),
                                          )
                                      ),
                                      Text(
                                        "Welcome Back",
                                        textAlign: TextAlign.center ,
                                        style: TextStyle(
                                            color: Colors.black,fontWeight: FontWeight.bold,fontSize: 26),),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(00.0),
                                        padding: EdgeInsets.only(top: 05.0,
                                            left: 15.0,
                                            right: 05.0),
                                        //color: Colors.white30,
                                        color: Colors.white,
                                        width: 300.0,
                                        height: 40.0,
                                        child: TextField(
                                            controller: emailController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field

                                            new InputDecoration.collapsed(
                                                hintText: 'Email/Phone number')),
                                      ),

                                      SizedBox(height: 10,),
                                      Container(
                                        margin: const EdgeInsets.all(00.0),
                                        padding: EdgeInsets.only(top: 05.0,
                                            left: 15.0,
                                            right: 05.0),
                                        //color: Colors.white30,
                                        color: Colors.white,
                                        width: 300.0,
                                        height: 40.0,
                                        child: TextField(
                                            obscureText: true,
                                            controller: passwordController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Password')),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        child:isLoading
                                            ? Center(child: CircularProgressIndicator())
                                            : TextButton(
                                          style: TextButton.styleFrom(
                                              fixedSize: const Size(300, 45),
                                              foregroundColor: Colors.white,
                                              backgroundColor: Colors.green,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(00),
                                              ),
                                              textStyle: const TextStyle(fontSize: 20)),
                                          // child: Text('Book Now'),

                                          child: const Text('Continue',style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
                                          onPressed: () async {
                                            setState(() => isLoading = true);
                                             _postData();
                                            //login(emailController.text.toString(), passwordController.text.toString());
                                            await Future.delayed(Duration(seconds: 2), () => () {});
                                            setState(() => isLoading = false);
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            Text("New to this site?",
                                              style: TextStyle(color: Colors.black87,fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                  fixedSize: const Size(180, 40),
                                                  foregroundColor: Colors.green,
                                                  backgroundColor: Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(00),
                                                  ),
                                                  textStyle: const TextStyle(fontSize: 16)),
                                              onPressed: () {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //       builder: (context) => Register()
                                                //   ),
                                                // );
                                              },
                                              child: const Text('Create New Account'),

                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                fixedSize: const Size(180, 40),
                                                foregroundColor: Colors.redAccent,
                                                backgroundColor: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(00),
                                                ),
                                                textStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                                            onPressed: () {
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) => ForgotpwdOTPVerified()
                                              //   ),
                                              // );
                                            },
                                            child: const Text('Forgot password'),

                                          )
                                      ),
                                    ],
                                  )
                              ),
                              // middle widget goes here
                              Expanded(
                                child: Container(),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // Icon(Icons.star),
                                    // Text("Bottom Text")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        )
    );
  }
}