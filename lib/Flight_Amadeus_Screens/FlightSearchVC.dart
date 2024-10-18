import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../flyScreens/Flights.dart';
import '../flyScreens/airlineVC.dart';
import 'OneWay_DestinationSelection/Oneway-DestinationJsonVC.dart';
import 'OnwardJourneyVC.dart';
import 'OnwardtripVC.dart';
import 'OriginDestSelectionVC.dart';
import 'ReturnJourney/Roundtrip_Destinationscreens/Rndtrp_DestinationJsonVC.dart';
import 'ReturnJourney/Roundtrip_OriginScreens/Rndtrp_OriginJsonVC.dart';
import 'ReturnJourney_flightsearch/forwardJourneyVC.dart';
import 'ReturnJourney_flightsearch/forwardtripVC.dart';
import 'flightClasstypesVC.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlightSearchVC extends StatefulWidget {
  String classstr = '';

  @override
  _FlightSearchVCState createState() => _FlightSearchVCState();
}

class _FlightSearchVCState extends State<FlightSearchVC> with SingleTickerProviderStateMixin {
  String classstr = '';
  String currency_code_dropdownvalue = 'Select Currency Code';
  String currency_code_Rndtrp_dropdownvalue = 'Select Currency Code';

  var items = [
   'Select Currency Code',
    'USD',
    'ZAR'
  ];

  String passengerliststr = '';
  String flightTokenstr = '';
 // int selectedindex = 0;
  int currentpage = 0;
  String OrginAirportcitystr = '';
  String DestinationAirportcitystr = '';
  String Retrived_Oneway_iatacodestr = '';
  String Retrived_Oneway_Citynamestr = '';
  String Retrived_Oneway_Airportnamestr = '';

  String RetrivedOneway_Oneway_Destinationiatacodestr = '';
  String RetrivedOnew_Oneway_DestinationCitynamestr = '';

  String RndOriginAirportcitystr = '';
  String Retrived_Rndtrp_iatacodestr = '';
  String Retrived_Rndtrp_Citynamestr = '';

  String RndDestinationAirportcitystr = '';
  String Retrived_Rndtrp_Destination_iatacodestr = '';
  String Retrived_Rndtrp_Destination_Citynamestr = '';
  List<Widget> flightFields = [];
  TextEditingController FromdateInputController = TextEditingController();
  List<TextEditingController> fromControllers = [];
  List<TextEditingController> toControllers = [];
  List<double> fieldHeights = []; // List to manage dynamic heights
  List<TextEditingController> departureControllers = [];






  //TabController _tabController;
  late TabController _tabController;



  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {


      print(currency_code_dropdownvalue);
      prefs.setString('currency_code_dropdownvaluekey', (currency_code_dropdownvalue));

      currency_code_dropdownvalue = prefs.getString('currency_code_dropdownvaluekey') ?? '';

      classstr = prefs.getString('classkey') ?? "";
      passengerliststr = prefs.getString('passengerlistkey') ?? "";
      print('passengerliststr....');
      print(passengerliststr);
      currentpage = prefs.getInt('Roundtripindexkey') ?? 0;
      print('current page...');
      print(currentpage);
      flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
      //Onwway values
      OrginAirportcitystr = prefs.getString('sourcekey') ?? '';
      DestinationAirportcitystr = prefs.getString('destinationkey') ?? '';
  Retrived_Oneway_iatacodestr = prefs.getString('Oneway_iatacodekey') ?? '';
  Retrived_Oneway_Citynamestr = prefs.getString('Oneway_Citynamekey') ?? '';
      Retrived_Oneway_Airportnamestr = prefs.getString('Oneway_Oneway_Airportnamestrkey') ?? '';




      //Roundtrip values

      RndOriginAirportcitystr = prefs.getString('Rndtrp_origincitykey') ?? '';
      Retrived_Rndtrp_iatacodestr = prefs.getString('Rndtrp_originiatacodekey') ?? '';
      Retrived_Rndtrp_Citynamestr = prefs.getString('Rndtrp_originCitynamekey') ?? '';
      //Roundtrip Destination city values
      RndDestinationAirportcitystr = prefs.getString('Rndtrp_Destinationcitykey') ?? '';
      Retrived_Rndtrp_Destination_iatacodestr = prefs.getString('Rndtrp_Destinationiatacodekey') ?? '';
      Retrived_Rndtrp_Destination_Citynamestr = prefs.getString('Rndtrp_DestinationCitynamekey') ?? '';

      RetrivedOneway_Oneway_Destinationiatacodestr = prefs.getString('Oneway_Destinationiatacodekey') ?? '';
      RetrivedOnew_Oneway_DestinationCitynamestr = prefs.getString('Oneway_DestinationCitynamekey') ?? '';
      print('flight token received...');
      print(flightTokenstr);
      print('current page1...');
      print(currentpage );
      print('class value...');
      print(classstr);
      print(passengerliststr);
      _tabController = new TabController(vsync: this, length: 3);
      print('tab...');
      print(_tabController.index);
    });
  }
  void addFlightField() {
    print('Add flight field clicked...');

    // Create new controllers for the new fields
    TextEditingController fromController = TextEditingController();
    TextEditingController toController = TextEditingController();
    TextEditingController departureController = TextEditingController(); // New controller for departure

    // Add the controllers to their respective lists
    fromControllers.add(fromController);
    toControllers.add(toController);
    departureControllers.add(departureController);

    // Add a new column for the new set of fields
    flightFields.add(
      Column(
        children: [
          Container(
            height: 50,
            width: 340,
            color: Colors.white,
            child: TextField(
              controller: fromController,
              readOnly: true,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              onTap: () async {
                print('Flying from clicked...');
                // Logic for navigating to selection screen
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                prefixIcon: Icon(Icons.flight, color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                hintText: 'Flying from',
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 50,
            width: 340,
            color: Colors.white,
            child: TextField(
              controller: toController,
              readOnly: true,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              onTap: () async {
                print('Flying to clicked...');
                // Logic for navigating to selection screen
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                prefixIcon: Icon(Icons.flight, color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                hintText: 'Flying to',
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 50,
            width: 340,
            color: Colors.white,
            child: TextField(
              controller: departureController, // Use the new controller
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                prefixIcon: Icon(Icons.calendar_month, color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                hintText: 'Departure',
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2050),
                );
                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  departureController.text = formattedDate; // Use the new controller for departure
                }
              },
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );

    // Call setState to refresh the UI with new fields
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _retrieveValues();
    addFlightField();

  }

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
              color: Colors.white
          ),
          title: Text('Book a flight', textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,
                  fontFamily: 'Baloo',
                  fontWeight: FontWeight.w900,
                  fontSize: 20)),
        ),
        body: SingleChildScrollView(

          child: Column(
            children: <Widget>[

              _tabSection(context),


            ],
          ),
        ));
  }


  Widget _tabSection(BuildContext context) {

    print('calling passenger list values....');
    print(classstr);
    print(passengerliststr);
    //_tabController = new TabController(vsync: this, length: 2);
    print('tab......');
    print(_tabController.index);
    _tabController.addListener((){
      print('my index is'+ _tabController.index.toString());
    });

    int selectedindex = 0;

    String fromDate = '';
    TextEditingController FromdateInputController = TextEditingController();
    // TextEditingController TodateInputController = TextEditingController();
    // bool first = false;
    TextEditingController returnFromdateInputController = TextEditingController();
    TextEditingController TodateInputController = TextEditingController();
    TextEditingController passengerController = TextEditingController();
   //Oneway fields:-
    TextEditingController OriginAirportCityController = TextEditingController();
    TextEditingController DestinationAirportCityController = TextEditingController();
    //OriginAirportCityController.text = OrginAirportcitystr;
    // DestinationAirportCityController.text = RetrivedOnew_Oneway_DestinationCitynamestr + " (" + (RetrivedOneway_Oneway_Destinationiatacodestr)+ ")";
    // OriginAirportCityController.text =     Retrived_Oneway_Citynamestr + " (" + ((Retrived_Oneway_iatacodestr)) + ")";


    DestinationAirportCityController.text = RetrivedOnew_Oneway_DestinationCitynamestr;
    OriginAirportCityController.text =     Retrived_Oneway_Citynamestr;

    //Roundtrip fields:-
    TextEditingController Rnd_OriginAirportCityController = TextEditingController();
    TextEditingController Rnd_DestinationAirportCityController = TextEditingController();
    // Rnd_OriginAirportCityController.text = RndOriginAirportcitystr;
    // Rnd_DestinationAirportCityController.text = RndDestinationAirportcitystr;
    Rnd_OriginAirportCityController.text = Retrived_Rndtrp_iatacodestr;
    Rnd_DestinationAirportCityController.text = Retrived_Rndtrp_Destination_iatacodestr;

    //DestinationAirportCityController.text = DestinationAirportcitystr;


    passengerController.text = passengerliststr + " ," + classstr;
    bool first = false;
    String returnfromDatestr = '';
    String toDatestr = '';
    return DefaultTabController(
      length: 3,
      initialIndex: currentpage,
      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: <Widget>[
          Container(
            //alignment: Alignment.center,

            // margin: EdgeInsets.fromLTRB(30, 50, 12, 12),
            //margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            margin: EdgeInsets.only(
                left: 0.0, top: 50.0, right: 0.0, bottom: 0.0),
           // padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
           // padding: const EdgeInsets.only(top: 8,bottom: 8.0,left: 10, right: 10),

            height: 50,
            width: 360,
             color: Colors.green,
            //color: Color.fromRGBO(133, 193, 233, 0.5),
            child: TabBar(
                //controller: _tabController,
                onTap: (index) {
                  selectedindex = index;
                },
                tabs: [
              //Tab(text: "One-Way",),
              Tab(
                child: Text(
                  'One-Way',
                  style: TextStyle(
                    //fontFamily: kFontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      //color: Color(0xFF818181),
                      color: Colors.white
                  ),
                ),
              ),

              Tab(
                child: Text(
                  'Round-Trip',
                  style: TextStyle(
                    //fontFamily: kFontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    //color: Color(0xFF818181),
                    color: Colors.white,
                  ),
                ),
              ),
                  Tab(
                    child: Text(
                      'Multi-City',
                      style: TextStyle(
                        //fontFamily: kFontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        //color: Color(0xFF818181),
                        color: Colors.white,
                      ),
                    ),
                  ),
            ]),
          ),
          Container(
            //margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
            //padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            height: 400,
            width: 360,
    margin: EdgeInsets.only(
    left: 0.0, top: 0.0, right: 0.0, bottom: 0.0),

    //color: Colors.grey,
            //color: Color.fromRGBO(235, 245, 251, 0.4),
            //133, 193, 233
            color: Color.fromRGBO(133, 193, 233, 0.5),
            //Add this to give height
            // height: MediaQuery.of(context).size.height,
            child: TabBarView(
                //controller: _tabController,

                children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 340,
                      color: Colors.white,

                      child: TextField(
                        controller: OriginAirportCityController,
                        readOnly: true,
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),

                        onTap: () async{
                          print('One way source clicked...');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SourceDestinationCityVC()),
                          );
                          print('Oneway selected ind1 ');
                          print(selectedindex);
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setInt('selectedIndexkey', selectedindex);
                          prefs.setString("OnewayDeparturekey", 'OnewayDeparture');
                          prefs.setString("Oneway_iatacodekey", Retrived_Oneway_iatacodestr);
                          prefs.setString("Oneway_Citynamekey", Retrived_Oneway_Citynamestr);




                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          prefixIcon: Icon(
                              Icons.flight, color: Colors.green),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                          hintText: 'Flying from',
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 340,
                      color: Colors.white,
                        child: TextField(
                          controller: DestinationAirportCityController,
                          readOnly: true,
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),

                          onTap: () async{
                            print('One way destination clicked...');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OnewwayDestinationCityVC()),
                            );
                            print('Oneway selected ind1');
                            print(selectedindex);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setInt('selectedIndexkey', selectedindex);
                            prefs.setString("OnewayArrivalkey", 'OnewayArrival');
                            prefs.setString("Oneway_Destinationiatacodekey", RetrivedOneway_Oneway_Destinationiatacodestr);
                            prefs.setString("Oneway_DestinationCitynamekey", RetrivedOnew_Oneway_DestinationCitynamestr);

                          },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          prefixIcon: Icon(
                              Icons.flight, color: Colors.green),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                          hintText: 'Flying to',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 340,
                      //color: Colors.white,
                      color: Colors.white,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButton(
                            isExpanded: true,
                            // Initial Value
                            value: currency_code_dropdownvalue,
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
                                currency_code_dropdownvalue = newValue!;


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
                      width: 340,
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

                            hintText: 'Departure',
                          ),

                          controller: FromdateInputController,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2050));
                            if (pickedDate != null) {
                              FromdateInputController.text =
                                  pickedDate.toString();
                              fromDate = DateFormat('yyyy-MM-dd').format(
                                  pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

                              FromdateInputController.text = fromDate;
                            }
                          }
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 340,
                      color: Colors.white,
                      child: TextField(
                        controller: passengerController,
                        readOnly: true,
                        style: TextStyle(fontSize: 16),

                        onTap: () async{
                          print('Economy class clicked...');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => classTypesVC()),
                          );
                          print('Oneway selected ind');
                          print(selectedindex);
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setInt('selectedIndexkey', selectedindex);

                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          prefixIcon: Icon(Icons.account_circle_outlined,
                              color: Colors.green),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                          hintText: '1 Passenger , Economy',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                  InkWell(
                    child: Container(
                    height: 50,
                    width: 340,
                     color: Colors.green,

                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                              "Search",
                              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800,color: Colors.white),
                              textAlign: TextAlign.center
                          ),
                        )

                    ),
                    onTap: () async {

                      if(FromdateInputController.text != ''){

                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                        print('tap..');
                        print(flightTokenstr);
                        flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                        prefs.setString("flightTokenstrKey", flightTokenstr);
                        prefs.setString("from_Datekey", FromdateInputController.text);
                        print(currency_code_dropdownvalue);
                        prefs.setString('currency_code_dropdownvaluekey', (currency_code_dropdownvalue));
                        prefs.setString('travel_classstr', (classstr));

                        print('Tapped onward....');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FlightOnWardTrip()),
                        );



                      } else {
                        print('empty field...');
                        final snackBar = SnackBar(
                          content: Text('Please select currency code and date.'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }


                    },
                  )


                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 340,
                      color: Colors.white,
                        child: TextField(
                          controller: Rnd_OriginAirportCityController,
                          readOnly: true,
                          style: TextStyle(fontSize: 16),

                          onTap: () async{
                            print('Economy class clicked...');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RndtrpOriginCityVC()),
                            );
                            print('Return selected ind');
                            print(selectedindex);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setInt('selectedIndexkey', selectedindex);
                            prefs.setString("RndtrpDeparturekey", 'RndtrpDeparture');
                            prefs.setString("Rndtrp_originiatacodekey", Retrived_Rndtrp_iatacodestr);
                            prefs.setString("Rndtrp_originCitynamekey", Retrived_Rndtrp_Citynamestr);
                            //
                            // RndOriginAirportcitystr = prefs.getString('Rndtrp_origincitykey') ?? '';
                            // Retrived_Rndtrp_iatacodestr = prefs.getString('Rndtrp_originiatacodekey') ?? '';
                            // Retrived_Rndtrp_Citynamestr = prefs.getString('Rndtrp_originCitynamekey') ?? '';


                          },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          prefixIcon: Icon(
                              Icons.flight, color: Colors.green),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                          hintText: 'Flying from',
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 340,
                      color: Colors.white,
                        child: TextField(
                          readOnly: true,
                          controller: Rnd_DestinationAirportCityController,
                          style: TextStyle(fontSize: 16),

                          onTap: () async{
                            print('Economy class clicked...');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RndtrpDestinationCityVC()),
                            );
                            print('Return selected ind');
                            print(selectedindex);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setInt('selectedIndexkey', selectedindex);
                            prefs.setString("RndtrpDestinationkey", 'RndtrpDestination');
                            prefs.setString("Rndtrp_Destinationiatacodekey", Retrived_Rndtrp_Destination_iatacodestr);
                            prefs.setString("Rndtrp_DestinationCitynamekey", Retrived_Rndtrp_Destination_Citynamestr);

                          },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          prefixIcon: Icon(
                              Icons.flight, color: Colors.green),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                          hintText: 'Flying to',
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 340,
                      //color: Colors.white,
                      color: Colors.white,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButton(
                            isExpanded: true,
                            // Initial Value
                            value: currency_code_Rndtrp_dropdownvalue,
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
                                currency_code_Rndtrp_dropdownvalue = newValue!;
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
                      width: 340,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 165,
                            color: Colors.red,
                            child: TextField(
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  prefixIcon: Icon(Icons.calendar_month,
                                      color: Colors.green),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                  ),
                                  hintText: 'Dep',
                                ),

                                controller: returnFromdateInputController,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2050));
                                  if (pickedDate != null) {
                                    returnFromdateInputController.text =
                                        pickedDate.toString();
                                    returnfromDatestr =
                                        DateFormat('yyyy-MM-dd').format(
                                            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                    print('from date...');
                                    print(returnfromDatestr);
                                    returnFromdateInputController.text =
                                        returnfromDatestr;
                                  }
                                }
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 50,
                            width: 165,
                            color: Colors.red,
                            child: TextField(
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  prefixIcon: Icon(Icons.calendar_month,
                                      color: Colors.green),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                  ),

                                  hintText: 'Rerurn',
                                ),

                                controller: TodateInputController,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2050));
                                  if (pickedDate != null) {
                                    TodateInputController.text =
                                        pickedDate.toString();
                                    toDatestr = DateFormat('yyyy-MM-dd').format(
                                        pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                    TodateInputController.text = toDatestr;
                                  }
                                }
                            ),
                          )
                        ],
                      ),
                     
                    ),


                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 340,
                      color: Colors.white,
                      child: TextField(
                        controller: passengerController,
                        readOnly: true,
                        style: TextStyle(fontSize: 16),

                        onTap: () async {
                          print('Economy class clicked...');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => classTypesVC()),
                          );
                          print('Return selected ind');
                          print(selectedindex);
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setInt('selectedIndexkey', selectedindex);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          prefixIcon: Icon(Icons.account_circle_outlined,
                              color: Colors.green),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                          hintText: '1 Passenger , Economy',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      child: Container(
                          height: 50,
                          width: 340,
                          color: Colors.green,

                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                                "Search",
                                style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800,color: Colors.white),
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

                        prefs.setString("returnfrom_Datekey", returnFromdateInputController.text);
                        prefs.setString("returnto_Datekey", TodateInputController.text);
                        print(currency_code_Rndtrp_dropdownvalue);
                        prefs.setString('currency_code_Rndtrp_dropdownvaluekey', (currency_code_Rndtrp_dropdownvalue));



                        print('forward Tapped onward....');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FlightforwardTrip()),
                        );
                      },
                    )
                  ],
                ),
              ),

              Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 340,
                          color: Colors.white,

                          child: TextField(
                            controller: OriginAirportCityController,
                            readOnly: true,
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),

                            onTap: () async{
                              print('One way source clicked...');

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SourceDestinationCityVC()),
                              );
                              print('Oneway selected ind1 ');
                              print(selectedindex);
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setInt('selectedIndexkey', selectedindex);
                              prefs.setString("OnewayDeparturekey", 'OnewayDeparture');
                              prefs.setString("Oneway_iatacodekey", Retrived_Oneway_iatacodestr);
                              prefs.setString("Oneway_Citynamekey", Retrived_Oneway_Citynamestr);




                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              prefixIcon: Icon(
                                  Icons.flight, color: Colors.green),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              hintText: 'Flying from',
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 340,
                          color: Colors.white,
                          child: TextField(
                            controller: DestinationAirportCityController,
                            readOnly: true,
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),

                            onTap: () async{
                              print('One way destination clicked...');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OnewwayDestinationCityVC()),
                              );
                              print('Oneway selected ind1');
                              print(selectedindex);
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setInt('selectedIndexkey', selectedindex);
                              prefs.setString("OnewayArrivalkey", 'OnewayArrival');
                              prefs.setString("Oneway_Destinationiatacodekey", RetrivedOneway_Oneway_Destinationiatacodestr);
                              prefs.setString("Oneway_DestinationCitynamekey", RetrivedOnew_Oneway_DestinationCitynamestr);

                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              prefixIcon: Icon(
                                  Icons.flight, color: Colors.green),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              hintText: 'Flying to',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 340,
                          //color: Colors.white,
                          color: Colors.white,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButton(
                                isExpanded: true,
                                // Initial Value
                                value: currency_code_dropdownvalue,
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
                                    currency_code_dropdownvalue = newValue!;


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
                          width: 340,
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

                                hintText: 'Departure',
                              ),

                              controller: FromdateInputController,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2050));
                                if (pickedDate != null) {
                                  FromdateInputController.text =
                                      pickedDate.toString();
                                  fromDate = DateFormat('yyyy-MM-dd').format(
                                      pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

                                  FromdateInputController.text = fromDate;
                                }
                              }
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 340,
                          color: Colors.white,
                          child: TextField(
                            controller: passengerController,
                            readOnly: true,
                            style: TextStyle(fontSize: 16),

                            onTap: () async{
                              print('Economy class clicked...');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => classTypesVC()),
                              );
                              print('Oneway selected ind');
                              print(selectedindex);
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setInt('selectedIndexkey', selectedindex);

                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              prefixIcon: Icon(Icons.account_circle_outlined,
                                  color: Colors.green),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              hintText: '1 Passenger , Economy',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust alignment as needed
                          children: [
                            InkWell(
                              child: Container(
                                height: 50, // Set height for consistent button size
                                width: 160, // Set a width for the button (or use Expanded)
                                color: Colors.green,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Add Dest",
                                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              onTap: () async {
                                // Add destination logic here
                                addFlightField(); // Add new fields when tapped
                              },
                            ),
                            SizedBox(width: 10), // Optional: add spacing between the buttons
                            InkWell(
                              child: Container(
                                height: 50,
                                width: 160, // Set a width for the button (or use Expanded)
                                color: Colors.green,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Search",
                                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              onTap: () async {
                                if (FromdateInputController.text != '') {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                                  print('tap..');
                                  print(flightTokenstr);
                                  prefs.setString("flightTokenstrKey", flightTokenstr);
                                  prefs.setString("from_Datekey", FromdateInputController.text);
                                  print(currency_code_dropdownvalue);
                                  prefs.setString('currency_code_dropdownvaluekey', currency_code_dropdownvalue);
                                  prefs.setString('travel_classstr', classstr);

                                  print('Tapped onward....');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FlightOnWardTrip(),
                                    ),
                                  );
                                } else {
                                  print('empty field...');
                                  final snackBar = SnackBar(
                                    content: Text('Please select currency code and date.'),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              },
                            ),
                          ],
                        )



                      ],
                    ),
                  ),


            ]),
          ),
        ],
      ),
    );
  }
}





class Entry {
  final String? name;
  final String? email;

  Entry(
      this.name,
      this.email,
      );


}
