
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
import 'package:tourstravels/My_Apartments/ViewApartmentVC.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';

import '../UserDashboard_Screens/newDashboard.dart';
import 'OnwardJourney_PassengerlistVC.dart';
import 'SeatMap/seatMapVC.dart';
//import 'NewUserbooking.dart';
class OnwardJourneyPassengerListViewDetails extends StatefulWidget {
  const OnwardJourneyPassengerListViewDetails({super.key});

  @override
  State<OnwardJourneyPassengerListViewDetails> createState() => _userDashboardState();
}

class _userDashboardState extends State<OnwardJourneyPassengerListViewDetails> {
  final baseDioSingleton = BaseSingleton();
  // int bookingID = 0;
  // var API = '';
  // String status = '';
  // int _counter = 0;
  // int idnum = 0;
  // String Date = '';
  // int selectedIndex = 0;
  // int imageID = 0;
  // String citystr = '';
  // String RetrivedPwd = '';
  // String RetrivedEmail = '';
  // String RetrivedBearertoekn = '';
  // String Bookingsts = 'Not booked yet!';
  // String Statusstr = '';
  //Amades api's token
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
  String OrderID = '';
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
  var firstNameArray = [];
  var lastNameArray = [];
  var phone_Array = [];
  var contact_Array = [];
  var email_Array = [];
  var gender_Array = [];

  // String stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
  //String stsbaseurl = baseDioSingleton.AbisiniyaBaseurl + 'booking/apartment/';

  String stsId = '';
  int ApartmentId = 0;
  var controller = ScrollController();
  late Future<List<DashboardApart>> BookingDashboardUsers ;
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
      // print('price...');
      // print(pricestr);

      OrderID = prefs.getString('OrderIDkey') ?? '';
      print('orderid in view details');
      print(OrderID);
      local_Abiniyatokenvalue = prefs.getString('local_Flight_tokenkey') ?? '';
      // print('local_Abiniyatokenvalue....');
      // print(local_Abiniyatokenvalue);

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
      // print('departure name...');
      // print(RetrivedOnew_Oneway_DestinationCitynamestr);
      Retrived_Oneway_iatacodestr = prefs.getString('Oneway_iatacodekey') ?? '';
      Retrived_Oneway_Citynamestr = prefs.getString('Oneway_Citynamekey') ?? '';
      // print('Arrival name str...');
      // print(Retrived_Oneway_Citynamestr);
      CurrencyCodestr = prefs.getString('currency_code_dropdownvaluekey') ?? '';
      // print('Currency code...');
      // print(CurrencyCodestr);
      Travel_class_str = prefs.getString('travel_classstr') ?? '';
      // print('Travel_class_str...');
      // print(Travel_class_str);
      flight_optionstr = prefs.getString('flight_optionkey') ?? '';
      // print('flight_optionstr...');
      // print(flight_optionstr);

      referencestr = prefs.getString('reference_key') ?? '';
      // print('referencestr...');
      // print(referencestr);
      firstnamestr = prefs.getString('passenger_firstname_key') ?? '';
      print('firstnamestr...');
      print(firstnamestr);

      lastnamestr = prefs.getString('passenger_lastname_key') ?? '';
      print('lastnamestr...');
      print(lastnamestr);

      phonestr = prefs.getString('passenger_phone_key') ?? '';
      // print('phonestr...');
      // print(phonestr);

      emailstr = prefs.getString('passenger_email_key') ?? '';
      // print('emailstr...');
      // print(emailstr);

      genderstr = prefs.getString('passenger_gender_key') ?? '';
      // print('genderstr...');
      // print(genderstr);

      dobstr = prefs.getString('passenger_dob_key') ?? '';
      // print('dobstr...');
      // print(dobstr);

      travellerId = prefs.getString('travellerIdkey') ?? '';
      print('travellerId...');
      print(travellerId);





    });
  }
//@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    _postData();
    //Passengerlist_ByRecordRetriveAPI();
    //  BookingDashboardUsers = DashboardBooking_fetchUsers();
    //pics = fetchpics();
  }

  Future<dynamic> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    OrderID = prefs.getString('OrderIDkey') ?? '';
    print('orderid in view details');
    print(OrderID);
    local_Abiniyatokenvalue = prefs.getString('local_Flight_tokenkey') ?? '';
    // print('local_Abiniyatokenvalue....');
    // print(local_Abiniyatokenvalue);

    // String url = 'https://staging.abisiniya.com/api/v1/vehicle/auth/show/' + VehicleId.toString();
    //https://staging.abisiniya.com/api/v1/flight/flightreqshownew/U62GRQ
    String url = 'https://test.travel.api.amadeus.com/v1/booking/flight-orders/' + OrderID;



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
      var travelers = RecordLocatorData['travelers'];
      print('RecordLocatorData travelers...');
      print(travelers);
      for(var namestr in travelers) {
        var nameArray = namestr['name'];
        // print('nameArray...');
        // print(nameArray);
        //fName = nameArray['firstName'];
        var firstnamestr = nameArray['firstName'];
        print('first name value');
        print(firstnamestr);

        firstNameArray.add(firstnamestr);
        print('array...');
        print(firstNameArray);
      }

      // print(ViewApartmentList);
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
  // Future<dynamic> Passengerlist_ByRecordRetriveAPI() async {
  //   // String url = 'https://staging.abisiniya.com/api/v1/apartment/auth/
  //   String url = 'https://test.travel.api.amadeus.com/v1/booking/flight-orders/' + OrderID;
  //
  //   print('url...');
  //   print(url);
  //   //{{API_URL}}/v1/booking/flight-orders/eJzTd9cPNgsP8jYHAAtQAlo%3D
  //
  //   //String url = baseDioSingleton.AbisiniyaBaseurl + 'apartment/auth/list';
  //
  //   var response = await http.get(
  //     Uri.parse(
  //         url),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       "Content-Type": "application/json",
  //       "Accept": "application/json",
  //       //"Authorization": "Bearer ${flightTokenstr}",
  //       "Authorization": "Bearer $flightTokenstr",
  //
  //     },
  //     // headers: {
  //     //   // 'Authorization':
  //     //   // 'Bearer <--your-token-here-->',
  //     //   "Authorization": "Bearer $RetrivedBearertoekn",
  //     //
  //     // },
  //   );
  //   print('list view status code...');
  //   print(response.statusCode);
  //
  //   if (response.statusCode == 200) {
  //     final data1 = jsonDecode(response.body);
  //     var RecordLocatorData = data1['data'];
  //     // print('RecordLocatorData...');
  //     // print(RecordLocatorData);
  //     var travelers = RecordLocatorData['travelers'];
  //     // print('RecordLocatorData travelers...');
  //     // print(travelers);
  //     // var genderstr = travelers['gender'];
  //     // print('gender values...');
  //     // print(genderstr);
  //     for(var genderArray in travelers){
  //       gender = genderArray['gender'];
  //       gender_Array.add(gender);
  //       print('gender value..');
  //       print(gender);
  //     }
  //     for(var namestr in travelers){
  //       var nameArray = namestr['name'];
  //       // print('nameArray...');
  //       // print(nameArray);
  //       //fName = nameArray['firstName'];
  //       var firstnamestr = nameArray['firstName'];
  //
  //       firstNameArray.add(firstnamestr);
  //       print('fname...');
  //       print(firstnamestr);
  //       print(firstNameArray);
  //       var lastnamestr = nameArray['lastName'];
  //
  //       // lName = nameArray['lastName'];
  //       lastNameArray.add(lastnamestr);
  //       print('lName...');
  //       print(lastnamestr);
  //       print(lastNameArray);
  //       fullName = fName + ' ' + lName;
  //       var contactArray = namestr['contact'];
  //       contact_Array.add(contactArray);
  //       // print('contactArray...');
  //       // print(contactArray);
  //       eMail = contactArray['emailAddress'];
  //       email_Array.add(eMail);
  //       print('emailAddress...');
  //       print(eMail);
  //       var phoneArray = contactArray['phones'];
  //       print('phonearray...');
  //       print(phoneArray);
  //       for(var phonenumberData in phoneArray){
  //         phonenumber = phonenumberData['number'];
  //         phone_Array.add(phonenumber);
  //         print('phone number');
  //         print(phonenumber);
  //       }
  //       //
  //       // for(var phoneData in contactArray){
  //       //   var phoneArray = phoneData['phones'];
  //       //   print('phonearray...');
  //       //   print(phoneArray);
  //       //   // var phonenumber = phoneArray['number'];
  //       //   // print('phonenumber...');
  //       //   // print(phonenumber);
  //       // }
  //
  //     }
  //
  //     return json.decode(response.body);
  //   } else {
  //     // If that call was not successful, throw an error.
  //     //throw Exception('Failed to load post');
  //   }
  // }



  //Passenger list post API calling...
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
        "flight_id":OrderID,
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

    print('paseeger list array....');
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

  //Alert Dialog box
  DeclinedshowAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {},
    );
    Widget continueButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PivotDashboard()),
        );
        //Navigator.push(
        //context, MaterialPageRoute(builder: (context) => Page1()));
        //Navigator.pushNamed(context, AppRoutes.helpScreen);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text(
          "Do you want Update Decline!"),
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
//Status Alert
  UpdatedstatusshowAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {},
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PivotDashboard()),
        );
        //Navigator.push(
        //context, MaterialPageRoute(builder: (context) => Page1()));
        //Navigator.pushNamed(context, AppRoutes.helpScreen);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text(
          "Do you want Update the status!"),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  builder: (context) => Passengerlist()),
            );

          },
        ),
        title: Text('Passenger Details',textAlign: TextAlign.center,
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
                      // Container(
                      //   height: 50,
                      //   width: 340,
                      //   color: Colors.black54,
                      //
                      //   child: Column(
                      //     children: [
                      //
                      //
                      //     ],
                      //   ),
                      // ),
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
                                    Text('Contact View Details:',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),

                                    SizedBox(
                                      height: 20,
                                    ),

                                    ListView.separated(
                                      //scrollDirection:Axis.horizontal,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        //itemCount:50,
                                        //itemCount: snapshot.data?['data'].length ?? '',
                                        itemCount: firstNameArray.length,

                                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                                        itemBuilder: (BuildContext context, int index) {
                                          return Container(
                                           height: 200,
                                           width: 320,
                                           color: Colors.black12,
                                           child: Column(
                                             children: [
                                                 SizedBox(
                                                   height: 20,
                                                 ),
                                                 // Row(
                                                 //   children: [
                                                 //     Container(
                                                 //       height: 30,
                                                 //       width: 100,
                                                 //       color: Colors.transparent,
                                                 //       child: Text('Name:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                 //     ),
                                                 //     Container(
                                                 //       height: 30,
                                                 //       width: 240,
                                                 //       color: Colors.transparent,
                                                 //       child:Text(fullName,textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black)),),
                                                 //       // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                 //     )
                                                 //   ],
                                                 // ),
                                                 //
                                                 // Row(
                                                 //   children: [
                                                 //     Container(
                                                 //       height: 30,
                                                 //       width: 100,
                                                 //       color: Colors.transparent,
                                                 //       child: Text('Gender:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                 //     ),
                                                 //     Container(
                                                 //       height: 30,
                                                 //       width: 240,
                                                 //       color: Colors.transparent,
                                                 //       //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                 //       child:Text(gender,textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black)),),
                                                 //     )
                                                 //   ],
                                                 // ),
                                                 //
                                                 // Row(
                                                 //   children: [
                                                 //     Container(
                                                 //       height: 30,
                                                 //       width: 100,
                                                 //       color: Colors.transparent,
                                                 //       child: Text('Phone:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                 //     ),
                                                 //     Container(
                                                 //       height: 30,
                                                 //       width: 240,
                                                 //       color: Colors.transparent,
                                                 //       //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                 //       child:Text(phonenumber,textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black)),),
                                                 //     )
                                                 //   ],
                                                 // ),
                                                 //
                                                 // Row(
                                                 //   children: [
                                                 //     Container(
                                                 //       height: 30,
                                                 //       width: 100,
                                                 //       color: Colors.transparent,
                                                 //       child: Text('Email:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                 //     ),
                                                 //     Container(
                                                 //       height: 50,
                                                 //       width: 240,
                                                 //       color: Colors.transparent,
                                                 //       //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                 //       child:Text(eMail,textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black)),),
                                                 //     )
                                                 //   ],
                                                 // ),
                                               Container(
                                                 height: 160,
                                                 width: 340,
                                                 alignment: Alignment.center,
                                                 color: Colors.grey,
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
                                                           child:Text(firstNameArray[index] + '  '+ '',textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black)),),
                                                           // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                         )
                                                       ],
                                                     ),

                                                     // Row(
                                                     //   children: [
                                                     //     Container(
                                                     //       height: 30,
                                                     //       width: 100,
                                                     //       color: Colors.transparent,
                                                     //       child: Text('Gender:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                     //     ),
                                                     //     Container(
                                                     //       height: 30,
                                                     //       width: 240,
                                                     //       color: Colors.transparent,
                                                     //       //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                     //       child:Text(gender_Array[index],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black)),),
                                                     //     )
                                                     //   ],
                                                     // ),
                                                     //
                                                     // Row(
                                                     //   children: [
                                                     //     Container(
                                                     //       height: 30,
                                                     //       width: 100,
                                                     //       color: Colors.transparent,
                                                     //       child: Text('Phone:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                     //     ),
                                                     //     Container(
                                                     //       height: 30,
                                                     //       width: 240,
                                                     //       color: Colors.transparent,
                                                     //       //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                     //       child:Text(phone_Array[index],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black)),),
                                                     //     )
                                                     //   ],
                                                     // ),
                                                     //
                                                     // Row(
                                                     //   children: [
                                                     //     Container(
                                                     //       height: 30,
                                                     //       width: 100,
                                                     //       color: Colors.transparent,
                                                     //       child: Text('Email:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                     //     ),
                                                     //     Container(
                                                     //       height: 50,
                                                     //       width: 240,
                                                     //       color: Colors.transparent,
                                                     //       //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                     //       child:Text(email_Array[index],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black)),),
                                                     //     )
                                                     //   ],
                                                     // ),


                                                   ],
                                                 ),
                                               ),
                                               // SizedBox(
                                               //   height: 2,
                                               // ),
                                               // Container(
                                               //   height: 60,
                                               //   width: 340,
                                               //   color: Colors.green,
                                               //   child: Row(
                                               //     children: [
                                               //       SizedBox(
                                               //         width: 10,
                                               //       ),
                                               //       Container(
                                               //         height: 50,
                                               //         width: 150,
                                               //         color: Colors.white,
                                               //         child: Align(
                                               //           alignment: Alignment.center,
                                               //           child: Text(
                                               //             totalpricevalues,
                                               //             style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900,color:Colors.red),),
                                               //         ),
                                               //       ),
                                               //       SizedBox(
                                               //         width: 5,
                                               //       ),
                                               //       InkWell(
                                               //         child: Container(
                                               //             height: 50,
                                               //             width: 150,
                                               //             color: Colors.blue,
                                               //             child: Align(
                                               //               alignment: Alignment.center,
                                               //               child: Text(
                                               //                   "Seat",
                                               //                   style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w900,color: Colors.white),
                                               //                   textAlign: TextAlign.center
                                               //               ),
                                               //             )
                                               //         ),
                                               //         onTap: () async {
                                               //           print('seat continue btn tapped....');
                                               //           Navigator.push(
                                               //             context,
                                               //             MaterialPageRoute(
                                               //                 builder: (context) => SeatMapVC()),
                                               //           );
                                               //           //_postData();
                                               //           // });
                                               //         },
                                               //       ),
                                               //     ],
                                               //   ),
                                               // ),


                                               ],
                                           ),

                                          );
                                          //return  Text('Some text');
                                        }),


                                    SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      height: 60,
                                      width: 340,
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
                                                      "Seat",
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









                              //       Container(
                              // height: 160,
                              // width: 340,
                              //   alignment: Alignment.center,
                              //   color: Colors.grey,
                              //       child: Column(
                              //         children: [
                              //           SizedBox(
                              //             height: 20,
                              //           ),
                              //         Row(
                              //                             children: [
                              //                               Container(
                              //                                 height: 30,
                              //                                 width: 100,
                              //                                 color: Colors.transparent,
                              //                                 child: Text('Name:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                              //                               ),
                              //                               Container(
                              //                                 height: 30,
                              //                                 width: 240,
                              //                                 color: Colors.transparent,
                              //                                 child:Text(fullName,textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black)),),
                              //                                 // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                              //                               )
                              //                             ],
                              //                           ),
                              //
                              //                           Row(
                              //                             children: [
                              //                               Container(
                              //                                 height: 30,
                              //                                 width: 100,
                              //                                 color: Colors.transparent,
                              //                                 child: Text('Gender:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                              //                               ),
                              //                               Container(
                              //                                 height: 30,
                              //                                 width: 240,
                              //                                 color: Colors.transparent,
                              //                                 //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                              //                                 child:Text(gender,textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black)),),
                              //                               )
                              //                             ],
                              //                           ),
                              //
                              //           Row(
                              //             children: [
                              //               Container(
                              //                 height: 30,
                              //                 width: 100,
                              //                 color: Colors.transparent,
                              //                 child: Text('Phone:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                              //               ),
                              //               Container(
                              //                 height: 30,
                              //                 width: 240,
                              //                 color: Colors.transparent,
                              //                 //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                              //                 child:Text(phonenumber,textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black)),),
                              //               )
                              //             ],
                              //           ),
                              //
                              //           Row(
                              //             children: [
                              //               Container(
                              //                 height: 30,
                              //                 width: 100,
                              //                 color: Colors.transparent,
                              //                 child: Text('Email:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                              //               ),
                              //               Container(
                              //                 height: 50,
                              //                 width: 240,
                              //                 color: Colors.transparent,
                              //                 //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                              //                 child:Text(eMail,textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black)),),
                              //               )
                              //             ],
                              //           ),
                              //
                              //
                              //         ],
                              //       ),
                              // ),
                              //       SizedBox(
                              //         height: 2,
                              //       ),
                              //       Container(
                              //         height: 60,
                              //         width: 340,
                              //         color: Colors.green,
                              //         child: Row(
                              //           children: [
                              //             SizedBox(
                              //               width: 10,
                              //             ),
                              //             Container(
                              //               height: 50,
                              //               width: 150,
                              //               color: Colors.white,
                              //               child: Align(
                              //                 alignment: Alignment.center,
                              //                 child: Text(
                              //                   totalpricevalues,
                              //                   style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900,color:Colors.red),),
                              //               ),
                              //             ),
                              //             SizedBox(
                              //               width: 5,
                              //             ),
                              //             InkWell(
                              //               child: Container(
                              //                   height: 50,
                              //                   width: 150,
                              //                   color: Colors.blue,
                              //                   child: Align(
                              //                     alignment: Alignment.center,
                              //                     child: Text(
                              //                         "Seat",
                              //                         style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w900,color: Colors.white),
                              //                         textAlign: TextAlign.center
                              //                     ),
                              //                   )
                              //               ),
                              //               onTap: () async {
                              //                 print('seat continue btn tapped....');
                              //                 Navigator.push(
                              //                   context,
                              //                   MaterialPageRoute(
                              //                       builder: (context) => SeatMapVC()),
                              //                 );
                              //                 //_postData();
                              //                 // });
                              //               },
                              //             ),
                              //           ],
                              //         ),
                              //       ),

                                    ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        //itemCount:50,
                                        itemCount: snapshot.data['data'].length ?? '',
                                        //itemCount: snapshot.data['data'].length ?? '',

                                        //itemCount: snapshot.data?['data']['bookings'].length ?? "" ,
                                        //itemCount: snapshot.data!['data'][0]['bookings'][0].length ?? 0,
                                        //itemCount: snapshot.data?.length ?? 0,
                                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                                        itemBuilder: (BuildContext context, int index) {
                                         // bookingID = snapshot.data['data'][index]['id'];


//    itemBuilder: (context,index){
//                                           return Container(
//                                             height: 190,
//                                             width: 100,
//                                             alignment: Alignment.center,
//                                             color: Colors.red,
//                                           );


//                                           return Container(
//                                             height: 190,
//                                             width: 100,
//                                             alignment: Alignment.center,
//                                             color: Colors.white,
//                                             child: InkWell(
//
//                                               child: Column(
//                                                 children: [
//                                                   Container(
//                                                     height: 190,
//                                                     width: 340,
//                                                     color: Colors.black12,
//                                                     child: Column(
//                                                       children: [
//
//                                                         Row(
//                                                           children: [
//                                                             Container(
//                                                               height: 30,
//                                                               width: 140,
//                                                               color: Colors.transparent,
//                                                               child: Text('Address:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
//                                                             ),
//                                                             Container(
//                                                               height: 30,
//                                                               width: 200,
//                                                               color: Colors.transparent,
//                                                               //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
//                                                               child:Text(snapshot.data['data'][index]['address'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
//                                                             )
//                                                           ],
//                                                         ),
//                                                         Row(
//                                                           children: [
//                                                             Container(
//                                                               height: 30,
//                                                               width: 140,
//                                                               color: Colors.transparent,
//                                                               child: Text('Guests:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
//                                                             ),
//                                                             Container(
//                                                               height: 30,
//                                                               width: 200,
//                                                               color: Colors.transparent,
//                                                               child:Text(snapshot.data['data'][index]['guest'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
//                                                               // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
//                                                             )
//                                                           ],
//                                                         ),
//
//                                                         Row(
//                                                           children: [
//                                                             Container(
//                                                               height: 30,
//                                                               width: 140,
//                                                               color: Colors.transparent,
//                                                               child: Text('Beds:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
//                                                             ),
//                                                             Container(
//                                                               height: 30,
//                                                               width: 200,
//                                                               color: Colors.transparent,
//                                                               //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
//                                                               child:Text(snapshot.data['data'][index]['bedroom'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
//                                                             )
//                                                           ],
//                                                         ),
//
//                                                         Row(
//                                                           children: [
//                                                             Container(
//                                                               height: 30,
//                                                               width: 140,
//                                                               color: Colors.transparent,
//                                                               child: Text('Baths:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
//                                                             ),
//                                                             Container(
//                                                               height: 30,
//                                                               width: 200,
//                                                               color: Colors.transparent,
//                                                               //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
//                                                               child:Text(snapshot.data['data'][index]['bathroom'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
//                                                             )
//                                                           ],
//                                                         ),
//
//                                                         Row(
//                                                           children: [
//                                                             Container(
//                                                               height: 30,
//                                                               width: 140,
//                                                               color: Colors.transparent,
//                                                               child: Text('Price:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
//                                                             ),
//                                                             Container(
//                                                               height: 30,
//                                                               width: 200,
//                                                               color: Colors.transparent,
//                                                               //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
//                                                               child:Text(snapshot.data['data'][index]['price'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
//                                                             )
//                                                           ],
//                                                         ),
//
//
//                                                         Row(
//                                                           children: [
//
//                                                             Align(
//                                                               alignment: Alignment.center,
//                                                               child: Container(
//                                                                 color: Colors.transparent,
//                                                                 child: Text('Action:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black),),
//                                                               ),
//                                                             ),
//
//                                                             SizedBox(
//                                                               width: 30,
//                                                             ),
//                                                             InkWell(
//                                                               child: Container(
//                                                                 color: Colors.cyan,
//                                                                 child: Container(
//                                                                   width: 55,
//                                                                   color: Colors.transparent,
//                                                                   child: Text('View',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.white),),
//                                                                 ),                                                              ),
//                                                               onTap: () async {
//
//                                                                 Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
//                                                                   builder: (_) => ViewApartmnt(),
//                                                                 ),);
//                                                                 SharedPreferences prefs = await SharedPreferences.getInstance();
//                                                                 print('booking id...');
//                                                                 print(snapshot.data['data'][index]['id']);
//                                                                 // prefs.setString('addresskey', snapshot.data['data'][index]['address']);
//                                                                 // prefs.setString('citykey', snapshot.data['data'][index]['city']);
//                                                                 // prefs.setInt('userbookingId', snapshot.data['data'][index]['id']);
//                                                                 // prefs.setString('tokenkey', RetrivedBearertoekn);
//
//
//                                                                 print("value of your text");},
//                                                             ),
//                                                             SizedBox(
//                                                               width: 15,
//                                                             ),
//                                                             InkWell(
//                                                               child: Container(
//                                                                 width: 55,
//                                                                 color: Colors.green,
//                                                                 child: Text('Edit',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.white),),
//                                                               ),
//                                                               onTap: () async{print("value of your text");
//
//                                                               // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
//                                                               //   builder: (_) => AptmentEdit(),
//                                                               // ),);
//
//                                                               },
//                                                             ),
//                                                             SizedBox(
//                                                               width: 20,
//                                                             ),
//                                                             InkWell(
//                                                               child: Container(
//                                                                 width: 65,
//                                                                 color: Colors.red,
//                                                                 child: Text('Delete',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.white),),
//                                                               ),
//                                                               onTap: () async{
//                                                               //   print("value of your text");
//                                                               //   SharedPreferences prefs = await SharedPreferences.getInstance();
//                                                               //   print('booking id........');
//                                                               //   print(snapshot.data['data'][index]['id']);
//                                                               //   prefs.setInt('userbookingId', snapshot.data['data'][index]['id']);
//                                                               //   prefs.setString('tokenkey', RetrivedBearertoekn);
//                                                               //   ApartmentId = snapshot.data['data'][index]['id'];
//                                                               //   try{
//                                                               //     print('delete url...');
//                                                               //     print(ApartmentId);
//                                                               //     var url = '';
//                                                               //     // url = ('https://staging.abisiniya.com/api/v1/apartment/delete/$ApartmentId'
//                                                               //     url = (baseDioSingleton.AbisiniyaBaseurl + 'apartment/delete/$ApartmentId');
//                                                               //
//                                                               //     print(url);
//                                                               //     final response = await http
//                                                               //         .delete(Uri.parse(url),
//                                                               //       headers: {
//                                                               //         // 'Authorization':
//                                                               //         // 'Bearer <--your-token-here-->',
//                                                               //         "Authorization": "Bearer $RetrivedBearertoekn",
//                                                               //
//                                                               //       },
//                                                               //     );
//                                                               //
//                                                               //     if (response.statusCode == 200) {
//                                                               //       print('Apartment Deleted successfully');
//                                                               //       Navigator.push(
//                                                               //         context,
//                                                               //         MaterialPageRoute(
//                                                               //             builder: (context) => MyApartmentScreen()
//                                                               //         ),
//                                                               //       );
//                                                               //     } else {
//                                                               //       throw Exception('Failed to delete data');
//                                                               //     }
//                                                               //   } catch (error) {
//                                                               //     print(error);
//                                                               //   }
//                                                                },
//                                                             ),
//
//                                                           ],
//                                                         )
//                                                       ],
//
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               onTap: () async{
//
//                                                 // if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
//                                                 //     : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Awaiting Approval' || (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
//                                                 //     : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Approved' || (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
//                                                 //     : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked In' || (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
//                                                 //     : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked Out'){
//                                                 //
//                                                 //
//                                                 //   SharedPreferences prefs = await SharedPreferences.getInstance();
//                                                 //   print('booking id...');
//                                                 //   print(snapshot.data['data'][index]['id']);
//                                                 //   prefs.setString('namekey', snapshot.data['data'][index]['name']);
//                                                 //
//                                                 //   prefs.setString('addresskey', snapshot.data['data'][index]['address']);
//                                                 //   prefs.setString('citykey', snapshot.data['data'][index]['city']);
//                                                 //   prefs.setString('countrykey', snapshot.data['data'][index]['country']);
//                                                 //   prefs.setInt('guestkey', snapshot.data['data'][index]['guest']);
//                                                 //   prefs.setInt('bedroomkey', snapshot.data['data'][index]['bedroom']);
//                                                 //   prefs.setInt('bathroomkey', snapshot.data['data'][index]['bathroom']);
//                                                 //   prefs.setInt('pricekey', snapshot.data['data'][index]['price']);
//                                                 //   prefs.setInt('userbookingId', snapshot.data['data'][index]['id']);
//                                                 //   prefs.setString('tokenkey', RetrivedBearertoekn);
//                                                 //
//                                                 //
//                                                 //   Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
//                                                 //     builder: (_) => PivotDashboard(),
//                                                 //   ),);
//                                                 //
//                                                 // } else {
//                                                 //   print('failure....');
//                                                 //   final snackBar = SnackBar(
//                                                 //     content: Text('Not booked yet!'),
//                                                 //   );
//                                                 //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                                                 // }
//
//                                               },
//                                             ),
//                                           );
                                          //return  Text('Some text');
                                        }),

                                    Column(
                                      children:<Widget>[
                                        // Text('second test'),
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

                  );

                }
            }
          }
      ),
    );
  }
}
