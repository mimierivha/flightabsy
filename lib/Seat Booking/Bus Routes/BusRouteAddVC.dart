
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

//https://stackoverflow.com/questions/59425633/flutter-create-dynamic-textfield-when-button-click
void main() {
  runApp(BusRouteAddscreen());
}

class BusRouteAddscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Add Route Details',style: (TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.black54)),),

            SizedBox(
              height: 100,
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () async {
                List<PersonEntry> persons = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SOF(),
                  ),
                );
                if (persons != null) persons.forEach(print);
              },
            ),
          ],


        ),
        // child: TextButton(
        //   child: Text('Add'),
        //   onPressed: () async {
        //     List<PersonEntry> persons = await Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => SOF(),
        //       ),
        //     );
        //     if (persons != null) persons.forEach(print);
        //   },
        // ),
      ),
    );
  }
}

class SOF extends StatefulWidget {
  @override
  _SOFState createState() => _SOFState();
}

class _SOFState extends State<SOF> {
  var locationnameTECs = <TextEditingController>[];
  var minutesTECs = <TextEditingController>[];
  var priceTECs = <TextEditingController>[];

  var cards = <Card>[];
  List<String> namgeList = [];
  var name = '';
  var locationnamestr = '';
  var minutesstr = '';
  var pricestr = '';
  var locationName = '';
  String? dropdownvalue;
  var locationmultplevalues = [];
  var minutesmultplevalues = [];
  var pricemultplevalues = [];
  List<String> items = [];
  List<String> LocationIdItems = [];


  void changedData(String? value){
    var dropdownValue = value!;
  }


  Card createCard() {
    //String? dropdownvalue;
    List<String> namgeList = [];

    var locationIdValue = '';


    var locationController = TextEditingController();
    var minutesController = TextEditingController();
    var priceController = TextEditingController();
    var locationID = '';
    locationnameTECs.add(locationController);

    minutesTECs.add(minutesController);
    priceTECs.add(priceController);

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Location ${cards.length + 1}'),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<dynamic>(
                future: getAllCategory(),
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    var data = snapshot.data!;
                    // print('data...');
                    // print(data);
                    print(items);
                    print(LocationIdItems);


                    // var dataid = snapshot.data!['id'].toString();
                    // print('id...');
                    // print(dataid);


                    SizedBox(
                      height: 50,
                    );
                    return DropdownButton<String>(
                      isExpanded: true,
                      hint: Text(
                        'Select Location',
                        //style: kMainContentStyleLightBlack,
                      ),
                      autofocus: true,
                      //value: dropdownValue!, //?? dropdownOptions[0],
                      //value: dropdownvalue ?? data[0],
                      // value: data[0] ?? 'Selected Value',
                      icon: const Icon(
                        Icons.agriculture_rounded,
                        color: Color(0xFF773608), //Color(0xFF2E7D32), //Colors.green,
                      ),
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String? newValue,) {
                        setState(() {
                          dropdownvalue = newValue!;
                          print('call....');
                          print(newValue);
                          items.indexOf(newValue) + 1;
                          print('index...');
                          print(items.indexOf(newValue) + 1);
                          locationID = (items.indexOf(newValue) + 1).toString();
                          locationController.text = newValue;
                          DropdownMenuItem(child: Text(newValue), value: newValue);
                          // return cards.add(newValue as Card);
                          //cards.add(createCard());
                        });
                      },
                      items: data.map<DropdownMenuItem<String>>((String newValue) {
                        return DropdownMenuItem<String>(
                          value: newValue,
                          child: Text(newValue),
                        );
                      }
                      ).toList(),
                    );

                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),



              // FutureBuilder<List<String>>(
              //   future: getAllCategory(),
              //   builder: (context, snapshot) {
              //
              //     if (snapshot.hasData) {
              //       var data = snapshot.data!;
              //     // var  bookingID = snapshot.data['data'];
              //
              //       print('data...');
              //       print(data);
              //       print('namelist....');
              //
              //       SizedBox(
              //         height: 50,
              //       );
              //       return DropdownButton<String>(
              //         isExpanded: true,
              //         hint: Text(
              //           'Select Location',
              //           //style: kMainContentStyleLightBlack,
              //         ),
              //         autofocus: true,
              //         //value: dropdownValue!, //?? dropdownOptions[0],
              //            //value: dropdownvalue ?? data[0],
              //         // value: data[0] ?? 'Selected Value',
              //         icon: const Icon(
              //           Icons.agriculture_rounded,
              //           color: Color(0xFF773608), //Color(0xFF2E7D32), //Colors.green,
              //         ),
              //         elevation: 16,
              //         underline: Container(
              //           height: 2,
              //           color: Colors.black,
              //         ),
              //         onChanged: (String? newValue) {
              //           setState(() {
              //             dropdownvalue = newValue!;
              //             print('call....');
              //             print(newValue);
              //
              //             jobController.text = newValue;
              //             DropdownMenuItem(child: Text(newValue), value: newValue);
              //             // return cards.add(newValue as Card);
              //             //cards.add(createCard());
              //           });
              //         },
              //         items: data.map<DropdownMenuItem<String>>((String newValue) {
              //           return DropdownMenuItem<String>(
              //             value: newValue,
              //             child: Text(newValue),
              //           );
              //         }).toList(),
              //       );
              //
              //     } else {
              //       return const CircularProgressIndicator();
              //     }
              //   },
              // ),
            ],
          ),

          TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location')),
          TextField(
              controller: minutesController,
              decoration: InputDecoration(labelText: 'minutes')),
          TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'price')),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    cards.add(createCard());



  }

//   @override
//   void initState() {
//     super.initState();
// //    cards.add(createCard());
//     getData();
//   }
  //var dropdownvalue;




  //final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  final TextEditingController routenameController = TextEditingController();
  String result = ''; // To s





  _onDone() {
    // _postData();
    // RouteAdd('p1,p2','1','1','1');
    //sendPostRequest();
    List<PersonEntry> entries = [];
    List<List<dynamic>>listArray = List<List<dynamic>>.empty(growable: true);

    final combinedData = <Map<String, dynamic>>[];
    // var myControllers = [];


    //list.join() // 'abc';

    for (int i = 0; i < cards.length; i++) {

      locationnamestr = locationnameTECs[i].text;
      locationmultplevalues.add(locationnameTECs[i].text);
      print('name...');
      print(locationmultplevalues);
      minutesstr = minutesTECs[i].text;
      minutesmultplevalues.add(minutesTECs[i].text);
      print(minutesmultplevalues);
      pricestr = priceTECs[i].text;
      pricemultplevalues.add(priceTECs[i].text);
      print(pricemultplevalues);
      //print((locationmultplevalues.toString()));


      //final input = '[name 1, name2, name3, ...]';
      // final removedBrackets = locationmultplevalues.toString().substring(1, myControllers.toString().length - 1);
      // final parts = removedBrackets.split(', ');
      // print(parts);

      // var joined = parts.map((part) => "'$part'").join(',');
      //
      // print('joined...');
      // print(joined);


      // String json = jsonEncode(myControllers);
      // print(json);
      //
      // List list2 = jsonDecode(json);
      // print(list2);


      // combinedData.add(nameTECs[i].text as Map<String, dynamic>);
      // print('combined d...');
      // print(combinedData);

      // List documents = [];// empty list of documents
      // documents.add(name);
      // print(documents[i]);

      //print("${nameTECs[i].text[i++]}");



      // print(listArray.add(nameTECs[i].text));
      // print(listArray.add((nameTECs[i].text)));
      // entries.add(PersonEntry(name));
      // print(entries);
      // print(entries.add(PersonEntry(name)));



      // listArray.add(nameTECs[i].text as List);
      // print('Array....');
      // print(listArray);

      _postData();
      //  var listArray = [];
      //  listArray.add(name);
      //  print(listArray);
      //  namgeList.join("");
      // print(namgeList.join(""));
      // var age = ageTECs[i].text;
      //  print('age...');
      //  print(age);
      //   var job = jobTECs[i].text;
      //  print('job...');
      //  print(job);
      entries.add(PersonEntry(name));
    }

    Navigator.pop(context, entries);
  }

  Future<dynamic> getAllCategory() async {
    //var baseUrl = "https://staging.abisiniya.com/api/v1/flight/airlinelist";
    var baseUrl = 'https://staging.abisiniya.com/api/v1/bus/buslocation/list';

    http.Response response = await http.get(Uri.parse(baseUrl));
    // if (response.statusCode == 200) {
    //   final data1 = jsonDecode(response.body);
    //   var getpicsData = [];
    //   var picstrr = data1['data'];
    //   print(picstrr);
    //   for (var record in picstrr) {
    //     var locationNAme = record['buslocation'];
    //     print('num....');
    //     print(locationNAme);
    //     namgeList.add(locationName);
    //   }
    //   return json.decode(response.body);
    // }
    if (response.statusCode == 200) {

      var jsonData = json.decode(response.body);
      print(jsonData.toString());
      var namestr = jsonData['data'];
      for (var nameArray in namestr) {
        String namestrvalue = nameArray['buslocation'];
        //String namestrvalue = nameArray['id'].toString();

        String locationID1 = nameArray['id'].toString();
        //print(namestrvalue);
        items.add(namestrvalue);
        LocationIdItems.add(locationID1);
      }
      return items;
    }
    else {
      throw response.statusCode;
    }
  }


  Future<void> _postData() async {
    try {
      var apiUrl = '';
      // print('calling name value...');
      // print(name);

      apiUrl = 'https://staging.abisiniya.com/api/v1/bus/route/add/routesdetail';

      var RetrivedBearertoekn = '342|eIl3iQCOQ8N2GxMJJ1DdRyvAVdcNiZXzBMydNnQB580bd26e';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          //'Content-Type': 'application/json; charset=UTF-8',
          "Authorization":"Bearer $RetrivedBearertoekn",
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          'name' : routenameController.text,
          'locids' : locationmultplevalues,
          'minutes' : minutesmultplevalues,
          'prices' : pricemultplevalues
          // Add any other data you want to send in the body
        }),
      );

      print('code....');
      print(response.statusCode);
      if (response.statusCode == 201) {
        // Successful POST request, handle the response here
        final responseData = jsonDecode(response.body);
        // setState(() {
        //   result = 'ID: ${responseData['id']}\nName: ${responseData['name']}\nEmail: ${responseData['email']}';
        // }
        // );
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to post data');
      }
    } catch (e) {
      // setState(() {
      //   result = 'Error: $e';
      // });
    }
  }

  List categoryItemlist = [];
  var subjectItemlist = [];


  Future<dynamic> getData() async {
    // String url = 'https://staging.abisiniya.com/api/v1/vehicle/auth/list';
    var RetrivedBearertoekn = '402|H1Xpj6eVWsFoFi8Uv3H1tQMojRD07v7qsMQ5l5Vxdc0ee1fe';
    String url = 'https://staging.abisiniya.com/api/v1/bus/buslocation/list';
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
      var jsonData = json.decode(response.body);
      print(jsonData);
      setState(() {
        categoryItemlist = jsonData;
        print(categoryItemlist);
      });
    }
    // if (response.statusCode == 200) {
    //   var jsonDataSubject = json.decode(response.body);
    //   setState(() {
    //     categoryItemlist.add(jsonDataSubject);
    //     print(categoryItemlist);
    //   });
    // }
    // if (response.statusCode == 200) {
    //   final data1 = jsonDecode(response.body);
    //   var getpicsData = [];
    //   var picstrr = data1['data'];
    //   print('location.');
    //   print(picstrr);
    //   // for (var record in picstrr) {
    //   //   idnum = record['id'];
    //   // }
    //   return json.decode(response.body);
    // }

    else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[

          Text('Add Route Details',style: (TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.black54)),),

          SizedBox(
            height: 100,
          ),

          TextField(
              controller: routenameController,
              decoration: InputDecoration(labelText: 'Enter routename seperated by comma')),
          Expanded(
            child: ListView.builder(
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int index) {
                return cards[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              child: Text('add new'),
              onPressed: () => setState(() => cards.add(createCard())),
            ),
          )
        ],
      ),
      floatingActionButton:
      FloatingActionButton(child: Icon(Icons.done), onPressed: _onDone),
    );
  }
}
class PersonEntry {
  final String name;
  // final String age;
  // final String studyJob;

  PersonEntry(this.name);
  @override
  String toString() {
    // print('str values..');
    // print(name);
    return 'Person: name= $name';
  }
}