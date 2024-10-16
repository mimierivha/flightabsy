import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import '../Auth/Register.dart';
import '../Singleton/SingletonAbisiniya.dart';
import 'OnwardJourney_PassengetViewdetailsVC.dart';



void main() {
  runApp(Passengerlist());
}

class Passengerlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SOF(),
    );
  }
}
class Home extends StatelessWidget {
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
            color: Colors.green
        ),
        title: Text('One way Flight Search', textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red,
                fontFamily: 'Baloo',
                fontWeight: FontWeight.w900,
                fontSize: 20)),
      ),
      body: Center(
        child: TextButton(
          child: Text('Add entries'),
          onPressed: () async {
            List<PersonEntry> persons = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SOF(),
              ),
            );
            if (persons != null) persons.forEach(print);
          },
        ),
      ),
    );
  }
}

class

SOF extends StatefulWidget {
  @override
  _SOFState createState() => _SOFState();
}

class _SOFState extends State<SOF> {
  var nameTECs = <TextEditingController>[];
  var ageTECs = <TextEditingController>[];
  var jobTECs = <TextEditingController>[];
  var cards = <Card>[];
  //String genderDropdown = 'Select Gender';
  String dropdownvalue = 'Select Gender';


  var items = [
    'Select Gender',
    'MALE',
    'FEMALE'
  ];
  //String currency_code_dropdownvalue = 'Select Gender';
  String CurrencyCodestr = '';
  String totalpriceSignvalues = '';
  String totalpricevalues = '';
  //withour usd/zar
  String totalprice = '';
  bool isLoading = false;
  String flightTokenstr = '';
  String OrderID = '';
  String referencestr = '';
  String travellerId = '';
  //bool isLoading = false;
  //String flightTokenstr = '';
  List travelersArray = [];
  List Convert_segmentArray = [];
  List Convert_AirlineArray = [];
  var travelerPricingslistArray = [];
  var totalPricevaluesArray = [];
  var cabintrvalue_Array = [];
  List convert_order_segArray = [];
  List Convert_offer_data = [];

  late final validatingAirlineCodestrvalue ;
  List validatingAirlineCodestrArray = [];
  final baseDioSingleton = BaseSingleton();




  List convert_travelerPricingsArray = [];
  Map<String, dynamic> convert_Currency_PriceArray = {};
  Map<String, dynamic> fareRulesArray = {};

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
  String fromDate = '';
  String Abiniyatokenvalue = '';
  int login_user_ID= 0;
  var offer_array_Data = '';

  // String totalpricevalues = '';
  String cabintrvalue = '';
  var flight_offer_Array = [];
  List Conver_travelersArray = [];


  TextEditingController Passengerlist_EmailTxt = TextEditingController();
  TextEditingController Passengerlist_phone_numtxt = TextEditingController();
  TextEditingController Passengerlist_firstnametxt = TextEditingController();
  TextEditingController Passengerlist_lastnametxt = TextEditingController();
  TextEditingController Passengerlist_DOBtxt = TextEditingController();
  TextEditingController Passengerlist_gendertxt = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();








  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CurrencyCodestr = prefs.getString('currency_code_dropdownvaluekey') ?? '';
    totalpricevalues = prefs.getString('totalpriceSignvalueskey') ?? '';
    totalprice = prefs.getString('pricekey') ?? '';
    // print('totalprice...');
    // print(totalprice);

    offer_array_Data = prefs.getString('flight_offer_Array_key') ?? '';
    print('offer data...');
    print(offer_array_Data.toString());

    //var data = <Map<String, dynamic>>;








    flight_ID = prefs.getString('flightid_key') ?? '';
    print('flight_ID...');
    print(flight_ID);
    sourcestr = prefs.getString('source_key') ?? '';
    print('sourcestr...');
    print(sourcestr);
    lastTicketing_Datestr = prefs.getString('lastTicketing_Datekey') ?? '';
    print('lastTicketing_Datestr...');
    print(lastTicketing_Datestr);
    lastTicketingDate_Timestr = prefs.getString('lastTicketingDate_Timekey') ?? '';
    print('lastTicketingDate_Timestr...');
    print(lastTicketingDate_Timestr);
    numberOfBookableSeatsstr = prefs.getString('numberOfBookableSeatskey') ?? '';
    print('numberOfBookableSeatsstr...');
    print(numberOfBookableSeatsstr);
    Careercodestr = prefs.getString('carrierCodekey') ?? '';
    print('Careercodestr...');
    print(Careercodestr);
    //airlinestr = prefs.getString('airlinekey') ?? '';
    //logostr = prefs.getString('logokey') ?? '';
    // print('Careercodestr.....');
    // print(Careercodestr);
    validatingAirlineCodestrvalue = prefs.getString('validatingAirlineCodeskey') ?? '';
    print('validatingAirlineCodestr...');
    print(validatingAirlineCodestrvalue);
    validatingAirlineCodestrArray = json.decode(validatingAirlineCodestrvalue);
    print('validatingAirlineCodestrArray...');
    print(validatingAirlineCodestrArray.first);



    RetrivedOneway_Oneway_Destinationiatacodestr = prefs.getString('Oneway_Destinationiatacodekey') ?? '';
    RetrivedOnew_Oneway_DestinationCitynamestr = prefs.getString('Oneway_DestinationCitynamekey') ?? '';
    Retrived_Oneway_iatacodestr = prefs.getString('Oneway_iatacodekey') ?? '';
    Retrived_Oneway_Citynamestr = prefs.getString('Oneway_Citynamekey') ?? '';

    durationstr = prefs.getString('durationkey') ?? '';
    // print('duration...');
    // print(durationstr);
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
    final travelerPricings ;
    travelerPricings = prefs.getString('order_travelerPricingkey') ?? '';
    print('order_travelerPricingkey...');
    print(travelerPricings);
    convert_travelerPricingsArray = json.decode(travelerPricings);
    print('convert_travelerPricingsArray........');
    print(convert_travelerPricingsArray);
    final Retrived_Currency_PriceArray ;
    Retrived_Currency_PriceArray = prefs.getString('convert_Currency_PriceArraykey') ?? '';
    print('Retrived_Currency_PriceArray...');
    print(Retrived_Currency_PriceArray);

    convert_Currency_PriceArray = jsonDecode(Retrived_Currency_PriceArray);
    print('convert_Currency_PriceArray....');
    print(convert_Currency_PriceArray);

    //FareRules
    //FareRules
    final Retrive_fareRules ;
    Retrive_fareRules = prefs.getString('fareRuleskey') ?? '';
    print('fareRuleskey...');
    print(Retrive_fareRules);
    fareRulesArray = jsonDecode(Retrive_fareRules);
    print('Retrive_fareRules....');
    print(fareRulesArray);
    // final Retrive_fareRules ;
    // Retrive_fareRules = prefs.getString('fareRuleskey') ?? '';
    // print('passenger fareRuleskey...');
    // print(Retrive_fareRules);
    //
    // if(Retrive_fareRules != ""){
    //   print('farerules empty..');
    //
    // }else {
    //   print('farerules not empty..');
    //
    //   fareRulesArray = jsonDecode(Retrive_fareRules);
    //   print('Retrive_fareRules....');
    //   print(fareRulesArray);
    //
    // }
    //fareRulesArray = jsonDecode(Retrive_fareRules);


    //
    // for (var i=1; i<=2; i++) {
    //
    //         // travelersArray = <Map<String, dynamic>>[
    //         //   {
    //         //     "id": i,
    //         //     "travelerType": array.toString(),
    //         //     "fareOptions": [
    //         //       "STANDARD"
    //         //     ],
    //         //   },
    //         // ];
    //       }



    print('textfield values...');

    setState(() {
      for (var i=1; i<=2; i++) {

        Conver_travelersArray = <Map<String, dynamic>>[
          {
            "id": "1",
            "dateOfBirth": Passengerlist_DOBtxt.text,
            "name": {
              "firstName": Passengerlist_firstnametxt.text,
              "lastName": Passengerlist_lastnametxt.text
            },
            "gender": Passengerlist_gendertxt.text,
            "contact": {
              "emailAddress": Passengerlist_EmailTxt.text,
              "phones": [
                {
                  "deviceType": "MOBILE",
                  "countryCallingCode": "34",
                  "number": Passengerlist_phone_numtxt.text
                }
              ]
            },
          }
        ];
        print('Conver_travelersArray....');
        print(Conver_travelersArray);
      }
    }
    );

  //
  //   for (var i=1; i<=2; i++) {
  //
  //     Conver_travelersArray = <Map<String, dynamic>>[
  //   {
  //   "id": "1",
  //   "dateOfBirth": Passengerlist_DOBtxt.text,
  //   "name": {
  //   "firstName": Passengerlist_firstnametxt.text,
  //   "lastName": Passengerlist_lastnametxt.text
  //   },
  //   "gender": Passengerlist_gendertxt.text,
  //   "contact": {
  //   "emailAddress": Passengerlist_EmailTxt.text,
  //   "phones": [
  //   {
  //   "deviceType": "MOBILE",
  //   "countryCallingCode": "34",
  //   "number": Passengerlist_phone_numtxt.text
  //   }
  //   ]
  //   },
  //     }
  // ];
  //     print('Conver_travelersArray....');
  //     print(Conver_travelersArray);
  //   }
  }




  LoginshowAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Register",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green),),

      onPressed:  () async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('FlightRegistraionkey',"Flight Register" );
        Navigator.of(context, rootNavigator: true).pop();
        await Navigator.of(context)
            .push(new MaterialPageRoute(builder: (context) => Register()));
        setState((){
          //Navigator.pop(context);
        });
      },
      // onPressed:  () {
      //   Navigator.of(context, rootNavigator: true).pop();
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Register()
      //     ),
      //   );
      // },
    );
    Widget continueButton = TextButton(
      child: Text("Continue",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green),),

      onPressed: () async {
        setState(() => isLoading = true);
        // _postData();
        login(emailController.text.toString(), passwordController.text.toString());

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('emailkey', emailController.text);
        prefs.setString('passwordkey', passwordController.text);



        print('token value....');
       // print(tokenvalue);
        //prefs.setString('tokenkey', tokenvalue);
        await Future.delayed(Duration(seconds: 2), () => () {});
        setState(() => isLoading = false);
      },

      // onPressed:  () async{
      //   Navigator.of(context, rootNavigator: true).pop();
      //   await Navigator.of(context)
      //       .push(new MaterialPageRoute(builder: (context) => OnwardJourneyPassengerListViewDetails()));
      //   setState((){
      //     //Navigator.pop(context);
      //   });
      // },

    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Abisiniya",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 24,color: Colors.green),),
      // Text("Do you want Login?",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.black54),),
      content: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(hintText: 'Password'),
          ),
        ],
      ),
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

  //void showDialogWithFields() {
     showAlertDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (_) {
        // var emailController = TextEditingController();
        // var passwordController = TextEditingController();
        return AlertDialog(
          title: Text('Login'),
          content: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(hintText: 'Password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              //onPressed: () => Navigator.pop(context),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Register()
                  ),
                );
              },

              child: Text('Create'),
            ),
            TextButton(
              onPressed: () async {
                setState(() => isLoading = true);
                // _postData();
                login(emailController.text.toString(), passwordController.text.toString());

                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('emailkey', emailController.text);
                prefs.setString('passwordkey', passwordController.text);
                // print('token value....');
                // print(Abiniyatokenvalue);
                prefs.setString('tokenkey', Abiniyatokenvalue);
                await Future.delayed(Duration(seconds: 2), () => () {});
                  // Navigator.pop(context);
                // Future.delayed(Duration.zero, () {
                //   showAlertdialog(context);
                // });

                setState(() => isLoading = false);
              },
              child: Text('Continue'),
            ),
          ],
        );
      },
    );
  }

  //Post API calling...
  Future<void> _postData() async {
    setState(() {
      isLoading = true;
    });
    //tempList = List<String>();
    //List<String> tempList = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
    // print(' Details Onward journey token1...');
    // print(flightTokenstr);
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

           //"flightOffers": Convert_offer_data,

          "flightOffers": [
            {
              "type": "flight-offer",
              "id": flight_ID,
              "source": sourcestr,
              "instantTicketingRequired": false,
              "nonHomogeneous": false,
              "paymentCardRequired": false,
              "lastTicketingDate": lastTicketing_Datestr,
              "itineraries": [
                {
                   "segments": convert_order_segArray,

                  // "segments": [
                  //   {
                  //     "departure": {
                  //       "iataCode": "BLR",
                  //       "terminal": "2",
                  //       "at": "2024-08-07T11:30:00"
                  //     },
                  //     "arrival": {
                  //       "iataCode": "DEL",
                  //       "terminal": "3",
                  //       "at": "2024-08-07T14:10:00"
                  //     },
                  //     "carrierCode": "AI",
                  //     "number": "2816",
                  //     "aircraft": {
                  //       "code": "32N"
                  //     },
                  //     "operating": {
                  //       "carrierCode": "AI"
                  //     },
                  //     "duration": "PT2H40M",
                  //     "id": "1",
                  //     "numberOfStops": 0,
                  //     "co2Emissions": [
                  //       {
                  //         "weight": 120,
                  //         "weightUnit": "KG",
                  //         "cabin": "ECONOMY"
                  //       }
                  //     ]
                  //   }
                  // ]
                }
              ],

               "price": convert_Currency_PriceArray,

              // "price": {
              //   "currency": "USD",
              //   "total": "101.90",
              //   "base": "85.00",
              //   "fees": [
              //     {
              //       "amount": "0.00",
              //       "type": "SUPPLIER"
              //     },
              //     {
              //       "amount": "0.00",
              //       "type": "TICKETING"
              //     },
              //     {
              //       "amount": "0.00",
              //       "type": "FORM_OF_PAYMENT"
              //     }
              //   ],
              //   "grandTotal": "101.90",
              //   "billingCurrency": "USD"
              // },
              "pricingOptions": {
                "fareType": [
                  "PUBLISHED"
                ],
                "includedCheckedBagsOnly": true
              },
              "validatingAirlineCodes": [
                validatingAirlineCodestrArray.first
              ],
               "travelerPricings": convert_travelerPricingsArray,

              // "travelerPricings": [
              //   {
              //     "travelerId": "1",
              //     "fareOption": "STANDARD",
              //     "travelerType": "ADULT",
              //     "price": {
              //       "currency": "USD",
              //       "total": "101.90",
              //       "base": "85.00",
              //       "taxes": [
              //         {
              //           "amount": "2.80",
              //           "code": "P2"
              //         },
              //         {
              //           "amount": "7.70",
              //           "code": "IN"
              //         },
              //         {
              //           "amount": "4.40",
              //           "code": "K3"
              //         },
              //         {
              //           "amount": "2.00",
              //           "code": "YR"
              //         }
              //       ]
              //     },
              //     "fareDetailsBySegment": [
              //       {
              //         "segmentId": "1",
              //         "cabin": "ECONOMY",
              //         "fareBasis": "LIP",
              //         "brandedFare": "VECOCOMF",
              //         "class": "L",
              //         "includedCheckedBags": {
              //           "weight": 15,
              //           "weightUnit": "KG"
              //         }
              //       }
              //     ]
              //   }
              // ]
            }
          ],

           "travelers": Conver_travelersArray,

          // "travelers": [
          //   {
          //     "id": "1",
          //     "dateOfBirth": Passengerlist_DOBtxt.text,
          //     "name": {
          //       "firstName": Passengerlist_firstnametxt.text,
          //       "lastName": Passengerlist_lastnametxt.text
          //     },
          //     "gender": Passengerlist_gendertxt.text,
          //     "contact": {
          //       "emailAddress": Passengerlist_EmailTxt.text,
          //       "phones": [
          //         {
          //           "deviceType": "MOBILE",
          //           "countryCallingCode": "34",
          //           "number": Passengerlist_phone_numtxt.text
          //         }
          //       ]
          //     },
          //     // "documents": [
          //     //   {
          //     //     "documentType": "PASSPORT",
          //     //     "birthPlace": "Madrid",
          //     //     "issuanceLocation": "Madrid",
          //     //     "issuanceDate": "2015-04-14",
          //     //     "number": "00000000",
          //     //     "expiryDate": "2025-04-14",
          //     //     "issuanceCountry": "ES",
          //     //     "validityCountry": "ES",
          //     //     "nationality": "ES",
          //     //     "holder": true
          //     //   }
          //     // ]
          //   },
          //   {
          //     "id": "2",
          //     "dateOfBirth": "2012-10-11",
          //     "gender": "FEMALE",
          //     "contact": {
          //       "emailAddress": "jorge.gonzales833@telefonica.es",
          //       "phones": [
          //         {
          //           "deviceType": "MOBILE",
          //           "countryCallingCode": "34",
          //           "number": "480080076"
          //         }
          //       ]
          //     },
          //     "name": {
          //       "firstName": "ADRIANA",
          //       "lastName": "GONZALES"
          //     }
          //   }
          // ],
          // "travelers": [
          //   {
          //     "id": "1",
          //     "dateOfBirth": Passengerlist_DOBtxt.text,
          //     "name": {
          //       "firstName": Passengerlist_firstnametxt.text,
          //       "lastName": Passengerlist_lastnametxt.text
          //     },
          //     "gender": Passengerlist_gendertxt.text,
          //     "contact": {
          //       "emailAddress": Passengerlist_EmailTxt.text,
          //       "phones": [
          //         {
          //           "deviceType": "MOBILE",
          //           "countryCallingCode": "33",
          //           "number": Passengerlist_phone_numtxt.text
          //         }
          //       ]
          //     },
          //     "loyaltyPrograms": [
          //       {
          //         "programOwner": "QF",
          //         "id": "1925825570"
          //       }
          //     ]
          //   }
          // ],
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

      ),
    );

    print('list array....');

    print(response.statusCode);
    if (response.statusCode == 201) {
      // print('retrived abisiniya token value....');
      // print(Abiniyatokenvalue);
      // Successful POST request, handle the response here
      final responseData = jsonDecode(response.body);
      // print('pass lis detailes data...');
      // print(responseData);
      var flightData = responseData['data'];
      // print('passenger list Response data...');
      // print(flightData);
      // for (var flightdataArray in flightData) {
      //   OrderID = flightdataArray['id'];
      //   print('Order Id..');
      //   print(OrderID);
      // }
      var flightOffers = flightData['flightOffers'];
      // print('flightOffers...');
      // print(flightOffers);
      OrderID = flightData['id'];
      // print('Order Id..');
      // print(OrderID);
      var associatedRecordsData = flightData['associatedRecords'];
        print('associatedRecords...');
        print(associatedRecordsData);
        for(var associatedRecordsArray in associatedRecordsData){
          referencestr = associatedRecordsArray['reference'];
          // print('referencestr...');
          // print(referencestr);
        }
      var travelers = flightData['travelers'];
      // print('travelers...');
      // print(travelers);
      for(var travelersArray in travelers){
        travellerId = travelersArray['id'];
        print('travellerId...');
        print(travellerId);
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('OrderIDkey', OrderID);
      prefs.setString('travellerIdkey', travellerId);

      // print('order id receive');
      // print(OrderID);

      prefs.setString('pricekey', totalprice);
      prefs.setString('reference_key', referencestr);
      prefs.setString('passenger_firstname_key', Passengerlist_firstnametxt.text);
      prefs.setString('passenger_lastname_key', Passengerlist_lastnametxt.text);
      prefs.setString('passenger_phone_key', Passengerlist_phone_numtxt.text);
      prefs.setString('passenger_email_key', Passengerlist_EmailTxt.text);
      prefs.setString('passenger_gender_key', Passengerlist_gendertxt.text);
      prefs.setString('passenger_dob_key', Passengerlist_DOBtxt.text);
      prefs.setString('local_Flight_tokenkey', Abiniyatokenvalue);
      setState(() async{

        Navigator.of(context, rootNavigator: true).pop();
        await Navigator.of(context)
            .push(new MaterialPageRoute(builder: (context) => OnwardJourneyPassengerListViewDetails()));
        setState((){
          Navigator.pop(context);
        });
      });



      // for (var travelerstr in flightData) {
      //   var travelerstr_Array = travelerstr['travelers'];
      //   print('travelers...');
      //   print(travelerstr_Array);
      // }
    } else if(response.statusCode == 400){
      final responseData = jsonDecode(response.body);
      var flighterror_Data = responseData['errors'];
      // print('flighterror_Data...');
      // print(flighterror_Data);
      for(var titledata in flighterror_Data){
        var titlestr = titledata['title'];
        // print('titlestr...');
        // print(titlestr);
        var detail = titledata['detail'];
        if(titlestr == 'SEGMENT SELL FAILURE'){
          final snackBar = SnackBar(
            content: Text(titlestr + ' , ' + 'Please check flight details and try again'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final snackBar = SnackBar(
            content: Text(detail + ' , ' +'Please try again..'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
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

  // Future<void> _postData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   //tempList = List<String>();
  //   //List<String> tempList = [];
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
  //   print(' Details Onward journey token1...');
  //   print(flightTokenstr);
  //   //{{API_URL}}/v1/shopping/flight-offers/pricing
  //   final response = await http.post(
  //     //v1/booking/flight-orders
  //     Uri.parse(
  //         'https://test.travel.api.amadeus.com/v1/booking/flight-orders'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       "Content-Type": "application/json",
  //       "Accept": "application/json",
  //       //"Authorization": "Bearer ${flightTokenstr}",
  //       "Authorization": "Bearer $flightTokenstr",
  //
  //     },
  //     body: jsonEncode(<String, dynamic>
  //     {
  //       "data": {
  //         "type": "flight-order",
  //         "flightOffers": [
  //           {
  //             "type": "flight-offer",
  //             "id": flight_ID,
  //             "source": sourcestr,
  //             "instantTicketingRequired": false,
  //             "nonHomogeneous": false,
  //             "oneWay": false,
  //             "isUpsellOffer": false,
  //             "lastTicketingDate": lastTicketing_Datestr,
  //             "lastTicketingDateTime": lastTicketingDate_Timestr,
  //             "numberOfBookableSeats": numberOfBookableSeatsstr,
  //             "itineraries": [
  //               {
  //                 "duration": durationstr,
  //                 "segments": Convert_segmentArray
  //
  //
  //                 // "segments": [
  //                 //   {
  //                 //     "departure": {
  //                 //       "iataCode": "BLR",
  //                 //       "terminal": "2",
  //                 //       "at": "2024-07-23T11:30:00"
  //                 //     },
  //                 //     "arrival": {
  //                 //       "iataCode": "DEL",
  //                 //       "terminal": "3",
  //                 //       "at": "2024-07-23T14:10:00"
  //                 //     },
  //                 //     "carrierCode": "AI",
  //                 //     "number": "2816",
  //                 //     "aircraft": {
  //                 //       "code": "32N"
  //                 //     },
  //                 //     "operating": {
  //                 //       "carrierCode": "AI"
  //                 //     },
  //                 //     "duration": "PT2H40M",
  //                 //     "id": "1",
  //                 //     "numberOfStops": 0,
  //                 //     "blacklistedInEU": false
  //                 //   }
  //                 // ]
  //               }
  //             ],
  //
  //             "price": convert_Currency_PriceArray,
  //
  //             // "price": {
  //             //   "currency": "USD",
  //             //   "total": "205.00",
  //             //   "base": "169.00",
  //             //   "fees": [
  //             //     {
  //             //       "amount": "0.00",
  //             //       "type": "SUPPLIER"
  //             //     },
  //             //     {
  //             //       "amount": "0.00",
  //             //       "type": "TICKETING"
  //             //     }
  //             //   ],
  //             //   "grandTotal": "205.00"
  //             // },
  //             "pricingOptions": {
  //               "fareType": [
  //                 "PUBLISHED"
  //               ],
  //               "includedCheckedBagsOnly": false
  //             },
  //             "validatingAirlineCodes": [
  //               //"AI"
  //               Careercodestr,
  //             ],
  //             "travelerPricings": convert_travelerPricingsArray,
  //
  //
  //             // "travelerPricings": [
  //             //   {
  //             //     "travelerId": "1",
  //             //     "fareOption": "STANDARD",
  //             //     "travelerType": "ADULT",
  //             //     "price": {
  //             //       "currency": "USD",
  //             //       "total": "95.70",
  //             //       "base": "79.00"
  //             //     },
  //             //     "fareDetailsBySegment": [
  //             //       {
  //             //         "segmentId": "1",
  //             //         "cabin": "ECONOMY",
  //             //         "fareBasis": "UIP",
  //             //         "class": "U",
  //             //         "includedCheckedBags": {
  //             //           "weight": 15,
  //             //           "weightUnit": "KG"
  //             //         },
  //             //         "includedCabinBags": {
  //             //           "quantity": 0
  //             //         }
  //             //       }
  //             //     ]
  //             //   },
  //             //   {
  //             //     "travelerId": "2",
  //             //     "fareOption": "STANDARD",
  //             //     "travelerType": "CHILD",
  //             //     "price": {
  //             //       "currency": "USD",
  //             //       "total": "88.30",
  //             //       "base": "72.00"
  //             //     },
  //             //     "fareDetailsBySegment": [
  //             //       {
  //             //         "segmentId": "1",
  //             //         "cabin": "ECONOMY",
  //             //         "fareBasis": "UIPCH",
  //             //         "class": "U"
  //             //       }
  //             //     ]
  //             //   },
  //             //   {
  //             //     "travelerId": "3",
  //             //     "fareOption": "STANDARD",
  //             //     "travelerType": "HELD_INFANT",
  //             //     "associatedAdultId": "1",
  //             //     "price": {
  //             //       "currency": "USD",
  //             //       "total": "21.00",
  //             //       "base": "18.00"
  //             //     },
  //             //     "fareDetailsBySegment": [
  //             //       {
  //             //         "segmentId": "1",
  //             //         "cabin": "ECONOMY",
  //             //         "fareBasis": "UIPIN",
  //             //         "class": "U"
  //             //       }
  //             //     ]
  //             //   }
  //             // ],
  //             "fareRules": fareRulesArray
  //
  //
  //             // "fareRules": {
  //             //   "rules": [
  //             //     {
  //             //       "category": "EXCHANGE",
  //             //       "maxPenaltyAmount": "36.00"
  //             //     },
  //             //     {
  //             //       "category": "REFUND",
  //             //       "maxPenaltyAmount": "48.00"
  //             //     },
  //             //     {
  //             //       "category": "REVALIDATION",
  //             //       "notApplicable": true
  //             //     }
  //             //   ]
  //             // }
  //           }
  //         ],
  //         // "flightOffers": [
  //         //   {
  //         //     "type": "flight-offer",
  //         //     "id": "1",
  //         //     "source": "GDS",
  //         //     "instantTicketingRequired": false,
  //         //     "nonHomogeneous": false,
  //         //     "paymentCardRequired": false,
  //         //     "lastTicketingDate": "2024-09-17",
  //         //     "itineraries": [
  //         //       {
  //         //         "segments": [
  //         //           {
  //         //             "departure": {
  //         //               "iataCode": "BLR",
  //         //               "terminal": "2",
  //         //               "at": "2024-09-17T11:30:00"
  //         //             },
  //         //             "arrival": {
  //         //               "iataCode": "DEL",
  //         //               "terminal": "3",
  //         //               "at": "2024-09-17T14:10:00"
  //         //             },
  //         //             "carrierCode": "AI",
  //         //             "number": "2816",
  //         //             "aircraft": {
  //         //               "code": "32N"
  //         //             },
  //         //             "operating": {
  //         //               "carrierCode": "AI"
  //         //             },
  //         //             "duration": "PT2H40M",
  //         //             "id": "1",
  //         //             "numberOfStops": 0,
  //         //             "co2Emissions": [
  //         //               {
  //         //                 "weight": 120,
  //         //                 "weightUnit": "KG",
  //         //                 "cabin": "ECONOMY"
  //         //               }
  //         //             ]
  //         //           }
  //         //         ]
  //         //       }
  //         //     ],
  //         //     "price": {
  //         //       "currency": "USD",
  //         //       "total": "95.70",
  //         //       "base": "79.00",
  //         //       "fees": [
  //         //         {
  //         //           "amount": "0.00",
  //         //           "type": "SUPPLIER"
  //         //         },
  //         //         {
  //         //           "amount": "0.00",
  //         //           "type": "TICKETING"
  //         //         },
  //         //         {
  //         //           "amount": "0.00",
  //         //           "type": "FORM_OF_PAYMENT"
  //         //         }
  //         //       ],
  //         //       "grandTotal": "95.70",
  //         //       "billingCurrency": "USD"
  //         //     },
  //         //     "pricingOptions": {
  //         //       "fareType": [
  //         //         "PUBLISHED"
  //         //       ],
  //         //       "includedCheckedBagsOnly": true
  //         //     },
  //         //     "validatingAirlineCodes": [
  //         //       "AI"
  //         //     ],
  //         //     "travelerPricings": [
  //         //       {
  //         //         "travelerId": "1",
  //         //         "fareOption": "STANDARD",
  //         //         "travelerType": "ADULT",
  //         //         "price": {
  //         //           "currency": "USD",
  //         //           "total": "95.70",
  //         //           "base": "79.00",
  //         //           "taxes": [
  //         //             {
  //         //               "amount": "2.80",
  //         //               "code": "P2"
  //         //             },
  //         //             {
  //         //               "amount": "7.80",
  //         //               "code": "IN"
  //         //             },
  //         //             {
  //         //               "amount": "4.10",
  //         //               "code": "K3"
  //         //             },
  //         //             {
  //         //               "amount": "2.00",
  //         //               "code": "YR"
  //         //             }
  //         //           ]
  //         //         },
  //         //         "fareDetailsBySegment": [
  //         //           {
  //         //             "segmentId": "1",
  //         //             "cabin": "ECONOMY",
  //         //             "fareBasis": "UIP",
  //         //             "class": "U",
  //         //             "includedCheckedBags": {
  //         //               "weight": 15,
  //         //               "weightUnit": "KG"
  //         //             }
  //         //           }
  //         //         ]
  //         //       }
  //         //     ]
  //         //   }
  //         // ],
  //         "travelers": [
  //           {
  //             "id": "1",
  //             "dateOfBirth": "1997-10-17",
  //             "name": {
  //               "firstName": "MEMBER",
  //               "lastName": "LOYTEST"
  //             },
  //             "gender": "MALE",
  //             "contact": {
  //               "emailAddress": "Member@Mustermann.com",
  //               "phones": [
  //                 {
  //                   "deviceType": "MOBILE",
  //                   "countryCallingCode": "33",
  //                   "number": "480080076"
  //                 }
  //               ]
  //             }
  //             // "loyaltyPrograms": [
  //             //     {
  //             //         "programOwner": "QF",
  //             //         "id": "1925825570"
  //             //     }
  //             // ]
  //           }
  //         ],
  //         "formOfPayments": [
  //           {
  //             "other": {
  //               "method": "CASH",
  //               "flightOfferIds": [
  //                 "1"
  //               ]
  //             }
  //           }
  //         ]
  //       }
  //     }
  //     ),
  //   );
  //
  //   print('list array....');
  //
  //   print(response.statusCode);
  //   if (response.statusCode == 201) {
  //     // Successful POST request, handle the response here
  //     final responseData = jsonDecode(response.body);
  //     print('pass lis detailes data...');
  //     print(responseData);
  //     var flightData = responseData['data'];
  //     print('passenger list Response data...');
  //     print(flightData);
  //
  //     var flightOffers = flightData['flightOffers'];
  //     print('flightOffers...');
  //     print(flightOffers);
  //     var travelers = flightData['travelers'];
  //     print('travelers...');
  //     print(travelers);
  //     // for (var travelerstr in flightData) {
  //     //   var travelerstr_Array = travelerstr['travelers'];
  //     //   print('travelers...');
  //     //   print(travelerstr_Array);
  //     // }
  //   }
  //   else {
  //     // throw Exception("Failed to load Dogs Breeds.");
  //     // final snackBar = SnackBar(
  //     //   content: Text('failed!,please try again'),
  //     // );
  //     // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }


  Card createCard() {
    var nameController = TextEditingController();
    var ageController = TextEditingController();
    var jobController = TextEditingController();
    nameTECs.add(nameController);
    ageTECs.add(ageController);
    jobTECs.add(jobController);
    // String dropdownvalue = 'ECONOMY';
    //
    // var items = [
    //   'Select Class',
    //   'ECONOMY',
    //   'PREMIUM ECONOMY',
    //   'BUSINESS',
    //   'FIRST'
    // ];

    // var items = [
    //   'Select Gender',
    //   'Male',
    //   'Female'
    // ];
    // //String currency_code_dropdownvalue = 'Select Gender';
    // String dropdownvalue = 'Select Gender';

    String CurrencyCodestr = '';
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            height: 450,
            width: 320,
            //color: Colors.yellow,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5), //border corner radius
              boxShadow:[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), //color of shadow
                  spreadRadius: 5, //spread radius
                  blurRadius: 7, // blur radius
                  offset: Offset(0, 2), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
                ),
                //you can set more BoxShadow() here
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Passenger:- ${cards.length + 1} Adult',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please be careful:-',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Passenger details must match your passport or photo ID',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
                ),



                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: 310,
                  //color: Colors.white,
                  color: Colors.white,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton(
                        isExpanded: true,
                        // Initial Value
                        value: dropdownvalue,
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                            Passengerlist_gendertxt.text = dropdownvalue;

                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: 310,
                  color: Colors.grey,
                  child: TextField(
                    controller: Passengerlist_gendertxt,
                    readOnly: true,
                    //autofocus: true,

                    style: TextStyle(fontSize: 16),

                    onTap: () async{
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      // prefixIcon: Icon(
                      //     Icons.account_circle, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(0),
                        ),
                      ),
                      hintText: 'Gender',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 310,
                  color: Colors.white,
                  child: TextField(
                    controller: Passengerlist_firstnametxt,
                    //readOnly: true,
                    autofocus: true,

                    style: TextStyle(fontSize: 16),

                    onTap: () async{
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      // prefixIcon: Icon(
                      //     Icons.account_circle, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(0),
                        ),
                      ),
                      hintText: 'Firstname',
                    ),
                  ),
                ),


                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: 310,
                  color: Colors.white,
                  child: TextField(
                    controller: Passengerlist_lastnametxt,
                    //readOnly: true,
                    autofocus: true,
                    style: TextStyle(fontSize: 16),

                    onTap: () async{
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      // prefixIcon: Icon(
                      //     Icons.account_circle, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(0),
                        ),
                      ),
                      hintText: 'Lastname',
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: 310,
                  color: Colors.white,
                  child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        prefixIcon: Icon(
                            Icons.calendar_month, color: Colors.green),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0),
                          ),
                        ),

                        hintText: 'DOB',
                      ),

                      controller: Passengerlist_DOBtxt,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2050));
                        if (pickedDate != null) {
                          Passengerlist_DOBtxt.text =
                              pickedDate.toString();
                          fromDate = DateFormat('yyyy-MM-dd').format(
                              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

                          Passengerlist_DOBtxt.text = fromDate;
                        }
                      }
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }

    @override
  void initState() {
    super.initState();
    for(int i = 1; i <= 2; i++){
      print('passenger textfield values....');
      print(Passengerlist_EmailTxt.text.toString());
      cards.add(createCard());

      print('passenger textfield values1....');
      print(Passengerlist_EmailTxt.text);

      for (var i=1; i<=2; i++) {

        Conver_travelersArray = <Map<String, dynamic>>[
          {
            "id": "1",
            "dateOfBirth": Passengerlist_DOBtxt.text,
            "name": {
              "firstName": Passengerlist_firstnametxt.text,
              "lastName": Passengerlist_lastnametxt.text
            },
            "gender": Passengerlist_gendertxt.text,
            "contact": {
              "emailAddress": Passengerlist_EmailTxt.text,
              "phones": [
                {
                  "deviceType": "MOBILE",
                  "countryCallingCode": "34",
                  "number": Passengerlist_phone_numtxt.text
                }
              ]
            },
          }
        ];
        print('Conver_travelersArray....');
        print(Conver_travelersArray);
      }
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
    for (var i=1; i<=2; i++) {

      Conver_travelersArray = <Map<String, dynamic>>[
        {
          "id": "1",
          "dateOfBirth": Passengerlist_DOBtxt.text,
          "name": {
            "firstName": Passengerlist_firstnametxt.text,
            "lastName": Passengerlist_lastnametxt.text
          },
          "gender": Passengerlist_gendertxt.text,
          "contact": {
            "emailAddress": Passengerlist_EmailTxt.text,
            "phones": [
              {
                "deviceType": "MOBILE",
                "countryCallingCode": "34",
                "number": Passengerlist_phone_numtxt.text
              }
            ]
          },
        }
      ];
      print('Conver_travelersArray....');
      print(Conver_travelersArray);
    }
    setState(() {
      for (var i=1; i<=2; i++) {

        Conver_travelersArray = <Map<String, dynamic>>[
          {
            "id": "1",
            "dateOfBirth": Passengerlist_DOBtxt.text,
            "name": {
              "firstName": Passengerlist_firstnametxt.text,
              "lastName": Passengerlist_lastnametxt.text
            },
            "gender": Passengerlist_gendertxt.text,
            "contact": {
              "emailAddress": Passengerlist_EmailTxt.text,
              "phones": [
                {
                  "deviceType": "MOBILE",
                  "countryCallingCode": "34",
                  "number": Passengerlist_phone_numtxt.text
                }
              ]
            },
          }
        ];
        print('Conver_travelersArray....');
        print(Conver_travelersArray);
      }
    }
    );
  }

  _onDone() {
    List<PersonEntry> entries = [];
    for (int i = 0; i < 3; i++) {
      var name = nameTECs[i].text;
      var age = ageTECs[i].text;
      var job = jobTECs[i].text;
      entries.add(PersonEntry(name, age, job));
    }
    Navigator.pop(context, entries);
  }



  void login(String email , password) async {
    try{
      print('login url...');
      print(baseDioSingleton.AbisiniyaBaseurl +'login');
      Response response = await post(
        //Uri.parse('https://staging.abisiniya.com/api/v1/login'),
          Uri.parse(baseDioSingleton.AbisiniyaBaseurl +'login'),
          body: {
            'email' : emailController.text.toString(),
            'password' : passwordController.text.toString()
          }
      );
      isLoading = true;
      if(response.statusCode == 200){
        isLoading = false;
        print('success api response');
        var data = jsonDecode(response.body.toString());
        var data1 = jsonDecode(response.body.toString());
        // print(data1['data']);
        // print(data1['data']['token']);
        Abiniyatokenvalue = (data1['data']['token']);
        String namestr = (data1['data']['name']);
        // print('token value....');
        // print(Abiniyatokenvalue);
        login_user_ID = (data1['data']['userID']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('tokenkey', Abiniyatokenvalue);
        prefs.setInt('login_user_ID_key', login_user_ID);

        Future.delayed(Duration.zero, () {
          //LoginshowAlertDialog(context);
           _postData();
          //showAlertdialog(context);
        });
        //_postData();
        //showAlertDialog(context);
        // );
      }else {
        print('failed');
        final snackBar = SnackBar(
          content: Text('Hi, Invalid login credentials'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {

    // showAlertDialog(BuildContext context) {
    //   // set up the buttons
    //   Widget cancelButton = TextButton(
    //     child: Text("Cancel",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green),),
    //     onPressed:  () {
    //       Navigator.of(context, rootNavigator: true).pop();
    //     },
    //   );
    //   Widget continueButton = TextButton(
    //     child: Text("Continue",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green),),
    //     onPressed:  () async{
    //       Navigator.of(context, rootNavigator: true).pop();
    //       await Navigator.of(context)
    //           .push(new MaterialPageRoute(builder: (context) => OnwardJourneyPassengerListViewDetails()));
    //       setState((){
    //         //Navigator.pop(context);
    //       });
    //     },
    //   );
    //
    //   // set up the AlertDialog
    //   AlertDialog alert = AlertDialog(
    //     title: Text("Abisiniya",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 24,color: Colors.green),),
    //     content: Text("Do you want Login?",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.black54),),
    //     actions: [
    //       cancelButton,
    //       continueButton,
    //     ],
    //   );
    //
    //   // show the dialog
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return alert;
    //     },
    //   );
    // }

    // void showDialogWithFields() {
    //   showDialog(
    //     context: context,
    //     builder: (_) {
    //       // var emailController = TextEditingController();
    //       // var passwordController = TextEditingController();
    //       return AlertDialog(
    //         title: Text('Login'),
    //         content: ListView(
    //           shrinkWrap: true,
    //           children: [
    //             TextFormField(
    //               controller: emailController,
    //               decoration: InputDecoration(hintText: 'Email'),
    //             ),
    //             TextFormField(
    //               controller: passwordController,
    //               decoration: InputDecoration(hintText: 'Password'),
    //             ),
    //           ],
    //         ),
    //         actions: [
    //           TextButton(
    //             //onPressed: () => Navigator.pop(context),
    //             onPressed: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) => Register()
    //                 ),
    //               );
    //             },
    //
    //             child: Text('Create'),
    //           ),
    //           TextButton(
    //             // onPressed: () {
    //             //   print('send bttn pressed...');
    //             //   // Send them to your email maybe?
    //             //   var email = emailController.text;
    //             //   var password = passwordController.text;
    //             //   Navigator.pop(context);
    //             // },
    //             onPressed: () async {
    //               setState(() => isLoading = true);
    //               // _postData();
    //               login(emailController.text.toString(), passwordController.text.toString());
    //
    //               SharedPreferences prefs = await SharedPreferences.getInstance();
    //               prefs.setString('emailkey', emailController.text);
    //               prefs.setString('passwordkey', passwordController.text);
    //               print('token value....');
    //               print(Abiniyatokenvalue);
    //               prefs.setString('tokenkey', Abiniyatokenvalue);
    //               await Future.delayed(Duration(seconds: 2), () => () {});
    //                 // Navigator.pop(context);
    //               // Future.delayed(Duration.zero, () {
    //               //   showAlertdialog(context);
    //               // });
    //
    //               setState(() => isLoading = false);
    //             },
    //             child: Text('Continue'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }
    Passengerlist_EmailTxt.text;
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
            color: Colors.green
        ),
        title: Text('Passenger Details', textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white
                ,
                fontFamily: 'Baloo',
                fontWeight: FontWeight.w900,
                fontSize: 20)),
      ),      body: SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          // Text('Hey'),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 225,
            width: 320,
            //color: Colors.blueGrey,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5), //border corner radius
              boxShadow:[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), //color of shadow
                  spreadRadius: 5, //spread radius
                  blurRadius: 7, // blur radius
                  offset: Offset(0, 2), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
                ),
                //you can set more BoxShadow() here
              ],
            ),
            child: Column(
              children: [

                SizedBox(height: 15,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Contact details',
                    style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800),),
                ),
                SizedBox(height: 5,),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'This is where your E- ticket will be sent',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                ),
                SizedBox(
                  height: 20,
                ),
                // Container(
                //   height: 50,
                //   width: 310,
                //   color: Colors.white,
                //   child: TextField(
                //     //controller: Rnd_OriginAirportCityController,
                //     readOnly: true,
                //     style: TextStyle(fontSize: 16),
                //
                //     onTap: () async{
                //     },
                //     decoration: InputDecoration(
                //       filled: true,
                //       fillColor: Color(0xFFFFFFFF),
                //       prefixIcon: Icon(
                //           Icons.account_circle, color: Colors.green),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(0),
                //         ),
                //       ),
                //       hintText: 'Firstname',
                //     ),
                //   ),
                // ),
                //
                //
                // SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   height: 50,
                //   width: 310,
                //   color: Colors.white,
                //   child: TextField(
                //     //controller: Rnd_OriginAirportCityController,
                //     readOnly: true,
                //     style: TextStyle(fontSize: 16),
                //
                //     onTap: () async{
                //     },
                //     decoration: InputDecoration(
                //       filled: true,
                //       fillColor: Color(0xFFFFFFFF),
                //       prefixIcon: Icon(
                //           Icons.account_circle, color: Colors.green),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(0),
                //         ),
                //       ),
                //       hintText: 'Lastname',
                //     ),
                //   ),
                // ),
                //
                // SizedBox(
                //   height: 10,
                // ),
                Container(
                  height: 50,
                  width: 310,
                  color: Colors.white,
                  child: TextField(
                    controller: Passengerlist_phone_numtxt,
                    //readOnly: true,
                    autofocus: true,

                      keyboardType: TextInputType.number,

                      style: TextStyle(fontSize: 16),

                    onTap: () async{
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      prefixIcon: Icon(
                          Icons.phone, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(0),
                        ),
                      ),
                      hintText: 'Phone number',
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: 310,
                  color: Colors.white,
                  child: TextField(
                    controller: Passengerlist_EmailTxt,
                    autofocus: true,


                    //readOnly: true,
                    style: TextStyle(fontSize: 16),

                    onTap: () async{
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      prefixIcon: Icon(
                          Icons.email, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(0),
                        ),
                      ),
                      hintText: 'Email',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child:ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int index) {
                return cards[index];
              },
            ),
          ),

          SizedBox(
            height: 5,
          ),
          Container(
            height: 60,
            width: 320,
            color: Colors.green,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50,
                  width: 150,
                  color: Colors.white,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      totalpricevalues,
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900,color:Colors.red),),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  child: Container(
                      height: 50,
                      width: 150,
                      color: Colors.blue,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                            "Continue",
                            style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w900,color: Colors.white),
                            textAlign: TextAlign.center
                        ),
                      )
                  ),
                  onTap: () async {
                    print('continue btn tapped....');

                    LoginshowAlertDialog(context);
                    },

                ),
              ],
            ),
          ),
          // ListView.builder(
          //     physics: NeverScrollableScrollPhysics(),
          //     shrinkWrap: true,
          //     itemCount:18,
          //     itemBuilder: (context,index){
          //       return  Text('Some text');
          //     })
        ],
      ),
    ),
      // body: Column(
      //   children: <Widget>[
      //
      //     Text('suresh bandaru'),
      //
      //     Expanded(
      //
      //       child: Container(
      //         child:ListView.builder(
      //           itemCount: cards.length,
      //           itemBuilder: (BuildContext context, int index) {
      //             return cards[index];
      //           },
      //         ),
      //       ),
      //
      //             // child:ListView.builder(
      //             //   itemCount: cards.length,
      //             //   itemBuilder: (BuildContext context, int index) {
      //             //     return cards[index];
      //             //   },
      //             // ),
      //
      //         //   ],
      //         // )
      //
      //     ),
      //     // Expanded(
      //     //   child: ListView.builder(
      //     //     itemCount: cards.length,
      //     //     itemBuilder: (BuildContext context, int index) {
      //     //       return cards[index];
      //     //     },
      //     //   ),
      //     // ),
      //     Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: TextButton(
      //         child: Text('add new'),
      //         onPressed: () => setState(() => cards.add(createCard())),
      //       ),
      //     )
      //   ],
      // ),


      // floatingActionButton:
      // FloatingActionButton(child: Icon(Icons.done), onPressed: _onDone),
    );
  }
}

class PersonEntry {
  final String name;
  final String age;
  final String studyJob;

  PersonEntry(this.name, this.age, this.studyJob);
  @override
  String toString() {
    return 'Person: name= $name, age= $age, study job= $studyJob';
  }
}

