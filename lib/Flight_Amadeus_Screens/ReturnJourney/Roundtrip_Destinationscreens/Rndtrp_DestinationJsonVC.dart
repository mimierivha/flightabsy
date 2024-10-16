import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../FlightSearchVC.dart';
import '../Roundtrip_OriginScreens/Rndtrp_OriginModelVC.dart';





class RndtrpDestinationCityVC extends StatefulWidget {
  // HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<RndtrpDestinationCityVC> {
  List<UserDetails> _searchResult = [];
  List<UserDetails> _userDetails = [];
  TextEditingController RndtrpDestinationcontroller = new TextEditingController();
  String OnewayDeparturestr = '';
  String OnewayArrivalstr = '';
  String Rndtrp_Destinationiatacode = '';
  String Rndtrp_DestinationCityname = '';
  int RndselectedIndex = 0;
  bool isLoading = false;
  String RndtrpDeparturestr = '';
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      OnewayDeparturestr = prefs.getString('OnewayDeparturekey') ?? "";
      OnewayArrivalstr = prefs.getString('OnewayArrivalkey') ?? "";
      print('Oneway source and desti');
      print(OnewayDeparturestr);
      print(OnewayArrivalstr);


      RndtrpDeparturestr = prefs.getString('RndtrpDestinationkey') ?? "";
      RndselectedIndex = prefs.getInt('selectedIndexkey') ?? 0;
      print('Rnd destination index...');
      print(RndselectedIndex);


    });
  }


  // Get json result and convert it to model. Then add


  Future<dynamic> DestinationlocationAPI() async {

    // _fetchDogsBreed() async{
    setState(() {
      isLoading = true;
    });
    //tempList = List<String>();
    //List<String> tempList = [];
    //tempList = [];

    //var baseUrl = "https://dog.ceo/api/breeds/list/all";
    String baseUrl = 'https://staging.abisiniya.com/api/v1/amadeus/airportlist';


    http.Response response = await http.get(Uri.parse(baseUrl));
    //final response = await http.get('https://dog.ceo/api/breeds/list/all');
    if (response.statusCode == 200) {

      List<String> items = [];
      var jsonData = json.decode(response.body);
      print('Airport list.....');
      print(jsonData.toString());
      setState(() {
        for (Map user in jsonData) {
          _userDetails.add(UserDetails.fromJson(user as Map<String, dynamic>));

        }
      }



      );
    }
    else{
      throw Exception("Failed to load Dogs Breeds.");
    }
    setState(() {
      //_userDetails = _searchResult;
      isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();

    DestinationlocationAPI();
    _retrieveValues();
  }

  Widget _buildUsersList() {
    return Center(
        child: isLoading?
        CircularProgressIndicator():

        ListView.builder(
          itemCount: _userDetails.length,
          itemBuilder: (context, index) {

            // Oneway_Destinationiatacode = _userDetails[index].iata;
            // Oneway_DestinationCityname = _userDetails[index].Name;

            Rndtrp_Destinationiatacode = _userDetails[index].iata;
            Rndtrp_DestinationCityname = _userDetails[index].Name;

            return new Card(
              child: new ListTile(
                // leading: new CircleAvatar(
                //   // backgroundImage: new NetworkImage(
                //   //   _userDetails[index].profileUrl,
                //   // ),
                // ),
                //title: new Text(_userDetails[index].Name),

                  leading: Icon(Icons.flight),
                  // title: new Text(_userDetails[index].Name +
                  //     '  - ' +
                  //     _userDetails[index].iata + ' -' + _userDetails[index].City),
                  title: new Text(_userDetails[index].Name + '  ' + "\($Rndtrp_Destinationiatacode)" + ' ' + _userDetails[index].City +" " + _userDetails[index].Country),
                  onTap: () async {
                                  print('selected value....');
                                  print((_userDetails[index].Name +
                                      '  - ' +
                                      _userDetails[index].iata));
                                  RndtrpDestinationcontroller.text = _userDetails[index].Name + '  - ' + _userDetails[index].iata;
                                  Rndtrp_Destinationiatacode = _userDetails[index].iata;
                                  Rndtrp_DestinationCityname = _userDetails[index].Name;

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FlightSearchVC()),
                                  );
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString("Rndtrp_Destinationcitykey", RndtrpDestinationcontroller.text);
                                  prefs.setString("Rndtrp_Destinationiatacodekey", Rndtrp_Destinationiatacode);
                                  prefs.setString("Rndtrp_DestinationCitynamekey", Rndtrp_DestinationCityname);
                                  prefs.setInt('Roundtripindexkey', RndselectedIndex);

                                }
              ),


              margin: const EdgeInsets.all(0.0),
            );
          },
        )
    );
  }

  Widget _buildSearchResults() {
    return new ListView.builder(
      itemCount: _searchResult.length,
      itemBuilder: (context, index) {
        // Oneway_iatacode = _searchResult[index].iata;
        // Oneway_Cityname = _searchResult[index].Name;
        // Rndtrp_originiatacode = _searchResult[index].iata;
        // Rndtrp_originCityname = _searchResult[index].Name;
        Rndtrp_Destinationiatacode = _searchResult[index].iata;
        Rndtrp_DestinationCityname = _searchResult[index].Name;



        return new Card(
          child: new ListTile(
              leading: Icon(Icons.flight),

              // leading: new CircleAvatar(
              //   // backgroundImage: new NetworkImage(
              //   //   _searchResult[i].profileUrl,
              //   // ),
              // ),
              // title: new Text(
              //     _searchResult[i].firstName),

              title: new Text(_searchResult[index].Name + '  ' + "\($Rndtrp_Destinationiatacode)" + ' ' + _searchResult[index].City +" " + _searchResult[index].Country),

              // title: new Text(
              //     _searchResult[index].Name + '   -' +(_searchResult[index].iata + ' -' + _searchResult[index].City)),
        onTap: () async{
                      print('filter....');
                      print(RndtrpDestinationcontroller.text = _searchResult[index].Name + '  - ' + _searchResult[index].iata);
                      RndtrpDestinationcontroller.text = _searchResult[index].Name + '  - ' + _searchResult[index].iata;
                      Rndtrp_Destinationiatacode = _searchResult[index].iata;
                      Rndtrp_DestinationCityname = _searchResult[index].Name;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FlightSearchVC()),
                      );
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString("Rndtrp_Destinationcitykey", RndtrpDestinationcontroller.text);
                      prefs.setString("Rndtrp_Destinationiatacodekey", Rndtrp_Destinationiatacode);
                      prefs.setString("Rndtrp_DestinationCitynamekey", Rndtrp_DestinationCityname);
                      prefs.setInt('Roundtripindexkey', RndselectedIndex);



                    }
          ),


          margin: const EdgeInsets.all(0.0),
        );
      },
    );
  }


  // Widget _buildUsersList() {
  //   return new ListView.builder(
  //     itemCount: _userDetails.length,
  //     itemBuilder: (context, index) {
  //       return new Card(
  //         child: new ListTile(
  //           // leading: new CircleAvatar(
  //           //   // backgroundImage: new NetworkImage(
  //           //   //   _userDetails[index].profileUrl,
  //           //   // ),
  //           // ),
  //           //title: new Text(_userDetails[index].Name),
  //
  //             leading: Icon(Icons.flight),
  //             title: new Text(_userDetails[index].Name +
  //                 '  - ' +
  //                 _userDetails[index].iata),
  //             onTap: () async {
  //
  //               print('selected value....');
  //               print((_userDetails[index].Name +
  //                   '  - ' +
  //                   _userDetails[index].iata));
  //               RndtrpDestinationcontroller.text = _userDetails[index].Name + '  - ' + _userDetails[index].iata;
  //               Rndtrp_Destinationiatacode = _userDetails[index].iata;
  //               Rndtrp_DestinationCityname = _userDetails[index].Name;
  //
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => FlightSearchVC()),
  //               );
  //               SharedPreferences prefs = await SharedPreferences.getInstance();
  //               prefs.setString("Rndtrp_Destinationcitykey", RndtrpDestinationcontroller.text);
  //               prefs.setString("Rndtrp_Destinationiatacodekey", Rndtrp_Destinationiatacode);
  //               prefs.setString("Rndtrp_DestinationCitynamekey", Rndtrp_DestinationCityname);
  //               prefs.setInt('Roundtripindexkey', selectedIndex);
  //
  //             }
  //         ),
  //
  //
  //         margin: const EdgeInsets.all(0.0),
  //       );
  //     },
  //   );
  // }
  //
  // Widget _buildSearchResults() {
  //   return new ListView.builder(
  //     itemCount: _searchResult.length,
  //     itemBuilder: (context, index) {
  //
  //       return new Card(
  //         child: new ListTile(
  //             leading: Icon(Icons.flight),
  //
  //             // leading: new CircleAvatar(
  //             //   // backgroundImage: new NetworkImage(
  //             //   //   _searchResult[i].profileUrl,
  //             //   // ),
  //             // ),
  //             // title: new Text(
  //             //     _searchResult[i].firstName),
  //
  //             title: new Text(
  //                 _searchResult[index].Name + '   -' +(_searchResult[index].iata)),
  //             onTap: () async{
  //               print('filter....');
  //               print(RndtrpDestinationcontroller.text = _searchResult[index].Name + '  - ' + _searchResult[index].iata);
  //               RndtrpDestinationcontroller.text = _searchResult[index].Name + '  - ' + _searchResult[index].iata;
  //               Rndtrp_Destinationiatacode = _searchResult[index].iata;
  //               Rndtrp_DestinationCityname = _searchResult[index].Name;
  //
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => FlightSearchVC()),
  //               );
  //               SharedPreferences prefs = await SharedPreferences.getInstance();
  //               prefs.setString("Rndtrp_Destinationcitykey", RndtrpDestinationcontroller.text);
  //               prefs.setString("Rndtrp_Destinationiatacodekey", Rndtrp_Destinationiatacode);
  //               prefs.setString("Rndtrp_DestinationCitynamekey", Rndtrp_DestinationCityname);
  //               prefs.setInt('Roundtripindexkey', selectedIndex);
  //
  //
  //
  //             }
  //         ),
  //
  //
  //         margin: const EdgeInsets.all(0.0),
  //       );
  //     },
  //   );
  // }

  Widget _buildBody() {
    return new Column(
      children: <Widget>[
        new Container(
            color: Theme.of(context).primaryColor,

            child: _buildSearchBox()),
        new Expanded(
            child: _searchResult.length != 0 || RndtrpDestinationcontroller.text.isNotEmpty
                ? _buildSearchResults()
                : _buildUsersList()),
      ],
    );
  }
  Widget _buildSearchBox() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        child: new ListTile(
          leading: new Icon(Icons.search),
          title: new TextField(
            controller: RndtrpDestinationcontroller,
            decoration: new InputDecoration(
                hintText: 'Search', border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
            onPressed: () {
              RndtrpDestinationcontroller.clear();
              onSearchTextChanged('');
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

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
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.white
        ),

        title: const Text('Airport',
            textAlign: TextAlign.center,
            style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
      ),
      // appBar: new AppBar(
      //   title: new Text('Home'),
      //   elevation: 0.0,
      // ),
      body: _buildBody(),
      // resizeToAvoidBottomPadding: true,
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.Name.contains(text) ||
          userDetail.iata.contains(text) || userDetail.Country.contains(text)) _searchResult.add(userDetail);

    }


    );

    setState(() {});
  }
}