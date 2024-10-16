import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:tourstravels/Auth/ForgotPassword.dart';
import 'package:tourstravels/Auth/Register.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:tourstravels/shared_preferences.dart';
import 'package:tourstravels/Auth/forgotpwdemailVerify.dart';
import 'package:tourstravels/tabbar.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/UserDashboard_Screens/newDashboard.dart';

import '../ApartVC/Apartment.dart';
import '../ServiceDasboardVC.dart';
import 'FlightSearchVC.dart';
class classTypesVC extends StatefulWidget {
  @override
  _classTypesVCState createState() => _classTypesVCState();
}
class _classTypesVCState extends State<classTypesVC> {
  final baseDioSingleton = BaseSingleton();
  bool isLoading = false;
  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController passengerController = TextEditingController();
  String tokenvalue = '';

  String dropdownvalue = 'ECONOMY';
  int selectedIndex = 0;

  int _counter = 1;
  int _childrenscounter = 0;
  int _infantcounter = 0;
  int selectedindex = 0;
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedindex = prefs.getInt('selectedIndexkey') ?? 0;

      print('index...');
      print(selectedIndex);


    });
  }

  @override
  void initState() {
    super.initState();

    _retrieveValues();

  }


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }
  //Children's increment and decrement
  void _childrensincrementCounter() {
    setState(() {
      _childrenscounter++;
    });
  }

  void _childrensdecrementCounter() {
    setState(() {
      _childrenscounter--;
    });
  }

  //Infants's increment and decrement
  void _infantincrementCounter() {
    setState(() {
      _infantcounter++;
    });
  }

  void _infantdecrementCounter() {
    setState(() {
      _infantcounter--;
    });
  }

// List of items in our dropdown menu
  var items = [
    'Select Class',
    'ECONOMY',
    'PREMIUM ECONOMY',
    'BUSINESS',
    'FIRST'
  ];


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
          centerTitle: true,
          leading: BackButton(
            onPressed: () async{
              print("back Pressed");
              print('back drop value');
              print(dropdownvalue);
              SharedPreferences prefs = await SharedPreferences.getInstance();
               prefs.setString('classkey', (dropdownvalue));
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FlightSearchVC()),

              );
            },
          ),
          title: Text('FLIGHTS',textAlign: TextAlign.center,
              style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
        ),
        body: Column(
          children: <Widget>[
            Container(color: Colors.white, height: 50),
            Expanded(
              child: Container(
                color: Colors.white,
                child: LayoutBuilder(
                  builder: (context, constraint) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [

                              Container(
                                height: 50,
                                width: 320,
                                //color: Colors.white,
                                color: Color.fromRGBO(133, 193, 233, 0.5),

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DropdownButton(
                                      isExpanded: true,
                                      // Initial Value
                                      value: dropdownvalue,
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
                                          dropdownvalue = newValue!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // middle widget goes here
                              Expanded(
                                child: Column(
                                  children: [
                                Container(
                                  // margin: EdgeInsets.fromLTRB(30, 50, 12, 12),
                                  //margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                                  margin: EdgeInsets.only(left: 20.0, top: 15.0, right: 20.0, bottom: 0.0),
                                  //padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                                  height: 400,
                                  width: 320,
                                  color: Color.fromRGBO(133, 193, 233, 0.5),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 320,
                                        color: Colors.white,
                                        child: TextField(
                                          controller: passengerController,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color(0xFFFFFFFF),
                                            prefixIcon: Icon(Icons.class_outlined, color: Colors.deepPurple),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(0),
                                              ),
                                            ),
                                            hintText: 'Passengers',
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 70,
                                        width: 316,
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 10.0, top: 00.0, right: 00.0, bottom: 0.0),
                                              height: 90,
                                              width: 140,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 10,),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      'Adults',
                                                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.deepPurple),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                  // Align(
                                                  //   alignment: Alignment.centerLeft,
                                                  //   child: Text(
                                                  //     '>11 years',
                                                  //     style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.deepPurple),
                                                  //     textAlign: TextAlign.center,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 90,
                                              width: 160,
                                              color: Colors.white,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  AnimatedOpacity(
                                                    opacity: _counter != 0 ? 1.0 : 0.0,
                                                    duration: Duration(milliseconds: 500),
                                                  ),
                                                  //SizedBox(height: 10.0),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      TextButton(
                                                        onPressed: _decrementCounter,
                                                        child: Icon(Icons.remove),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        '$_counter',
                                                        style: TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      TextButton(
                                                        onPressed: _incrementCounter,
                                                        child: Icon(Icons.add),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                            )
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 70,
                                        width: 316,
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 10.0, top: 00.0, right: 00.0, bottom: 0.0),
                                              height: 90,
                                              width: 140,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 10,),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      'Children',
                                                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.deepPurple),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      '2-11 years',
                                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.deepPurple),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                                height: 90,
                                                width: 160,
                                                color: Colors.white,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedOpacity(
                                                      opacity: _childrenscounter != 0 ? 1.0 : 0.0,
                                                      duration: Duration(milliseconds: 500),
                                                    ),
                                                    //SizedBox(height: 10.0),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        TextButton(
                                                          onPressed: _childrensdecrementCounter,
                                                          child: Icon(Icons.remove),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          '$_childrenscounter',
                                                          style: TextStyle(
                                                            fontSize: 18.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10.0),
                                                        TextButton(
                                                          onPressed: _childrensincrementCounter,
                                                          child: Icon(Icons.add),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 70,
                                        width: 316,
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 10.0, top: 00.0, right: 00.0, bottom: 0.0),
                                              height: 90,
                                              width: 140,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 10,),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      'Infants',
                                                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.deepPurple),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      '<2 years',
                                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.deepPurple),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                                height: 90,
                                                width: 160,
                                                color: Colors.white,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    AnimatedOpacity(
                                                      opacity: _infantcounter != 0 ? 1.0 : 0.0,
                                                      duration: Duration(milliseconds: 500),
                                                    ),
                                                    //SizedBox(height: 10.0),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        TextButton(
                                                          onPressed: _infantdecrementCounter,
                                                          child: Icon(Icons.remove),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          '$_infantcounter',
                                                          style: TextStyle(
                                                            fontSize: 18.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10.0),
                                                        TextButton(
                                                          onPressed: _infantincrementCounter,
                                                          child: Icon(Icons.add),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                          height: 50,
                                          width: 320,
                                          color: Colors.green,
                                        child:TextButton(
                                          onPressed: () async {

                                            print('passenger cnt clk');
                                            print(_counter + _childrenscounter + _infantcounter);
                                            int passengercnt = 0;
                                            passengercnt = _counter + _childrenscounter + _infantcounter;
                                            var passengerlist = passengercnt.toString() + " " +'Passengers';
                                            passengerController.text = passengerlist;



                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => FlightSearchVC()),
                                            );
                                            print(dropdownvalue);
                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            prefs.setString('classkey', (dropdownvalue));
                                            prefs.setString('passengerlistkey', (passengerlist));
                                            prefs.setInt('Adult_countkey', (_counter));
                                            prefs.setInt('_childrenscounterKey', (_childrenscounter));
                                            prefs.setInt('_infantcounter', (_infantcounter));


                                            prefs.setInt('Roundtripindexkey', selectedindex);
                                          },
                                          child: Text('Confirm',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.white),),
                                          style: ButtonStyle(
                                            alignment: Alignment.center, // <-- had to set alignment
                                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                              EdgeInsets.zero, // <-- had to set padding to zero
                                            ),
                                          ),
                                        ),
                                          // child:Align(
                                          //     alignment: Alignment.center,
                                          //     child: GestureDetector(
                                          //       onTap: () {
                                          //         print('passenger cnt clk');
                                          //         // print(_counter + _childrenscounter + _infantcounter);
                                          //         //
                                          //         // passengerController.text = _counter.toString() + _childrenscounter.toString() + _infantcounter.toString();
                                          //       },
                                          //       child: Text('Confirm',
                                          //           style: TextStyle(
                                          //             height: 1.2,
                                          //             fontFamily: 'Dubai',
                                          //             fontSize: 20,
                                          //             color: Colors.white,
                                          //             fontWeight: FontWeight.w800,
                                          //           )),
                                          //     ))
                                      ),


                                    ],
                                  ),
                                  // child: Container(
                                  //   height: 50,
                                  //   width: 320,
                                  //   color: Colors.white,
                                  //   child: TextField(
                                  //     decoration: InputDecoration(
                                  //       filled: true,
                                  //       fillColor: Color(0xFFFFFFFF),
                                  //       prefixIcon: Icon(Icons.flight, color: Colors.deepPurple),
                                  //       border: OutlineInputBorder(
                                  //         borderRadius: BorderRadius.all(
                                  //           Radius.circular(0),
                                  //         ),
                                  //       ),
                                  //       hintText: 'Passengers',
                                  //     ),
                                  //   ),
                                  // ),
                                ),


                                  ],
                                ),

                                // child: ListView(
                                //
                                // ),

                                //
                                // child: Center(
                                //   child: ListView.builder(
                                //     itemCount: 5,
                                //     itemBuilder: (context, index) {
                                //       return Padding(
                                //         padding: const EdgeInsets.only(top: 8.0),
                                //         child: Card(
                                //           margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                                //           color: index == selectedIndex
                                //               ? Colors.amberAccent
                                //               : Colors.brown[30],
                                //           child: ListTile(
                                //             isThreeLine: true,
                                //             title: Row(children: <Widget>[
                                //               Container(
                                //                 child: Text("Some Text"),
                                //                 alignment: Alignment.topLeft,
                                //               ),
                                //               Spacer(),
                                //               Container(
                                //                 child: Text("Some Text"),
                                //                 alignment: Alignment.topRight,
                                //               ),
                                //             ]),
                                //             subtitle: Container(
                                //                 child: Column(
                                //                     crossAxisAlignment: CrossAxisAlignment.start,
                                //                     children: <Widget>[
                                //                       Text("Some Text"),
                                //                     ])),
                                //             trailing: Row(
                                //               mainAxisSize: MainAxisSize.min,
                                //               children: <Widget>[
                                //                 GestureDetector(
                                //                   onTap: () {
                                //                     setState(() {
                                //                       selectedIndex = index;
                                //                     });
                                //                   },
                                //                   onLongPress: () => print("Long Press: Call"),
                                //                   child: Padding(
                                //                     padding: EdgeInsets.all(16.0),
                                //                     child: Icon(
                                //                       Icons.call,
                                //                       size: 20.0,
                                //                       color: Colors.green,
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       );
                                //     },
                                //   ),
                                // )

                                // child: ListView.builder(
                                //   itemCount: 5,
                                //   itemBuilder: (context, index) {
                                //     return Padding(
                                //       padding: const EdgeInsets.only(top: 8.0),
                                //       child: Card(
                                //         margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                                //         color: index == selectedIndex
                                //             ? Colors.amberAccent
                                //             : Colors.brown[30],
                                //         child: ListTile(
                                //           isThreeLine: true,
                                //           title: Row(children: <Widget>[
                                //             Container(
                                //               child: Text("Some Text"),
                                //               alignment: Alignment.topLeft,
                                //             ),
                                //             Spacer(),
                                //             Container(
                                //               child: Text("Some Text"),
                                //               alignment: Alignment.topRight,
                                //             ),
                                //           ]),
                                //           subtitle: Container(
                                //               child: Column(
                                //                   crossAxisAlignment: CrossAxisAlignment.start,
                                //                   children: <Widget>[
                                //                     Text("Some Text"),
                                //                   ])),
                                //           trailing: Row(
                                //             mainAxisSize: MainAxisSize.min,
                                //             children: <Widget>[
                                //               GestureDetector(
                                //                 onTap: () {
                                //                   setState(() {
                                //                     selectedIndex = index;
                                //                   });
                                //                 },
                                //                 onLongPress: () => print("Long Press: Call"),
                                //                 child: Padding(
                                //                   padding: EdgeInsets.all(16.0),
                                //                   child: Icon(
                                //                     Icons.call,
                                //                     size: 20.0,
                                //                     color: Colors.green,
                                //                   ),
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        )
    );
  }
}



