
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

import 'OnwardJourney_price_DetailsVC.dart';
import 'SeatMap/seatMapVC.dart';
class FlightOnWardTrip extends StatefulWidget {
  const FlightOnWardTrip({super.key});

  @override
  State<FlightOnWardTrip> createState() => _userDashboardState();
}

class _userDashboardState extends State<FlightOnWardTrip> {
  final baseDioSingleton = BaseSingleton();

  int bookingID = 0;
  int numberOfBookableSeats = 0;
  String totalpricevalues = '';
  String totalpriceSignvalues = '';
  List travelersArray = [];
  var travelerIdArray = [];


  List animalArray = [];
  String grandTotalprice = '';
  var grand_totalPricevaluesArray = [];



  var totalPricevaluesArray = [];
  List flight_offerResponse = [];
  var flight_offerResponse_mutable = [];






  var API = '';
  String status = '';
  int _counter = 0;
  int idnum = 0;
  String Date = '';
  int selectedIndex = 0;
  int imageID = 0;
  String citystr = '';
  String RetrivedPwd = '';
  String RetrivedEmail = '';
  String RetrivedBearertoekn = '';
  String Bookingsts = 'Not booked yet!';
  String Statusstr = '';
  String stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
  String stsId = '';
  int VehicleId = 0;
  var controller = ScrollController();
  late Future<List<DashboardApart>> BookingDashboardUsers ;
  int count = 15;
  int Passengers_cnt = 0;

  String flightTokenstr = '';
  String carrierCodestr = '';
  String Airlinecodestr = '';
  String Airlinenamestr = '';
  String Airlinelogostr = '';
  String Retrived_Oneway_iatacodestr = '';
  String Retrived_Oneway_Citynamestr = '';
  String RetrivedOneway_Oneway_Destinationiatacodestr = '';
  String RetrivedOnew_Oneway_DestinationCitynamestr = '';
  String AmadeusAPI_Careercode = '';
  String Oneway_From_Datestr = '';
  String FlightResponsestr = '';
  String cabintrvalue = '';
  String Travel_class_str = '';
  String failurestr = '';



  var cabintrvalue_Array = [];
  var AirportListArray = [];
  var convertedAirlineArray = [];
  var AirlinelogoArray = [];
  var OnwardJourney_postrequestrequestAPI = [];
  var OnwardJourneylist = [];
  var OnwardJourney_depiataCodelist = [];
  var OnwardJourney_arrivaliataCodelist = [];
  var OnwardJourney_DeptimeArray = [];
  var OnwardJourney_ArrivaltimeArray = [];
  var OnwardJourney_dateArray = [];
  var OnwardJourney_durationArray = [];
  var OnwardJourney_carrierCodeArray = [];
  var OnwardJourney_airlineCodeArray = [];
  var OnwardJourney_airlineNameArray = [];
  var OnwardJourney_airlineLogoArray = [];
  var OnwardJourney_Segmentrray = [];
  var Currency_Price_Array = [];
  var fareRulesArray = [];
  var travelerPricingslistArray = [];





  var FlightEmptyArray = [];
  var flightstatusstr = '';
  var Departuretextstr = '';
  var flight_departurests = '';
  bool isLoading = false;

  var Static_Airline_code_array = [];
  var Static_Airline_name_array = [];
  var priceArray = [];
  var flightoffer_ID_Array = [];
  var lastTicketingDateArray = [];
  var lastTicketingDateTimeArray = [];
  var sourceArray = [];
  var numberOfBookableSeatsArray = [];
  var durationArray = [];
  var validatingAirlineCodesArrayList = [];













  //List<Map<String, dynamic>> mapList = [];
  // Map<String, dynamic> travellers = {};
  String sourcevalue = '';
  String flightoffer_ID = '';
  List<dynamic> travellers = [];
  List returnedList = [];
  List Connectflightcnt_dep = [];
  List Connectflightcnt_Arrival = [];
  String Connectedflightstr = '';





  //Inside widget string values
  String airlinestring = '';
  String departuretimestr = '';
  String arrivaltimestr = '';
  String durationtimestr = '';
  String departureiatacodestr = '';
  String arrivaliatacodestr = '';
  String CareerCountrycodestr = '';
  String Datastr = '';
  String logostr = '';
  String Deptimeconvert = '';
  String arrivalcode = '';
  String Datestr = '';
  String depiataCode = '';
  String CurrencyCodestr = '';
  int weight = 0;
  String weightUnitstr = '';
  int quantity = 0;
  int Cabin_weight = 0;
  String Cabin_weightUnitstr = '';
  int Cabin_quantity = 0;
  int Aduld_cnt = 0;
  int children_cnt = 0;
  int infant_cnt = 0;






  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // RetrivedEmail = prefs.getString('emailkey') ?? "";
      // RetrivedPwd = prefs.getString('passwordkey') ?? "";
      // RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      // VehicleId = prefs.getInt('userbookingId') ?? 0;
      CurrencyCodestr = prefs.getString('currency_code_dropdownvaluekey') ?? '';
      // print('Currency code value...');
      // print(CurrencyCodestr);
      Travel_class_str = prefs.getString('travel_classstr') ?? '';
      flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
      // print('Onward journey token...');
      // print(flightTokenstr);

      Oneway_From_Datestr = prefs.getString('from_Datekey') ?? '';
      // print('date calling...');
      // print(Oneway_From_Datestr);

      Retrived_Oneway_iatacodestr = prefs.getString('Oneway_iatacodekey') ?? '';
      Retrived_Oneway_Citynamestr = prefs.getString('Oneway_Citynamekey') ?? '';
      // print('received values in onward...');
      // print(Retrived_Oneway_iatacodestr);
      // print(Retrived_Oneway_Citynamestr);

      RetrivedOneway_Oneway_Destinationiatacodestr = prefs.getString('Oneway_Destinationiatacodekey') ?? '';
      RetrivedOnew_Oneway_DestinationCitynamestr = prefs.getString('Oneway_DestinationCitynamekey') ?? '';

      //Passengerlist
      Aduld_cnt = prefs.getInt('Adult_countkey') ?? 0;
      print('adult cnt...');
      print(Aduld_cnt);
      children_cnt = prefs.getInt('_childrenscounterKey') ?? 0;
      print('children_cnt...');
      print(children_cnt);

      infant_cnt = prefs.getInt('_infantcounter') ?? 0;

      // print('infant_cnt...');
      // print(infant_cnt);
      // if(Aduld_cnt >= 1 && children_cnt == 0 && infant_cnt == 0) {
      //   print('adults.....');
      //
      // } else if(Aduld_cnt == 1 && children_cnt == 1 && infant_cnt == 1) {
      // print('1 adult,1 child and 1 infant');
      //
      // } else {
      // print('1 adult,2 child and 1 infant');
      //
      // }
      // print('received values in dest onward...');
      // print(RetrivedOneway_Oneway_Destinationiatacodestr);
      // print(RetrivedOnew_Oneway_DestinationCitynamestr);



    });
  }




//@override
  initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();


    _postData();
    setState(() {
      getUserDetails();
    });


    Map<String, dynamic> _portaInfoMap = {
      "name": "Vitalflux.com",
      "domains": ["Data Science", "Mobile", "Web"],
      "noOfArticles": [
        {"type": "data science", "count": 50},
        {"type": "web", "count": 75}
      ]
    };

    List listvalues = [];
    for (var i = 0; i < 5; i++) {
      listvalues.add(i);
    }
    print('values....');
    print(listvalues);
    //return Column(children: list);


    // var list = ["one", "two", "three", "four"];
    //
    // for (var name in list) {
    //   return Text(name);
    // }


    List<dynamic> datalistArray = [];
  //   for (var i = 1; i <= 2; i++) {
  //     print('i value...');
  //     print(i);
  //     if(i == 1) {
  //         travelersArray = <Map<String, dynamic>>[
  //           {
  //             "id": "1",
  //             "travelerType": 'ADULT',
  //             "fareOptions": [
  //               "STANDARD"
  //             ],
  //           },
  //         ];
  //     } else {
  //       travelersArray = <Map<String, dynamic>>[
  // {
  //   "id": "1",
  //   "travelerType": 'ADULT',
  //   "fareOptions": [
  //   "STANDARD"
  //   ]
  //
  //           },
  //
  //         {
  //           "id": "2",
  //           "travelerType": 'ADULT',
  //           "fareOptions": [
  //             "STANDARD"
  //           ]
  //         }
  //
  //       ];
  //     }
  //
  //     print('travelersArray....');
  //     print(travelersArray);
  //     // traveller_datalistArray.add(travelersArray.first);
  //     // print('data list arrray......');
  //     // print(traveller_datalistArray);
  //   }
    //
    // // for (var i=1; i<=2; i++) {
    // //   travelersArray = <Map<String, dynamic>>[
    // //     {
    // //       "id": i,
    // //       "travelerType": 'Adult',
    // //       "fareOptions": [
    // //         "STANDARD"
    // //       ],
    // //     },
    // //   ];
    // //   print('travelersArray....');
    // //   print(travelersArray.toString());
    // //
    // //   datalistArray.add(travelersArray.first);
    // //   print('data list arrray......');
    // //   print(datalistArray.toString());
    // //   // String encodedData = jsonEncode(travelersArray.map((e) => e.toJson()).toList());
    // //   // print('encodedData....');
    // //   // print(encodedData);
    // //
    // //
    // //
    // //
    // // }
    //
    // print('out side area travelersArray....');
    // print(travelersArray.toString());
    //
    // datalistArray.add(travelersArray.first);
    // print('out side data list arrray......');
    // print(datalistArray.toString());
    //
    // var json = '{"id":1,"tags":["a","b","c"]}';
    // var data = jsonDecode(json);
    //
    // List<dynamic> rawTags = data['tags'];
    //
    // List<String> tags = rawTags.map(
    //       (item) {
    //     return item as String;
    //   },
    // ).toList();
    //
    // print('tags...');
    // print(tags);
    //
    //
    //
    //
    // var animalsttest = [
    //   {
    //     "0": ["cow", "chicken", "Fish"]
    //   }
    // ];
    // for (final a in animalsttest) {
    //   for (final x in a.values) {
    //     for (final y in x.asMap().entries) {
    //       print('animalsttest....');
    //
    //       print('${y.key + 1}. ${y.value}');
    //     }
    //   }
    // }
    //
    //
    //
    //
    //
    //
    //
    // // List<dynamic> ListData =
    // // [{"question_id":1,"option_id":2},
    // //   {"question_id":2,"option_id":6}];
    // //
    // // var json = {
    // //   'listKey': json.encode(ListData)
    // // }
    //
    //
    //
    //
    // List<dynamic> animals = [
    //   {
    //     "0": ["cow", "chicken"]
    //   },
    // ];
    // var adults = '';
    // for (var i=1; i<=2; i++) {
    //   for (final a in animals) {
    //     for (final x in a.values) {
    //       for (final y in x
    //           .asMap()
    //           .entries) {
    //         print('animal values...');
    //         print('${y.value}');
    //         adults = ('${y.value}');
    //         print(adults);
    //
    //         var array = [];
    //         array.add(adults);
    //         print('array....');
    //         print(array.toString());
    //         travelersArray = <Map<String, dynamic>>[
    //           {
    //             "id": i,
    //             "travelerType": array.toString(),
    //             "fareOptions": [
    //               "STANDARD"
    //             ],
    //           },
    //         ];
    //       }
    //     }
    //
    //
    //
    //     print('passenger list...');
    //     print(travelersArray);
    //
    //     //travelersArray.add(travellers);
    //     // List<String> strlist = travellers.cast<String>();
    //
    //     // print('loop..');
    //     // print(travelersArray);
    //   }
    // }
    //return travellers;
  }

  Future<dynamic> getUserDetails() async {
    String baseUrl = 'https://staging.abisiniya.com/api/v1/amadeus/airlinelist';
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {

      var jsonData = json.decode(response.body);
      // print('Airport list.....');
      var data = jsonData['data'];
      AirportListArray.add(data);
      setState(() {
        AirportListArray.add(data);
      });
      //return json.decode(response.body);
    }
  }


 // _postData() async{
    //Future<dynamic> _postData(dynamic body) async {
      Future<void> _postData() async {

        SharedPreferences prefs = await SharedPreferences.getInstance();

        Aduld_cnt = prefs.getInt('Adult_countkey') ?? 0;
        print('adult cnt...');
        print(Aduld_cnt);
        children_cnt = prefs.getInt('_childrenscounterKey') ?? 0;
        print('children_cnt...');
        print(children_cnt);

        infant_cnt = prefs.getInt('_infantcounter') ?? 0;
        print('infant_cnt...');
        print(infant_cnt);

        //for (var i = 1; i <= Aduld_cnt; i++) {
          //Passengerlist
          print('i value...');
          print(Aduld_cnt);


          if(Aduld_cnt >= 1 && children_cnt == 0 && infant_cnt == 0) {
            print('first adult checking....');

            if (Aduld_cnt == 1) {
              print('first adult checking....');

              travelersArray = <Map<String, dynamic>>[
                {
                  "id": "1",
                  "travelerType": 'ADULT',
                  "fareOptions": [
                    "STANDARD"
                  ],
                },
              ];
            } else if (Aduld_cnt == 2) {
              print('second adult checking....');

              travelersArray = <Map<String, dynamic>>[
                {
                  "id": "1",
                  "travelerType": 'ADULT',
                  "fareOptions": [
                    "STANDARD"
                  ]
                },

                {
                  "id": "2",
                  "travelerType": 'ADULT',
                  "fareOptions": [
                    "STANDARD"
                  ]
                }

              ];
            } else if (Aduld_cnt == 3) {
              print('second adult checking....');

              travelersArray = <Map<String, dynamic>>[
                {
                  "id": "1",
                  "travelerType": 'ADULT',
                  "fareOptions": [
                    "STANDARD"
                  ]
                },

                {
                  "id": "2",
                  "travelerType": 'ADULT',
                  "fareOptions": [
                    "STANDARD"
                  ]
                },
                {
                  "id": "3",
                  "travelerType": 'ADULT',
                  "fareOptions": [
                    "STANDARD"
                  ]
                }

              ];
            } else if (Aduld_cnt == 4) {
              print('second adult checking....');

              travelersArray = <Map<String, dynamic>>[
                {
                  "id": "1",
                  "travelerType": 'ADULT',
                  "fareOptions": [
                    "STANDARD"
                  ]
                },

                {
                  "id": "2",
                  "travelerType": 'ADULT',
                  "fareOptions": [
                    "STANDARD"
                  ]
                },
                {
                  "id": "3",
                  "travelerType": 'ADULT',
                  "fareOptions": [
                    "STANDARD"
                  ]
                },
                {
                  "id": "4",
                  "travelerType": 'ADULT',
                  "fareOptions": [
                    "STANDARD"
                  ]
                }

              ];
            } else {
              print('second adult checking....');

              travelersArray = <Map<String, dynamic>>[
                {
                  "id": "1",
                  "travelerType": 'ADULT',
                  "fareOptions": [
                    "STANDARD"
                  ]
                },

                {
                  "id": "2",
                  "travelerType": 'ADULT',
                  "fareOptions": [
                    "STANDARD"
                  ]
                },
                {
                  "id": "3",
                  "travelerType": 'ADULT',
                  "fareOptions": [
                    "STANDARD"
                  ]
                },
                {
                  "id": "4",
                  "travelerType": 'ADULT',
                  "fareOptions": [
                    "STANDARD"
                  ]
                },
                {
                  "id": "5",
                  "travelerType": 'ADULT',
                  "fareOptions": [
                    "STANDARD"
                  ]
                }

              ];
            }
          } else if(Aduld_cnt == 1 && children_cnt == 1 && infant_cnt == 1) {
            print('1 adult,1 child and 1 infant');
            travelersArray = <Map<String, dynamic>>[
              {
                "id": "1",
                "travelerType": 'ADULT',
                "fareOptions": [
                  "STANDARD"
                ]
              },

              {
                "id": "2",
                "travelerType": 'CHILD',
                "fareOptions": [
                  "STANDARD"
                ]
              },
              {
                "id": "3",
                "travelerType": 'HELD_INFANT',
                "fareOptions": [
                  "STANDARD"
                ],
                "associatedAdultId": "1"
              }
            ];
          } else if(Aduld_cnt == 1 && children_cnt == 2 && infant_cnt == 1) {
            print('1 adult,2 child and 1 infant');
            travelersArray = <Map<String, dynamic>>[
              {
                "id": "1",
                "travelerType": 'ADULT',
                "fareOptions": [
                  "STANDARD"
                ]
              },

              {
                "id": "2",
                "travelerType": 'CHILD',
                "fareOptions": [
                  "STANDARD"
                ]
              },
              {
                "id": "3",
                "travelerType": 'CHILD',
                "fareOptions": [
                  "STANDARD"
                ],
               // "associatedAdultId": "1"
              },
              {
                "id": "4",
                "travelerType": 'HELD_INFANT',
                "fareOptions": [
                  "STANDARD"
                ],
                "associatedAdultId": "1"
              }
            ];

          }



          print('travelersArray....');
          print(travelersArray);
        //}
        print('side travelersArray....');
        print(travelersArray);
        setState(() {
      isLoading = true;
    });
    //tempList = List<String>();
    //List<String> tempList = [];

    //SharedPreferences prefs = await SharedPreferences.getInstance();
    flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
    // print('Onward journey token1...');
    // print(flightTokenstr);    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
    // print('Onward journey token1...');
    // print(flightTokenstr);
    final response = await http.post(
      Uri.parse('https://test.travel.api.amadeus.com/v2/shopping/flight-offers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Content-Type": "application/json",
        "Accept": "application/json",
        //"Authorization": "Bearer ${flightTokenstr}",
        "Authorization": "Bearer $flightTokenstr",

      },
      body: jsonEncode(<String, dynamic>
      {
        "currencyCode": CurrencyCodestr,
        "originDestinations": [
          {
            "id": "1",
            "originLocationCode": Retrived_Oneway_iatacodestr,
            "destinationLocationCode": RetrivedOneway_Oneway_Destinationiatacodestr,
            "departureDateTimeRange": {
              "date": Oneway_From_Datestr
            }
          }
          // {
          //     "id": "2",
          //     "originLocationCode": "FRA",
          //     "destinationLocationCode": "CDG",
          //     "departureDateTimeRange": {
          //         "date": "2024-09-17"
          //
          //     }
          // }
        ],

           "travelers": travelersArray,

          // "travelers": [
        //   {
        //     "id": "1",
        //     "travelerType": "ADULT",
        //     "fareOptions": [
        //       "STANDARD"
        //     ]
        //   },
        //   {
        //     "id": "2",
        //     "travelerType": "ADULT",
        //     "fareOptions": [
        //       "STANDARD"
        //     ]
        //   }
          // {
          //   "id": "2",
          //   "travelerType": "CHILD",
          //   "fareOptions": [
          //     "STANDARD"
          //   ]
          // },
          // {
          //   "id": "3",
          //   "travelerType": "HELD_INFANT",
          //   "fareOptions": [
          //     "STANDARD"
          //   ],
          //   "associatedAdultId": "1"
          // }
        //],
        "sources": [
          "GDS"
        ],

        "searchCriteria": {
          "maxFlightOffers": 10,

          "cabinRestrictions": [
            {
              "cabin": Travel_class_str,
              "coverage": "MOST_SEGMENTS",
              "originDestinationIds": [
                "1"
              ]
            }
          ],
          //   "additionalInformation": {
          //     "includedCheckedBagsOnly": true,
          //     "brandedFares": false
          //   },
          "additionalInformation": {
            "chargeableCheckedBags": false,
            "brandedFares": false
          },
          "pricingOptions": {
            "fareType": [
              "PUBLISHED",
              "NEGOTIATED"
            ],
            "includedCheckedBagsOnly": false
          }
        }
      }
      // {
      //   "currencyCode": CurrencyCodestr,
      //   "originDestinations": [
      //     {
      //       "id": "1",
      //
      //     //   "originLocationCode": Retrived_Oneway_iatacodestr,
      //     // "destinationLocationCode": RetrivedOneway_Oneway_Destinationiatacodestr,
      //     // // "originLocationCode": "HRE",
      //     // // "destinationLocationCode": "DEL",
      //     // "departureDateTimeRange": {
      //     // "date": Oneway_From_Datestr
      //       "originLocationCode": Retrived_Oneway_iatacodestr,
      //       "destinationLocationCode": RetrivedOneway_Oneway_Destinationiatacodestr,
      //       // "originLocationCode": "HRE",
      //       // "destinationLocationCode": "DEL",
      //       "departureDateTimeRange": {
      //         "date": Oneway_From_Datestr
      //         // "time": "10:00:00"
      //       }
      //     }
      //     // {
      //     //   "id": "2",
      //     //   "originLocationCode": "DEL",
      //     //   "destinationLocationCode": "HRE",
      //     //   "departureDateTimeRange": {
      //     //     "date": "2024-07-12"
      //     //     //"time": "17:00:00"
      //     //   }
      //     // }
      //   ],
      //
      //
      //   "travelers": travelersArray,
      //   // "travelers": [
      //   //   {
      //   //     "id": "1",
      //   //     "travelerType": "ADULT",
      //   //     "fareOptions": [
      //   //       "STANDARD"
      //   //     ]
      //   //   }
      //     // {
      //     //   "id": "2",
      //     //   "travelerType": "CHILD",
      //     //   "fareOptions": [
      //     //     "STANDARD"
      //     //   ]
      //     // }
      //
      //   "sources": [
      //     "GDS"
      //   ],
      //   "searchCriteria": {
      //     "maxFlightOffers": 50,
      //     "flightFilters": {
      //       "cabinRestrictions": [
      //         {
      //           "cabin": "BUSINESS",
      //           "coverage": "MOST_SEGMENTS",
      //           "originDestinationIds": [
      //             "1"
      //           ]
      //         }
      //       ],
      //       "carrierRestrictions": {
      //         "excludedCarrierCodes": [
      //           "AA",
      //           "TP",
      //           "AZ"
      //         ]
      //       }
      //     }
      //   }
      // }
      ),
    );

    // print('post data api Flight search API response.......');
    //
    // print(response.statusCode);

        if (response.statusCode == 401) {
          print('failed....');
          //failurestr = 'failure';
        }

          if (response.statusCode == 200) {
      // Successful POST request, handle the response here
      final responseData = jsonDecode(response.body);
      var flightData = responseData['data'] ?? 'Not found Flights';
       print('Response data...');
       print(flightData);
      flight_offerResponse.add(flightData);
      flight_offerResponse_mutable.add(flightData);
      // print('lenth...');
      // print(Arraylenth.length);

      if (flightData == []) {
        print('got not empty array...');
      } else {
        print('got empty array...');
        FlightResponsestr = 'Empty';
        final snackBar = SnackBar(
          content: Text('Not found flights in this route'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      FlightEmptyArray.add(flightData);
      for (var flightdataArray in flightData) {
        sourcevalue = flightdataArray['source'];
        // print('source value...');
        // print(sourcevalue);
        sourceArray.add(sourcevalue);
        flightoffer_ID = flightdataArray['id'];
        print('flight id..');
        print(flightoffer_ID);
        var lastTicketingDatestr = flightdataArray['lastTicketingDate'];
        lastTicketingDateArray.add(lastTicketingDatestr);
        var lastTicketingDateTimestr = flightdataArray['lastTicketingDateTime'];
        lastTicketingDateTimeArray.add(lastTicketingDateTimestr);

        // print('id...');
        // print(flightoffer_ID);
        flightoffer_ID_Array.add(flightoffer_ID);
        OnwardJourneylist.add(sourcevalue);
        numberOfBookableSeats = flightdataArray['numberOfBookableSeats'];
        //print(numberOfBookableSeats);
        numberOfBookableSeatsArray.add(numberOfBookableSeats);
        var itinerariesArray = flightdataArray['itineraries'];
        //print(itinerariesArray);
        for (var Durationstrv in itinerariesArray) {
          String duration = Durationstrv['duration'];
          durationArray.add(duration);
          // String duration = itinerariesArray['segments'];
          // print('durationval...');
          // print(duration);
          String trimedDuration = duration.substring(2);
          OnwardJourney_durationArray.add(trimedDuration.toLowerCase());
          for (var SegmentArray in itinerariesArray) {
            var segmentValuesAray = SegmentArray['segments'];
            // print('segmentArray...');
            // print(segmentValuesAray);
            OnwardJourney_Segmentrray.add(segmentValuesAray);
            for (var DeparturArray in segmentValuesAray) {
              var carrierCodestr = DeparturArray['carrierCode'];
              // print('careercode.');
              // print(carrierCodestr);
               setState(() {
                 getUserDetails();
                 // print('Array........');
                 // print(AirportListArray.toString());
               });

              // final Airportlist = (AirportListArray?.length ?? 0) > 0 ? AirportListArray.first : null;
              // print('Airportlist...');
              // print(Airportlist);
              // var AirlinelistArray = [];
              // AirlinelistArray.add(Airportlist);
              // print('AirlinelistArray...');
              // print(AirlinelistArray);
              // List newLst_airport = AirportListArray.where( (o) => o['code'] == carrierCodestr).toList();
              //
              // print('list array...');
              // print(newLst_airport);
              // for(var airlinenamearray in newLst_airport){
              //         var Airline_name = airlinenamearray['name'];
              //         print('final airport name...');
              //         print(Airline_name);
              //         convertedAirlineArray.add(Airline_name);
              //         var Airline_logo = airlinenamearray['logo'];
              //         print('Airline_logo....');
              //         print(Airline_logo);
              //         AirlinelogoArray.add(Airline_logo);
              //       }
              //

              setState(() {
                OnwardJourney_carrierCodeArray.add(carrierCodestr);
              });
              var Dep = DeparturArray['departure'];
              depiataCode = Dep['iataCode'];
              print('dep...');
              print(depiataCode);
              if (flightoffer_ID == '1'){
                var Dep = DeparturArray['departure'];
                var depiataCode_cnt = Dep['iataCode'];
                print('loop dep...');
                print(depiataCode);
                Connectflightcnt_dep.add(depiataCode_cnt);
                print('dep cnt..');
                print(Connectflightcnt_dep);

              }
              if(Retrived_Oneway_iatacodestr == depiataCode) {
                OnwardJourney_depiataCodelist.add(depiataCode);
                print('dep array...');
                print(OnwardJourney_depiataCodelist);
                var departuretime = Dep['at'];
                Deptimeconvert =
                (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                Datestr =
                (new DateFormat.yMd().format(DateTime.parse(departuretime)));
                OnwardJourney_dateArray.add(Datestr);
                OnwardJourney_DeptimeArray.add(Deptimeconvert);
              }
              var arrival = DeparturArray['arrival'];
              arrivalcode = arrival['iataCode'];
              print('arrival....');
              print(arrivalcode);
              Connectflightcnt_Arrival.add(arrivalcode);
              if(RetrivedOneway_Oneway_Destinationiatacodestr == arrivalcode){
                OnwardJourney_arrivaliataCodelist.add(arrivalcode);
                // print('arrival array...');
                // print(OnwardJourney_arrivaliataCodelist);
                var arrivaltime = arrival['at'];
                var Arrivaltimeconvert = (new DateFormat.Hm().format(
                    DateTime.parse(arrivaltime)));
                OnwardJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
                // print('last...');
                // print(OnwardJourney_ArrivaltimeArray);
              }

            }
          }
        }
      }
      for(var Currency_Price in flightData){
        var Currency_Pricestr = Currency_Price['price'];
        print('Currency_Pricestr...');
        print(Currency_Pricestr);
        grandTotalprice = Currency_Pricestr['grandTotal'];
        print('grandTotalprice...');
        print(grandTotalprice);
        grand_totalPricevaluesArray.add(grandTotalprice);
        Currency_Price_Array.add(Currency_Pricestr);

      }


      //validatingAirlineCodes
      for (var validatingAirlineCodesArray in flightData) {
        //travelerPricings
        var validatingAirlineCodes = validatingAirlineCodesArray['validatingAirlineCodes'];
        // print('validatingAirlineCodes...');
        // print(validatingAirlineCodes.toString());
        validatingAirlineCodesArrayList.add(validatingAirlineCodes);
        // print('validatingAirlineCodesArrayList...');
        //
        //  print(validatingAirlineCodesArrayList);
        // final removedBrackets = validatingAirlineCodesArrayList.toString().substring(1, validatingAirlineCodesArrayList.toString().length - 1);
        // final parts = removedBrackets.split(', ');
        //
        // var joined = parts.map((part) => "'$part'").join(', ');




      }

      //travelerPricings
      for (var priceArray in flightData) {
        //travelerPricings
        var travelerPricings_Array = priceArray['travelerPricings'];
        print('price Array...');
        print(travelerPricings_Array);
        for(var travelidArray in travelerPricings_Array){
          String travelerId = '';
          travelerId = travelidArray['travelerId'];
          print('travelerId...');
          print(travelerId);
          travelerIdArray.add(travelerId);
        }
        print('last travelerId...');
        print(travelerIdArray.last);

        travelerPricingslistArray.add(travelerPricings_Array);
        List filterpriceArray = travelerPricings_Array.where((
            o) => o['travelerId'] == '1').toList();
        print('filtered...');
        print(filterpriceArray);
        for (var price in filterpriceArray) {
          var priceArray = price['price'];
          print('total price value..');
          print(priceArray);
          totalpricevalues = priceArray['total'];
          print('total amt..');
          print(totalpricevalues);
          totalPricevaluesArray.add(totalpricevalues);
          var cabin_class_array = price['fareDetailsBySegment'];
            print('cabin_class_array..');
            print(cabin_class_array);

          for(var cabinvalueArray in cabin_class_array){
              cabintrvalue = cabinvalueArray['cabin'];
              print('cabin value...');
              print(cabintrvalue);
              var includedCheckedBags = cabinvalueArray['includedCheckedBags'] ?? '';
              // print('includedCheckedBags...');
              // print(includedCheckedBags);
              quantity = includedCheckedBags['quantity'] ?? 0;
              print('check quantity...');
              print(quantity);


              // var includedCabinBags = cabinvalueArray['includedCabinBags'] ?? '';
              // print('includedCabinBags...');
              // print(includedCabinBags);
              // Cabin_quantity = includedCabinBags['quantity'] ?? '';
              // print('Cabin_quantity.....');
              // print(Cabin_quantity);

              // int weight = 0;
              // weight = includedCheckedBags['weight'];
              // print('weight...');
              // print(weight);



              weightUnitstr = includedCheckedBags['weightUnit'] ?? "";
              // var includedCabinBags = cabinvalueArray['includedCabinBags'] ?? "";
              // print('includedCabinBags...');
              // print(includedCabinBags);
              // Cabin_weightUnitstr = includedCabinBags['weightUnit'] ?? "";

              if(weightUnitstr == 'KG'){
                print('true weight...');
                print(weightUnitstr);
                weight = includedCheckedBags['weight'] ?? '';
                print('weight...');
                print(weight);
              } else{
                print('false calling....');
                quantity = includedCheckedBags['quantity'] ?? 0;
                print('quantity...');
                print(quantity);

              }
              // var includedCabinBags = cabinvalueArray['includedCabinBags'] ?? "";
              // print('includedCabinBags...');
              // print(includedCabinBags);
              // Cabin_weightUnitstr = includedCabinBags['weightUnit'] ?? "";

              // var includedCabinBags = cabinvalueArray['includedCabinBags'] ?? "";
              // print('includedCabinBags...');
              // print(includedCabinBags);

              // for(var cabin_BaggageArray in includedCabinBags){
              //   Cabin_quantity = cabin_BaggageArray['quantity'];
              //   print('Cabin_weightUnitstr quantity...');
              //   print(Cabin_quantity);
              // }


              //
              // if(Cabin_quantity != ''){
              //
              //   print('Cabin_weight false calling....');
              //   Cabin_quantity = includedCabinBags['quantity'] ?? 0;
              //   print('Cabin_weightUnitstr quantity...');
              //   print(Cabin_quantity);
              //
              // } else{
              //   print('true Cabin_weightUnitstr weight...');
              //   print(weightUnitstr);
              //   Cabin_weight = includedCabinBags['weight'] ?? "";
              //   print('Cabin_weight...');
              //   print(Cabin_weight);
              //
              // }


              cabintrvalue_Array.add(cabintrvalue);
            }
        }
      }
      //fareRules
      for(var fareRules in flightData){
        var fareRulesstr = fareRules['fareRules'] ?? '';
        print('fareRulesstr..... empty');
        print(fareRulesstr);
        fareRulesArray.add(fareRulesstr);
      }
    } else if (response.statusCode == 401){
      final snackBar = SnackBar(
        content: Text('failed!,please try again...'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else{
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
            title: Text('One way Flight Search', textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,
                    fontFamily: 'Baloo',
                    fontWeight: FontWeight.w900,
                    fontSize: 20)),
          ),
          body: Center(
            child: isLoading?
              CircularProgressIndicator():
                Column(
                        children: <Widget>[
                          //Container(color: Colors.red, height: 50),
                          new Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                            child:Container(
                                width: 400,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 50.0,
                                  child: Image.asset(
                                      "images/aeroplane_image.png",
                                      height: 125.0,
                                      width: 400.0,
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
                                  // Departuretextstr = 'Departure To ' + ' '+  RetrivedOneway_Oneway_Destinationiatacodestr;
                                  //
                                  // flight_departurests = 'Price per passenger, taxes and fees included';

                                  if(Connectflightcnt_dep.length == 1){
                                    Connectedflightstr = 'Non Stop';
                                  } else {
                                    Connectedflightstr = Connectflightcnt_dep.length.toString() + ' '+ 'Stops';
                                  }

                                  if(failurestr == ""){
                                    if(sourcevalue == "") {
                                      flightstatusstr = 'Not found flights this route';
                                    } else {
                                      flightstatusstr = 'Departure To ' + ' '+  RetrivedOneway_Oneway_Destinationiatacodestr;
                                      flight_departurests = 'Price per passenger, taxes and fees included';
                                    }
                                  } else {
                                    print('api failure...');
                                    flightstatusstr = 'Please try again...';
                                  }
                                  return SingleChildScrollView(
                                    physics: ScrollPhysics(),
                                    child: Column(
                                      children: <Widget>[
                                        //Text('Your Apartments'),
                                        Container(
                                          margin: const EdgeInsets.only(left: 10.0, right: 0.0),
                                          height: 80,
                                          width: 360,
                                          child: Column(
                                            children: [

                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  flightstatusstr,
                                                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  flight_departurests,
                                                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ListView.separated(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            //itemCount: snapshot.data.length + 1 ?? '',
                                            itemCount: totalPricevaluesArray.length ,

                                            // itemCount: totalPricevaluesArray.length ,
                                            separatorBuilder: (BuildContext context, int index) => const Divider(),
                                            itemBuilder: (BuildContext context, int index) {
                                              var Carrercodestr = OnwardJourney_carrierCodeArray[index].toString();
                                              List newLst_airport = AirportListArray.first.where( (o) => o['airlineCode'] == Carrercodestr).toList();
                                             // print('code...');
                                             //  print(newLst_airport);
                                              for(var airlinenamearray in newLst_airport){
                                                      var Airline_name = airlinenamearray['airlineName'];
                                                      convertedAirlineArray.add(Airline_name);
                                                      var Airline_logo = airlinenamearray['airlineLogo'];
                                                      AirlinelogoArray.add(Airline_logo);
                                                    }

                                              // for (var airlinenameArray in AirportListArray.first){
                                              //
                                              //   var airlineCode = airlinenameArray['airlineCode'];
                                              //   // print('airlineCode...');
                                              //   // print(airlineCode);
                                              //   if(airlineCode == OnwardJourney_carrierCodeArray[index].toString()){
                                              //     var airlineName = airlinenameArray['airlineName'];
                                              //     // print('airlineName...');
                                              //     // print(airlineName);
                                              //     convertedAirlineArray.add(airlineName);
                                              //     var airlineLogo = airlinenameArray['airlineLogo'];
                                              //     AirlinelogoArray.add(airlineLogo);
                                              //   }
                                              // }

                                              if(CurrencyCodestr == "USD"){
                                                totalpricevalues = grand_totalPricevaluesArray[index].toString();
                                                //print("I have \$$dollars."); // I have $42.
                                                // totalpriceSignvalues = "\$$totalpricevalues";
                                                totalpriceSignvalues = "\USD $totalpricevalues";
                                              } else {
                                                totalpricevalues = grand_totalPricevaluesArray[index].toString();
                                                totalpriceSignvalues = "\ZAR $totalpricevalues";
                                              }
                                              return Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Card(
                                                  child: Column(
                                                    children: <Widget>[
                                                      // Column(
                                                  InkWell(
                                                      child: Column(

                                                  children: [
                                                          Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              // Text(OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black
                                                              // ),),
                                                              Text(OnwardJourney_dateArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black
                                                              ),),
                                                              Text(OnwardJourney_DeptimeArray[index].toString() + '-----------------> ' + OnwardJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black
                                                              ),),
                                                              // Text(Retrived_Rndtrp_Destinationiatacodestr[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black
                                                              // ),),
                                                              SizedBox(),
                                                              Text(OnwardJourney_depiataCodelist[index].toString() + '               '+ Connectedflightstr +'                '+  OnwardJourney_arrivaliataCodelist[index].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black
                                                              ),),
                                                              // Text(OnwardJourney_arrivaliataCodelist[index].toString() + '                                          ' + OnwardJourney_depiataCodelist[index].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black
                                                              // ),),
                                                              Container(
                                                                height: 80,
                                                                width: 360,
                                                                color: Colors.transparent,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Container(
                                                                      height: 45,
                                                                      width: 130,
                                                                      color: Colors.transparent,
                                                                      child: Column(
                                                                        children: [
                                                                          SizedBox(height: 10,),
                                                                          // Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                          // ),),
                                                                          Text( "Seats:${numberOfBookableSeats}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black
                                                                          ),),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(width: 40,),
                                                                    Container(
                                                                      height: 45,
                                                                      width: 150,
                                                                      color: Colors.transparent,
                                                                      child: Column(
                                                                        children: [
                                                                          SizedBox(height: 10,),
                                                                          // Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                          // ),),
                                                                          Text( "${totalpriceSignvalues}",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.red
                                                                          ),),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 80,
                                                                width: 360,
                                                                color: Colors.transparent,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 30,
                                                                    ),
                                                                    Container(
                                                                      height: 70,
                                                                      width: 70,
                                                                      decoration: BoxDecoration(
                                                                          image: DecorationImage(image: NetworkImage(AirlinelogoArray[index].toString()),
                                                                              fit: BoxFit.cover)
                                                                      ),
                                                                    ),
                                                                    SizedBox(width: 40,),
                                                                    Container(
                                                                      height: 45,
                                                                      width: 150,
                                                                      color: Colors.transparent,
                                                                      child:  Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                      ),),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 50,
                                                                width: 300,
                                                                color: Colors.transparent,
                                                                child:  Text(cabintrvalue_Array[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                ),),
                                                              ),

                                                              Container(
                                                                height: 50,
                                                                width: 360,
                                                                color: Colors.transparent,
                                                                child: Container(
                                                                  height: 50,
                                                                  width: 250,
                                                                  margin: const EdgeInsets.only(left: 125.0, right: 0.0),
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(width: 100,),

                                                                      InkWell(

                                                                        child: Container(
                                                                            height: 45,
                                                                            width: 100,
                                                                            color: Colors.green,
                                                                            child: Align(
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                  "Select",
                                                                                  style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w800,color: Colors.white),
                                                                                  textAlign: TextAlign.center
                                                                              ),
                                                                            )
                                                                        ),
                                                                        onTap: () async {
                                                                          //print('continue btn tapped....');

                                                                          SharedPreferences prefs = await SharedPreferences.getInstance();

                                                                          Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => SeatMapVC()),
                                                                          );
                                                                          prefs.setString('flightid_key', flightoffer_ID_Array[index]);;
                                                                          prefs.setString('source_key', sourceArray[index]);
                                                                          prefs.setString('lastTicketing_Datekey', lastTicketingDateArray[index]);
                                                                          prefs.setString('lastTicketingDate_Timekey', lastTicketingDateTimeArray[index]);
                                                                          prefs.setString('numberOfBookableSeatskey', numberOfBookableSeatsArray[index].toString());
                                                                          prefs.setString('carrierCodekey', OnwardJourney_carrierCodeArray[index]);
                                                                          prefs.setString('flight_optionkey', 'one-way');

                                                                          // print('career code...');
                                                                          // print(OnwardJourney_carrierCodeArray[index]);
                                                                          prefs.setString('durationkey', durationArray[index]);
                                                                          String segJson = jsonEncode(OnwardJourney_Segmentrray[index]);
                                                                          // print('segJson...');
                                                                          // print(segJson);
                                                                          prefs.setString('Segmentkey', segJson);
                                                                          String validatingAirlineCodesArrayData = jsonEncode(validatingAirlineCodesArrayList[index]);
                                                                          prefs.setString('validatingAirlineCodeskey', validatingAirlineCodesArrayData);
                                                                          // print('validatingAirlineCodesArrayData......');
                                                                          // print(validatingAirlineCodesArrayData);
                                                                          String travelerPricings = jsonEncode(travelerPricingslistArray[index]);
                                                                          prefs.setString('travelerPricingskey', travelerPricings);
                                                                          String Currency_Price = jsonEncode(Currency_Price_Array[index]);
                                                                          prefs.setString('Currency_Pricekey', Currency_Price);
                                                                          String fareRulesstr = jsonEncode(fareRulesArray[index]);
                                                                          print('fareRulesstr...');
                                                                          print(fareRulesstr);
                                                                          prefs.setString('fareRuleskey', fareRulesstr);
                                                                          prefs.setString('airlinekey', convertedAirlineArray[index]);
                                                                          prefs.setString('logokey', AirlinelogoArray[index]);
                                                                          //Baggage
                                                                          prefs.setInt('weightkey', weight) ?? 0;
                                                                          prefs.setInt('quantitykey', quantity) ?? 0;
                                                                          Passengers_cnt = Aduld_cnt + children_cnt + infant_cnt;
                                                                          prefs.setInt('Passengers_cntkey', Passengers_cnt) ?? 0;
                                                                          prefs.setInt('Passengers_Adult_cntkey', Aduld_cnt) ?? 0;
                                                                          prefs.setInt('Passengers_Child_cntkey', children_cnt) ?? 0;
                                                                          prefs.setInt('Passengers_infant_cntkey', infant_cnt) ?? 0;



                                                                          print('sent value');
                                                                          print(Passengers_cnt);


                                                                          //Cabin Baggage
                                                                          // prefs.setInt('Cabin_weightkey', Cabin_weight) ?? 0;
                                                                          // prefs.setString('Cabin_quantitykey', Cabin_quantity) ?? "";




                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),

                                              onTap: () async{

                                                SharedPreferences prefs = await SharedPreferences.getInstance();

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => OnwardJourney_Flight_Details()),
                                                );
                                                prefs.setString('flightid_key', flightoffer_ID_Array[index]);;
                                                prefs.setString('source_key', sourceArray[index]);
                                                prefs.setString('lastTicketing_Datekey', lastTicketingDateArray[index]);
                                                prefs.setString('lastTicketingDate_Timekey', lastTicketingDateTimeArray[index]);
                                                prefs.setString('numberOfBookableSeatskey', numberOfBookableSeatsArray[index].toString());
                                                prefs.setString('carrierCodekey', OnwardJourney_carrierCodeArray[index]);
                                                prefs.setString('durationkey', durationArray[index]);
                                                prefs.setString('flight_optionkey', 'one-way');

                                                String validatingAirlineCodesArrayData = jsonEncode(validatingAirlineCodesArrayList[index]);
                                                prefs.setString('validatingAirlineCodeskey', validatingAirlineCodesArrayData);
                                                // print('validatingAirlineCodesArrayData......');
                                                // print(validatingAirlineCodesArrayData);
                                                String segJson = jsonEncode(OnwardJourney_Segmentrray[index]);
                                                prefs.setString('Segmentkey', segJson);
                                                String travelerPricings = jsonEncode(travelerPricingslistArray[index]);
                                                prefs.setString('travelerPricingskey', travelerPricings);
                                                String Currency_Price = jsonEncode(Currency_Price_Array[index]);
                                                prefs.setString('Currency_Pricekey', Currency_Price);
                                                String fareRulesstr = jsonEncode(fareRulesArray[index]);
                                                // print('fareRulesstr...');
                                                // print(fareRulesstr);
                                                prefs.setString('fareRuleskey', fareRulesstr);

                                              },

                                              )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                        Column(
                                          children:<Widget>[
                                            ListView.builder(
                                                physics: NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: 1,
                                                itemBuilder: (context,index){
                                                  return  Text('',style: TextStyle(fontSize: 22),);
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




