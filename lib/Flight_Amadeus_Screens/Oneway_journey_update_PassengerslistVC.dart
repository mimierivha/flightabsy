import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import '../Auth/Register.dart';
import '../Singleton/SingletonAbisiniya.dart';
import 'OnwardJourney_PassengetViewdetailsVC.dart';
import 'OnwardJourney_newpassengerdetailsVC.dart';


//https://stackoverflow.com/questions/59425633/flutter-create-dynamic-textfield-when-button-click
// void main() {
//   runApp(App());
// }
//
// class App extends StatelessWidget {
//
//   @override
//
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Home(),
//     );
//   }
// }
//
// class Home extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             Text('Add Route Details',style: (TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.black54)),),
//
//             SizedBox(
//               height: 100,
//             ),
//             TextButton(
//               child: Text('Add'),
//               onPressed: () async {
//                 List<PersonEntry> persons = await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SOF(),
//                   ),
//                 );
//                 if (persons != null) persons.forEach(print);
//               },
//             ),
//           ],
//
//
//         ),
//         // child: TextButton(
//         //   child: Text('Add'),
//         //   onPressed: () async {
//         //     List<PersonEntry> persons = await Navigator.push(
//         //       context,
//         //       MaterialPageRoute(
//         //         builder: (context) => SOF(),
//         //       ),
//         //     );
//         //     if (persons != null) persons.forEach(print);
//         //   },
//         // ),
//       ),
//     );
//   }
// }

class Multiple_passengerlistVC extends StatefulWidget {
  @override
  _SOFState createState() => _SOFState();
}

class _SOFState extends State<Multiple_passengerlistVC> {
  TextEditingController Passengerlist_EmailTxt = TextEditingController();
  TextEditingController Passengerlist_phone_numtxt = TextEditingController();
  var firstNameTECs = <TextEditingController>[];
  var lastNameTECs = <TextEditingController>[];
  var genderTECs = <TextEditingController>[];
  var dobTECs = <TextEditingController>[];


  var cards = <Card>[];
  List<String> namgeList = [];
  var name = '';
  var firstNamestr = '';
  var lastNamestr = '';
  var genderstr = '';
  var dobstr = '';



  var locationName = '';
  String? dropdownvalue;
  var locationmultplevalues = [];
  var minutesmultplevalues = [];
  var pricemultplevalues = [];


  String selectedseat = '';
  String PassengerType = '';
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
  int Retrived_Passengers_cnt = 0;
  int Retrived_Adult_cnt = 0;
  int Retrived_child_cnt = 0;
  int Retrived_infant_cnt = 0;


  //bool isLoading = false;
  //String flightTokenstr = '';
  List travelersArray = [];
  List firstNameArray = [];
  List lastNameArray = [];
  List dobArray = [];
  List genderArray = [];




  List Convert_segmentArray = [];
  List Convert_AirlineArray = [];
  var travelerPricingslistArray = [];
  var totalPricevaluesArray = [];
  var cabintrvalue_Array = [];
  List convert_order_segArray = [];
  List convert_Travellertype_Array = [];
  List convert_passenger_Price_Array = [];





  List Convert_offer_data = [];
  List<dynamic> traveller_datalistArray = [];


  late final validatingAirlineCodestrvalue ;
  List validatingAirlineCodestrArray = [];
  final baseDioSingleton = BaseSingleton();




  List convert_travelerPricingsArray = [];
  Map<String, dynamic> convert_Currency_PriceArray = {};
  Map<String, dynamic> fareRulesArray = {};
  Map<String, dynamic> travellistarray = {};

  var travelerIdArray = [];
  String travelerTypestr = '';
  var travelerTypeArray = [];



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
  var passengerlistArray = [];

  // String totalpricevalues = '';
  String cabintrvalue = '';
  var flight_offer_Array = [];
  List Convert_travelersArray = [];




  List<String> items = [];
  List<String> LocationIdItems = [];



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



    Retrived_Passengers_cnt = prefs.getInt('Passengers_cntkey') ?? 0;
    Retrived_Adult_cnt = prefs.getInt('Passengers_Adult_cntkey') ?? 0;
    Retrived_child_cnt = prefs.getInt('Passengers_Child_cntkey') ?? 0;
    Retrived_infant_cnt = prefs.getInt('Passengers_infant_cntkey') ?? 0;



    print('order passengers cnt value');
    print(Retrived_Passengers_cnt);
    print(Retrived_Adult_cnt);
    print(Retrived_child_cnt);
    print(Retrived_infant_cnt);




    setState(() {
      for(int i = 1; i <= Retrived_Passengers_cnt; i++) {
        print('passenger textfield values....');
        cards.add(createCard());
      }
    });




    selectedseat = prefs.getString('selectedseatkey') ?? '';
    print('order price screen seat');
    print(selectedseat);

    passengerlistArray = ['Adult','Child','Infant'];
    print('passengerlistArray...');
    print(passengerlistArray);
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
    //Traveller types receiving
    final Retrived_Traveller_type_Array;
    Retrived_Traveller_type_Array = prefs.getString('TravellertypejsonParsingkey') ?? '';
    print('Retrived_Traveller_type_Array...');
    print(Retrived_Traveller_type_Array);

    convert_Travellertype_Array = json.decode(Retrived_Traveller_type_Array);
    print('convert_Travellertype_Array array...');
    print(convert_Travellertype_Array);

    //Calling each passengers price values
    final passenger_Price_Array;
    passenger_Price_Array = prefs.getString('priceArrayjsonParsingkey') ?? '';
    print('passenger_Price_Array...');
    print(passenger_Price_Array);
    convert_passenger_Price_Array = json.decode(passenger_Price_Array);
    print('passenger_Price_Array...');
    print(convert_passenger_Price_Array);


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

    print('order seat number...');
    print(selectedseat);
    convert_travelerPricingsArray[0]['fareDetailsBySegment']![0]["additionalServices"] = {
      "chargeableSeatNumber": selectedseat
    };
    final Retrived_Currency_PriceArray ;
    Retrived_Currency_PriceArray = prefs.getString('convert_Currency_PriceArraykey') ?? '';
    print('order Retrived_Currency_PriceArray...');
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

  @override
  void initState(){
    super.initState();

    _retrieveValues();

    //onPressed: () => setState(() => cards.add(createCard())),
    //print('viws Passengers_cnt....');
    // print(Retrived_Passengers_cnt);
    // setState(() {
    //   // Passengers_cnt = prefs.getInt('Passengers_cntkey') ?? 0;
    //   print('calling order passengers cnt');
    //   print(Retrived_Passengers_cnt);
    // });

    // for(int i = 1; i <= Retrived_Passengers_cnt; i++) {
    //   print('passenger textfield values....');
    //   cards.add(createCard());
    // }
  }


  void changedData(String? value){
    var dropdownValue = value!;
  }



  Card createCard() {
    print('calling order passengers cnt value');
    print(Retrived_Passengers_cnt);
    print(Retrived_Adult_cnt);
    print(Retrived_child_cnt);

    if(Retrived_Adult_cnt >= 1 && Retrived_child_cnt == 0 && Retrived_child_cnt == 0) {
      print('pass Only Adults calling...');
     // PassengerType = "Adult";
      if(cards.length == 0){
        PassengerType = "Adult";
      } else if (cards.length == 1) {
        PassengerType = "Adult";
      }else if (cards.length == 2) {
        PassengerType = "Adult";
      }else if (cards.length == 3) {
        PassengerType = "Adult";
      }else if (cards.length == 4) {
        PassengerType = "Adult";
      } else {
        PassengerType = "Adult";
      }
    } else if(Retrived_Adult_cnt == 1 && Retrived_child_cnt == 1 && Retrived_child_cnt == 1) {

      print('pass 1 adult,1 child and 1 infant');
      if(cards.length == 0){
        PassengerType = "Adult";
      } else if (cards.length == 1) {
        PassengerType = "Child";
      } else {
        PassengerType = "Infant";
      }

    }else {

      print('pass 1 adult,2 child and 1 infant');
      if(cards.length == 0){
        PassengerType = "Adult";
      } else if (cards.length == 1) {
        PassengerType = "Child";
      }else if (cards.length == 2) {
        PassengerType = "Child";
      } else {
        PassengerType = "Infant";
      }

    }



    String dropdownvalue = 'Select Gender';

    String fromDate = '';


    var items = [
      'Select Gender',
      'MALE',
      'FEMALE'
    ];



    TextEditingController Passengerlist_firstnametxt = TextEditingController();
    TextEditingController Passengerlist_lastnametxt = TextEditingController();
    TextEditingController Passengerlist_DOBtxt = TextEditingController();
    TextEditingController Passengerlist_gendertxt = TextEditingController();

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    firstNameTECs.add(Passengerlist_firstnametxt);
    lastNameTECs.add(Passengerlist_lastnametxt);
    genderTECs.add(Passengerlist_gendertxt);
    dobTECs.add(Passengerlist_DOBtxt);
    // var nameController = TextEditingController();
    // var ageController = TextEditingController();
    // var jobController = TextEditingController();
    // nameTECs.add(nameController);
    // ageTECs.add(ageController);
    // jobTECs.add(jobController);
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




    // //Post API calling...
    // Future<void> _postData() async {
    //   setState(() {
    //     isLoading = true;
    //   });
    //   //tempList = List<String>();
    //   //List<String> tempList = [];
    //
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
    //   // print(' Details Onward journey token1...');
    //   // print(flightTokenstr);
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
    //
    //         //"flightOffers": Convert_offer_data,
    //
    //         "flightOffers": [
    //           {
    //             "type": "flight-offer",
    //             "id": flight_ID,
    //             "source": sourcestr,
    //             "instantTicketingRequired": false,
    //             "nonHomogeneous": false,
    //             "paymentCardRequired": false,
    //             "lastTicketingDate": lastTicketing_Datestr,
    //             "itineraries": [
    //               {
    //                 "segments": convert_order_segArray,
    //
    //                 // "segments": [
    //                 //   {
    //                 //     "departure": {
    //                 //       "iataCode": "BLR",
    //                 //       "terminal": "2",
    //                 //       "at": "2024-08-07T11:30:00"
    //                 //     },
    //                 //     "arrival": {
    //                 //       "iataCode": "DEL",
    //                 //       "terminal": "3",
    //                 //       "at": "2024-08-07T14:10:00"
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
    //                 //     "co2Emissions": [
    //                 //       {
    //                 //         "weight": 120,
    //                 //         "weightUnit": "KG",
    //                 //         "cabin": "ECONOMY"
    //                 //       }
    //                 //     ]
    //                 //   }
    //                 // ]
    //               }
    //             ],
    //
    //             "price": convert_Currency_PriceArray,
    //
    //             // "price": {
    //             //   "currency": "USD",
    //             //   "total": "101.90",
    //             //   "base": "85.00",
    //             //   "fees": [
    //             //     {
    //             //       "amount": "0.00",
    //             //       "type": "SUPPLIER"
    //             //     },
    //             //     {
    //             //       "amount": "0.00",
    //             //       "type": "TICKETING"
    //             //     },
    //             //     {
    //             //       "amount": "0.00",
    //             //       "type": "FORM_OF_PAYMENT"
    //             //     }
    //             //   ],
    //             //   "grandTotal": "101.90",
    //             //   "billingCurrency": "USD"
    //             // },
    //             "pricingOptions": {
    //               "fareType": [
    //                 "PUBLISHED"
    //               ],
    //               "includedCheckedBagsOnly": true
    //             },
    //             "validatingAirlineCodes": [
    //               validatingAirlineCodestrArray.first
    //             ],
    //             "travelerPricings": convert_travelerPricingsArray,
    //
    //             // "travelerPricings": [
    //             //   {
    //             //     "travelerId": "1",
    //             //     "fareOption": "STANDARD",
    //             //     "travelerType": "ADULT",
    //             //     "price": {
    //             //       "currency": "USD",
    //             //       "total": "101.90",
    //             //       "base": "85.00",
    //             //       "taxes": [
    //             //         {
    //             //           "amount": "2.80",
    //             //           "code": "P2"
    //             //         },
    //             //         {
    //             //           "amount": "7.70",
    //             //           "code": "IN"
    //             //         },
    //             //         {
    //             //           "amount": "4.40",
    //             //           "code": "K3"
    //             //         },
    //             //         {
    //             //           "amount": "2.00",
    //             //           "code": "YR"
    //             //         }
    //             //       ]
    //             //     },
    //             //     "fareDetailsBySegment": [
    //             //       {
    //             //         "segmentId": "1",
    //             //         "cabin": "ECONOMY",
    //             //         "fareBasis": "LIP",
    //             //         "brandedFare": "VECOCOMF",
    //             //         "class": "L",
    //             //         "includedCheckedBags": {
    //             //           "weight": 15,
    //             //           "weightUnit": "KG"
    //             //         }
    //             //       }
    //             //     ]
    //             //   }
    //             // ]
    //           }
    //         ],
    //
    //         "travelers": Conver_travelersArray,
    //
    //         // "travelers": [
    //         //   {
    //         //     "id": "1",
    //         //     "dateOfBirth": Passengerlist_DOBtxt.text,
    //         //     "name": {
    //         //       "firstName": Passengerlist_firstnametxt.text,
    //         //       "lastName": Passengerlist_lastnametxt.text
    //         //     },
    //         //     "gender": Passengerlist_gendertxt.text,
    //         //     "contact": {
    //         //       "emailAddress": Passengerlist_EmailTxt.text,
    //         //       "phones": [
    //         //         {
    //         //           "deviceType": "MOBILE",
    //         //           "countryCallingCode": "34",
    //         //           "number": Passengerlist_phone_numtxt.text
    //         //         }
    //         //       ]
    //         //     },
    //         //     // "documents": [
    //         //     //   {
    //         //     //     "documentType": "PASSPORT",
    //         //     //     "birthPlace": "Madrid",
    //         //     //     "issuanceLocation": "Madrid",
    //         //     //     "issuanceDate": "2015-04-14",
    //         //     //     "number": "00000000",
    //         //     //     "expiryDate": "2025-04-14",
    //         //     //     "issuanceCountry": "ES",
    //         //     //     "validityCountry": "ES",
    //         //     //     "nationality": "ES",
    //         //     //     "holder": true
    //         //     //   }
    //         //     // ]
    //         //   },
    //         //   {
    //         //     "id": "2",
    //         //     "dateOfBirth": "2012-10-11",
    //         //     "gender": "FEMALE",
    //         //     "contact": {
    //         //       "emailAddress": "jorge.gonzales833@telefonica.es",
    //         //       "phones": [
    //         //         {
    //         //           "deviceType": "MOBILE",
    //         //           "countryCallingCode": "34",
    //         //           "number": "480080076"
    //         //         }
    //         //       ]
    //         //     },
    //         //     "name": {
    //         //       "firstName": "ADRIANA",
    //         //       "lastName": "GONZALES"
    //         //     }
    //         //   }
    //         // ],
    //         // "travelers": [
    //         //   {
    //         //     "id": "1",
    //         //     "dateOfBirth": Passengerlist_DOBtxt.text,
    //         //     "name": {
    //         //       "firstName": Passengerlist_firstnametxt.text,
    //         //       "lastName": Passengerlist_lastnametxt.text
    //         //     },
    //         //     "gender": Passengerlist_gendertxt.text,
    //         //     "contact": {
    //         //       "emailAddress": Passengerlist_EmailTxt.text,
    //         //       "phones": [
    //         //         {
    //         //           "deviceType": "MOBILE",
    //         //           "countryCallingCode": "33",
    //         //           "number": Passengerlist_phone_numtxt.text
    //         //         }
    //         //       ]
    //         //     },
    //         //     "loyaltyPrograms": [
    //         //       {
    //         //         "programOwner": "QF",
    //         //         "id": "1925825570"
    //         //       }
    //         //     ]
    //         //   }
    //         // ],
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
    //
    //     ),
    //   );
    //
    //   print('list array....');
    //
    //   print(response.statusCode);
    //   if (response.statusCode == 201) {
    //     // print('retrived abisiniya token value....');
    //     // print(Abiniyatokenvalue);
    //     // Successful POST request, handle the response here
    //     final responseData = jsonDecode(response.body);
    //     // print('pass lis detailes data...');
    //     // print(responseData);
    //     var flightData = responseData['data'];
    //     // print('passenger list Response data...');
    //     // print(flightData);
    //     // for (var flightdataArray in flightData) {
    //     //   OrderID = flightdataArray['id'];
    //     //   print('Order Id..');
    //     //   print(OrderID);
    //     // }
    //     var flightOffers = flightData['flightOffers'];
    //     // print('flightOffers...');
    //     // print(flightOffers);
    //     OrderID = flightData['id'];
    //     // print('Order Id..');
    //     // print(OrderID);
    //     var associatedRecordsData = flightData['associatedRecords'];
    //     print('associatedRecords...');
    //     print(associatedRecordsData);
    //     for(var associatedRecordsArray in associatedRecordsData){
    //       referencestr = associatedRecordsArray['reference'];
    //       // print('referencestr...');
    //       // print(referencestr);
    //     }
    //     var travelers = flightData['travelers'];
    //     // print('travelers...');
    //     // print(travelers);
    //     for(var travelersArray in travelers){
    //       travellerId = travelersArray['id'];
    //       print('travellerId...');
    //       print(travellerId);
    //     }
    //     SharedPreferences prefs = await SharedPreferences.getInstance();
    //     prefs.setString('OrderIDkey', OrderID);
    //     prefs.setString('travellerIdkey', travellerId);
    //
    //     // print('order id receive');
    //     // print(OrderID);
    //
    //     prefs.setString('pricekey', totalprice);
    //     prefs.setString('reference_key', referencestr);
    //     prefs.setString('passenger_firstname_key', Passengerlist_firstnametxt.text);
    //     prefs.setString('passenger_lastname_key', Passengerlist_lastnametxt.text);
    //     prefs.setString('passenger_phone_key', Passengerlist_phone_numtxt.text);
    //     prefs.setString('passenger_email_key', Passengerlist_EmailTxt.text);
    //     prefs.setString('passenger_gender_key', Passengerlist_gendertxt.text);
    //     prefs.setString('passenger_dob_key', Passengerlist_DOBtxt.text);
    //     prefs.setString('local_Flight_tokenkey', Abiniyatokenvalue);
    //     setState(() async{
    //
    //       Navigator.of(context, rootNavigator: true).pop();
    //       await Navigator.of(context)
    //           .push(new MaterialPageRoute(builder: (context) => OnwardJourneyPassengerListViewDetails()));
    //       setState((){
    //         Navigator.pop(context);
    //       });
    //     });
    //
    //
    //
    //     // for (var travelerstr in flightData) {
    //     //   var travelerstr_Array = travelerstr['travelers'];
    //     //   print('travelers...');
    //     //   print(travelerstr_Array);
    //     // }
    //   } else if(response.statusCode == 400){
    //     final responseData = jsonDecode(response.body);
    //     var flighterror_Data = responseData['errors'];
    //     // print('flighterror_Data...');
    //     // print(flighterror_Data);
    //     for(var titledata in flighterror_Data){
    //       var titlestr = titledata['title'];
    //       // print('titlestr...');
    //       // print(titlestr);
    //       var detail = titledata['detail'];
    //       if(titlestr == 'SEGMENT SELL FAILURE'){
    //         final snackBar = SnackBar(
    //           content: Text(titlestr + ' , ' + 'Please check flight details and try again'),
    //         );
    //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //       } else {
    //         final snackBar = SnackBar(
    //           content: Text(detail + ' , ' +'Please try again..'),
    //         );
    //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //       }
    //     }
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
                    'Passenger:- ${cards.length + 1} ${PassengerType}',
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
  // Card createCard() {
  //   //String? dropdownvalue;
  //   List<String> namgeList = [];
  //
  //   var locationIdValue = '';
  //
  //
  //   var locationController = TextEditingController();
  //   var minutesController = TextEditingController();
  //   var priceController = TextEditingController();
  //   var locationID = '';
  //   locationnameTECs.add(locationController);
  //
  //   minutesTECs.add(minutesController);
  //   priceTECs.add(priceController);
  //
  //   return Card(
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         Text('Location ${cards.length + 1}'),
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             FutureBuilder<dynamic>(
  //               future: getAllCategory(),
  //               builder: (context, snapshot) {
  //
  //                 if (snapshot.hasData) {
  //                   var data = snapshot.data!;
  //                   // print('data...');
  //                   // print(data);
  //                   print(items);
  //                   print(LocationIdItems);
  //                   SizedBox(
  //                     height: 50,
  //                   );
  //                   return DropdownButton<String>(
  //                     isExpanded: true,
  //                     hint: Text(
  //                       'Select Location',
  //                       //style: kMainContentStyleLightBlack,
  //                     ),
  //                     autofocus: true,
  //                     //value: dropdownValue!, //?? dropdownOptions[0],
  //                     //value: dropdownvalue ?? data[0],
  //                     // value: data[0] ?? 'Selected Value',
  //                     icon: const Icon(
  //                       Icons.agriculture_rounded,
  //                       color: Color(0xFF773608), //Color(0xFF2E7D32), //Colors.green,
  //                     ),
  //                     elevation: 16,
  //                     underline: Container(
  //                       height: 2,
  //                       color: Colors.black,
  //                     ),
  //                     onChanged: (String? newValue,) {
  //                       setState(() {
  //                         dropdownvalue = newValue!;
  //                         print('call....');
  //                         print(newValue);
  //                         items.indexOf(newValue) + 1;
  //                         print('index...');
  //                         print(items.indexOf(newValue) + 1);
  //                         locationID = (items.indexOf(newValue) + 1).toString();
  //                         locationController.text = newValue;
  //                         DropdownMenuItem(child: Text(newValue), value: newValue);
  //                         // return cards.add(newValue as Card);
  //                         //cards.add(createCard());
  //                       });
  //                     },
  //                     items: data.map<DropdownMenuItem<String>>((String newValue) {
  //                       return DropdownMenuItem<String>(
  //                         value: newValue,
  //                         child: Text(newValue),
  //                       );
  //                     }
  //                     ).toList(),
  //                   );
  //
  //                 } else {
  //                   return const CircularProgressIndicator();
  //                 }
  //               },
  //             ),
  //
  //
  //
  //             // FutureBuilder<List<String>>(
  //             //   future: getAllCategory(),
  //             //   builder: (context, snapshot) {
  //             //
  //             //     if (snapshot.hasData) {
  //             //       var data = snapshot.data!;
  //             //     // var  bookingID = snapshot.data['data'];
  //             //
  //             //       print('data...');
  //             //       print(data);
  //             //       print('namelist....');
  //             //
  //             //       SizedBox(
  //             //         height: 50,
  //             //       );
  //             //       return DropdownButton<String>(
  //             //         isExpanded: true,
  //             //         hint: Text(
  //             //           'Select Location',
  //             //           //style: kMainContentStyleLightBlack,
  //             //         ),
  //             //         autofocus: true,
  //             //         //value: dropdownValue!, //?? dropdownOptions[0],
  //             //            //value: dropdownvalue ?? data[0],
  //             //         // value: data[0] ?? 'Selected Value',
  //             //         icon: const Icon(
  //             //           Icons.agriculture_rounded,
  //             //           color: Color(0xFF773608), //Color(0xFF2E7D32), //Colors.green,
  //             //         ),
  //             //         elevation: 16,
  //             //         underline: Container(
  //             //           height: 2,
  //             //           color: Colors.black,
  //             //         ),
  //             //         onChanged: (String? newValue) {
  //             //           setState(() {
  //             //             dropdownvalue = newValue!;
  //             //             print('call....');
  //             //             print(newValue);
  //             //
  //             //             jobController.text = newValue;
  //             //             DropdownMenuItem(child: Text(newValue), value: newValue);
  //             //             // return cards.add(newValue as Card);
  //             //             //cards.add(createCard());
  //             //           });
  //             //         },
  //             //         items: data.map<DropdownMenuItem<String>>((String newValue) {
  //             //           return DropdownMenuItem<String>(
  //             //             value: newValue,
  //             //             child: Text(newValue),
  //             //           );
  //             //         }).toList(),
  //             //       );
  //             //
  //             //     } else {
  //             //       return const CircularProgressIndicator();
  //             //     }
  //             //   },
  //             // ),
  //           ],
  //         ),
  //
  //         TextField(
  //             controller: locationController,
  //             decoration: InputDecoration(labelText: 'Location')),
  //         TextField(
  //             controller: minutesController,
  //             decoration: InputDecoration(labelText: 'minutes')),
  //         TextField(
  //             controller: priceController,
  //             decoration: InputDecoration(labelText: 'price')),
  //       ],
  //     ),
  //   );
  // }

  // @override
  // void initState(){
  //   super.initState();
  //
  //   _retrieveValues();
  //
  //   //onPressed: () => setState(() => cards.add(createCard())),
  //   print('viws Passengers_cnt....');
  //   print(Passengers_cnt);
  //   setState(() {
  //    // Passengers_cnt = prefs.getInt('Passengers_cntkey') ?? 0;
  //     print('calling order passengers cnt');
  //     print(Passengers_cnt);
  //   });
  //
  //   for(int i = 1; i <= Passengers_cnt; i++) {
  //     print('passenger textfield values....');
  //     cards.add(createCard());
  //   }
  // }

//   @override
//   void initState() {
//     super.initState();
// //    cards.add(createCard());
//     getData();
//   }
  //var dropdownvalue;




  //final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  final TextEditingController routenameController = TextEditingController();
  String result = ''; // To s





  _onDone() {


    List<PersonEntry> entries = [];
    List<List<dynamic>>listArray = List<List<dynamic>>.empty(growable: true);

    for (int i = 0; i < cards.length; i++) {


      firstNamestr = firstNameTECs[i].text;
      lastNamestr = lastNameTECs[i].text;
      genderstr = genderTECs[i].text;
      dobstr = dobTECs[i].text;
      print('firstNamestr...');
      print(firstNamestr);
      firstNameArray.add(firstNamestr);
      lastNameArray.add(lastNamestr);
      genderArray.add(genderstr);
      dobArray.add(dobstr);



      print('firstNameArray...');
      print(firstNameArray);
      print(lastNamestr);
      print(genderstr);
      print(dobstr);
      entries.add(PersonEntry(name));

      _postData();
      //loginshowAlertDialog(context);






      // for (var i=1; i<=2; i++) {
      //
      //
      //    = <Map<String, dynamic>>[
      //     {
      //       "id": i,
      //       "travelerType": 'Adult',
      //       "fareOptions": [
      //         "STANDARD"
      //       ],
      //     },
      //   ];
      //   print('pasenger travelersArray....');
      //   print(travelersArray);
      // }



      // for (var i = 1; i <= 2; i++) {
      //   Convert_travelersArray = <Map<String, dynamic>>[
      //     {
      //       "id": i,
      //       "dateOfBirth": dobstr,
      //       "name": {
      //         "firstName": firstNamestr,
      //         "lastName": lastNamestr
      //       },
      //       "gender": genderstr,
      //       "contact": {
      //         "emailAddress": Passengerlist_EmailTxt.text,
      //         "phones": [
      //           {
      //             "deviceType": "MOBILE",
      //             "countryCallingCode": "34",
      //             "number": Passengerlist_phone_numtxt.text
      //           }
      //         ]
      //       },
      //
      //     }
      //
      //   ];
      //   print('Conver_travelersArray....');
      //   print(Convert_travelersArray);
      //   final myArrayJson = jsonEncode(Convert_travelersArray);
      //   print('myArrayJson...');
      //   final myArrayRegular = jsonDecode(myArrayJson);
      //   print('myArrayRegular..');
      //   print(myArrayRegular);
      // }
      //showAlertDialog(context);

    }
    // RouteAdd('p1,p2','1','1','1');
    //sendPostRequest();
    // List<PersonEntry> entries = [];
    // List<List<dynamic>>listArray = List<List<dynamic>>.empty(growable: true);

    final combinedData = <Map<String, dynamic>>[];
    // var myControllers = [];
  }






  List categoryItemlist = [];
  var subjectItemlist = [];

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //price Alert Dialog
  Widget setupAlertDialoadContainer() {
    return Container(
      height: 200,
      width: 300,
      //color: Colors.white,
       child: ListView.builder(
         itemCount: convert_Travellertype_Array.length,
               itemBuilder: (BuildContext context, int index) {
                 return ListTile(
                   title: Text(convert_Travellertype_Array[index] + "            " + convert_passenger_Price_Array[index]),

                     //leading: Text('Total'),
                     trailing: Text(totalpricevalues)
                 );
               },
       )
    );
  }

  //Passengers List

  PassengerListshowAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        // var emailController = TextEditingController();
        // var passwordController = TextEditingController();
        return AlertDialog(
          title: Text('Passenger fares'),
          content: ListView.builder(
            shrinkWrap: true,
        itemCount: convert_Travellertype_Array.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: Text(convert_Travellertype_Array[index] + "            " + convert_passenger_Price_Array[index]),

              //leading: Text('Total'),
             // trailing: Text(totalpricevalues)
          );

        }

            // children: [
            //
            //  // Text(convert_Travellertype_Array[index] + "            " + convert_passenger_Price_Array[index]),
            //
            // ],
            // children: [
            //   TextFormField(
            //     controller: emailController,
            //     decoration: InputDecoration(hintText: 'Email'),
            //   ),
            //   TextFormField(
            //     controller: passwordController,
            //     decoration: InputDecoration(hintText: 'Password'),
            //   ),
            // ],
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

              child: Text('Total',style: (TextStyle(fontWeight: FontWeight.w800,fontSize: 20,color: Colors.red))),
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
              child: Text(totalpricevalues,style: (TextStyle(fontWeight: FontWeight.w800,fontSize: 20,color: Colors.red)),),
            ),
          ],
        );
      },
    );
  }


  //void showDialogWithFields() {
  loginshowAlertDialog(BuildContext context) {
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
             // onPressed: () async {

                onPressed:  () async{
                  // Navigator.of(context, rootNavigator: true).pop();
                  // await Navigator.of(context)
                  //     .push(new MaterialPageRoute(builder: (context) => Passenger_DetailsVC()));
                  // setState((){
                  //   //Navigator.pop(context);
                  // });
                //},


                //setState(() => isLoading = true);
                // _postData();
                  print('call login....');
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

  Future<void> _postData() async {

    print('firstNameArray calling');
    print(firstNameArray.first);

    //for (var i = 1; i <= Retrived_Passengers_cnt; i++) {
      print('i value...');
      print(Retrived_Passengers_cnt);
      if(Retrived_Passengers_cnt == 1) {
        print('1 adult checking....');
        travelersArray = <Map<String, dynamic>>[
          {
            "id": 1,
            "dateOfBirth": dobstr,
            "name": {
              "firstName": firstNamestr,
              "lastName": lastNamestr
            },
            "gender": genderstr,
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
      } else if (Retrived_Passengers_cnt == 2) {
        print('2 adult checking....');

        travelersArray = <Map<String, dynamic>>[
          {
            "id": "1",
            "dateOfBirth": dobArray[0],
            "name": {
              "firstName": firstNameArray[0],
              "lastName": lastNameArray[0]
            },
            "gender": genderArray[0],
            "contact": {
              "emailAddress": Passengerlist_EmailTxt.text,
              "phones": [
                {
                  "deviceType": "MOBILE",
                  "countryCallingCode": "33",
                  "number": Passengerlist_phone_numtxt.text
                }
              ]
            }
          },
          {
            "id": "2",
            "dateOfBirth": dobArray[1],
            "name": {
              "firstName": firstNameArray[1],
              "lastName": lastNameArray[1]
            },
            "gender": genderArray[1],
            "contact": {
              "emailAddress": Passengerlist_EmailTxt.text,
              "phones": [
                {
                  "deviceType": "MOBILE",
                  "countryCallingCode": "33",
                  "number": Passengerlist_phone_numtxt.text
                }
              ]
            }
          }

        ];
      } else if (Retrived_Passengers_cnt == 3) {
        print('3 adult checking....');
         travelersArray = <Map<String, dynamic>>[
           {
    "id": "1",
    "dateOfBirth": dobArray[0],
    "name": {
    "firstName": firstNameArray[0],
    "lastName": lastNameArray[0]
    },
    "gender": genderArray[0],
    "contact": {
    "emailAddress": Passengerlist_EmailTxt.text,
    "phones": [
    {
    "deviceType": "MOBILE",
    "countryCallingCode": "33",
    "number": Passengerlist_phone_numtxt.text
    }
    ]
    }
    },
    {
    "id": "2",
    "dateOfBirth": dobArray[1],
    "name": {
    "firstName": firstNameArray[1],
    "lastName": lastNameArray[1]
    },
    "gender": genderArray[1],
    "contact": {
    "purpose": "STANDARD_WITHOUT_TRANSMISSION",
    "emailAddress": Passengerlist_EmailTxt.text,
    "phones": [
    {
    "deviceType": "MOBILE",
    "countryCallingCode": "33",
    "number": Passengerlist_phone_numtxt.text
    }
    ]
    }
    },
    {
    "id": "3",
    "dateOfBirth": dobArray[2],
    "name": {
    "firstName": firstNameArray[2],
    "lastName": lastNameArray[2]
    },
    "gender": genderArray[2],
    "contact": {
    "purpose": "STANDARD_WITHOUT_TRANSMISSION",
    "emailAddress": Passengerlist_EmailTxt.text,
    "phones": [
    {
    "deviceType": "MOBILE",
    "countryCallingCode": "33",
    "number": Passengerlist_phone_numtxt.text
    }
    ]
    }
    }
    ];

        // travelersArray = <Map<String, dynamic>>[
        //   {
        //     "id": "1",
        //     "dateOfBirth": dobArray[0],
        //     "name": {
        //       "firstName": firstNameArray[0],
        //       "lastName": lastNameArray[0]
        //     },
        //     "gender": genderArray[0],
        //     "contact": {
        //       "emailAddress": Passengerlist_EmailTxt.text,
        //       "phones": [
        //         {
        //           "deviceType": "MOBILE",
        //           "countryCallingCode": "33",
        //           "number": Passengerlist_phone_numtxt.text
        //         }
        //       ]
        //     }
        //   },
        //   {
        //     "id": "2",
        //     "dateOfBirth": dobArray[1],
        //     "name": {
        //       "firstName": firstNameArray[1],
        //       "lastName": lastNameArray[1]
        //     },
        //     "gender": genderArray[1],
        //     "contact": {
        //       "emailAddress": Passengerlist_EmailTxt.text,
        //       "phones": [
        //         {
        //           "deviceType": "MOBILE",
        //           "countryCallingCode": "33",
        //           "number": Passengerlist_phone_numtxt.text
        //         }
        //       ]
        //     }
        //   },
        //   {
        //     "id": "3",
        //     "dateOfBirth": dobArray[2],
        //     "name": {
        //       "firstName": firstNameArray[2],
        //       "lastName": lastNameArray[2]
        //     },
        //     "gender": genderArray[2],
        //     "contact": {
        //       "emailAddress": Passengerlist_EmailTxt.text,
        //       "phones": [
        //         {
        //           "deviceType": "MOBILE",
        //           "countryCallingCode": "33",
        //           "number": Passengerlist_phone_numtxt.text
        //         }
        //       ]
        //     }
        //   }

        //];
      }  else if (Retrived_Passengers_cnt == 4) {
        print('4 adult checking....');
        travelersArray = <Map<String, dynamic>>[
          {
            "id": "1",
            "dateOfBirth": dobArray[0],
            "name": {
              "firstName": firstNameArray[0],
              "lastName": lastNameArray[0]
            },
            "gender": genderArray[0],
            "contact": {
              "emailAddress": Passengerlist_EmailTxt.text,
              "phones": [
                {
                  "deviceType": "MOBILE",
                  "countryCallingCode": "33",
                  "number": Passengerlist_phone_numtxt.text
                }
              ]
            }
          },
          {
            "id": "2",
            "dateOfBirth": dobArray[1],
            "name": {
              "firstName": firstNameArray[1],
              "lastName": lastNameArray[1]
            },
            "gender": genderArray[1],
            "contact": {
              "purpose": "STANDARD_WITHOUT_TRANSMISSION",
              "emailAddress": Passengerlist_EmailTxt.text,
              "phones": [
                {
                  "deviceType": "MOBILE",
                  "countryCallingCode": "33",
                  "number": Passengerlist_phone_numtxt.text
                }
              ]
            }
          },
          {
            "id": "4",
            "dateOfBirth": dobArray[3],
            "name": {
              "firstName": firstNameArray[3],
              "lastName": lastNameArray[3]
            },
            "gender": genderArray[3],
            "contact": {
              "purpose": "STANDARD_WITHOUT_TRANSMISSION",
              "emailAddress": Passengerlist_EmailTxt.text,
              "phones": [
                {
                  "deviceType": "MOBILE",
                  "countryCallingCode": "33",
                  "number": Passengerlist_phone_numtxt.text
                }
              ]
            }
          },
          {
            "id": "3",
            "dateOfBirth": dobArray[2],
            "name": {
              "firstName": firstNameArray[2],
              "lastName": lastNameArray[2]
            },
            "gender": "MALE",
            "contact": {
              "purpose": "STANDARD_WITHOUT_TRANSMISSION",
              "emailAddress": Passengerlist_EmailTxt.text,
              "phones": [
                {
                  "deviceType": "MOBILE",
                  "countryCallingCode": "33",
                  "number": Passengerlist_phone_numtxt.text
                }
              ]
            }
          }
        ];

        // travelersArray = <Map<String, dynamic>>[
        //   {
        //     "id": "1",
        //     "dateOfBirth": dobArray[0],
        //     "name": {
        //       "firstName": firstNameArray[0],
        //       "lastName": lastNameArray[0]
        //     },
        //     "gender": genderArray[0],
        //     "contact": {
        //       "emailAddress": Passengerlist_EmailTxt.text,
        //       "phones": [
        //         {
        //           "deviceType": "MOBILE",
        //           "countryCallingCode": "33",
        //           "number": Passengerlist_phone_numtxt.text
        //         }
        //       ]
        //     }
        //   },
        //   {
        //     "id": "2",
        //     "dateOfBirth": dobArray[1],
        //     "name": {
        //       "firstName": firstNameArray[1],
        //       "lastName": lastNameArray[1]
        //     },
        //     "gender": genderArray[1],
        //     "contact": {
        //       "emailAddress": Passengerlist_EmailTxt.text,
        //       "phones": [
        //         {
        //           "deviceType": "MOBILE",
        //           "countryCallingCode": "33",
        //           "number": Passengerlist_phone_numtxt.text
        //         }
        //       ]
        //     }
        //   },
        //   {
        //     "id": "3",
        //     "dateOfBirth": dobArray[2],
        //     "name": {
        //       "firstName": firstNameArray[2],
        //       "lastName": lastNameArray[2]
        //     },
        //     "gender": genderArray[2],
        //     "contact": {
        //       "emailAddress": Passengerlist_EmailTxt.text,
        //       "phones": [
        //         {
        //           "deviceType": "MOBILE",
        //           "countryCallingCode": "33",
        //           "number": Passengerlist_phone_numtxt.text
        //         }
        //       ]
        //     }
        //   },
        //   {
        //     "id": "4",
        //     "dateOfBirth": dobArray[3],
        //     "name": {
        //       "firstName": firstNameArray[3],
        //       "lastName": lastNameArray[3]
        //     },
        //     "gender": genderArray[3],
        //     "contact": {
        //       "emailAddress": Passengerlist_EmailTxt.text,
        //       "phones": [
        //         {
        //           "deviceType": "MOBILE",
        //           "countryCallingCode": "33",
        //           "number": Passengerlist_phone_numtxt.text
        //         }
        //       ]
        //     }
        //   }
        //
        // ];
      } else  {
    print('5 adult checking....');

    travelersArray = <Map<String, dynamic>>[
    {
    "id": "1",
    "dateOfBirth": dobArray[0],
    "name": {
    "firstName": firstNameArray[0],
    "lastName": lastNameArray[0]
    },
    "gender": genderArray[0],
    "contact": {
    "emailAddress": Passengerlist_EmailTxt.text,
    "phones": [
    {
    "deviceType": "MOBILE",
    "countryCallingCode": "33",
    "number": Passengerlist_phone_numtxt.text
    }
    ]
    }
    },
    {
    "id": "2",
    "dateOfBirth": dobArray[1],
    "name": {
    "firstName": firstNameArray[1],
    "lastName": lastNameArray[1]
    },
    "gender": genderArray[1],
    "contact": {
    "emailAddress": Passengerlist_EmailTxt.text,
    "phones": [
    {
    "deviceType": "MOBILE",
    "countryCallingCode": "33",
    "number": Passengerlist_phone_numtxt.text
    }
    ]
    }
    },
    {
    "id": "3",
    "dateOfBirth": dobArray[2],
    "name": {
    "firstName": firstNameArray[2],
    "lastName": lastNameArray[2]
    },
    "gender": genderArray[2],
    "contact": {
    "emailAddress": Passengerlist_EmailTxt.text,
    "phones": [
    {
    "deviceType": "MOBILE",
    "countryCallingCode": "33",
    "number": Passengerlist_phone_numtxt.text
    }
    ]
    }
    },
    {
    "id": "4",
    "dateOfBirth": dobArray[3],
    "name": {
    "firstName": firstNameArray[3],
    "lastName": lastNameArray[3]
    },
    "gender": genderArray[3],
    "contact": {
    "emailAddress": Passengerlist_EmailTxt.text,
    "phones": [
    {
    "deviceType": "MOBILE",
    "countryCallingCode": "33",
    "number": Passengerlist_phone_numtxt.text
    }
    ]
    }
    },
      {
        "id": "5",
        "dateOfBirth": dobArray[4],
        "name": {
          "firstName": firstNameArray[4],
          "lastName": lastNameArray[4]
        },
        "gender": genderArray[4],
        "contact": {
          "emailAddress": Passengerlist_EmailTxt.text,
          "phones": [
            {
              "deviceType": "MOBILE",
              "countryCallingCode": "33",
              "number": Passengerlist_phone_numtxt.text
            }
          ]
        }
      }

    ];
    }

      print('travelersArray....');
      print(travelersArray);

    //}
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
                // "additionalServices": {
                //   "chargeableSeatNumber": selectedseat
                // },

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


            "travelers": travelersArray,

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

      print('order api list array....');

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
        print('Order Id..');
        print(OrderID);
        var associatedRecordsData = flightData['associatedRecords'];
        print('associatedRecords...');
        print(associatedRecordsData);
        for (var associatedRecordsArray in associatedRecordsData) {
          referencestr = associatedRecordsArray['reference'];
          // print('referencestr...');
          // print(referencestr);
        }

        //Traveller Types and traveller id's

        //travelerPricings
        // for (var priceArray in flightOffers) {
        //   //travelerPricings
        //   var travelerPricings_Array = priceArray['travelerPricings'];
        //   print('price Array...');
        //   print(travelerPricings_Array);
        //   for (var travelidArray in travelerPricings_Array) {
        //     String travelerId = '';
        //     travelerId = travelidArray['travelerId'];
        //     print('travelerId...');
        //     print(travelerId);
        //     travelerIdArray.add(travelerId);
        //     travelerTypestr = travelidArray['travelerType'];
        //     travelerTypeArray.add(travelerTypestr);
        //     print('travelerTypeArray...');
        //     print(travelerTypeArray);
        //
        //
        //
        //   }
        //   print('last travelerId...');
        //   print(travelerIdArray.last);
        // }


        var travelers = flightData['travelers'];
        // print('travelers...');
        // print(travelers);
        for (var travelersArray in travelers) {
          travellerId = travelersArray['id'];
          print('travellerId...');
          print(travellerId);
        }
        // Navigator.of(context, rootNavigator: true).pop();
        // Navigator.of(context)
        //     .push(new MaterialPageRoute(builder: (context) => Passenger_DetailsVC()));
        // setState((){
        //   //Navigator.pop(context);
        // });
        loginshowAlertDialog(context);

               // Navigator.of(context, rootNavigator: true).pop();
        // Navigator.of(context)
        //     .push(new MaterialPageRoute(builder: (context) => Passenger_DetailsVC()));
        // setState((){
        //   //Navigator.pop(context);
        // });
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => Passenger_DetailsVC()),
        // );
        // setState(() async{
        //
        //   Navigator.of(context, rootNavigator: true).pop();
        //   await Navigator.of(context)
        //       .push(new MaterialPageRoute(builder: (context) => OnwardJourneyPassengerListViewDetails()));
        //   setState((){
        //     Navigator.pop(context);
        //   });
       // });
        // setState(() async{
        //   Navigator.of(context, rootNavigator: true).pop();
        //   await Navigator.of(context)
        //       .push(new MaterialPageRoute(builder: (context) => OnwardJourneyPassengerListViewDetails()));
        //   setState((){
        //     Navigator.pop(context);
        //   });
        // });


        // for (var travelerstr in flightData) {
        //   var travelerstr_Array = travelerstr['travelers'];
        //   print('travelers...');
        //   print(travelerstr_Array);
        // }
      } else if (response.statusCode == 400) {
        final responseData = jsonDecode(response.body);
        var flighterror_Data = responseData['errors'];
        // print('flighterror_Data...');
        // print(flighterror_Data);
        for (var titledata in flighterror_Data) {
          var titlestr = titledata['title'];
          // print('titlestr...');
          // print(titlestr);
          var detail = titledata['detail'];
          if (titlestr == 'SEGMENT SELL FAILURE') {
            final snackBar = SnackBar(
              content: Text(titlestr + ' , ' +
                  'Please check flight details and try again'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            final snackBar = SnackBar(
              content: Text(detail + ' , ' + 'Please try again..'),
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


  //Post API calling...
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
        Future.delayed(Duration.zero, () async{
          setState(() {
           // _postData();
            print('order id receive2');
            print(OrderID);

          });
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('tokenkey', Abiniyatokenvalue);
          prefs.setInt('login_user_ID_key', login_user_ID);
          prefs.setString('OrderIDkey', OrderID);
          prefs.setString('travellerIdkey', travellerId);
          print('order id receive1');
          print(OrderID);
          prefs.setString('pricekey', totalprice);
          prefs.setString('reference_key', referencestr);
          prefs.setString('passenger_firstname_key', firstNamestr);
          prefs.setString('passenger_lastname_key', lastNamestr);
          prefs.setString('passenger_phone_key', Passengerlist_phone_numtxt.text);
          prefs.setString('passenger_email_key', Passengerlist_EmailTxt.text);
          prefs.setString('passenger_gender_key', genderstr);
          prefs.setString('passenger_dob_key', dobstr);
          prefs.setString('local_Flight_tokenkey', Abiniyatokenvalue);


          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => Passenger_DetailsVC()));
          setState((){
            //Navigator.pop(context);
          });
          //loginshowAlertDialog(context);
          //LoginshowAlertDialog(context);
          // _postData();
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
    } catch (e){
      print(e.toString());
    }
  }


  //LoginshowAlertDialog(context);




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
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 25,
                        width: 150,
                        color: Colors.blue,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            totalpricevalues,
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900,color:Colors.red),),
                        ),
                      ),

                      InkWell(
                        child: Container(
                            height: 25,
                            width: 150,
                            color: Colors.blue,
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                children: [

                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("    Fare summary",
                                      style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600,color: Colors.white),
                                      textAlign: TextAlign.center
                                  )),
                                Icon(Icons.keyboard_arrow_up,color: Colors.white,)

                                ],


                              )
                            )
                        ),
                        onTap: () async {
                          print('fare summary....');
                          PassengerListshowAlertDialog(context);
                          // showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return AlertDialog(
                          //         title: Text('Passengers Fare summary'),
                          //         content: setupAlertDialoadContainer(),
                          //
                          //
                          //       );
                          //     });
                          //_postData();

                          //LoginshowAlertDialog(context);
                        },

                      )
                    ],
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
                    _onDone();

                    //_postData();

                    //LoginshowAlertDialog(context);
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
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Column(
    //     children: <Widget>[
    //
    //       Text('Add Route Details',style: (TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.black54)),),
    //
    //       SizedBox(
    //         height: 100,
    //       ),
    //
    //       TextField(
    //           controller: routenameController,
    //           decoration: InputDecoration(labelText: 'Enter routename seperated by comma')),
    //       Expanded(
    //         child: ListView.builder(
    //           itemCount: cards.length,
    //           itemBuilder: (BuildContext context, int index) {
    //             return cards[index];
    //           },
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(16.0),
    //         child: TextButton(
    //           child: Text('add new'),
    //           onPressed: () => setState(() => cards.add(createCard())),
    //         ),
    //       )
    //     ],
    //   ),
    //   floatingActionButton:
    //   FloatingActionButton(child: Icon(Icons.done), onPressed: _onDone),
    // );
  }

}
class PersonEntry {
  final String name;
  // final String age;
  // final String studyJob;

  PersonEntry(this.name);
  @override
  String toString() {
    // print('str values..');
    // print(name);
    return 'Person: name= $name';
  }
}