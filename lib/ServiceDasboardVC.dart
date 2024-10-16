import 'package:flutter/material.dart';
import 'package:tourstravels/settingsVC.dart';
import 'package:tourstravels/supportVC.dart';

import 'ApartVC/Apartment.dart';
import 'ApartVC/Authenticated_Userbookingscreen.dart';
import 'Auth/Login.dart';
import 'Authenticated_Vehiclescreen.dart';
import 'Flight_Amadeus_Screens/FlightSearchVC.dart';
import 'UserDashboard_Screens/newDashboard.dart';
import 'flyScreens/Auth_flightRequestVC.dart';
import 'flyScreens/Flights.dart';
import 'Vehicles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ServiceDashboardScreen extends StatefulWidget {
  const ServiceDashboardScreen({super.key});
  @override
  State<ServiceDashboardScreen> createState() => _ServiceDashboardScreenState();
}

class _ServiceDashboardScreenState extends State<ServiceDashboardScreen> {
  List<String> LoggedinUserlist = [];
  @override
  final borderRadius = BorderRadius.circular(20); // Image border
  String Logoutstr = '';
  String LoggedInUSerstr = '';
  String NewBookingUserstr = '';
  String Signoutstr = '';
  String flightTokenstr = '';
  bool isLoading = false;

  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      Logoutstr = prefs.getString('logoutkey') ?? "";
      print('new dashboard sts...');
      print(Logoutstr);
       if(Logoutstr == 'LogoutDashboard'){
       }
    });
  }

  // Future<void> _postData() async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('https://test.travel.api.amadeus.com/v2/shopping/flight-offers'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, dynamic>{
  //           "currencyCode": "ZAR",
  //           "originDestinations": [
  //             {
  //               "id": "1",
  //               "originLocationCode": "CDG",
  //               "destinationLocationCode": "WAW",
  //               "departureDateTimeRange": {
  //                 "date": "2024-09-12"
  //               }
  //             },
  //             {
  //               "id": "2",
  //               "originLocationCode": "WAW",
  //               "destinationLocationCode": "CDG",
  //               "departureDateTimeRange": {
  //                 "date": "2024-09-17"
  //               }
  //             }
  //           ],
  //           "travelers": [
  //             {
  //               "id": "1",
  //               "travelerType": "ADULT",
  //               "fareOptions": [
  //                 "STANDARD"
  //               ]
  //             }
  //           ],
  //           "sources": [
  //             "GDS"
  //           ],
  //           "searchCriteria": {
  //             "additionalInformation": {
  //               "chargeableCheckedBags": false,
  //               "brandedFares": false
  //             },
  //             "pricingOptions": {
  //               "fareType": [
  //                 "PUBLISHED",
  //                 "NEGOTIATED"
  //               ],
  //               "includedCheckedBagsOnly": false
  //             },
  //             "flightFilters": {
  //               "carrierRestrictions": {
  //                 "includedCarrierCodes": [
  //                   "LO"
  //                 ]
  //               }
  //             }
  //           }
  //
  //       }),
  //     );
  //
  //     print('Flight search API response.......');
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       // Successful POST request, handle the response here
  //       final responseData = jsonDecode(response.body);
  //       setState(() {
  //         //result = 'ID: ${responseData['id']}\nName: ${responseData['name']}\nEmail: ${responseData['email']}';
  //       });
  //     } else {
  //       // If the server returns an error response, throw an exception
  //       throw Exception('Failed to post data');
  //     }
  //   } catch (e) {
  //     setState(() {
  //       //result = 'Error: $e';
  //     });
  //   }
  // }


  Future<void> _postData() async {
    setState(() {
      isLoading = true;
    });
    const Map<String, String> header = {
      'Content-type': 'application/x-www-form-urlencoded',
      // 'Accept': 'application/json',
    };
    var response = await http.post(
        Uri.parse("https://test.travel.api.amadeus.com/v1/security/oauth2/token"),
        body: ({
          // 'user_id': userController.text,
          // 'token': apiController.text,
          // 'device': "Android",
          "grant_type": "client_credentials",
          "client_id": "3xzMCq3eez5H14GWGesCOGdr02AKCnpj",
          "client_secret": "zIQ5idVReq6NsBtw",
        })
    );

    print('status code...');
    print(response.statusCode);
    // if (response.statusCode == 200) {
    //   final body = jsonDecode(response.body);
    //   print(body);
    //   flightTokenstr = body['access_token'];
    //   print('flightTokenstr....');
    //   print(flightTokenstr);
    //   //GetUserCarModel getUserCarModel = GetUserCarModel.fromJson(body);
    //   //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Login")));
    // }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(body);
      flightTokenstr = body['access_token'];
      print('flightTokenstr....');
      print(flightTokenstr);
      //GetUserCarModel getUserCarModel = GetUserCarModel.fromJson(body);
      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Login")));
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

  // Future<void> AmadeusPost() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   const Map<String, String> header = {
  //     'Content-type': 'application/x-www-form-urlencoded',
  //     // 'Accept': 'application/json',
  //   };
  //   var response = await http.post(
  //       Uri.parse("https://test.travel.api.amadeus.com/v1/security/oauth2/token"),
  //       body: ({
  //         // 'user_id': userController.text,
  //         // 'token': apiController.text,
  //         // 'device': "Android",
  //         "grant_type": "client_credentials",
  //         "client_id": "3xzMCq3eez5H14GWGesCOGdr02AKCnpj",
  //         "client_secret": "zIQ5idVReq6NsBtw",
  //       })
  //   );
  //
  //   print('status code...');
  //   print(response.statusCode);
  //   // if (response.statusCode == 200) {
  //   //   final body = jsonDecode(response.body);
  //   //   print(body);
  //   //   flightTokenstr = body['access_token'];
  //   //   print('flightTokenstr....');
  //   //   print(flightTokenstr);
  //   //   //GetUserCarModel getUserCarModel = GetUserCarModel.fromJson(body);
  //   //   //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Login")));
  //   // }
  //   if (response.statusCode == 200) {
  //     final body = jsonDecode(response.body);
  //     print(body);
  //     flightTokenstr = body['access_token'];
  //     print('flightTokenstr....');
  //     print(flightTokenstr);
  //     //GetUserCarModel getUserCarModel = GetUserCarModel.fromJson(body);
  //     //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Login")));
  //   } else {
  //     // If the server returns an error response, throw an exception
  //    // throw Exception('Failed to post data');
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }
  void initState() {
    // TODO: implement initState
    super.initState();
    _postData();
    _retrieveValues();
    //AmadeusPost();
  }
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner:false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.green,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Colors.white, Colors.green]),
              ),
            ),
            title: Center(
              child: Text(
                'Abisiniya',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          body:Center(
    child: isLoading?
    CircularProgressIndicator():

          Container(
            margin: EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.white, Colors.green]),
            ),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 1.0,
              children: [
                Ink(
                  color: Colors.white,
                  child: InkWell(
                    child:Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            //margin: EdgeInsets.only(top: 20,left: 20),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius),
                            child: ClipRRect(
                              borderRadius: borderRadius,
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(48), // Image radius
                                //child: Image.network('imageUrl', fit: BoxFit.cover),
                                child: Image.asset('images/apts.jpg', fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Text('Apartments',style: (TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),)
                        ],
                      ),
                    ),
                    onTap: () async{
                       SharedPreferences prefs = await SharedPreferences.getInstance();
                       print('dashboard sts...');
                      print(Logoutstr);
                      LoggedInUSerstr = prefs.getString('LoggedinUserkey') ?? "";
                      print(' logged in user...');
                      print(LoggedInUSerstr);
                       print('letters length....');
                       LoggedinUserlist.add(LoggedInUSerstr);
                       print(LoggedinUserlist);
                       print(LoggedinUserlist.length);
                      if (LoggedInUSerstr == 'LoggedUser') {
                        print('login...');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuthenticatedUserScreen()),
                        );
                        SharedPreferences prefrences = await SharedPreferences.getInstance();
                        await prefrences.remove("LoggedinUserkey");

                      }  else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Apartmentscreen()),
                        );
                      }
                    },
                  ),
                ),

                Ink(
                  color: Colors.white,
                  child: InkWell(
                    child:Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            //margin: EdgeInsets.only(top: 20,left: 20),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius),
                            child: ClipRRect(
                              borderRadius: borderRadius,
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(48), // Image radius
                                //child: Image.network('imageUrl', fit: BoxFit.cover),
                                child: Image.asset('images/Flightimg.jpg', fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Text('Flights',style: (TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),)
                        ],
                      ),
                    ),
                    onTap: () async{

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString('flightTokenstrKey', flightTokenstr);
                      print('flight token sending...');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FlightSearchVC()),
                        );


                      // LoggedinUserlist.add(LoggedInUSerstr);
                      // SharedPreferences prefs = await SharedPreferences.getInstance();
                      // LoggedInUSerstr = prefs.getString('LoggedinUserkey') ?? "";
                      // LoggedinUserlist.add(LoggedInUSerstr);
                      // if (LoggedInUSerstr == 'LoggedUser') {
                      //   print('login...');
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => AuthFlightScreen()),
                      //   );
                      //   SharedPreferences prefrences = await SharedPreferences.getInstance();
                      //   await prefrences.remove("LoggedinUserkey");
                      //
                      // }  else{
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => FlightScreen()),
                      //   );
                      // }
                    },
                  ),
                ),
                Ink(
                  color: Colors.white,
                  child: InkWell(
                    child:Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            //margin: EdgeInsets.only(top: 20,left: 20),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius),
                            child: ClipRRect(
                              borderRadius: borderRadius,
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(48), // Image radius
                                //child: Image.network('imageUrl', fit: BoxFit.cover),
                                child: Image.asset('images/carimgs.jpg', fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Text('Vehicles',style: (TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),)
                        ],
                      ),
                    ),
                    onTap: () async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      Logoutstr = prefs.getString('logoutkey') ?? "";
                      print('vehicle dashboard sts...');
                      print(Logoutstr);
                      LoggedinUserlist.add(LoggedInUSerstr);
                     // SharedPreferences prefs = await SharedPreferences.getInstance();
                      LoggedInUSerstr = prefs.getString('LoggedinUserkey') ?? "";
                      LoggedinUserlist.add(LoggedInUSerstr);
                      print('vehcle LoggedInUSerstr.....');
                      print(LoggedInUSerstr);
                      if (LoggedInUSerstr == 'LoggedUser') {
                        print('vehicle login...');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuthenticatedVehiclescreen()),
                        );
                        SharedPreferences prefrences = await SharedPreferences.getInstance();
                        await prefrences.remove("LoggedinUserkey");

                      }  else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Vehiclescreen()),
                        );
                      }
                      // if(Logoutstr == 'LogoutDashboard'){
                      //   print('loged in user....');
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => AuthenticatedVehiclescreen()),
                      //   );
                      // } else {
                      //   print('fresh vehicle use...');
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Vehiclescreen()),
                      //   );                      }
                    },
                  ),
                ),
                Ink(
                  color: Colors.white,
                  child: InkWell(
                    child:Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            //margin: EdgeInsets.only(top: 20,left: 20),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius),
                            child: ClipRRect(
                              borderRadius: borderRadius,
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(48), // Image radius
                                //child: Image.network('imageUrl', fit: BoxFit.cover),
                                child: Image.asset('images/profileimg.jpg', fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Text('My Profile',style: (TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),)
                        ],
                      ),
                    ),
                    onTap: () async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      Logoutstr = prefs.getString('logoutkey') ?? "";
                      print('vehicle dashboard sts...');
                      print(Logoutstr);
                      LoggedinUserlist.add(LoggedInUSerstr);
                      // SharedPreferences prefs = await SharedPreferences.getInstance();
                      LoggedInUSerstr = prefs.getString('LoggedinUserkey') ?? "";
                      LoggedinUserlist.add(LoggedInUSerstr);
                      print('vehcle LoggedInUSerstr.....');
                      print(LoggedInUSerstr);
                      if (LoggedInUSerstr == 'LoggedUser') {
                        print('vehicle login...');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => newuserDashboard()),
                        );
                        SharedPreferences prefrences = await SharedPreferences.getInstance();
                        await prefrences.remove("LoggedinUserkey");

                      }  else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login()),
                        );
                      }
                      // if(Logoutstr == 'LogoutDashboard'){
                      //   print('loged in user....');
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => AuthenticatedVehiclescreen()),
                      //   );
                      // } else {
                      //   print('fresh vehicle use...');
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Vehiclescreen()),
                      //   );                      }
                    },
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => Login()),
                    //   );
                    // },
                  ),
                ),
                Ink(
                  color: Colors.white,
                  child: InkWell(
                    child:Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            //margin: EdgeInsets.only(top: 20,left: 20),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius),
                            child: ClipRRect(
                              borderRadius: borderRadius,
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(48), // Image radius
                                //child: Image.network('imageUrl', fit: BoxFit.cover),
                                child: Image.asset('images/Settingsimg.jpg', fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Text('More',style: (TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),)
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => settingsScreen()),
                      );
                    },
                  ),
                ),
                Ink(
                  color: Colors.white,
                  child: InkWell(
                    child:Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            //margin: EdgeInsets.only(top: 20,left: 20),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius),
                            child: ClipRRect(
                              borderRadius: borderRadius,
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(48), // Image radius
                                //child: Image.network('imageUrl', fit: BoxFit.cover),
                                child: Image.asset('images/support.jpg', fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Text('Support',style: (TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),)
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => supportScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          )
        )
    );
  }
}
