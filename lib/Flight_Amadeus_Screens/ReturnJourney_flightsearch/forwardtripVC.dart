
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

import 'BackwardJourneyVC.dart';
import 'BackwardtripVC.dart';
class FlightforwardTrip extends StatefulWidget {
  const FlightforwardTrip({super.key});

  @override
  State<FlightforwardTrip> createState() => _userDashboardState();
}

class _userDashboardState extends State<FlightforwardTrip> {
  final baseDioSingleton = BaseSingleton();

  int bookingID = 0;
  int numberOfBookableSeats = 0;
  String totalpricevalues = '';
  String totalpriceSignvalues = '';



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
  String ConvertedDep_Datestr = '';
  String NewdepiataCode = '';



  var Convervared_DateArray = [];
  var AirportListArray = [];
  var convertedAirlineArray = [];
  var AirlinelogoArray = [];
  var OnwardJourney_postrequestrequestAPI = [];
  var OnwardJourneylist = [];
  var frd_rnd_depiataCodelist = [];
  var frd_rnd_arrivaliataCodelist = [];
  var frd_rnd_DeptimeArray = [];
  var frd_rnd_ArrivaltimeArray = [];
  var frd_rnd_dateArray = [];
  var frd_rnd_durationArray = [];
  var frd_rnd_carrierCodeArray = [];
  var frd_rnd_airlineCodeArray = [];
  var frd_rnd_airlineNameArray = [];
  var frd_rnd_airlineLogoArray = [];
  var FlightEmptyArray = [];
  var flightstatusstr = '';
  var Departuretextstr = '';
  var flight_departurests = '';
  bool isLoading = false;

  var Static_Airline_code_array = [];
  var Static_Airline_name_array = [];
  var priceArray = [];



  //List<Map<String, dynamic>> mapList = [];
  Map<String, dynamic> travellers = {};
  String sourcevalue = '';

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

  //Round trip
  String Retrived_Rndtrp_iatacodestr = '';
  String Retrived_Rndtrp_Citynamestr = '';
  String Retrived_Rndtrp_Destination_iatacodestr = '';
  String Retrived_Rndtrp_Destination_Citynamestr = '';
  String Returnjourney_FromDatestr = '';
  String Returnjourney_ToDatestr = '';

  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // RetrivedEmail = prefs.getString('emailkey') ?? "";
      // RetrivedPwd = prefs.getString('passwordkey') ?? "";
      // RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      // VehicleId = prefs.getInt('userbookingId') ?? 0;
      //prefs.setString('currency_code_Rndtrp_dropdownvaluekey', (currency_code_Rndtrp_dropdownvalue));

      CurrencyCodestr = prefs.getString('currency_code_Rndtrp_dropdownvaluekey') ?? '';
      print('Currency code value...');
      print(CurrencyCodestr);
      flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
      print('Onward journey token...');
      print(flightTokenstr);
      //
      // Oneway_From_Datestr = prefs.getString('from_Datekey') ?? '';
      // print('date calling...');
      // print(Oneway_From_Datestr);
      //
      // Retrived_Oneway_iatacodestr = prefs.getString('Oneway_iatacodekey') ?? '';
      // Retrived_Oneway_Citynamestr = prefs.getString('Oneway_Citynamekey') ?? '';
      // print('received values in onward...');
      // print(Retrived_Oneway_iatacodestr);
      // print(Retrived_Oneway_Citynamestr);
      //
      // RetrivedOneway_Oneway_Destinationiatacodestr = prefs.getString('Oneway_Destinationiatacodekey') ?? '';
      // RetrivedOnew_Oneway_DestinationCitynamestr = prefs.getString('Oneway_DestinationCitynamekey') ?? '';

      print('received values in dest onward...');
      print(RetrivedOneway_Oneway_Destinationiatacodestr);
      print(RetrivedOnew_Oneway_DestinationCitynamestr);


      Returnjourney_FromDatestr = prefs.getString('returnfrom_Datekey') ?? '';
      Returnjourney_ToDatestr = prefs.getString('returnto_Datekey') ?? '';
      print('return dates...');
      print(Returnjourney_FromDatestr);
      print(Returnjourney_ToDatestr);

      //RndOriginAirportcitystr = prefs.getString('Rndtrp_origincitykey') ?? '';
      Retrived_Rndtrp_iatacodestr = prefs.getString('Rndtrp_originiatacodekey') ?? '';
      print('Rnd trip origin');
      print(Retrived_Rndtrp_iatacodestr);
      Retrived_Rndtrp_Citynamestr = prefs.getString('Rndtrp_originCitynamekey') ?? '';
      //Roundtrip Destination city values
      //RndDestinationAirportcitystr = prefs.getString('Rndtrp_Destinationcitykey') ?? '';
      Retrived_Rndtrp_Destination_iatacodestr = prefs.getString('Rndtrp_Destinationiatacodekey') ?? '';

      print('Rnd trip dest');
      print(Retrived_Rndtrp_Destination_iatacodestr);
      Retrived_Rndtrp_Destination_Citynamestr = prefs.getString('Rndtrp_DestinationCitynamekey') ?? '';



    });
  }
//@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    _postData();
    getUserDetails();


    Map<String, dynamic> _portaInfoMap = {
      "name": "Vitalflux.com",
      "domains": ["Data Science", "Mobile", "Web"],
      "noOfArticles": [
        {"type": "data science", "count": 50},
        {"type": "web", "count": 75}
      ]
    };
    print('mapping...');
    print(_portaInfoMap);

    travellers = {
      "travelers": [
        {
          "id": "1",
          "travelerType": "ADULT",
          "fareOptions": [
            "STANDARD"
          ]
        }
      ],
    };



    // "travelers": [
    // {
    // "id": "1",
    // "travelerType": "ADULT",
    // "fareOptions": [
    // "STANDARD"
    // ]
    // }
    // ],

  }

  _postData() async{
    setState(() {
      isLoading = true;
    });
    //tempList = List<String>();
    //List<String> tempList = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
    print('Onward journey token1...');
    print(flightTokenstr);    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
    print('Onward journey token1...');
    print(flightTokenstr);
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

            //   "originLocationCode": Retrived_Oneway_iatacodestr,
            // "destinationLocationCode": RetrivedOneway_Oneway_Destinationiatacodestr,
            // // "originLocationCode": "HRE",
            // // "destinationLocationCode": "DEL",
            // "departureDateTimeRange": {
            // "date": Oneway_From_Datestr
            "originLocationCode": Retrived_Rndtrp_iatacodestr,
            "destinationLocationCode": Retrived_Rndtrp_Destination_iatacodestr,
            // "originLocationCode": "HRE",
            // "destinationLocationCode": "DEL",
            "departureDateTimeRange": {
              "date": Returnjourney_FromDatestr
              // "time": "10:00:00"
            }
          },
          {
            "id": "2",
            "originLocationCode": Retrived_Rndtrp_Destination_iatacodestr,
            "destinationLocationCode": Retrived_Rndtrp_iatacodestr,
            "departureDateTimeRange": {
              "date": Returnjourney_ToDatestr
              //"time": "17:00:00"
            }
          }
        ],
        "travelers": [
          {
            "id": "1",
            "travelerType": "ADULT",
            "fareOptions": [
              "STANDARD"
            ]
          }
          // {
          //   "id": "2",
          //   "travelerType": "CHILD",
          //   "fareOptions": [
          //     "STANDARD"
          //   ]
          // }
        ],
        "sources": [
          "GDS"
        ],
        "searchCriteria": {
          "maxFlightOffers": 50,
          "flightFilters": {
            "cabinRestrictions": [
              {
                "cabin": "BUSINESS",
                "coverage": "MOST_SEGMENTS",
                "originDestinationIds": [
                  "1"
                ]
              }
            ],
            "carrierRestrictions": {
              "excludedCarrierCodes": [
                "AA",
                "TP",
                "AZ"
              ]
            }
          }
        }
      }
      ),
    );

    print('post data api Flight search API response.......');

    print(response.statusCode);
    if (response.statusCode == 200) {
      // Successful POST request, handle the response here
      final responseData = jsonDecode(response.body);
      var flightData = responseData['data'] ?? 'Not found Flights';
      print('Response data...');
      print(flightData);
      var Arraylenth = [];
      Arraylenth.add(flightData);
      print('lenth...');
      print(Arraylenth.length);

      if(flightData == []){
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
        print('source value...');
        print(sourcevalue);
        OnwardJourneylist.add(sourcevalue);
        numberOfBookableSeats = flightdataArray['numberOfBookableSeats'];
        print(numberOfBookableSeats);
        var itinerariesArray = flightdataArray['itineraries'];
        print(itinerariesArray);
        for(var Durationstrv in itinerariesArray){
          String duration = Durationstrv['duration'];
          // String duration = itinerariesArray['segments'];
          // print('durationval...');
          // print(duration);
          String trimedDuration = duration.substring(2);
          frd_rnd_durationArray.add(trimedDuration.toLowerCase());
          for (var SegmentArray in itinerariesArray){
            var segmentValuesAray = SegmentArray['segments'];
            for(var DeparturArray in segmentValuesAray){
              carrierCodestr = DeparturArray['carrierCode'];
              frd_rnd_carrierCodeArray.add(carrierCodestr);


              // List newLst_airport = AirportListArray[0].where( (o) => o['airlineCode'] == carrierCodestr).toList();
              //
              // print('airline_line...');
              // print(newLst_airport);
              // for(var airlinenamearray in newLst_airport){
              //   var Airline_name = airlinenamearray['airlineName'];
              //   print('final airport name...');
              //   print(Airline_name);
              //   convertedAirlineArray.add(Airline_name);
              //   var Airline_logo = airlinenamearray['airlineLogo'];
              //   print('Airline_logo....');
              //   print(Airline_logo);
              //   AirlinelogoArray.add(Airline_logo);
              // }
              var Dep = DeparturArray['departure'];
              depiataCode = Dep['iataCode'];

              if (depiataCode == Retrived_Rndtrp_iatacodestr){
                NewdepiataCode = Dep['iataCode'];
                // print('NewdepiataCode...');
                // print(NewdepiataCode);
                frd_rnd_depiataCodelist.add(NewdepiataCode);
                var departuretime = Dep['at'];
                // print('departure time..');
                // print(departuretime);
                var Deptimeconvert = (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                var Datestr = (new DateFormat.yMd().format(DateTime.parse(departuretime)));
                // print('date.');
                // print(Datestr);
                var inputFormat = DateFormat('dd/MM/yyyy');
                var date1 = inputFormat.parse(Datestr);
                var outputFormat = DateFormat('yyyy-dd-MM');
                ConvertedDep_Datestr = outputFormat.format(date1); // "2019-08-18"
                // print('Converted date formate...');
                // print(ConvertedDep_Datestr);
                setState(() {
                  Convervared_DateArray.add(ConvertedDep_Datestr);

                });
                frd_rnd_dateArray.add(Datestr);
                // print('time conversion...');
                // print(Deptimeconvert);
                frd_rnd_DeptimeArray.add(Deptimeconvert);

              }

              var arrival = DeparturArray['arrival'];
              // print('arrival....');
              // print(arrival);
              var arrivalcode = arrival['iataCode'];
              // print('arrivalcode...');
              // print(arrivalcode);
//
              if(arrivalcode == Retrived_Rndtrp_Destination_iatacodestr){
                var Newarrivalcode = arrival['iataCode'];
                // print('Newarrivalcode...');
                // print(Newarrivalcode);
                frd_rnd_arrivaliataCodelist.add(Newarrivalcode);
                var arrivaltime = arrival['at'];
                // print('arrivaltime...');
                // print(arrivaltime);
                var Arrivaltimeconvert = (new DateFormat.Hm().format(DateTime.parse(arrivaltime)));
                // print('time arrivaltime...');
                // print(Arrivaltimeconvert);
                frd_rnd_ArrivaltimeArray.add(Arrivaltimeconvert);

              }
              setState(() {
                getUserDetails();
              });

              // print('airline array...');
              // print(carrierCodestr);
              // print(AirportListArray[0]);



            }
          }
        }
      }
      for (var priceArray in flightData) {
        totalpricevalues = priceArray['price']['total'];
        // print('price value...');
        // print(totalpricevalues);
      }
    }
    else{
      throw Exception("Failed to load Dogs Breeds.");
    }
    setState(() {
      isLoading = false;
    });
  }


  Future<dynamic> getUserDetails() async {
    String baseUrl = 'https://staging.abisiniya.com/api/v1/amadeus/airlinelist';
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      print('s call load...');
      List<String> items = [];
      var jsonData = json.decode(response.body);
      print('Airport list.....');
      print(jsonData.toString());
      var Data = jsonData['data'];
      // print('Data....');
      // print(Data);

      AirportListArray.add(Data);
      return json.decode(response.body);
    }
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
              title: Text('Two way Flight Search', textAlign: TextAlign.center,
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
                          if(sourcevalue == "") {
                            flightstatusstr = 'Not found flights this route';
                          } else {
                            flightstatusstr = 'Departure To ' + ' '+  Retrived_Rndtrp_Destination_iatacodestr;

                            flight_departurests = 'Price per passenger, taxes and fees included';
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

                                      // Align(
                                      //   alignment: Alignment.topLeft,
                                      //   child: Text(
                                      //     flightstatusstr,
                                      //     style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),),
                                      // ),

                                    ],
                                  ),
                                ),

                                ListView.separated(


                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    //itemCount: snapshot.data.length + 1 ?? '',
                                    itemCount: frd_rnd_DeptimeArray.length ,
                                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                                    itemBuilder: (BuildContext context, int index) {
                                      if(CurrencyCodestr == "USD"){
                                        //print("I have \$$dollars."); // I have $42.
                                        // totalpriceSignvalues = "\$$totalpricevalues";
                                        totalpriceSignvalues = "\USD $totalpricevalues";

                                      } else {
                                        totalpriceSignvalues = "\ZAR $totalpricevalues";

                                      }
                                      return Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Card(
                                          child: Column(
                                            children: <Widget>[
                                              Column(
                                                children: [
                                                  Column(


                                                    children: [

                                                      SizedBox(
                                                        height: 5,
                                                      ),


                                                      // Text(OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black
                                                      // ),),

                                                      Text(frd_rnd_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black
                                                      ),),
                                                      Text(frd_rnd_DeptimeArray[index].toString() + '-----------------> ' + frd_rnd_ArrivaltimeArray[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black
                                                      ),),
                                                      //
                                                      // // Text(Retrived_Rndtrp_Destinationiatacodestr[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black
                                                      // // ),),
                                                      // SizedBox(),

                                                      Text(frd_rnd_depiataCodelist[index].toString() + '                                          ' + frd_rnd_arrivaliataCodelist[index].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black
                                                      ),),


                                                      Container(
                                                        height: 80,
                                                        width: 360,
                                                        color: Colors.transparent,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 10,
                                                            ),

                                                            // Container(
                                                            //   height: 70,
                                                            //   width: 70,
                                                            //   decoration: BoxDecoration(
                                                            //       image: DecorationImage(image: NetworkImage(AirlinelogoArray[index].toString()),
                                                            //           fit: BoxFit.cover)
                                                            //   ),
                                                            // ),

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


                                                      // Container(
                                                      //   height: 80,
                                                      //   width: 360,
                                                      //   color: Colors.transparent,
                                                      //   child: Row(
                                                      //     children: [
                                                      //       SizedBox(
                                                      //         width: 10,
                                                      //       ),
                                                      //
                                                      //       Container(
                                                      //         height: 70,
                                                      //         width: 70,
                                                      //         decoration: BoxDecoration(
                                                      //             image: DecorationImage(image: NetworkImage(AirlinelogoArray[index].toString()),
                                                      //                 fit: BoxFit.cover)
                                                      //         ),
                                                      //       ),
                                                      //
                                                      //       // Container(
                                                      //       //   height: 45,
                                                      //       //   width: 130,
                                                      //       //   color: Colors.transparent,
                                                      //       //   child: Column(
                                                      //       //     children: [
                                                      //       //       SizedBox(height: 10,),
                                                      //       //       // Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                      //       //       // ),),
                                                      //       //       // Text( "Seats:${numberOfBookableSeats}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black
                                                      //       //       // ),),
                                                      //       //
                                                      //       //     ],
                                                      //       //   ),
                                                      //       //
                                                      //       // ),
                                                      //
                                                      //       SizedBox(width: 40,),
                                                      //       Container(
                                                      //         height: 45,
                                                      //         width: 150,
                                                      //         color: Colors.transparent,
                                                      //         child: Column(
                                                      //           children: [
                                                      //             SizedBox(height: 10,),
                                                      //             Text(convertedAirlineArray[index].toString() + "   -" + frd_rnd_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                      //             ),),
                                                      //           ],
                                                      //         ),
                                                      //
                                                      //       )
                                                      //     ],
                                                      //   ),
                                                      // ),


                                                      ExpansionTile(

                                                        title: Container(
                                                          //width: 100,
                                                          //transform: Matrix4.translationValues(20, 0, 0),
                                                          color: Colors.transparent,
                                                          child:     Align(
                                                              alignment: Alignment.centerRight,
                                                              child: Text('Details',style: (TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.green)),)
                                                          ),

                                                        ),
                                                        leading: const SizedBox(width: 0.00,),
                                                        children: [
                                                          Container(
                                                            height: 170,
                                                            width: 360,
                                                            color: Colors.transparent,
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  margin: const EdgeInsets.only(left: 10.0, right: 0.0),

                                                                  height: 160,
                                                                  width: 80,
                                                                  color: Colors.transparent,
                                                                  child: Column(
                                                                    children: [
                                                                      Text(frd_rnd_DeptimeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                      ),),
                                                                      SizedBox(height: 40,),
                                                                      Text(frd_rnd_dateArray[index].toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black
                                                                      ),),

                                                                      SizedBox(height: 50,),
                                                                      Text(frd_rnd_ArrivaltimeArray[index].toString() ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                      ),),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets.only(left: 0.0, right: 0.0),

                                                                  height: 160,
                                                                  width: 30,
                                                                  color: Colors.transparent,
                                                                  child:Container(
                                                                      width: 20,
                                                                      child: CircleAvatar(
                                                                        backgroundColor: Colors.transparent,
                                                                        radius: 50.0,
                                                                        child: Image.asset(
                                                                            "images/flight-path-icon.png",
                                                                            height: 150.0,
                                                                            width: 200.0,
                                                                            fit: BoxFit.fill
                                                                        ),
                                                                      )
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets.only(left: 0.0, right: 0.0),

                                                                  height: 160,
                                                                  width: 220,
                                                                  color: Colors.transparent,
                                                                  child: Column(
                                                                    children: [
                                                                      Align(
                                                                        alignment: Alignment.topLeft,
                                                                        child: Text(
                                                                          frd_rnd_depiataCodelist[index].toString(),
                                                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                                                      ),
                                                                      Align(
                                                                        alignment: Alignment.topLeft,
                                                                        child: Text(
                                                                          Retrived_Rndtrp_iatacodestr,
                                                                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                                                      ),

                                                                      Container(
                                                                        height: 50,
                                                                        width: 220,
                                                                        color: Colors.transparent,
                                                                        child: Row(
                                                                          children: [

                                                                            // Container(
                                                                            //   height: 40,
                                                                            //   width: 40,
                                                                            //   decoration: BoxDecoration(
                                                                            //     // image: DecorationImage(image: NetworkImage(snapshot.data["data"][index]['pictures'][0
                                                                            //     // ]['imageUrl']),
                                                                            //       image: DecorationImage(image: NetworkImage(AirlinelogoArray[index].toString()),
                                                                            //           fit: BoxFit.cover)
                                                                            //   ),
                                                                            // ),

                                                                            Container(
                                                                              height: 40,
                                                                              width: 170,
                                                                              color: Colors.transparent,
                                                                              child: Column(
                                                                                children: [
                                                                                  SizedBox(height: 10,),
                                                                                  // Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black
                                                                                  //
                                                                                  // ),),
                                                                                  Text(frd_rnd_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black

                                                                                  ),),
                                                                                ],
                                                                              ),

                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: Alignment.topLeft,
                                                                        child: Text(
                                                                          frd_rnd_arrivaliataCodelist[index].toString(),
                                                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                                                      ),
                                                                      Align(
                                                                        alignment: Alignment.topLeft,
                                                                        child: Text(
                                                                          Retrived_Rndtrp_Destination_iatacodestr,
                                                                          style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            width: 360,
                                                            color: Colors.transparent,
                                                            child: Container(
                                                              height: 45,
                                                              width: 250,
                                                              margin: const EdgeInsets.only(left: 125.0, right: 0.0),
                                                              child: Row(
                                                                children: [
                                                                  // InkWell(
                                                                  //   child: Container(
                                                                  //       height: 35,
                                                                  //       width: 100,
                                                                  //       color: Colors.green,
                                                                  //       child: Align(
                                                                  //         alignment: Alignment.center,
                                                                  //         child: Text(
                                                                  //             "Add Cart",
                                                                  //             style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w800,color: Colors.white),
                                                                  //             textAlign: TextAlign.center
                                                                  //         ),
                                                                  //       )
                                                                  //
                                                                  //   ),
                                                                  //   onTap: () async {
                                                                  //
                                                                  //
                                                                  //     print('Tapped onward....');
                                                                  //
                                                                  //   },
                                                                  // ),
                                                                  SizedBox(
                                                                    width: 50,
                                                                  ),
                                                                  InkWell(
                                                                    child: Container(
                                                                        height: 35,
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
                                                                      print("tapped on container");
                                                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                      flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                                                                      print('tap..');
                                                                      print(flightTokenstr);
                                                                      flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                                                                      prefs.setString("flightTokenstrKey", flightTokenstr);
                                                                      prefs.setString("Oneway_iatacodekey", Retrived_Oneway_iatacodestr);
                                                                      prefs.setString("Oneway_Citynamekey", Retrived_Oneway_Citynamestr);
                                                                      prefs.setString("Oneway_Destinationiatacodekey", RetrivedOneway_Oneway_Destinationiatacodestr);
                                                                      prefs.setString("Oneway_DestinationCitynamekey", RetrivedOnew_Oneway_DestinationCitynamestr);

                                                                      prefs.setString("returnfrom_Datekey", Returnjourney_FromDatestr);
                                                                      prefs.setString("returnto_Datekey", Returnjourney_ToDatestr);


                                                                      print('Tapped onward....');
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => FlightBack_wardTrip()),
                                                                      );
                                                                      print('Tapped onward....');

                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );

                                    }),

                                Column(
                                  children:<Widget>[
                                    //Text('second test'),
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




