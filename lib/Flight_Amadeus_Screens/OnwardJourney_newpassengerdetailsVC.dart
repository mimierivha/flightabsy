
import 'package:flutter/material.dart';
//import 'package:tourstravels/ApartVC/Add_Apartment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'dart:convert';
import 'package:tourstravels/ApartVC/Addaprtment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/UserDashboard_Screens/Apartbooking_Model.dart';
import 'package:tourstravels/UserDashboard_Screens/PivoteVC.dart';
import 'package:tourstravels/tabbar.dart';
import 'package:tourstravels/My_Apartments/My_AprtmetsVC.dart';

import '../../UserDashboard_Screens/newDashboard.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';

import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';

import 'SeatMap/seatMapVC.dart';



//import 'ViewManagePicturesVC.dart';
//import 'NewUserbooking.dart';
class Passenger_DetailsVC extends StatefulWidget {
  const Passenger_DetailsVC({super.key});
  @override
  State<Passenger_DetailsVC> createState() => _userDashboardState();
}
class _userDashboardState extends State<Passenger_DetailsVC> {
  //suresh
  final baseDioSingleton = BaseSingleton();
  String flightTokenstr = '';
  //Local api's token
  String local_Abiniyatokenvalue = '';
  int Retrive_login_user_ID = 0;
  String fName = '';
  String lName = '';
  String fullName = '';
  String phonenumber = '';
  String gender = '';
  String eMail = '';
  String totalpricevalues = '';
  //without usd or zar
  String pricestr = '';
  String Retrived_OrderID = '';
  bool isLoading = false;


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
  String airlinestr = '';
  String logostr = '';
  String CurrencyCodestr = '';
  String Travel_class_str = '';
  String flight_optionstr = '';

  //Passenger list Retrived data
  String referencestr = '';
  String firstnamestr = '';
  String lastnamestr = '';
  String phonestr = '';
  String emailstr = '';
  String genderstr = '';
  String dobstr = '';
  String travellerId = '';
  String referenceID ='';
  String RetrivedPwd = '';
  String RetrivedEmail = '';
  String RetrivedBearertoekn = '';
  int VehicleId = 0;
  int Rating_review = 0;
  int flight_request_id = 0;
  String AvgRating_review = '';
  int avgRating = 0;
  var avglistMessage = '';
  var ViewApartmentList = [];
  var Reviewlist = [];
  var scoreRatinglist = [];
  var ReviewcreateDatelist = [];
  var PicArrayList = [];
  int Picture_Id = 0;
  String RetrivedProfileNamestr = '';
  String RetrivedProfileEmailstr = '';

  var firstNameArray = [];
  var lastNameArray = [];
  List convert_order_segArray = [];


  var controller = ScrollController();
  int count = 15;
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
      // print(' locator Details Onward journey token1...');
      // print(flightTokenstr);
      totalpricevalues = prefs.getString('totalpricevalueskey') ?? '';
      // print(totalpricevalues);
      // print('order totalpricevalues...');
      pricestr = prefs.getString('pricekey') ?? '';
      print('price...');
      print(pricestr);

      Retrived_OrderID = prefs.getString('OrderIDkey') ?? '';
      print('orderid in view details');
      print(Retrived_OrderID);
      local_Abiniyatokenvalue = prefs.getString('local_Flight_tokenkey') ?? '';
      print('local_Abiniyatokenvalue....');
      print(local_Abiniyatokenvalue);

      Retrive_login_user_ID = prefs.getInt('login_user_ID_key') ?? 0;
      print('Retrive_login_user_ID...');
      print(Retrive_login_user_ID);
      sourcestr = prefs.getString('source_key') ?? '';
      lastTicketing_Datestr = prefs.getString('lastTicketing_Datekey') ?? '';
      lastTicketingDate_Timestr = prefs.getString('lastTicketingDate_Timekey') ?? '';
      numberOfBookableSeatsstr = prefs.getString('numberOfBookableSeatskey') ?? '';
      Careercodestr = prefs.getString('carrierCodekey') ?? '';
      // print('CareerCode...');
      // print(Careercodestr);
      airlinestr = prefs.getString('airlinekey') ?? '';
      // print('airlinevalue...');
      // print(airlinestr);
      logostr = prefs.getString('logokey') ?? '';
      // print('Careercodestr.....');
      // print(Careercodestr);
      RetrivedOneway_Oneway_Destinationiatacodestr = prefs.getString('Oneway_Destinationiatacodekey') ?? '';
      RetrivedOnew_Oneway_DestinationCitynamestr = prefs.getString('Oneway_DestinationCitynamekey') ?? '';
      print('departure name...');
      print(RetrivedOnew_Oneway_DestinationCitynamestr);
      Retrived_Oneway_iatacodestr = prefs.getString('Oneway_iatacodekey') ?? '';
      Retrived_Oneway_Citynamestr = prefs.getString('Oneway_Citynamekey') ?? '';
      print('Arrival name str...');
      print(Retrived_Oneway_Citynamestr);
      CurrencyCodestr = prefs.getString('currency_code_dropdownvaluekey') ?? '';
      print('Currency code...');
      print(CurrencyCodestr);
      Travel_class_str = prefs.getString('travel_classstr') ?? '';
      // print('Travel_class_str...');
      // print(Travel_class_str);
      flight_optionstr = prefs.getString('flight_optionkey') ?? '';
      print('flight_optionstr...');
      print(flight_optionstr);

      referencestr = prefs.getString('reference_key') ?? '';
      print('referencestr...');
      print(referencestr);
      firstnamestr = prefs.getString('passenger_firstname_key') ?? '';
      print('firstnamestr...');
      print(firstnamestr);

      lastnamestr = prefs.getString('passenger_lastname_key') ?? '';
      print('lastnamestr...');
      print(lastnamestr);

      phonestr = prefs.getString('passenger_phone_key') ?? '';
      print('phonestr...');
      print(phonestr);

      emailstr = prefs.getString('passenger_email_key') ?? '';
      print('emailstr...');
      print(emailstr);

      genderstr = prefs.getString('passenger_gender_key') ?? '';
      print('genderstr...');
      print(genderstr);

      dobstr = prefs.getString('passenger_dob_key') ?? '';
      // print('dobstr...');
      // print(dobstr);

      travellerId = prefs.getString('travellerIdkey') ?? '';
      print('travellerId...');
      print(travellerId);




      RetrivedEmail = prefs.getString('emailkey') ?? "";
      RetrivedPwd = prefs.getString('passwordkey') ?? "";
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      flight_request_id = prefs.getInt('flight_request_idkey') ?? 0;
      print('flight_request_id...');
      print(flight_request_id);
      print(RetrivedBearertoekn);

      //prefs.setString('profilenamekey',snapshot.data['data'][index]['userDetail']['name'].toString() +" "+ snapshot.data['data'][index]['userDetail']['surname'].toString());

      RetrivedProfileNamestr = prefs.getString('profilenamekey') ?? "";
      RetrivedProfileEmailstr = prefs.getString('Profileemailkey') ?? "";
      Retrived_OrderID = prefs.getString('OrderIDkey') ?? '';
      print('orderid in view details');
      print(Retrived_OrderID);
      flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
      print('flightTokenstr.......');
      print(flightTokenstr);
      final Retrivedsegment_Array;
      Retrivedsegment_Array = prefs.getString('segmentlistkey') ?? '';
      print('Retrivedsegment_Array...');
      print(Retrivedsegment_Array);
      //   final ordersegstr = prefs.getString('Segmentkey') ?? '';
      // print('order seg');
      // print(ordersegstr);
      convert_order_segArray = json.decode(Retrivedsegment_Array);
      print('conneted conver order array...');
      print(convert_order_segArray);
    });
  }

  void initState() {

    // TODO: implement initState
    super.initState();
    _retrieveValues();
    PassengersWithConnected_flight_postData();
    //getData();
    //Navigator.pop(context);

    //getData();
    //pics = fetchpics();
  }


  Future<dynamic> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Retrived_OrderID = prefs.getString('OrderIDkey') ?? '';
    print('orderid in view details');
    print(Retrived_OrderID);
    flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
    print('flightTokenstr.......');
    print(flightTokenstr);
    // print(' Details Onward journey token1...');
    // print(flightTokenstr);
    //local_Abiniyatokenvalue = prefs.getString('local_Flight_tokenkey') ?? '';
    // print('local_Abiniyatokenvalue....');
    // print(local_Abiniyatokenvalue);

    // String url = 'https://staging.abisiniya.com/api/v1/vehicle/auth/show/' + VehicleId.toString();
    //https://staging.abisiniya.com/api/v1/flight/flightreqshownew/U62GRQ
    String url = 'https://test.travel.api.amadeus.com/v1/booking/flight-orders/' + Retrived_OrderID;
    print('OrderID url...');
    print(url);



    //prefs.setString('reference_key', snapshot.data['data'][index]['reference']);


    var response = await http.get(
      Uri.parse(
          url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Content-Type": "application/json",
        "Accept": "application/json",
        //"Authorization": "Bearer ${flightTokenstr}",
        "Authorization": "Bearer $flightTokenstr",

      },
      // headers: {
      //   // 'Authorization':
      //   // 'Bearer <--your-token-here-->',
      //   "Authorization": "Bearer $RetrivedBearertoekn",
      //
      // },
    );
    print('code...');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data1 = jsonDecode(response.body);


      var RecordLocatorData = data1['data'];
      print('RecordLocatorData...');
      print(RecordLocatorData);
      // var travelers = RecordLocatorData['travelers'];
      // print('RecordLocatorData travelers...');
      // print(travelers);
      // for(var namestr in travelers) {
      //   var nameArray = namestr['name'];
      //   // print('nameArray...');
      //   // print(nameArray);
      //   //fName = nameArray['firstName'];
      //   var firstnamestr = nameArray['firstName'];
      //   print('first name value');
      //   print(firstnamestr);
      //
      //   firstNameArray.add(firstnamestr);
      //   print('array...');
      //   print(firstNameArray);
      // }

      // print(ViewApartmentList);
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }




  //Passenger list post API calling...
  Future<void> PassengersWithConnected_flight_postData() async {
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
    //https://staging.abisiniya.com/api/v1/flight/amadeusflighbooking
    final response = await http.post(
      //v1/booking/flight-orders
      //https://abisiniya.com/api/v1/
      //https://staging.abisiniya.com/api/v1/flight/aflighbookingreqwithpassengers
      //          Uri.parse(baseDioSingleton.AbisiniyaBaseurl +'login'),
      // Uri.parse(
      //     'https://abisiniya.com/api/v1/flight/aflighbookingreqwithpassengers'),
      Uri.parse(baseDioSingleton.AbisiniyaBaseurl +'flight/aflighbookingreqwithpassengers'),
      headers: <String, String>{
        //'Content-Type': 'application/json; charset=UTF-8',
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $local_Abiniyatokenvalue",
        //"Authorization": "Bearer $local_Abiniyatokenvalue",

      },
      body: jsonEncode(<String, dynamic>
      {
        "flight_id":Retrived_OrderID,
        "reference":referencestr,
        "queuingOfficeId":"JNBZA2195",
        "price":pricestr,
        "currency":CurrencyCodestr,
        "departure":RetrivedOnew_Oneway_DestinationCitynamestr,
        "arrival":Retrived_Oneway_Citynamestr,
        "airline":airlinestr,
        "carrierCode":Careercodestr,
        "travel_class":Travel_class_str,
        "flight_option":flight_optionstr,
        "status":"pending",
        "user_id":Retrive_login_user_ID.toString(),
        "segments": convert_order_segArray,

        "passengers":[
          {
            "id": "1",
            "dateOfBirth": dobstr,
            "name": {
              "firstName": firstnamestr,
              "lastName": lastnamestr
            },
            "gender": genderstr,
            "contact": {
              "emailAddress": emailstr,
              "phones": [
                {
                  "deviceType": "MOBILE",
                  "countryCallingCode": "34",
                  "number": phonestr
                }
              ]
            }
          }
          // {
          //     "id": "2",
          //     "dateOfBirth": "2012-10-11",
          //     "gender": "FEMALE",
          //     "contact": {
          //         "emailAddress": "abisiniya.suresh@yopmail.com",
          //         "phones": [
          //             {
          //                 "deviceType": "MOBILE",
          //                 "countryCallingCode": "34",
          //                 "number": "480080076"
          //             }
          //         ]
          //     },
          //     "name": {
          //         "firstName": "Madhu",
          //         "lastName": "Babu"
          //     }
          // }
        ]
      }
        // {
        //   "flight_id": OrderID,
        //   "reference": referencestr,
        //   "queuingOfficeId": "JNBZA2195",
        //   "price": pricestr,
        //   "currency": CurrencyCodestr,
        //   "departure": RetrivedOnew_Oneway_DestinationCitynamestr,
        //   "arrival": Retrived_Oneway_Citynamestr,
        //   "airline": airlinestr,
        //   "carrierCode": Careercodestr,
        //   "travel_class": Travel_class_str,
        //   "flight_option": flight_optionstr,
        //   "status":"pending",
        //   "user_id": Retrive_login_user_ID,
        //   "passengers":[
        //     {
        //       "id": "1",
        //       "dateOfBirth": dobstr,
        //       "name": {
        //         "firstName": firstnamestr,
        //         "lastName": lastnamestr
        //       },
        //       "gender": genderstr,
        //       "contact": {
        //         "emailAddress": emailstr,
        //         "phones": [
        //           {
        //             "deviceType": "MOBILE",
        //             "countryCallingCode": "34",
        //             "number": phonestr
        //           }
        //         ]
        //       }
        //       // "documents": [
        //       //     {
        //       //         "documentType": "PASSPORT",
        //       //         "birthPlace": "Madrid",
        //       //         "issuanceLocation": "Madrid",
        //       //         "issuanceDate": "2015-04-14",
        //       //         "number": "00000000",
        //       //         "expiryDate": "2025-04-14",
        //       //         "issuanceCountry": "ES",
        //       //         "validityCountry": "ES",
        //       //         "nationality": "ES",
        //       //         "holder": true
        //       //     }
        //       // ]
        //     }
        //   ]
        // }
        // {
        //   "flight_id":"eNzTc9aYdaQICjADAAsUvcb%3",
        //   "reference":"DA8Dj9",
        //   "queuingOfficeId":"JNBZA2195",
        //   "price":"298.99",
        //   "currency":"USD",
        //   "departure":"Addis Ababa Bole International Airport",
        //   "arrival":"Robert Gabriel Mugabe International Airport",
        //   "airline":"Air India",
        //   "carrierCode":"AI",
        //   "travel_class":"Economy",
        //   "flight_option":"one-way",
        //   "status":"pending",
        //   "user_id":"3",
        //   "passengers":[
        //     {
        //       "id": "1",
        //       "dateOfBirth": "1982-01-16",
        //       "name": {
        //         "firstName": "JORGE",
        //         "lastName": "GONZALES"
        //       },
        //       "gender": "MALE",
        //       "contact": {
        //         "emailAddress": "deepakk@yopmail.com",
        //         "phones": [
        //           {
        //             "deviceType": "MOBILE",
        //             "countryCallingCode": "34",
        //             "number": "480080076"
        //           }
        //         ]
        //       },
        //       // "documents": [
        //       //   {
        //       //     "documentType": "PASSPORT",
        //       //     "birthPlace": "Madrid",
        //       //     "issuanceLocation": "Madrid",
        //       //     "issuanceDate": "2015-04-14",
        //       //     "number": "00000000",
        //       //     "expiryDate": "2025-04-14",
        //       //     "issuanceCountry": "ES",
        //       //     "validityCountry": "ES",
        //       //     "nationality": "ES",
        //       //     "holder": true
        //       //   }
        //       // ]
        //     },
        //     // {
        //     //   "id": "2",
        //     //   "dateOfBirth": "2012-10-11",
        //     //   "gender": "FEMALE",
        //     //   "contact": {
        //     //     "emailAddress": "jorge.gonzales833@telefonica.es",
        //     //     "phones": [
        //     //       {
        //     //         "deviceType": "MOBILE",
        //     //         "countryCallingCode": "34",
        //     //         "number": "480080076"
        //     //       }
        //     //     ]
        //     //   },
        //     //   "name": {
        //     //     "firstName": "ADRIANA",
        //     //     "lastName": "GONZALES"
        //     //   }
        //     // }
        //   ]
        // }

      ),
    );

    print('paseeger list connected  array....');
    print(response.statusCode);

    print(response.statusCode);
    if (response.statusCode == 201) {
      print('Passenger list....');

      // Successful POST request, handle the response here
      final responseData = jsonDecode(response.body);
      print('pass lis detailes data...');
      print(responseData);
      // var flightData = responseData['data'];
      // print('passenger list Response data...');
      // print(flightData);

    }
    // else if(response.statusCode == 400){
    //   final responseData = jsonDecode(response.body);
    //   var flighterror_Data = responseData['errors'];
    //   print('flighterror_Data...');
    //   print(flighterror_Data);
    //   for(var titledata in flighterror_Data){
    //     var titlestr = titledata['title'];
    //     print('titlestr...');
    //     print(titlestr);
    //     var detail = titledata['detail'];
    //     if(titlestr == 'SEGMENT SELL FAILURE'){
    //       final snackBar = SnackBar(
    //         content: Text(titlestr + ' , ' + 'Please check flight details and try again'),
    //       );
    //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //     } else {
    //       final snackBar = SnackBar(
    //         content: Text(detail + ' , ' +'Please try again..'),
    //       );
    //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //     }
    //   }
    // }
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
        centerTitle: true,
        leading: BackButton(
          onPressed: () async{
            print("back Pressed");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => newuserDashboard()),
            );
          },
        ),  iconTheme: IconThemeData(
          color: Colors.green
      ),
        title: Text('ABISINIYA',textAlign: TextAlign.center,
            style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

      ),
      body: FutureBuilder<dynamic>(
        //future: ViewgetData(),
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('');
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                print('imagename......');
                return Text('');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.white),
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      Container(color: Colors.white, height: 10),
                      Expanded(
                        child: Container(
                          color: Colors.white70,
                          child: LayoutBuilder(
                            builder: (context, constraint) {
                              return SingleChildScrollView(
                                physics: ScrollPhysics(),
                                child: Column(
                                  children: <Widget>[
                                    //Text('Your Apartments'),

                                    Container(
                                      height: 50,
                                      width: 340,
                                      color: Colors.black12,
                                      child: Column(
                                        children: [
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Passenger Details:",
                                                style: TextStyle(
                                                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                              )
                                          ),
                                                                                  ],
                                      ),
                                    ),


                                    SizedBox(
                                      height: 30,
                                    ),
                                    ListView.separated(
                                      //scrollDirection:Axis.horizontal,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        //itemCount:50,
                                        itemCount: snapshot.data?['data']['travelers'].length ?? '',
                                        //itemCount: firstNameArray.length,





                                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                                        itemBuilder: (BuildContext context, int index) {
                                          var RecordLocatorData = snapshot.data?['data'];
                                          print('locatorData...');
                                          print(RecordLocatorData);
                                          var travelers = RecordLocatorData['travelers'];
                                          print('RecordLocatorData travelers...');
                                          print(travelers);
                                          for(var namestr in travelers) {
                                            var nameArray = namestr['name'];
                                            // print('nameArray...');
                                            // print(nameArray);
                                            //fName = nameArray['firstName'];
                                            firstnamestr = nameArray['firstName'];
                                            // print('first name value');
                                            // print(firstnamestr);

                                            firstNameArray.add(firstnamestr);
                                            print('array...');
                                            print(firstNameArray);

                                            lastnamestr = nameArray['lastName'];
                                            // print('lastnamestr name value');
                                            // print(lastnamestr);
                                            lastNameArray.add(lastnamestr);
                                          }
                                          print('first name value');
                                          print(firstnamestr);
                                          print('lastnamestr name value');
                                          print(lastnamestr);

                                          var name = snapshot.data?['data']['travelers'][index]['name']['firstName'];
                                          print('name.....');
                                          print(name);

                                          return Container(
                                            height: 60,
                                            width: 100,
                                            alignment: Alignment.center,
                                            color: Colors.white,
                                            child: InkWell(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 60,
                                                    width: 340,
                                                    color: Colors.black12,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 100,
                                                              color: Colors.transparent,
                                                              child: Text('Name:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 240,
                                                              color: Colors.transparent,
                                                              child:Text(firstNameArray[index] + '  '+ lastNameArray[index],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black)),),
                                                              // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            )
                                                          ],
                                                        ),

                                                      ],

                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ),
                                          );
                                          //return  Text('Some text');
                                        }),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      height: 50,
                                      width: 340,
                                      color: Colors.green,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          // Container(
                                          //   height: 50,
                                          //   width: 150,
                                          //   color: Colors.white,
                                          //   child: Align(
                                          //     alignment: Alignment.center,
                                          //     child: Text(
                                          //       totalpricevalues,
                                          //       style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900,color:Colors.red),),
                                          //   ),
                                          // ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            child: Container(
                                                height: 50,
                                                width: 300,
                                                color: Colors.transparent,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      "Continue to Payment",
                                                      style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w900,color: Colors.white),
                                                      textAlign: TextAlign.center
                                                  ),
                                                )
                                            ),
                                            onTap: () async {
                                              print('seat continue btn tapped....');
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => SeatMapVC()),
                                              );
                                              //_postData();
                                              // });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],

                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  );
                }
            }
          }
      ),
    );
  }
}
