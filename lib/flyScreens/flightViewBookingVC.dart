
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
import 'package:tourstravels/flyScreens/sendReplyVC.dart';
import 'package:tourstravels/tabbar.dart';
import 'package:tourstravels/My_Apartments/My_AprtmetsVC.dart';
import 'package:tourstravels/My_Apartments/ViewApartmentVC.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
// import 'MyBooking_AddReplyImage.dart';
// import 'MybookingVC.dart';
import 'MyflightRequest.dart';


//import 'NewUserbooking.dart';
class flightViewBookingscreen extends StatefulWidget {
  // const MyApartmentScreen({super.key});

  @override
  State<flightViewBookingscreen> createState() => _userDashboardState();
}

class _userDashboardState extends State<flightViewBookingscreen> {
  final baseDioSingleton = BaseSingleton();
  int bookingID = 0;
  String Referencestr = '';

  String RetrivedBearertoekn = '';
  String Bookingsts = 'Not booked yet!';
  int ApartmentId = 0;
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // RetrivedEmail = prefs.getString('emailkey') ?? "";
      // RetrivedPwd = prefs.getString('passwordkey') ?? "";
      //Referencestr = prefs.getString('referencekey') ?? "";
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      bookingID = prefs.getInt('userbookingId') ?? 0;
      print('bookingID id---');
      print(bookingID);
      print('My Apartment token');
      print(RetrivedBearertoekn);
    });
  }
//@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    getData();

  }

  Future<dynamic> getData() async {
    // String url = 'https://staging.abisiniya.com/api/v1/booking/apartment/mybookingdetail/$bookingID';
    //bookingID == 118;
    //String url = 'https://staging.abisiniya.com/api/v1/flight/show/12';
    String url = baseDioSingleton.AbisiniyaBaseurl + 'flight/show/$bookingID';

    print('url');
    print(url);

    var response = await http.get(
      Uri.parse(
          url),
      headers: {
        // 'Authorization':
        // 'Bearer <--your-token-here-->',
        "Authorization": "Bearer $RetrivedBearertoekn",

      },
    );
    print('code...');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data1 = jsonDecode(response.body);
      var getpicsData = [];
      var jsonData = data1['data'];
      print(jsonData);
      // for (var record in picstrr) {
      //   idnum = record['id'];
      // }
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text(
      //     'Abisiniya',
      //   ),
      //   // backgroundColor: const Color(0xff764abc),
      //   backgroundColor: Colors.green,
      //
      // ),
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          onPressed: () async{
            print("back Pressed");
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // prefs.setString('logoutkey', ('LogoutDashboard'));
            //prefs.setString('Property_type', ('Apartment'));
            //prefs.setString('LoggedinUserkey', LoggedInUser);


            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FluBooking_RequestScreen()),
            );
            // LoggedInUser = 'LoggedUser';
            // prefs.setString('LoggedinUserkey', LoggedInUser);
            //
            // NewBookingUserstr = prefs.getString('newBookingUserkey') ?? "";
            // LoggedInUSerstr = prefs.getString('LoggedinUserkey') ?? "";
            // print(' dashboard logged in user...');
            // print(LoggedInUSerstr);
            // print(NewBookingUserstr);

          },

        ),
        // iconTheme: IconThemeData(
        //     color: Colors.green,
        // ),
        title: Text('Flight Booking',textAlign: TextAlign.center,
            style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

      ),
      body: FutureBuilder<dynamic>(

        //future: BookingDashboardUsers,
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
                  //return InkWell(

                  return Column(
                    children: <Widget>[
                      //Container(color: Colors.red, height: 50),
                      Container(
                        height: 10,
                        width: 340,
                        color: Colors.white,

                      ),

                      Expanded(
                        child: Container(
                          color: Colors.white70,
                          child: LayoutBuilder(
                            builder: (context, constraint) {
                              return SingleChildScrollView(
                                physics: ScrollPhysics(),

                                child: Column(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        //Container(color: Colors.red, height: 50),
                                        Container(
                                          height: 100,
                                          width: 340,
                                          color: Colors.black12,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    width: 140,
                                                    color: Colors.transparent,
                                                    child: Text('Name:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                  ),
                                                  Container(
                                                      height: 30,
                                                      width: 200,
                                                      color: Colors.transparent,
                                                      child:Align(
                                                          alignment: Alignment.topLeft,
                                                          child: Text(
                                                            (snapshot.data?['data'][0]['flightRequest'].isEmpty ? 'Empty name'
                                                                : snapshot.data?["data"][0]['flightRequest'][0]['user_id']?['name'].toString()
                                                                ?? 'empty') + ' ' + (snapshot.data?['data'][0]['flightRequest'][0].isEmpty ? 'Empty name'
                                                                : snapshot.data?["data"][0]['flightRequest'][0]['user_id']?['surname'].toString()
                                                                ?? 'empty'),
                                                            style: TextStyle(
                                                                color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                          )
                                                      )
                                                    // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                  )
                                                ],
                                              ),

                                              Row(
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    width: 140,
                                                    color: Colors.transparent,
                                                    child: Text('Email:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                  ),
                                                  Container(
                                                      height: 30,
                                                      width: 200,
                                                      color: Colors.transparent,
                                                      child:Align(
                                                          alignment: Alignment.topLeft,
                                                          child: Text(
                                                            (snapshot.data?['data'][0]['flightRequest'][0].isEmpty ? 'Empty name'
                                                                : snapshot.data?["data"][0]['flightRequest'][0]['user_id']?['email'].toString()
                                                                ?? 'empty'),
                                                            style: TextStyle(
                                                                color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                          )
                                                      )
                                                    // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    width: 140,
                                                    color: Colors.transparent,
                                                    child: Text('Phone:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                  ),
                                                  Container(
                                                      height: 30,
                                                      width: 200,
                                                      color: Colors.transparent,
                                                      child:Align(
                                                          alignment: Alignment.topLeft,
                                                          child: Text(
                                                            (snapshot.data?['data'][0]['flightRequest'][0].isEmpty ? 'Empty name'
                                                                : snapshot.data?["data"][0]['flightRequest'][0]['user_id']?['phone'].toString()
                                                                ?? 'empty'),
                                                            style: TextStyle(
                                                                color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                          )
                                                      )
                                                    // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                  )
                                                ],
                                              ),
                                              //

                                            ],
                                          ),
                                        ),

                                        Text('Flight booked',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),


                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 140,
                                              color: Colors.transparent,
                                              child: Text('From:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                            ),
                                            Container(
                                                height: 40,
                                                width: 200,
                                                color: Colors.transparent,
                                                child:Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      (snapshot.data?['data'][0]['flightRequest'][0].isEmpty ? 'Empty name'
                                                          : snapshot.data?["data"][0]['flightRequest'][0]['from'].toString()
                                                          ?? 'empty'),
                                                      style: TextStyle(
                                                          color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                    )
                                                )
                                              // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 140,
                                              color: Colors.transparent,
                                              child: Text('To:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                            ),
                                            Container(
                                                height: 40,
                                                width: 200,
                                                color: Colors.transparent,
                                                child:Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      (snapshot.data?['data'][0]['flightRequest'][0].isEmpty ? 'Empty name'
                                                          : snapshot.data?["data"][0]['flightRequest'][0]['to'].toString()
                                                          ?? 'empty'),
                                                      style: TextStyle(
                                                          color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                    )
                                                )
                                              // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 140,
                                              color: Colors.transparent,
                                              child: Text('Airline:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                            ),
                                            Container(
                                                height: 40,
                                                width: 200,
                                                color: Colors.transparent,
                                                child:Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      (snapshot.data?['data'][0]['flightRequest'][0].isEmpty ? 'Empty name'
                                                          : snapshot.data?["data"][0]['flightRequest'][0]['airline'].toString()
                                                          ?? 'empty'),
                                                      style: TextStyle(
                                                          color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                    )
                                                )
                                              // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 140,
                                              color: Colors.transparent,
                                              child: Text('Depart Date:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                            ),
                                            Container(
                                                height: 40,
                                                width: 200,
                                                color: Colors.transparent,
                                                child:Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      (snapshot.data?['data'][0]['flightRequest'][0].isEmpty ? 'Empty name'
                                                          : snapshot.data?["data"][0]['flightRequest'][0]['departure_date'].toString()
                                                          ?? 'empty'),
                                                      style: TextStyle(
                                                          color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                    )
                                                )
                                              // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 140,
                                              color: Colors.transparent,
                                              child: Text('Return Date:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                            ),
                                            Container(
                                                height: 40,
                                                width: 200,
                                                color: Colors.transparent,
                                                child:Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      (snapshot.data?['data'][0]['flightRequest'][0].isEmpty ? 'Empty name'
                                                          : snapshot.data?["data"][0]['flightRequest'][0]['return_date'].toString()
                                                          ?? 'empty'),
                                                      style: TextStyle(
                                                          color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                    )
                                                )
                                              // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 140,
                                              color: Colors.transparent,
                                              child: Text('Travel Class:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                            ),
                                            Container(
                                                height: 40,
                                                width: 200,
                                                color: Colors.transparent,
                                                child:Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      (snapshot.data?['data'][0]['flightRequest'][0].isEmpty ? 'Empty name'
                                                          : snapshot.data?["data"][0]['flightRequest'][0]['travel_class'].toString()
                                                          ?? 'empty'),
                                                      style: TextStyle(
                                                          color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                    )
                                                )
                                              // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 140,
                                              color: Colors.transparent,
                                              child: Text('Trip option:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                            ),
                                            Container(
                                                height: 40,
                                                width: 200,
                                                color: Colors.transparent,
                                                child:Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      (snapshot.data?['data'][0]['flightRequest'][0].isEmpty ? 'Empty name'
                                                          : snapshot.data?["data"][0]['flightRequest'][0]['trip_option'].toString()
                                                          ?? 'empty'),
                                                      style: TextStyle(
                                                          color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                    )
                                                )
                                              // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 140,
                                              color: Colors.transparent,
                                              child: Text('Additional:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                            ),
                                            Container(
                                                height: 40,
                                                width: 200,
                                                color: Colors.transparent,
                                                child:Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      (snapshot.data?['data'][0]['flightRequest'][0].isEmpty ? 'Empty name'
                                                          : snapshot.data?["data"][0]['flightRequest'][0]['message'].toString()
                                                          ?? 'empty'),
                                                      style: TextStyle(
                                                          color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                    )
                                                )
                                              // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                            )
                                          ],
                                        ),


                                        Column(
                                          children: [

                                            // Align(
                                            //   alignment: Alignment.center,
                                            //   child: Container(
                                            //     color: Colors.transparent,
                                            //     child: Text('Action:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black),),
                                            //   ),
                                            // ),

                                            // SizedBox(
                                            //   width: 30,
                                            // ),
                                            InkWell(
                                              child: Container(
                                                color: Colors.green,
                                                child: Container(
                                                  width: 340,
                                                  height: 40,
                                                  color: Colors.transparent,
                                                  //child: Text('View',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.white),),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                      color: Colors.transparent,
                                                      child: Text('Add Reply',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.white),),
                                                    ),
                                                  ),


                                                ),                                                              ),
                                              onTap: () async {

                                                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                                  builder: (_) => flightAddReplyscreen(),
                                                ),);
                                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                                print('img in bokking....');
                                                print(bookingID);
                                                print(RetrivedBearertoekn);
                                                prefs.setInt('userbookingId', bookingID);
                                                prefs.setString('tokenkey', RetrivedBearertoekn);
                                                // prefs.setInt('userbookingId', snapshot.data['data'][index]['id']);
                                                // prefs.setString('tokenkey', RetrivedBearertoekn);

                                              },
                                            ),


                                          ],
                                        ),

                                        Column(
                                          children:<Widget>[
                                            //Text('second test'),
                                            ListView.separated(
                                                physics: NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: snapshot.data?["data"][0]['flightResponse'].length ?? '',


                                                separatorBuilder: (BuildContext context, int index) => const Divider(),


                                                itemBuilder: (BuildContext context, int index) {

                                                  SizedBox(
                                                    height: 20,
                                                  );
                                                  return Container(

                                                      child: Column(

                                                        children: [
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              Container(
                                                                height: 50,
                                                                width: 140,
                                                                color: Colors.transparent,
                                                                child:Text(
                                                                  (snapshot.data?['data'][0]['flightResponse'][0].isEmpty ? 'Empty name'
                                                                      : snapshot.data?["data"][0]['flightResponse'][0]['created_at'].toString()
                                                                      ?? 'empty'),
                                                                  style: TextStyle(
                                                                      color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
                                                                ),
                                                              ),
                                                              Container(
                                                                  height: 50,
                                                                  width: 200,
                                                                  color: Colors.transparent,
                                                                  child:Align(
                                                                    alignment: Alignment.topLeft,
                                                                      child: Text(
                                                                        (snapshot.data?['data'][0]['flightRequest'].isEmpty ? 'Empty name'
                                                                            : snapshot.data?["data"][0]['flightRequest'][0]['user_id']?['name'].toString()
                                                                            ?? 'empty') + ' ' + (snapshot.data?['data'][0]['flightRequest'][0].isEmpty ? 'Empty name'
                                                                            : snapshot.data?["data"][0]['flightRequest'][0]['user_id']?['surname'].toString()
                                                                            ?? 'empty'),
                                                                        style: TextStyle(
                                                                            color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                                      )
                                                                    // child:Text(
                                                                    //   (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                                    //       : snapshot.data?["data"]['booking'][0]['customerDetail']?['name'].toString()
                                                                    //       ?? 'empty') + (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                                    //       : snapshot.data?["data"]['booking'][0]['customerDetail']?['surname'].toString()
                                                                    //       ?? 'empty'),
                                                                    //   style: TextStyle(
                                                                    //       color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                                    // ),
                                                                  )
                                                                // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              Container(
                                                                height: 50,
                                                                width: 140,
                                                                color: Colors.transparent,
                                                                child:Text(
                                                                  ('Date & Time'),
                                                                  style: TextStyle(
                                                                      color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
                                                                ),
                                                              ),
                                                              Container(
                                                                  height: 50,
                                                                  width: 200,
                                                                  color: Colors.transparent,
                                                                  child:Align(
                                                                    alignment: Alignment.topLeft,
                                                                    child:Text((snapshot.data?['data'][0]['flightResponse'][0].isEmpty ? 'Empty name' : snapshot.data?["data"][0]['flightResponse'][0]['reply'].toString()
                                                                        ?? 'empty'), style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                                    ),
                                                                  )




                                                                // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                  );
                                                })

                                          ],
                                        )
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

                  );

                }
            }
          }
      ),
      // body: Center(
      //   child: Column(
      //     children: [
      //       SizedBox(
      //         height: 50,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
