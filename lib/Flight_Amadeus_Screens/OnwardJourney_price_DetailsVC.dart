
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

import 'BaggageDetails/BaggagedetailsVC.dart';
import 'Oneway_journey_update_PassengerslistVC.dart';
import 'OnwardJourney_NewpassengerlistVC.dart';
import 'OnwardJourney_PassengerlistVC.dart';
class OnwardJourney_Flight_Details extends StatefulWidget {
  const OnwardJourney_Flight_Details({super.key});

  @override
  State<OnwardJourney_Flight_Details> createState() => _userDashboardState();
}

class _userDashboardState extends State<OnwardJourney_Flight_Details> {
  final baseDioSingleton = BaseSingleton();
  bool isLoading = false;
  String flightTokenstr = '';
  List travelersArray = [];
  List travelersfareDetailsBySegmentArray = [];

  List Convert_segmentArray = [];
  List Convert_AirlineArray = [];
  var travelerPricingslistArray = [];
  var totalPricevaluesArray = [];
  var cabintrvalue_Array = [];
  List validatingAirlineCodestrArray = [];

  Map<String, dynamic> priceArray = {};
  Map<String, dynamic> includedCheckedBags = {};
  Map<String, dynamic> includedCabinBags = {};







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
  String segmentId = '';
  //Baggage
  int weight = 0;
  int quantity = 0;
  int Passengers_cnt = 0;
  //Cabin Baggage
  int Cabin_weight = 0;
  int Cabin_quantity = 0;

  String Baggagestr = '';
  String Cabin_Baggagestr = '';




  var flight_offer_Array = [];
  var OnwardJourney_Segmentrray = [];
  var Currency_Price_Array = [];
  String grandTotalprice = '';
  // var grand_totalPricevaluesArray = [];







  String selectedseat = '';
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

  var travelerIdArray = [];
  String travelerTypestr = '';
  var travelerTypeArray = [];



  late final  segmentDataArray;
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    CurrencyCodestr = prefs.getString('currency_code_dropdownvaluekey') ?? '';
    selectedseat = prefs.getString('selectedseatkey') ?? '';
    print('price screen seat');
    print(selectedseat);



    flight_ID = prefs.getString('flightid_key') ?? '';
    //prefs.setInt('Passengers_cntkey', Passengers_cnt) ?? 0;
    Passengers_cnt = prefs.getInt('Passengers_cntkey') ?? 0;
    print('1 price passengers cnt');
    print(Passengers_cnt);


    // print('flight_ID...');
    // print(flight_ID);
    sourcestr = prefs.getString('source_key') ?? '';
    lastTicketing_Datestr = prefs.getString('lastTicketing_Datekey') ?? '';
    lastTicketingDate_Timestr = prefs.getString('lastTicketingDate_Timekey') ?? '';
    numberOfBookableSeatsstr = prefs.getString('numberOfBookableSeatskey') ?? '';
    Careercodestr = prefs.getString('carrierCodekey') ?? '';
    airlinestr = prefs.getString('airlinekey') ?? '';
    logostr = prefs.getString('logokey') ?? '';
    // print('Careercodestr.....');
    // print(Careercodestr);
    RetrivedOneway_Oneway_Destinationiatacodestr = prefs.getString('Oneway_Destinationiatacodekey') ?? '';
    RetrivedOnew_Oneway_DestinationCitynamestr = prefs.getString('Oneway_DestinationCitynamekey') ?? '';
    Retrived_Oneway_iatacodestr = prefs.getString('Oneway_iatacodekey') ?? '';
    Retrived_Oneway_Citynamestr = prefs.getString('Oneway_Citynamekey') ?? '';

    // setState(() {
    //   final data = json.decode(RetrivedSegment_Array);
    //   for (var i in data) {
    //     Convert_segmentArray.add(i);
    //   }

    // });
    durationstr = prefs.getString('durationkey') ?? '';

    // prefs.setString('carrierCodekey', OnwardJourney_carrierCodeArray[index]);
    // prefs.setString('durationkey', durationArray[index]);

    //Flight search segment values retriving...
    //final RetrivedSegment_Array ;
    RetrivedSegment_Array = prefs.getString('Segmentkey') ?? '';

    validatingAirlineCodestr = prefs.getString('validatingAirlineCodeskey') ?? '';
    // print('validatingAirlineCodestr...');
    // print(validatingAirlineCodestr);
    validatingAirlineCodestrArray = json.decode(validatingAirlineCodestr);
    // print('validatingAirlineCodestrArray...');
    // print(validatingAirlineCodestrArray.first);

    //Baggage Data retrived
    //Baggage
    weight = prefs.getInt('weightkey') ?? 0;
    quantity = prefs.getInt('quantitykey') ?? 0;
    print('Retrived weight...');
    print(weight);
    print('Retrived quantity...');
    print(quantity);

    //Cabin Baggage
    // Cabin_weight = prefs.getInt('Cabin_weightkey') ?? 0;
    // print('Retrived Cabin_weight.... ');
    // print(Cabin_weight);
    // Cabin_quantity = prefs.getInt('Cabin_quantitykey') ?? 0;
    // print('Retrived Cabin_quantity.... ');
    // print(Cabin_quantity);



    //print(RetrivedSegment_Array);
    setState(() {
      final data = json.decode(RetrivedSegment_Array);
      for (var i in data) {
        Convert_segmentArray.add(i);
        // print('Convert_segmentArray....');
        // print(Convert_segmentArray);
      }
    });

    //travelerPricings values retrived

    final travelerPricings ;
    travelerPricings = prefs.getString('travelerPricingskey') ?? '';
    print('travelerPricings....');
    print(travelerPricings);





    // final Map<String, dynamic> tournament = {
    //       "travelerId": "1",
    //       "fareOption": "STANDARD",
    //       "travelerType": "ADULT",
    //       "price": {
    //         "currency": "USD",
    //         "total": "79.80",
    //         "base": "64.00"
    //       },
    //       "fareDetailsBySegment": [
    //         {
    //           "segmentId": "35",
    //           "cabin": "ECONOMY",
    //           "fareBasis": "UU1YXFII",
    //           "class": "U",
    //           "includedCheckedBags": {
    //             "weight": 15,
    //             "weightUnit": "KG"
    //           },
    //           "includedCabinBags": {
    //             "weight": 7,
    //             "weightUnit": "KG"
    //           },
    //           // "additionalServices": {
    //           //   "chargeableSeatNumber": "11D"
    //           // }
    //         }
    //       ]
    //     };




    // Map<String, dynamic> _portaInfoMap = {
    //   "noOfArticles": [
    //     travelerPricings,
    //     {"type": "web", "count": 75}
    //   ]
    // };
    setState(() {
      final data = json.decode(travelerPricings);
      for (var i in data) {
        convert_travelerPricingsArray.add(i);
      }
    });



    print('seat number...');
    print(selectedseat);
    convert_travelerPricingsArray[0]['fareDetailsBySegment']![0]["additionalServices"] = {
      "chargeableSeatNumber": selectedseat
    };
    print('');
    print(convert_travelerPricingsArray);

    travelersfareDetailsBySegmentArray = <Map<String, dynamic>>[

      // {
      //   "travelerId": "1",
      //   "fareOption": "STANDARD",
      //   "travelerType": "ADULT",
      //
      //    "price": priceArray,
      //convert_travelerPricingsArray....
      //   // "price": {
      //   //   "currency": "USD",
      //   //   "total": "79.80",
      //   //   "base": "64.00"
      //   // },
      //   "fareDetailsBySegment": [
      //     {
      //       "segmentId": "39",
      //       "cabin": "ECONOMY",
      //       "fareBasis": "UU1YXFII",
      //       "class": "U",
      //       "includedCheckedBags": {
      //         "weight": 15,
      //         "weightUnit": "KG"
      //       },
      //       "includedCabinBags": {
      //         "weight": 7,
      //         "weightUnit": "KG"
      //       },
      //       "additionalServices": {
      //         "chargeableSeatNumber": selectedseat
      //       }
      //     }
      //   ]
      // }

      {
        "travelerId": "1",
        "fareOption": "STANDARD",
        "travelerType": travelerTypestr,
        "price": priceArray,

        // "price": {
        //   "currency": "USD",
        //   "total": "79.90",
        //   "base": "64.00"
        // },
        "fareDetailsBySegment": [
          {
            "segmentId": segmentId,
            "cabin": cabintrvalue,
            "fareBasis": "UU1YXFII",
            "class": "U",
            "includedCheckedBags": includedCheckedBags,
            // "includedCheckedBags": {
            //   "weight": 15,
            //   "weightUnit": "KG"
            // },
            "includedCabinBags": includedCabinBags,
    "additionalServices": {
              "chargeableSeatNumber": selectedseat
            }
            // "includedCabinBags": {
            //   "weight": 7,
            //   "weightUnit": "KG"
            // }
          }
        ]
      }
    ];
    print('travelersfareDetailsBySegmentArray....');
    print(travelersfareDetailsBySegmentArray);



    prefs.setString('travelerPricingskey', travelerPricings);


    //currency and price values array retriving..
    final Retrived_Currency_PriceArray ;
    Retrived_Currency_PriceArray = prefs.getString('Currency_Pricekey') ?? '';
    print('p_Retrived_Currency_PriceArray...');
    print(Retrived_Currency_PriceArray);

    convert_Currency_PriceArray = jsonDecode(Retrived_Currency_PriceArray);
    // print('convert_Currency_PriceArray....');
    // print(convert_Currency_PriceArray);



    //FareRules
    final Retrive_fareRules ;
    Retrive_fareRules = prefs.getString('fareRuleskey') ?? '';
    print('price fareRuleskey...');
    print(Retrive_fareRules);
    if(Retrive_fareRules != ""){
      print('empty fare values....');
      // fareRulesArray = jsonDecode(Retrive_fareRules);
      // print('Retrive_fareRules....');
      // print(fareRulesArray);
    } else{
      fareRulesArray = jsonDecode(Retrive_fareRules);
      print('price Retrive_fareRules....');
      print(fareRulesArray);
    }

  }


//@override
  initState() {
    // TODO: implement initState
    super.initState();

    _retrieveValues();
    _postData();

    // Map<String, dynamic> _portaInfoMap = {
    //   "name": "Vitalflux.com",
    //   "domains": ["Data Science", "Mobile", "Web"],
    //   "noOfArticles": [
    //     {"type": "data science", "count": 50},
    //     {"type": "web", "count": 75}
    //   ]
    // };
    Map<String, dynamic> _portaInfoMap = {
      "name": "Vitalflux.com",
      "noOfArticles": [
        {"type": "data science", "count": 50},
        {"type": "web", "count": 75}
      ]
    };
    print('mapping...');
    print(_portaInfoMap);



    // for (var i=1; i<3; i++) {
    //   print('i values...');
    //   print(i);
    //
    //   var lst = <String>[]; // creates an empty list with the int data type
    //
    //   travelersArray = <Map<String, dynamic>>[
    //     {
    //       "id": i,
    //       "travelerType": "ADULT",
    //       "fareOptions": [
    //         "STANDARD"
    //       ],
    //     },
    //   ];

    //travelersArray.add(travellers);
    // List<String> strlist = travellers.cast<String>();

    // print('loop..');
    // print(travelersArray);
  }

  //return travellers;


  //_postData() async {
    //Future<dynamic> _postData(dynamic body) async {
      Future<void> _postData() async {
        setState(() {
          isLoading = true;
        });
        //tempList = List<String>();
        //List<String> tempList = [];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
        selectedseat = prefs.getString('selectedseatkey') ?? '';
        print('price screen seat');
        print(selectedseat);
        // print(' Details Onward journey token1...');
        // print(flightTokenstr);
        //{{API_URL}}/v1/shopping/flight-offers/pricing
        final response = await http.post(
          Uri.parse(
              'https://test.travel.api.amadeus.com/v1/shopping/flight-offers/pricing'),
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
              "type": "flight-offers-pricing",
              "flightOffers": [
                {
                  "type": "flight-offer",
                  "id": flight_ID,
                          "source": sourcestr,
                          "instantTicketingRequired": false,
                          "nonHomogeneous": false,
                          "oneWay": false,
                          "isUpsellOffer": false,
                          "lastTicketingDate": lastTicketing_Datestr,
                          "lastTicketingDateTime": lastTicketingDate_Timestr,
                          "numberOfBookableSeats": numberOfBookableSeatsstr,
                  // "id": "1",
                  // "source": "GDS",
                  // "instantTicketingRequired": false,
                  // "nonHomogeneous": false,
                  // "oneWay": false,
                  // "isUpsellOffer": false,
                  // "lastTicketingDate": "2024-09-19",
                  // "lastTicketingDateTime": "2024-09-19",
                  // "numberOfBookableSeats": 9,
                  "itineraries": [
                    {
                      // "duration": "PT2H55M",
                      //  "segments": se
                      "duration": durationstr,
                      "segments": Convert_segmentArray

                      // "segments": [
                      //   {
                      //     "departure": {
                      //       "iataCode": "BLR",
                      //       "terminal": "2",
                      //       "at": "2024-09-25T05:45:00"
                      //     },
                      //     "arrival": {
                      //       "iataCode": "DEL",
                      //       "terminal": "3",
                      //       "at": "2024-09-25T08:40:00"
                      //     },
                      //     "carrierCode": "AI",
                      //     "number": "804",
                      //     "aircraft": {
                      //       "code": "32N"
                      //     },
                      //     "operating": {
                      //       "carrierCode": "AI"
                      //     },
                      //     "duration": "PT2H55M",
                      //     "id": "39",
                      //     "numberOfStops": 0,
                      //     "blacklistedInEU": false
                      //   }
                      // ]
                    }
                  ],
                   "price": convert_Currency_PriceArray,
                  // "price": {
                  //   "currency": "USD",
                  //   "total": "79.80",
                  //   "base": "64.00",
                  //   "fees": [
                  //     {
                  //       "amount": "0.00",
                  //       "type": "SUPPLIER"
                  //     },
                  //     {
                  //       "amount": "0.00",
                  //       "type": "TICKETING"
                  //     }
                  //   ],
                  //   "grandTotal": "79.80"
                  // },
                  "pricingOptions": {
                    "fareType": [
                      "PUBLISHED"
                    ],
                    "includedCheckedBagsOnly": true
                  },
                  "validatingAirlineCodes": [
                    //"AI"
                    validatingAirlineCodestrArray.first
                  ],


                  "travelerPricings": convert_travelerPricingsArray,

                  // "travelerPricings": [
                  //   {
                  //     "travelerId": "1",
                  //     "fareOption": "STANDARD",
                  //     "travelerType": "ADULT",
                  //
                  //      "price": priceArray,
                  //
                  //     // "price": {
                  //     //   "currency": "USD",
                  //     //   "total": "79.80",
                  //     //   "base": "64.00"
                  //     // },
                  //     "fareDetailsBySegment": [
                  //       {
                  //         "segmentId": "39",
                  //         "cabin": "ECONOMY",
                  //         "fareBasis": "UU1YXFII",
                  //         "class": "U",
                  //         "includedCheckedBags": {
                  //           "weight": 15,
                  //           "weightUnit": "KG"
                  //         },
                  //         "includedCabinBags": {
                  //           "weight": 7,
                  //           "weightUnit": "KG"
                  //         },
                  //         "additionalServices": {
                  //           "chargeableSeatNumber": selectedseat
                  //         }
                  //       }
                  //     ]
                  //   }
                  // ],
                   "fareRules": fareRulesArray ?? ''
                  //   "rules": [
                  //     {
                  //       "category": "EXCHANGE",
                  //       "maxPenaltyAmount": "36.00"
                  //     },
                  //     {
                  //       "category": "REFUND",
                  //       "maxPenaltyAmount": "48.00"
                  //     },
                  //     {
                  //       "category": "REVALIDATION",
                  //       "notApplicable": true
                  //     }
                  //   ]
                  // }
                }
              ]
            }
          }
          // {
          //   "data": {
          //     "type": "flight-offers-pricing",
          //     "flightOffers": [
          //       {
          //         "type": "flight-offer",
          //         "id": flight_ID,
          //         "source": sourcestr,
          //         "instantTicketingRequired": false,
          //         "nonHomogeneous": false,
          //         "oneWay": false,
          //         "isUpsellOffer": false,
          //         "lastTicketingDate": lastTicketing_Datestr,
          //         "lastTicketingDateTime": lastTicketingDate_Timestr,
          //         "numberOfBookableSeats": numberOfBookableSeatsstr,
          //         "itineraries": [
          //           {
          //             "duration": durationstr,
          //              "segments": Convert_segmentArray
          //
          //
          //             // "segments": [
          //             //   {
          //             //     "departure": {
          //             //       "iataCode": "BLR",
          //             //       "terminal": "2",
          //             //       "at": "2024-07-23T11:30:00"
          //             //     },
          //             //     "arrival": {
          //             //       "iataCode": "DEL",
          //             //       "terminal": "3",
          //             //       "at": "2024-07-23T14:10:00"
          //             //     },
          //             //     "carrierCode": "AI",
          //             //     "number": "2816",
          //             //     "aircraft": {
          //             //       "code": "32N"
          //             //     },
          //             //     "operating": {
          //             //       "carrierCode": "AI"
          //             //     },
          //             //     "duration": "PT2H40M",
          //             //     "id": "1",
          //             //     "numberOfStops": 0,
          //             //     "blacklistedInEU": false
          //             //   }
          //             // ]
          //           }
          //         ],
          //
          //          "price": convert_Currency_PriceArray,
          //
          //         // "price": {
          //         //   "currency": "USD",
          //         //   "total": "205.00",
          //         //   "base": "169.00",
          //         //   "fees": [
          //         //     {
          //         //       "amount": "0.00",
          //         //       "type": "SUPPLIER"
          //         //     },
          //         //     {
          //         //       "amount": "0.00",
          //         //       "type": "TICKETING"
          //         //     }
          //         //   ],
          //         //   "grandTotal": "205.00"
          //         // },
          //         "pricingOptions": {
          //           "fareType": [
          //             "PUBLISHED"
          //           ],
          //           "includedCheckedBagsOnly": false
          //         },
          //         "validatingAirlineCodes": [
          //           //"AI"
          //           validatingAirlineCodestrArray.first,
          //         ],
          //          "travelerPricings": convert_travelerPricingsArray,
          //         "additionalServices": {
          //           "chargeableSeatNumber": selectedseat
          //         },
          //
          //
          //         // "travelerPricings": [
          //         //   {
          //         //     "travelerId": "1",
          //         //     "fareOption": "STANDARD",
          //         //     "travelerType": "ADULT",
          //         //     "price": {
          //         //       "currency": "USD",
          //         //       "total": "95.70",
          //         //       "base": "79.00"
          //         //     },
          //         //     "fareDetailsBySegment": [
          //         //       {
          //         //         "segmentId": "1",
          //         //         "cabin": "ECONOMY",
          //         //         "fareBasis": "UIP",
          //         //         "class": "U",
          //         //         "includedCheckedBags": {
          //         //           "weight": 15,
          //         //           "weightUnit": "KG"
          //         //         },
          //         //         "includedCabinBags": {
          //         //           "quantity": 0
          //         //         }
          //         //       }
          //         //     ]
          //         //   },
          //         //   {
          //         //     "travelerId": "2",
          //         //     "fareOption": "STANDARD",
          //         //     "travelerType": "CHILD",
          //         //     "price": {
          //         //       "currency": "USD",
          //         //       "total": "88.30",
          //         //       "base": "72.00"
          //         //     },
          //         //     "fareDetailsBySegment": [
          //         //       {
          //         //         "segmentId": "1",
          //         //         "cabin": "ECONOMY",
          //         //         "fareBasis": "UIPCH",
          //         //         "class": "U"
          //         //       }
          //         //     ]
          //         //   },
          //         //   {
          //         //     "travelerId": "3",
          //         //     "fareOption": "STANDARD",
          //         //     "travelerType": "HELD_INFANT",
          //         //     "associatedAdultId": "1",
          //         //     "price": {
          //         //       "currency": "USD",
          //         //       "total": "21.00",
          //         //       "base": "18.00"
          //         //     },
          //         //     "fareDetailsBySegment": [
          //         //       {
          //         //         "segmentId": "1",
          //         //         "cabin": "ECONOMY",
          //         //         "fareBasis": "UIPIN",
          //         //         "class": "U"
          //         //       }
          //         //     ]
          //         //   }
          //         // ],
          //          "fareRules": fareRulesArray ?? ''
          //
          //
          //         // "fareRules": {
          //         //   "rules": [
          //         //     {
          //         //       "category": "EXCHANGE",
          //         //       "maxPenaltyAmount": "36.00"
          //         //     },
          //         //     {
          //         //       "category": "REFUND",
          //         //       "maxPenaltyAmount": "48.00"
          //         //     },
          //         //     {
          //         //       "category": "REVALIDATION",
          //         //       "notApplicable": true
          //         //     }
          //         //   ]
          //         // }
          //       }
          //     ]
          //   }
          // }


          ),
        );

        print('Details array....');

        print(response.statusCode);
        if (response.statusCode == 200) {
          // Successful POST request, handle the response here
          final responseData = jsonDecode(response.body);
          // print('suresh detailes data...');
          // print(responseData);
          var flightData = responseData['data'];
          // print('Response data...');
          // print(flightData);

          var flightOffers = flightData['flightOffers'];
          print('flightOffers...');
          print(flightOffers);
          flight_offer_Array.add(flightOffers);
          for(var itinerariesValues in flightOffers){
            var itinerariesArray = itinerariesValues['itineraries'];
            // print('segmentsvalues...');
            // print(itinerariesArray);
            for(var segmentvalues in itinerariesArray){
              var SegmentArray = segmentvalues['segments'];
              // print('SegmentArray...');
              // print(SegmentArray);
              for(var DeparturArray in SegmentArray){
                var Dep = DeparturArray['departure'] ?? "";
                var depiataCodestr = Dep['iataCode'];
                // print('depiataCodestr..');
                // print(depiataCodestr);
                if(depiataCodestr == Retrived_Oneway_iatacodestr){
                  depiataCode = Dep['iataCode'];
                  // print('depiataCode.......');
                  // print(depiataCode);

                  var departuretime = Dep['at'];
                  Deptimeconvert =
                  (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                  Datestr =
                  (new DateFormat.yMd().format(DateTime.parse(departuretime)));

                }

                // OnwardJourney_dateArray.add(Datestr);
                // OnwardJourney_DeptimeArray.add(Deptimeconvert);
                Depterminal = Dep['terminal'] ?? "";
                // print('dep terminal...');
                // print(Depterminal);

              }
              for(var ArraivalArray in SegmentArray){
                var Arrival = ArraivalArray['arrival'] ?? "";
                var arrivalstr = Arrival['iataCode'];

                if(arrivalstr == RetrivedOneway_Oneway_Destinationiatacodestr){
                  arrivalCode = Arrival['iataCode'];
                  // print('arrivalCode...');
                  // print(arrivalCode);
                  var Arrivaltime = Arrival['at'];
                  Arrivaltimeconvert =
                  (new DateFormat.Hm().format(DateTime.parse(Arrivaltime)));
                  Datestr =
                  (new DateFormat.yMd().format(DateTime.parse(Arrivaltime)));
                }
                // print('arrivalCode...');
                // print(arrivalCode);
                Arrivalterminal = Arrival['terminal'] ?? "";
                // print('arrival terminal...');
                // print(Arrivalterminal);
                var Arrivaltime = Arrival['at'];
                Arrivaltimeconvert =
                (new DateFormat.Hm().format(DateTime.parse(Arrivaltime)));
                Datestr =
                (new DateFormat.yMd().format(DateTime.parse(Arrivaltime)));
                // OnwardJourney_dateArray.add(Datestr);
                // OnwardJourney_DeptimeArray.add(Deptimeconvert);
              }
            }
            //for(var Currency_Price in flightData){
            for(var GrandtotalpriceArray in flightOffers){
              var Currency_Pricestr = GrandtotalpriceArray['price'];
              print('price Currency_Pricestr...');
              print(Currency_Pricestr);
              grandTotalprice = Currency_Pricestr['grandTotal'];
              print('grandTotalprice...');
              print(grandTotalprice);
              Currency_Price_Array.add(Currency_Pricestr);
            }



            //travelerPricings
            for (var priceArray in flightOffers) {
              //travelerPricings
              var travelerPricings_Array = priceArray['travelerPricings'];
              print('passenger price Array...');
              print(travelerPricings_Array);
              for (var price in travelerPricings_Array) {
                var priceArray = price['price'];
                print('passenger priceArray....');
                print(priceArray);
                totalpricevalues = priceArray['total'];
                print('passenger total amt..');
                print(totalpricevalues);
                totalPricevaluesArray.add(totalpricevalues);
                print(totalPricevaluesArray);
              }

              for (var priceArray in flightOffers) {
                //travelerPricings
                var travelerPricings_Array = priceArray['travelerPricings'];
                print('price Array...');
                print(travelerPricings_Array);
                for (var travelidArray in travelerPricings_Array) {
                  String travelerId = '';
                  travelerId = travelidArray['travelerId'];
                  print('travelerId...');
                  print(travelerId);
                  travelerIdArray.add(travelerId);
                  travelerTypestr = travelidArray['travelerType'];
                  travelerTypeArray.add(travelerTypestr);
                  print('travelerTypeArray...');
                  print(travelerTypeArray);
                }
                print('last travelerId...');
                print(travelerIdArray.last);
              }


              travelerPricingslistArray.add(travelerPricings_Array);
              List filterpriceArray = travelerPricings_Array.where((
                  o) => o['travelerId'] == '1').toList();
              // print('filtered...');
              // print(filterpriceArray);
              for (var price in filterpriceArray) {
               // var priceArray = price['price'];
                // print('total price value..');
                // print(priceArray);
                // totalpricevalues = priceArray['total'];
                // print('total amt..');
                // print(totalpricevalues);
                // totalPricevaluesArray.add(totalpricevalues);
                var cabin_class_array = price['fareDetailsBySegment'];
                // print('cabin_class_array..');
                // print(cabin_class_array);
                for(var cabinvalueArray in cabin_class_array){
                  cabintrvalue = cabinvalueArray['cabin'];
                  // print('cabin value...');
                  // print(cabintrvalue);
                  cabintrvalue_Array.add(cabintrvalue);
                }
              }
            }

          }
        }
        else {
          // throw Exception("Failed to load Dogs Breeds.");
          final snackBar = SnackBar(
            content: Text('failed!,please try again'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        setState(() {
          isLoading = false;
        });
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
                      'Flight Details Summary', textAlign: TextAlign.center,
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
                      new Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 6.0),
                        child: Container(
                            width: 320,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50.0,
                              child: Image.asset(
                                  "images/aeroplane_image.png",
                                  height: 125.0,
                                  width: 320.0,
                                  fit: BoxFit.fill
                              ),
                            )
                        ),
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

                              if(quantity >= 0 && weight == 0){
                                print('quantity wise');
                                Baggagestr = quantity.toString() + ' ' + 'Piece';

                              } else {
                                print('kg wise');
                                Baggagestr = weight.toString() + ' ' + 'kg per person';
                              }
                              // if(Cabin_quantity != ''){
                              //   print('Cabin_quantity wise');
                              //   Cabin_Baggagestr = Cabin_quantity.toString() + ' ' + 'Piece';
                              //
                              // }else{
                              //   print(' Cabinkg wise');
                              //   Cabin_Baggagestr = Cabin_weight.toString() + ' ' + 'KG';
                              // }
                              Departuretextstr = 'Departure To ' + ' '+  RetrivedOneway_Oneway_Destinationiatacodestr;

                              flight_departurests = 'Price per passenger, taxes and fees included';
                               trimedDuration = durationstr.substring(2);

                              if(CurrencyCodestr == "USD"){
                                //totalpricevalues = totalPricevaluesArray[index].toString();
                                //print("I have \$$dollars."); // I have $42.
                                // totalpriceSignvalues = "\$$totalpricevalues";
                                totalpriceSignvalues = "\USD $grandTotalprice";
                              } else {
                               // totalpricevalues = totalPricevaluesArray[index].toString();
                                totalpriceSignvalues = "\ZAR $grandTotalprice";
                              }
                              return SingleChildScrollView(
                                physics: ScrollPhysics(),
                                child: Column(
                                  children: <Widget>[
                                    //Text('Your Apartments'),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      height: 850,
                                      width: 320,
                                      child: Column(
                                        children: [

                                          SizedBox(
                                            height: 5,
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              Departuretextstr,
                                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              flight_departurests,
                                              style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                          ),
                                          Container(
                                            height: 750,
                                            width: 320,
                                            color: Colors.white10,
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 65,
                                                  width: 320,
                                                  color: Colors.grey,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Container(
                                                        height: 50,
                                                        width: 300,
                                                        child: Text(depiataCode + '---> ' + arrivalCode,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black
                                                        )
                                                        )
                                                      ),
                                                    ],
                                                  ),
                                                  ),
                                                SizedBox(height: 2,),
                                                Container(
                                                    height: 380,
                                                    width: 320,
                                                    color: Colors.black12,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 350,
                                                        width: 320,
                                                        color: Colors.transparent,
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              margin: const EdgeInsets.only(left: 10.0, right: 0.0),
                                                              height: 350,
                                                              width: 80,
                                                              color: Colors.transparent,
                                                              child: Column(
                                                                children: [
                                                                  Text(depiataCode,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                  ),),

                                                                  SizedBox(height: 10,),
                                                                  Text(Deptimeconvert,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                  ),),

                                                                  SizedBox(
                                                                    height: 100,
                                                                  ),

                                                                  Text(trimedDuration,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                  ),),
                                                                  SizedBox(
                                                                    height: 100,
                                                                  ),
                                                                  Text(Arrivaltimeconvert,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                  ),),
                                                                  Text(arrivalCode,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                  ),),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                                                              height: 350,
                                                              width: 30,
                                                              color: Colors.transparent,
                                                              child:Container(
                                                                  width: 40,
                                                                  child: CircleAvatar(
                                                                    backgroundColor: Colors.transparent,
                                                                    radius: 50.0,
                                                                    child: Image.asset(
                                                                        "images/flight-path-icon.png",
                                                                        height: 300.0,
                                                                        width: 300.0,
                                                                        fit: BoxFit.fill
                                                                    ),
                                                                  )
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: const EdgeInsets.only(left: 0.0, right: 0.0),

                                                              height: 350,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              child: Column(
                                                                children: [
                                                                  Align(
                                                                    alignment: Alignment.topLeft,
                                                                    child: Text(
                                                                      Retrived_Oneway_iatacodestr,
                                                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                                                  ),
                                                                  Align(
                                                                    alignment: Alignment.topLeft,
                                                                    child: Text(
                                                                      Retrived_Oneway_Citynamestr,
                                                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                                                  ),

                                                                  Container(
                                                                    height: 50,
                                                                    width: 220,
                                                                    color: Colors.transparent,
                                                                    child: Text('Terminal:' + "   " + Depterminal,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                                                                  ),

                                                                  Container(
                                                                    alignment: FractionalOffset.centerLeft,

                                                                    height: 135,
                                                                    width: 200,
                                                                    color: Colors.transparent,
                                                                    child: Column(
                                                                      children: [
                                                                        SizedBox(
                                                                          width: 0,
                                                                        ),
                                                                        Container(
                                                                          alignment: FractionalOffset.centerLeft,

                                                                          height: 70,
                                                                          width: 130,
                                                                          //margin: new EdgeInsets.symmetric(vertical: 5.0),
                                                                          decoration: BoxDecoration(
                                                                              image: DecorationImage(image: NetworkImage(logostr),
                                                                                  fit: BoxFit.cover)
                                                                          ),
                                                                        ),
                                                                        SizedBox(width: 0,),
                                                                        Container(
                                                                          height: 45,
                                                                          width: 140,
                                                                          color: Colors.transparent,
                                                                          child:  Text(airlinestr + "   -" + Careercodestr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                          ),),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment: Alignment.topLeft,
                                                                    child: Text(
                                                                      RetrivedOneway_Oneway_Destinationiatacodestr,
                                                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                                                  ),
                                                                  Align(
                                                                    alignment: Alignment.topLeft,
                                                                    child: Text(
                                                                      RetrivedOnew_Oneway_DestinationCitynamestr,
                                                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                                                  ),
                                                                  Align(
                                                                    alignment: Alignment.topLeft,
                                                                    child: Text('Terminal:' + "   " + Arrivalterminal,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Container(
                                              height: 150,
                                              width: 320,
                                              color: Colors.black12,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    width: 320,
                                                    color: Colors.grey,
                                                    child:Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        "Baggage allowance",
                                                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      'Checked baggage: ' + ' '+ Baggagestr,
                                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800,color: Colors.black45),),
                                                  ),
                                                  // SizedBox(
                                                  //   height: 5,
                                                  // ),
                                                  // Align(
                                                  //   alignment: Alignment.centerLeft,
                                                  //   child: Text(
                                                  //     'Cabin baggage: ' + ' '+ Cabin_Baggagestr ?? 'Info unaailable,please check with airline',
                                                  //     style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800,color: Colors.black45),),
                                                  // ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      'Ticketing: ' + ' '+ 'Within 2 hours after payment',
                                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800,color: Colors.black45),),
                                                  ),



                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  InkWell(
                                                    child: Container(
                                                        height: 30,
                                                        width: 320,
                                                        color: Colors.transparent,
                                                        child: Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              "Baggage &Policy Details",
                                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900,color: Colors.blue),
                                                              textAlign: TextAlign.center
                                                          ),
                                                        )
                                                    ),
                                                    onTap: () async {
                                                      print('continue btn tapped....');
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => BaggageDetailsVC()),
                                                      );
                                                    },
                                                  )
                                                ],
                                              ),
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
                                                            totalpriceSignvalues,
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
                                                                  "Book",
                                                                  style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w900,color: Colors.white),
                                                                  textAlign: TextAlign.center
                                                              ),
                                                            )
                                                        ),
                                                        onTap: () async {
                                                          print('continue btn tapped....');
                                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                                          prefs.setString('totalpriceSignvalueskey', (totalpriceSignvalues));
                                                          prefs.setString('pricekey', (totalpricevalues));


                                                          String SegmentData = jsonEncode(Convert_segmentArray);
                                                          prefs.setString('segmentlistkey', SegmentData);
                                                           prefs.setString('flight_offer_Array_key', (flight_offer_Array.toString()));
                                                          // print('SegmentData...');
                                                         // print(Convert_segmentArray);

                                                          prefs.setString('flightid_key', flight_ID);
                                                          prefs.setString('source_key', sourcestr);
                                                          prefs.setString('lastTicketing_Datekey', lastTicketing_Datestr);
                                                          prefs.setString('lastTicketingDate_Timekey', lastTicketingDate_Timestr);
                                                          prefs.setString('numberOfBookableSeatskey', numberOfBookableSeatsstr);
                                                          prefs.setString('carrierCodekey', Careercodestr);
                                                          prefs.setString('durationkey', durationstr);
                                                          prefs.setInt('Passengers_cntkey', Passengers_cnt);

                                                          //Passengers_cnt = prefs.getInt('Passengers_cntkey') ?? 0;
                                                          print('2 price passengers cnt');
                                                          print(Passengers_cnt);
                                                          //String segJson = jsonEncode(OnwardJourney_Segmentrray.toString());


                                                          String segJson = jsonEncode(Convert_segmentArray);
                                                          prefs.setString('Segmentkey', segJson);
                                                          //Convert_segmentArray
                                                          //prefs.setString('Segmentkey', Convert_segmentArray.toString());
                                                          // print('----------seg');
                                                          // print(Convert_segmentArray);

                                                          String convert_travelerPricingJson = jsonEncode(convert_travelerPricingsArray);
                                                          prefs.setString('order_travelerPricingkey', convert_travelerPricingJson);
                                                          //Convert_segmentArray
                                                          //prefs.setString('Segmentkey', Convert_segmentArray.toString());
                                                          // print('----------order_travelerPricingkey');
                                                          // print(convert_travelerPricingsArray);




                                                          // String Currency_Price = jsonEncode(Currency_Price_Array[index]);
                                                          // prefs.setString('Currency_Pricekey', Currency_Price);
                                                          print('Currency_Price_Array....');
                                                          print(Currency_Price_Array.first);
                                                          String convert_Currency_PriceArrayJson = jsonEncode(Currency_Price_Array.first);
                                                          prefs.setString('convert_Currency_PriceArraykey', convert_Currency_PriceArrayJson);
                                                          print('----------convert_Currency_PriceArrayJson');
                                                          print(convert_Currency_PriceArrayJson);
                                                          String fareRulesstr = jsonEncode(fareRulesArray);
                                                          print('price fareRulesstr....');
                                                          print(fareRulesstr);
                                                          prefs.setString('fareRuleskey', fareRulesstr);
                                                          prefs.setString('validatingAirlineCodeskey', validatingAirlineCodestr);


                                                          //Traveller Type
                                                          String TravellertypejsonParsing = jsonEncode(travelerTypeArray);
                                                          // print('segJson...');
                                                          // print(segJson);
                                                          prefs.setString('TravellertypejsonParsingkey', TravellertypejsonParsing);

                                                          String priceArray = jsonEncode(totalPricevaluesArray);
                                                          // print('segJson...');
                                                          // print(segJson);
                                                          prefs.setString('priceArrayjsonParsingkey', priceArray);


                                                          //
                                                          //
                                                          // String travelerPricings = jsonEncode(travelerPricingslistArray);
                                                          // prefs.setString('travelerPricingskey', travelerPricings);
                                                          // String Currency_Price = jsonEncode(Currency_Price_Array);
                                                          // prefs.setString('Currency_Pricekey', Currency_Price);
                                                          // String fareRulesstr = jsonEncode(fareRulesArray);
                                                          // prefs.setString('fareRuleskey', fareRulesstr);
                                                          // // prefs.setString('airlinekey', convertedAirlineArray.toString());
                                                          // // prefs.setString('logokey', AirlinelogoArray[index]);
                                                          //
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => Multiple_passengerlistVC()),
                                                          );
                                                          },
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
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
