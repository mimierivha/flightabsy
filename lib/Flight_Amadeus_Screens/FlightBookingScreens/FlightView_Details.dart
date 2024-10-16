
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
import 'Flight_AddReplyVC.dart';


//import 'ViewManagePicturesVC.dart';
//import 'NewUserbooking.dart';
class FlightView_DetailsVC extends StatefulWidget {
  const FlightView_DetailsVC({super.key});
  @override
  State<FlightView_DetailsVC> createState() => _userDashboardState();
}
class _userDashboardState extends State<FlightView_DetailsVC> {
  //suresh
  final baseDioSingleton = BaseSingleton();
  String referenceID ='';
  String RetrivedPwd = '';
  String RetrivedEmail = '';
  String RetrivedBearertoekn = '';
  String departureIatastr = '';
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
  //Arrays:-
  var flightNumberArray = [];
  var aircraftNumberArray = [];
  var departureIataArray = [];
  var arrivalIataArray = [];
  var durationArray = [];
  var carrierCodeArray = [];


  var controller = ScrollController();
  int count = 15;
  int Array_cnt = 0;
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
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
    });
  }
//@override
//   Future<dynamic> Review() async {
//     //https://staging.abisiniya.com/api/v1/rating/vehicle/avgrating/81
//     String url = baseDioSingleton.AbisiniyaBaseurl + 'rating/vehicle/avgrating/$VehicleId';
//     print('avg vehicle rating...');
//     print(url);
//     var response = await http.get(
//       Uri.parse(
//           url),
//       headers: {
//         // 'Authorization':
//         // 'Bearer <--your-token-here-->',
//         "Authorization": "Bearer $RetrivedBearertoekn",
//       },
//     );
//     if (response.statusCode == 200) {
//       final data1 = jsonDecode(response.body);
//       // var data1 = jsonDecode(response.body.toString());
//       var ReviewData = data1['data']['ratingDetails'];
//       print('Review data.....');
//       print(ReviewData);
//       AvgRating_review = data1['data']['avgRating'];
//       for (var Reviewmsg in ReviewData){
//         var picReviewData = Reviewmsg['rating_comment'];
//         var scoreArray = Reviewmsg['rating_score'];
//         var createDateArray = Reviewmsg['created_at'];
//         print('review array...');
//         print(picReviewData);
//         Reviewlist.add(picReviewData);
//         scoreRatinglist.add(scoreArray);
//         ReviewcreateDatelist.add(createDateArray);
//         print('count...');
//         print(ReviewcreateDatelist.length);
//       }
//       // print(ViewApartmentList);
//       return json.decode(response.body);
//     } else {
//       // If that call was not successful, throw an error.
//       throw Exception('Failed to load post');
//     }
//   }
  Future<dynamic> getData() async {
    // String url = 'https://staging.abisiniya.com/api/v1/vehicle/auth/show/' + VehicleId.toString();
    //https://staging.abisiniya.com/api/v1/flight/flightreqshownew/U62GRQ
    SharedPreferences prefs = await SharedPreferences.getInstance();


    //aflightreqshow/{ref}
    flight_request_id = prefs.getInt('flight_request_idkey') ?? 0;
    referenceID = prefs.getString('reference_key') ?? "";

    //prefs.setString('reference_key', snapshot.data['data'][index]['reference']);

    print('retrive flight_request_id......');
    print(flight_request_id.toString());
    //https://staging.abisiniya.com/api/v1/flight/aflightreqshow/56
    //    String url = baseDioSingleton.AbisiniyaBaseurl + 'flight/aflightbookingreqlist';
    String url = baseDioSingleton.AbisiniyaBaseurl + 'flight/aflightreqshow/' + referenceID;

    print('url.....');
    print(url);
    print(RetrivedBearertoekn);
    var response = await http.get(
      Uri.parse(
          url),
      headers: {
        // 'Authorization':
        // 'Bearer <--your-token-here-->',
        "Authorization": "Bearer $RetrivedBearertoekn",
      },
    );
    if (response.statusCode == 200) {
      final data1 = jsonDecode(response.body);
      var getpicsData = [];
      var ViewflightsData = data1['data'];
      print('detailes flight data.....');
      print(ViewflightsData);
      // for (var SegmentArray in ViewflightsData) {
      //   var segmentValuesAray = SegmentArray['segments'] ?? '';
      //   print('segmentArray...');
      //   print(segmentValuesAray);
      //
      //   for(var subsegmentArray in segmentValuesAray){
      //     print('jumping...loop');
      //     print(subsegmentArray);
      //
      //
      //     var departureIatastr = subsegmentArray['departureIata'];
      //     print('departureIatastr...');
      //     print(departureIatastr);
      //     departureIataArray.add(departureIatastr);
      //   }
      //
      //
      //   // vprint('departureIataArray........');
      //   //         print(departureIataArray);ar segmentArray = [];
      //   // segmentArray.add(segmentValuesAray);
      //   // print('segmentArray...');
      //   // print(segmentArray[0] ?? "");
      //   // print(segmentArray[1] ?? "");
      //
      //
      //
      //   // print('departureIataArray...');
      //   //   // print(departureIataArray);
      //   //   var Dep = segmentValuesAray['departureIata'];
      //   //   print('loop dep...');
      //   //   print(Dep);
      //
      //
      //   // for(var departureIataArray in segmentValuesAray){
      //   //
      //   //   print('departureIataArray...');
      //   //   print(departureIataArray);
      //   //   var Dep = departureIataArray['departureIata'];
      //   //   print('loop dep...');
      //   //   print(Dep);
      //   // }
      // }
      // for (var pics in viewApartmentdata){
      //   var picData = pics['pictures'];
      //   for (var picArray in picData){
      //     var img = picArray['imageUrl'];
      //     Picture_Id = picArray['id'];
      //     print('img....');
      //     print(img);
      //     ViewApartmentList.add(img);
      //     PicArrayList.add(Picture_Id);
      //   }
      // }
      print('View Apartment success....');
      // print(ViewApartmentList);
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    //getData();
    //pics = fetchpics();
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
                                      height: 100,
                                      width: 340,
                                      color: Colors.black12,
                                      child: Column(
                                        children: [
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Flight Booking Details:",
                                                style: TextStyle(
                                                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                              )
                                          ),
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                (RetrivedProfileNamestr),
                                                style: TextStyle(
                                                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                              )
                                          ),
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                (RetrivedEmail),
                                                style: TextStyle(
                                                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                              )
                                          ),
                                        ],
                                      ),
                                    ),

                                    ListView.separated(
                                      //scrollDirection:Axis.horizontal,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        //itemCount:50,
                                        itemCount: snapshot.data?['data'].length ?? '',
                                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                                        itemBuilder: (BuildContext context, int index) {


                                          // print('departure...');
                                          // var dep = (snapshot.data?['data'].isEmpty ? 'Empty name'
                                          //     : snapshot.data?["data"][index]['segments'][index]['departureIata']?.toString() ?? 'empty');

                                          var ViewflightsData1 = (snapshot.data?["data"] ?? 'empty');

                                          print('departure....');
                                          print(ViewflightsData1);
                                          for (var SegmentArray in ViewflightsData1) {
                                            var segmentValuesAray = SegmentArray['segments'] ?? '';
                                            print('segmentArray...');
                                            print(segmentValuesAray);

                                            for(var subsegmentArray in segmentValuesAray){
                                              print('jumping...loop');
                                              print(subsegmentArray);


                                               departureIatastr = subsegmentArray['departureIata'];
                                              print('departureIatastr...');
                                              print(departureIatastr);
                                              departureIataArray.add(departureIatastr);
                                              var flightNumberstr = subsegmentArray['flightNumber'];
                                              flightNumberArray.add(flightNumberstr);
                                              var arrivalIatastr = subsegmentArray['arrivalIata'];
                                              arrivalIataArray.add(arrivalIatastr);
                                              var aircraftNumberstr = subsegmentArray['aircraftNumber'];
                                              aircraftNumberArray.add(aircraftNumberstr);
                                              var carrierCodestr = subsegmentArray['carrierCode'];
                                              carrierCodeArray.add(carrierCodestr);
                                              var durationstr = subsegmentArray['duration'];
                                              durationArray.add(durationstr);

                                            }
                                          }

                                          print('departureIataArray........');
                                          print(departureIataArray);
                                          print('Array count...');
                                          print(departureIataArray.length);
                                          Array_cnt = departureIataArray.length;
                                          print('Array_cnt...');
                                          print(Array_cnt);
                                         // print(departureIataArray[index].toString());



                                          return Container(
                                            height: 1300,
                                            width: 100,
                                            alignment: Alignment.center,
                                            color: Colors.white,
                                            child: InkWell(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 1300,
                                                    width: 340,
                                                    color: Colors.black12,
                                                    child: Column(
                                                      children: [
                                                        // Text(departureIataArray[0]),
                                                        // Text(departureIataArray[1]),

                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white70,
                                                              child: Text('Reference:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white70,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]['flightRequest']['reference']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white,
                                                              child: Text('Queing Office ID:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]['flightRequest']['queuingOfficeId']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 50,
                                                              width: 140,
                                                              color: Colors.white70,
                                                              child: Text('Departure:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 50,
                                                              width: 200,
                                                              color: Colors.white70,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]['flightRequest']['departure']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 50,
                                                              width: 140,
                                                              color: Colors.white,
                                                              child: Text('Arrival:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 50,
                                                              width: 200,
                                                              color: Colors.white,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]['flightRequest']['arrival']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white70,
                                                              child: Text('Airline:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white70,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]['flightRequest']['airline']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white,
                                                              child: Text('Carrier Code:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]['flightRequest']['carrierCode']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white70,
                                                              child: Text('Cabin:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white70,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]['flightRequest']['travel_class']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white,
                                                              child: Text('Flight Option:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]['flightRequest']['flight_option']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white70,
                                                              child: Text('Price:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white70,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]['flightRequest']['Price']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white,
                                                              child: Text('Currency:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]['flightRequest']['currency']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white70,
                                                              child: Text('Status:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white70,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]['flightRequest']['status']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),


                                                        Column(
                                                          children: [
                                                            if (Array_cnt == 1) ...[
                                                              Text('Itinerary Details',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Flight Num:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(flightNumberArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Departure:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(departureIataArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Arrival:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(arrivalIataArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Carrier:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(carrierCodeArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Aircraft:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(aircraftNumberArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Duration:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(durationArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ] else if(Array_cnt == 2)...[


                                                              Text('Itinerary Details:-1',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Flight Num:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(flightNumberArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Departure:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(departureIataArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Arrival:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(arrivalIataArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Carrier:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(carrierCodeArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Aircraft:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(aircraftNumberArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Duration:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(durationArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text('Itinerary Details-2',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Flight Num:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(flightNumberArray[1]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Departure:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(departureIataArray[1]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Arrival:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(arrivalIataArray[1]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Carrier:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(carrierCodeArray[1]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Aircraft:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(aircraftNumberArray[1]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Duration:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(durationArray[1]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ] else...[

                                                              Text('Itinerary Details:-1',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Flight Num:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(flightNumberArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Departure:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(departureIataArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Arrival:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(aircraftNumberArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Carrier:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(carrierCodeArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Aircraft:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(aircraftNumberArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Duration:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(durationArray[0]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text('Itinerary Details-2',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Flight Num:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(flightNumberArray[1]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Departure:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(departureIataArray[1]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Arrival:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(arrivalIataArray[1]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Carrier:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(carrierCodeArray[1]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Aircraft:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(aircraftNumberArray[1]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Duration:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(durationArray[1]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text('Itinerary Details-3',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Flight Num:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(flightNumberArray[2]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Departure:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(departureIataArray[2]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Arrival:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(arrivalIataArray[2]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Carrier:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(carrierCodeArray[2]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Aircraft:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(aircraftNumberArray[2]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 340,
                                                                color: Colors.red,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white70,
                                                                      child: Text('Duration:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white70,
                                                                      child:Text(durationArray[2]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),



                                                            ],
                                                          ],
                                                        ),





                                                        // Row(
                                                        //   children: [
                                                        //     Container(
                                                        //       height: 30,
                                                        //       width: 140,
                                                        //       color: Colors.white70,
                                                        //       child: Text('source:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                        //     ),
                                                        //     Container(
                                                        //       height: 30,
                                                        //       width: 200,
                                                        //       color: Colors.white70,
                                                        //       child: Text(departureIataArray[0]),
                                                        //       // child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                        //       //     : snapshot.data?["data"][index]['segments'][index]['departureIata']?.toString() ?? 'empty'),
                                                        //     )
                                                        //   ],
                                                        // ),
                                                        //
                                                        // Row(
                                                        //   children: [
                                                        //
                                                        //
                                                        //
                                                        //
                                                        //     Container(
                                                        //       height: 30,
                                                        //       width: 140,
                                                        //       color: Colors.white70,
                                                        //       child: Text('source1:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                        //     ),
                                                        //     Container(
                                                        //       height: 30,
                                                        //       width: 200,
                                                        //       color: Colors.white70,
                                                        //       child: Text(departureIataArray[1]),
                                                        //       // child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                        //       //     : snapshot.data?["data"][index]['segments'][index]['departureIata']?.toString() ?? 'empty'),
                                                        //     )
                                                        //   ],
                                                        // ),

                                                        SizedBox(
                                                          height: 5,
                                                        ),
    //                                                     Column(
    //                                                       children: [
    //                                                         Container(
    //                                                           height: 40,
    //                                                           width: 340,
    //                                                           color: Colors.red,
    //                                                           child: Text('Itinerary:',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.black),),
    //                                                         ),
    //                                                         Row(
    //                                                           children: [
    //                                                         ListView.separated(
    //                                                         //scrollDirection:Axis.horizontal,
    //                                                         physics: NeverScrollableScrollPhysics(),
    // shrinkWrap: true,
    // //itemCount:50,
    // itemCount: snapshot.data?['data'].length ?? '',
    // separatorBuilder: (BuildContext context, int index) => const Divider(),
    // itemBuilder: (BuildContext context, int index) {
    //   return Container(
    //       height: 250,
    //       width: 340,
    //       alignment: Alignment.center,
    //       color: Colors.green,
    //       child: InkWell(
    //         child: Column(
    //           children: [
    //             Container(
    //               height: 100,
    //               width: 340,
    //               color: Colors.amber,
    //
    //
    //             ),
    //           ],
    //         ),
    //       )
    //   );
    // }
    //
    //
    //                                                             // Container(
    //                                                             //   height: 30,
    //                                                             //   width: 140,
    //                                                             //   color: Colors.white70,
    //                                                             //   child: Text('Price:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
    //                                                             // ),
    //                                                             // Container(
    //                                                             //   height: 30,
    //                                                             //   width: 200,
    //                                                             //   color: Colors.white70,
    //                                                             //   child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
    //                                                             //       : snapshot.data?["data"][index]['segments'][index]['departureIata']?.toString() ?? 'empty'),
    //                                                             // )
    //                                                         ),
    //                                                           ]
    //
    //                                                         )
    //
    //                                                       ],
    //                                                     ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.transparent,
                                                              child: Text('Passengers:',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.black),),
                                                            ),

                                                          ],
                                                        ),


                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 200,
                                                              width: 340,
                                                              color: Colors.transparent,
                                                              //child: Text('Passengers:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),

                                                            child: Column(
                                                              children: [
                                                                //Text('Passengers:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white,
                                                                      child: Text('Fullname:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white,
                                                                      child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                          : snapshot.data?["data"][index]['passengers'][index]['name']?.toString() ?? 'empty' +" "+ (snapshot.data?["data"]['passengers'][index]['surname']?.toString() ?? 'empty')),
                                                                    )
                                                                  ],
                                                                ),

                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white,
                                                                      child: Text('Gender:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white,
                                                                      child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                          : snapshot.data?["data"][index]['passengers'][index]['gender']?.toString() ?? 'empty'),
                                                                    )
                                                                  ],
                                                                ),

                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white,
                                                                      child: Text('Date of Birth:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white,
                                                                      child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                          : snapshot.data?["data"][index]['passengers'][index]['dob']?.toString() ?? 'empty'),
                                                                    )
                                                                  ],
                                                                ),

                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white,
                                                                      child: Text('Email:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white,
                                                                      child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                          : snapshot.data?["data"][index]['passengers'][index]['email']?.toString() ?? 'empty'),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white,
                                                                      child: Text('Phone:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white,
                                                                      child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                          : snapshot.data?["data"][index]['passengers'][index]['phone']?.toString() ?? 'empty'),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      width: 140,
                                                                      color: Colors.white,
                                                                      child: Text('Passport:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                    ),
                                                                    Container(
                                                                      height: 30,
                                                                      width: 200,
                                                                      color: Colors.white,
                                                                      child:Text('View',style: (TextStyle(fontWeight: FontWeight.w800,fontSize: 18,color: Colors.blue)),),
                                                                    )
                                                                  ],
                                                                )

                                                              ],
                                                              //child: Text('Passengers:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),


                                                            ),

                                                            ),
                                                            // Container(
                                                            //   height: 30,
                                                            //   width: 200,
                                                            //   color: Colors.white70,
                                                            //   child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                            //       : snapshot.data?["data"]['passengers'][index]['surname']?.toString() ?? 'empty'),
                                                            // ),


                                                          ],
                                                        ),



                                                        // Column(
                                                        //   children:<Widget>[
                                                        //     //Text('Flight Images',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black54)),),
                                                        //     Text('Reply Messages',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 22,color: Colors.red),),
                                                        //     Text(snapshot.data?['data'][index]['responses'].isEmpty ? 'Not replied yet': snapshot.data?["data"][index]['responses'][index]['reply']?.toString() ?? 'empty',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 18,color: Colors.black)),
                                                        //     // InkWell(
                                                        //     //   child:Container(
                                                        //     //     height: 200,
                                                        //     //     decoration: BoxDecoration(
                                                        //     //         image: DecorationImage(image: NetworkImage(snapshot.data?['data'][index]['responses'].isEmpty ? 'Empty name' : snapshot.data?["data"][index]['responses'][index]['imageUrl']?.toString() ?? 'empty'),
                                                        //     //             fit: BoxFit.cover)
                                                        //     //     ),
                                                        //     //   ),
                                                        //     //   onTap: () {
                                                        //     //     //
                                                        //     //     // Picture_Id = PicArrayList[index];
                                                        //     //     // print('pic id..');
                                                        //     //     // print(Picture_Id);
                                                        //     //   },
                                                        //     // ),
                                                        //
                                                        //
                                                        //     // ListView.builder(
                                                        //     //     physics: NeverScrollableScrollPhysics(),
                                                        //     //     //scrollDirection: Axis.horizontal,
                                                        //     //     shrinkWrap: true,
                                                        //     //     //itemCount: snapshot.data?['data'].length ?? '',
                                                        //     //     itemCount: ViewApartmentList.length,
                                                        //     //
                                                        //     //     itemBuilder: (context,index){
                                                        //     //       Picture_Id = PicArrayList[index];
                                                        //     //       //return  Text(' Vehicles',style: TextStyle(fontSize: 22),);
                                                        //     //       return Column(
                                                        //     //         children: [
                                                        //     //           InkWell(
                                                        //     //             child:Container(
                                                        //     //               height: 200,
                                                        //     //               decoration: BoxDecoration(
                                                        //     //                   image: DecorationImage(image: NetworkImage(snapshot.data?['data'].isEmpty ? 'Empty name' : snapshot.data?["data"][index]['responses'][index]['imageUrl']?.toString() ?? 'empty'),
                                                        //     //                       fit: BoxFit.cover)
                                                        //     //               ),
                                                        //     //
                                                        //     //       //   child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                        //     //       //       : snapshot.data?["data"][index]['passengers'][index]['phone']?.toString() ?? 'empty'),
                                                        //     //       // )
                                                        //     //             ),
                                                        //     //             onTap: () {
                                                        //     //
                                                        //     //               Picture_Id = PicArrayList[index];
                                                        //     //               print('pic id..');
                                                        //     //               print(Picture_Id);
                                                        //     //             },
                                                        //     //           ),
                                                        //     //
                                                        //     //
                                                        //     //
                                                        //     //         ],
                                                        //     //       ) ;
                                                        //     //     }),
                                                        //
                                                        //     SizedBox(
                                                        //       height: 20,
                                                        //       //width: 300,
                                                        //     ),
                                                        //     InkWell(
                                                        //
                                                        //       child: Container(
                                                        //         color: Colors.green,
                                                        //
                                                        //
                                                        //         child: Container(
                                                        //           width: 360,
                                                        //           height: 50,
                                                        //           color: Colors.transparent,
                                                        //           child:Align(
                                                        //               alignment: Alignment.center,
                                                        //               child: Text(
                                                        //                 "Add Reply",
                                                        //                 style: TextStyle(
                                                        //                     color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),
                                                        //               )
                                                        //           ),
                                                        //         ),                                                              ),
                                                        //       onTap: () async{
                                                        //
                                                        //         Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                                        //           builder: (_) => Flight_Add_ReplyScreen(),
                                                        //         ),);
                                                        //         SharedPreferences prefs = await SharedPreferences.getInstance();
                                                        //        // prefs.setInt('userbookingId', ApartmentId);
                                                        //         prefs.setInt('Picturekey', Picture_Id);
                                                        //         prefs.setString('tokenkey', RetrivedBearertoekn);
                                                        //
                                                        //         print("value of your text");},
                                                        //     ),
                                                        //   ],
                                                        // ),



                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ),
                                          );
                                          //return  Text('Some text');
                                        }),

                                    // Column(
                                    //   children:<Widget>[
                                    //     Text('Passengers:-',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black54)),),
                                    //     ListView.builder(
                                    //         physics: NeverScrollableScrollPhysics(),
                                    //         //scrollDirection: Axis.horizontal,
                                    //         shrinkWrap: true,
                                    //         //itemCount: snapshot.data?['data'].length ?? '',
                                    //         itemCount: ViewApartmentList.length,
                                    //
                                    //         itemBuilder: (context,index){
                                    //           Picture_Id = PicArrayList[index];
                                    //           //return  Text(' Vehicles',style: TextStyle(fontSize: 22),);
                                    //           return Column(
                                    //             children: [
                                    //               InkWell(
                                    //                 child:Container(
                                    //                   height: 200,
                                    //                   decoration: BoxDecoration(
                                    //                       image: DecorationImage(image: NetworkImage(ViewApartmentList[index]),
                                    //                           fit: BoxFit.cover)
                                    //                   ),
                                    //                 ),
                                    //                 onTap: () {
                                    //
                                    //                   Picture_Id = PicArrayList[index];
                                    //                   print('pic id..');
                                    //                   print(Picture_Id);
                                    //                 },
                                    //               ),
                                    //             ],
                                    //           ) ;
                                    //         }),
                                    //     // InkWell(
                                    //     //   child: Container(
                                    //     //     color: Colors.green,
                                    //     //     child: Container(
                                    //     //       width: 360,
                                    //     //       height: 50,
                                    //     //       color: Colors.transparent,
                                    //     //       child:Align(
                                    //     //           alignment: Alignment.center,
                                    //     //           child: Text(
                                    //     //             "Manage Pictures",
                                    //     //             style: TextStyle(
                                    //     //                 color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),
                                    //     //           )
                                    //     //       ),
                                    //     //     ),                                                              ),
                                    //     //   onTap: () async{
                                    //     //
                                    //     //     // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                    //     //     //   builder: (_) => VehicleViewManagePictures(),
                                    //     //     // ),);
                                    //     //
                                    //     //     SharedPreferences prefs = await SharedPreferences.getInstance();
                                    //     //     prefs.setInt('userbookingId', VehicleId);
                                    //     //     prefs.setInt('Picturekey', Picture_Id);
                                    //     //     prefs.setString('tokenkey', RetrivedBearertoekn);
                                    //     //
                                    //     //     print("value of your text");},
                                    //     // ),
                                    //   ],
                                    // ),

//                                     Column(
//                                       children:<Widget>[
//                                         FutureBuilder<dynamic>(
//                                             future: Review(),
//                                             builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//                                               switch (snapshot.connectionState) {
//                                                 case ConnectionState.none:
//                                                   return Text('');
//                                                 case ConnectionState.waiting:
//                                                   return Center(child: CircularProgressIndicator());
//                                                 case ConnectionState.active:
//                                                   print('imagename......');
//                                                   return Text('');
//                                                 case ConnectionState.done:
//                                                   if (snapshot.hasError) {
//                                                     return Text(
//                                                       '${snapshot.error}',
//                                                       style: TextStyle(color: Colors.white),
//                                                     );
//                                                   } else {
//                                                     print('avg...');
//                                                     print(AvgRating_review);
//                                                     var myDouble = double.parse(AvgRating_review);
//                                                     print(myDouble);
//                                                     print(ReviewcreateDatelist.length);
//                                                     avglistMessage = '${AvgRating_review}  average based on ${ReviewcreateDatelist.length} reviews.';
//                                                     return Column(
//                                                       children: [
//                                                         Column(
//                                                           children: [
//                                                             //Text('User Ratings',style: TextStyle(fontSize: 25,fontWeight:FontWeight.w900),),
//                                                             Container(
//                                                               height: 50,
//                                                               width: 340,
//                                                               child:                                                //Text('User Ratings',style: TextStyle(fontSize: 25,fontWeight:FontWeight.w900),),
//                                                               Text('User Ratings',style: TextStyle(fontSize: 25,fontWeight:FontWeight.w900),),),
//                                                             Container(
//                                                               child: Column(
//                                                                 children: [
//                                                                   RatingBarIndicator(
//                                                                       rating: double.parse(AvgRating_review),
//                                                                       itemCount: 5,
//                                                                       itemSize: 40.0,
//                                                                       itemBuilder: (context, _) => const Icon(
//                                                                         Icons.star,
//                                                                         color: Colors.orange,
//                                                                       )),
//                                                                 ],
//                                                               ),
//
//                                                             ),
//                                                             Container(
//                                                               child:Text(avglistMessage,style: TextStyle(fontSize: 18,fontWeight:FontWeight.w900),),
//                                                               // child:Text('${(snapshot.data['data'][index]['price'].toString())}.00/Day.',textAlign: TextAlign.left,
//                                                               //   style: (TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.green)),),
//                                                             ),
//                                                           ],),
//                                                         //Text('User Ratings',style: TextStyle(fontSize: 25,fontWeight:FontWeight.w900),),
//                                                         ListView.separated(
//                                                             physics: NeverScrollableScrollPhysics(),
//                                                             shrinkWrap: true,
//                                                             //itemCount:50,
//                                                             // itemCount: snapshot.data['data'].length ?? '',
//                                                             itemCount: snapshot.data["data"]['ratingDetails'].length ?? '',
//
//                                                             //itemCount: snapshot.data?['data']['bookings'].length ?? "" ,
//                                                             //itemCount: snapshot.data!['data'][0]['bookings'][0].length ?? 0,
//                                                             //itemCount: snapshot.data?.length ?? 0,
//                                                             separatorBuilder: (BuildContext context, int index) => const Divider(),
//                                                             itemBuilder: (BuildContext context, int index) {
//                                                               //bookingID = snapshot.data['data'][index]['id'];
//                                                               // (snapshot.data?['data'].isEmpty ? 'Empty name'
//                                                               //     : snapshot.data?["data"][0]['user_detail']?['name']?.toString()
//                                                               //     ?? 'empty'),
//                                                               print('rating....');
//                                                               print(Reviewlist[index].toString());
//                                                               //print(scoreRatinglist[index].toString());
//                                                               Rating_review = scoreRatinglist[index];
//                                                               print('review score....');
//                                                               print(Rating_review);
//                                                               // print(snapshot.data['data']['ratingDetails']['rating_comment']);
//                                                               // print((snapshot.data?['data']['ratingDetails'].isEmpty ? 'Empty name'
//                                                               //     : snapshot.data?["data"]['ratingDetails'][index]['user_detail']['full_name']
//                                                               //     ?? 'empty'),);
// //                                                              Rating_review = snapshot.data['data'][index]['score'];
// //                                                              print(Rating_review.toDouble());
// // //    itemBuilder: (context,index){
//                                                               return Container(
//                                                                 height: 220,
//                                                                 width: 100,
//                                                                 alignment: Alignment.center,
//                                                                 color: Colors.white,
//                                                                 child: InkWell(
//                                                                   child: Column(
//                                                                     children: [
//                                                                       SizedBox(
//                                                                         height: 20,
//                                                                       ),
//                                                                       Container(
//                                                                         height: 190,
//                                                                         width: 340,
//                                                                         color: Colors.black12,
//                                                                         child: Column(
//                                                                           children: [
//                                                                             Column(
//                                                                               children: [
//                                                                                 Text(RetrivedProfileNamestr,style: TextStyle(fontSize: 18,fontWeight:FontWeight.w900),),
//                                                                               ],
//                                                                             ),
//                                                                             RatingBarIndicator(
//                                                                                 rating: Rating_review.toDouble(),
//                                                                                 itemCount: 5,
//                                                                                 itemSize: 40.0,
//                                                                                 itemBuilder: (context, _) => const Icon(
//                                                                                   Icons.star,
//                                                                                   color: Colors.orange,
//                                                                                 )),
//                                                                             Row(
//                                                                               children: [
//                                                                                 Container(
//                                                                                   height: 60,
//                                                                                   width: 140,
//                                                                                   color: Colors.white,
//                                                                                   child: Text('Review:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
//                                                                                 ),
//                                                                                 Container(
//                                                                                   height: 60,
//                                                                                   width: 200,
//                                                                                   color: Colors.white,
//                                                                                   //child:Text(snapshot.data['data'][index]['name'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.green)),),
//
//                                                                                   // child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
//                                                                                   //     : snapshot.data?["data"][index]?['comment']?.toString() ?? 'empty',style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black))),
//                                                                                   child:Text(Reviewlist[index].toString(),style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black))),
//                                                                                 )
//                                                                               ],
//                                                                             ),
//                                                                             Row(
//                                                                               children: [
//                                                                                 Container(
//                                                                                   height: 60,
//                                                                                   width: 140,
//                                                                                   color: Colors.white,
//                                                                                   child: Text('Date:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
//                                                                                 ),
//                                                                                 Container(
//                                                                                   height: 60,
//                                                                                   width: 200,
//                                                                                   color: Colors.white,
//                                                                                   //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
//                                                                                   child:Text(ReviewcreateDatelist[index].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 16,color: Colors.black)),),
//                                                                                 )
//                                                                               ],
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       ),
//
//                                                                     ],
//                                                                   ),
//                                                                   onTap: () async{
//                                                                     // Navigator.push(
//                                                                     //   context,
//                                                                     //   MaterialPageRoute(
//                                                                     //       builder: (context) => RatingScreen()),
//                                                                     // );
//                                                                     // SharedPreferences prefs = await SharedPreferences.getInstance();
//                                                                     //   print('booking id...');
//                                                                     //   print(snapshot.data['data'][index]['id']);
//                                                                     //   prefs.setString('makekey', snapshot.data['data'][index]['make']);
//                                                                     //   prefs.setString('modelkey', snapshot.data['data'][index]['model']);
//                                                                     //   prefs.setString('addresskey', snapshot.data['data'][index]['address']);
//                                                                     //   prefs.setString('citykey', snapshot.data['data'][index]['city']);
//                                                                     //   prefs.setInt('userbookingId', snapshot.data['data'][index]['id']);
//                                                                     //   prefs.setString('tokenkey', RetrivedBearertoekn);
//                                                                   },
//                                                                 ),
//                                                               );
//                                                               //return  Text('Some text');
//                                                             })
//                                                       ],
//                                                     );
//                                                   }
//                                               }
//                                             }
//                                         )
//                                       ],
//                                     ),

                                    // Column(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: <Widget>[
                                    //     const Text(
                                    //       'Leave Your Feedback',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800),
                                    //     ),
                                    //
                                    //     InkWell(
                                    //       onTap: () async {
                                    //         // Navigator.push(
                                    //         //   context,
                                    //         //   MaterialPageRoute(
                                    //         //       builder: (context) => VehicleRatingScreen()),
                                    //         // );
                                    //         SharedPreferences prefs = await SharedPreferences.getInstance();
                                    //         print('Vehicle id...');
                                    //         prefs.setInt('userbookingId', VehicleId);
                                    //         prefs.setString('tokenkey', RetrivedBearertoekn);
                                    //       }, // Handle your onTap
                                    //       child:Container(
                                    //         height: 50,
                                    //         width: 340,
                                    //         color: Colors.green,
                                    //         child: const Align(
                                    //           alignment: Alignment.center,
                                    //           child: Text('Review',
                                    //               style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w800
                                    //               ),
                                    //               textAlign: TextAlign.center),
                                    //         ),
                                    //       ),
                                    //
                                    //     )
                                    //
                                    //     // Container(
                                    //     //   height: 50,
                                    //     //   width: 340,
                                    //     //   color: Colors.green,
                                    //     //   child: const Align(
                                    //     //     alignment: Alignment.center,
                                    //     //     child: Text('Review',
                                    //     //         style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w800
                                    //     //         ),
                                    //     //         textAlign: TextAlign.center),
                                    //     //   ),
                                    //     // ),
                                    //   ],
                                    // ),

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
