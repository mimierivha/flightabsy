import 'package:flutter/material.dart';
//import 'package:tourstravels/ApartVC/Add_Apartment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'dart:convert';
import 'package:tourstravels/ApartVC/Addaprtment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import '../ServiceDasboardVC.dart';
import 'NewUserbooking.dart';
//void main() => runApp(Apartmentscreen());
class ApartmentSearchResultscreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final baseDioSingleton = BaseSingleton();
  final borderRadius = BorderRadius.circular(20); // Image border
  int _counter = 0;
  int selectedIndex = 0;
  int imageID = 0;
  String citystr = '';
  String RetrivedPwd = '';
  String RetrivedEmail = '';
  String Logoutstr = '';
  String RetrivedCitylocation = '';
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      RetrivedCitylocation = prefs.getString('locationkey') ?? "";
      print('Retrived city loc....');
      print(RetrivedCitylocation);
      RetrivedEmail = prefs.getString('emailkey') ?? "";
      RetrivedPwd = prefs.getString('passwordkey') ?? "";
      Logoutstr = prefs.getString('logoutkey') ?? "";
      var propertytype = prefs.getString('Property_type') ?? "";
      print(propertytype);
      print('logout....');
      print(Logoutstr);
    });
  }
    Future<dynamic> SendRequesertSearch() async {
      try{
      print('search url...');
      print(RetrivedCitylocation);
      print(baseDioSingleton.AbisiniyaBaseurl +'common/search');
      Response response = await post(
        //Uri.parse('https://staging.abisiniya.com/api/v1/login'),
          Uri.parse(baseDioSingleton.AbisiniyaBaseurl +'common/search'),
          body: {
            'type' : 'apartment',
            'keyword' : RetrivedCitylocation
          }
      );
      //isLoading = true;
      if(response.statusCode == 200){
        //isLoading = false;
        print('success search api response');
        final data = jsonDecode(response.body);
        print(data);
        return json.decode(response.body);

      }else {
        print('failed');
        //final snackBar = SnackBar(
        //   content: Text('Hi, Invalid login credentials'),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }catch(e){
      print(e.toString());
    }
  }
  //Login Authentication for Fresh or Existing user:
  void login(String email , password) async {
    try{
      Response response = await post(
        //Uri.parse('https://staging.abisiniya.com/api/v1/login'),
          Uri.parse(baseDioSingleton.AbisiniyaBaseurl + 'login'),
          body: {
            'email' : RetrivedEmail,
            'password' : RetrivedPwd
          }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('User Login Authentication  successfully');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddApartment()
          ),
        );
      } else {
        print('failed');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserBooking()
          ),
        );
      }
    }catch(e){
      print(e.toString());
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    SendRequesertSearch();
  }
  Future<dynamic> getData() async {
    //String url = 'https://staging.abisiniya.com/api/v1/apartment/list';
    String url = baseDioSingleton.AbisiniyaBaseurl + 'apartment/list';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data1 = jsonDecode(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
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
          centerTitle: true,
          leading: BackButton(
            onPressed: () async{
              print("back Pressed");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ServiceDashboardScreen()),
              );
            },
          ),
          title: Text('Search Result',textAlign: TextAlign.center,
              style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
        ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.white, Colors.green]),
            ),
            child: FutureBuilder(
                //future: SendRequesertSearch(),
              future: SendRequesertSearch(),


                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('Input a URL to start');
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                      return Text('');
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text(
                          '${snapshot.error}',
                          style: TextStyle(color: Colors.white),
                        );
                      } else {
                        return Column(
                          children: [
                            Expanded(child: Container(

                                child: LayoutBuilder(
                                    builder: (context, constraint) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          // mainAxisSize: MainAxisSize.min,
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[

                                            SizedBox(
                                              height: 20,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            SizedBox(
                                                height: 510, // <-- you should put some value here
                                                child: ListView.separated(
                                                  // physics: NeverScrollableScrollPhysics(),
                                                  // shrinkWrap: true,
                                                  scrollDirection: Axis.vertical,
                                                  itemCount: snapshot.data['data'].length ,
                                                  //itemCount: snapshot.data?["data"]['pictures'].length ?? '',
                                                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return Container(
                                                      height: 510,
                                                      width: 300,
                                                      //margin: EdgeInsets.all(Top:20),// add margin
                                                      //padding: EdgeInsets.all(20),
                                                      margin: EdgeInsets.only(top: 0, left: 20,right: 20),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.black,
                                                            width: 0.0,
                                                            style: BorderStyle.solid
                                                        ),
                                                        borderRadius: BorderRadius.circular(20),
                                                        //color: Colors.yellowAccent,
                                                        color: Colors.white,
                                                      ),
                                                      child: InkWell(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 25,
                                                            ),
                                                            Container(
                                                              height: 475,
                                                              width: 300,
                                                              decoration: const BoxDecoration(
                                                                  color: Color(0xFFffffff),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors.white,
                                                                      blurRadius: 15.0, // soften the shadow
                                                                      spreadRadius: 5.0, //extend the shadow
                                                                      offset: Offset(
                                                                        5.0, // Move to right 5  horizontally
                                                                        5.0, // Move to bottom 5 Vertically
                                                                      ),
                                                                    )
                                                                  ],
                                                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 200,
                                                                    decoration: BoxDecoration(
                                                                      // image: DecorationImage(image: NetworkImage(snapshot.data["data"][index]['pictures'][0
                                                                      // ]['imageUrl']),
                                                                        image: DecorationImage(image: NetworkImage(snapshot.data?['data'][index]['pictures'].isEmpty ? 'Empty image'
                                                                            : snapshot.data?["data"][index]['pictures'][0]['imageUrl'].toString() ?? 'empty'),
                                                                            fit: BoxFit.cover)
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 170,
                                                                    width: 300,
                                                                    color: Colors.white,
                                                                    child: Column(
                                                                      children: [
                                                                        SizedBox(
                                                                          width: 10,
                                                                        ),
                                                                        Container(
                                                                          width: 280,
                                                                          height: 40,
                                                                          color: Colors.white,
                                                                          child:Text(snapshot.data['data'][index]['city'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.green)),),
                                                                        ),
                                                                        SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        Container(
                                                                          width: 280,
                                                                          height: 70,
                                                                          color: Colors.white,
                                                                          //child: (Text(snapshot.data['data']['price'] as int)),
                                                                          child:Row(
                                                                            children: [
                                                                              Container(
                                                                                height: 60,
                                                                                width: 140,
                                                                                color: Colors.white,
                                                                                child: Column(
                                                                                  children: [
                                                                                    Container(
                                                                                      height: 30,
                                                                                      width: 140,
                                                                                      child:Text('Start From',textAlign: TextAlign.start,style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black)),),
                                                                                    ),
                                                                                    Container(
                                                                                      height: 30,
                                                                                      width: 140,
                                                                                      child:Text('${(snapshot.data['data'][index]['price'].toString())}.00/Night.',textAlign: TextAlign.left,
                                                                                        style: (TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.green)),),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                height: 40,
                                                                                width: 140,
                                                                                color: Colors.white,
                                                                                child: TextButton(
                                                                                  style: TextButton.styleFrom(backgroundColor:Colors.green),
                                                                                  onPressed: () async {
                                                                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                                    prefs.setString('citykey', snapshot.data['data'][index]['city']);
                                                                                    prefs.setInt('imgkeyId', snapshot.data['data'][index]['id']);
                                                                                    prefs.setString('addresskey', snapshot.data['data'][index]['address']);
                                                                                    prefs.setString('bathroomkey', (snapshot.data['data'][index]['bathroom'].toString()));
                                                                                    prefs.setString('bedroomkey', (snapshot.data['data'][index]['bedroom'].toString()));
                                                                                    prefs.setString('pricekey', (snapshot.data['data'][index]['price'].toString()));
                                                                                    prefs.setString('Property_type', ('Apartment'));
                                                                                    prefs.setString('emailkey', (RetrivedEmail));
                                                                                    prefs.setString('passwordkey', (RetrivedPwd));
                                                                                    print('email....');
                                                                                    print(RetrivedEmail);
                                                                                    print('pwd...');
                                                                                    print(RetrivedPwd);
                                                                                    print('logout......');
                                                                                    print(Logoutstr);
                                                                                    Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                          builder: (context) => UserBooking()
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  //child: const Text('BookNow'),
                                                                                  child: const Text('BookNow',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),

                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width: 10,
                                                                        ),
                                                                        Container(
                                                                          height: 50,
                                                                          width: 280,
                                                                          color: Colors.white,
                                                                          child:Text(snapshot.data['data'][index]['address'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.green)),),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 24,
                                                                  ),
                                                                  Container(
                                                                    height: 60,
                                                                    width: 280,
                                                                    color: Colors.green,
                                                                    child: Row(
                                                                      children: [

                                                                        Container(
                                                                          height: 40,
                                                                          width: 140,
                                                                          color: Colors.green,
                                                                          child:Text('${(snapshot.data['data'][index]['bedroom'].toString())} Bedroom(s)',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),textAlign: TextAlign.center,
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          height: 40,
                                                                          width: 140,
                                                                          color: Colors.green,
                                                                          child:Text('${(snapshot.data['data'][index]['bathroom'].toString())} Bathroom(s)',textAlign: TextAlign.center,
                                                                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18), ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        //onTap: ()
                                                        onTap: ()async{
                                                          print([index]);
                                                        },
                                                      ),
                                                    );},
                                                )
                                            ),
                                            Column(
                                              children: [
                                                Text('Popular Offers',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800),)
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                )))
                          ],
                        );
                      }
                  }
                }
            )
        )
    );
  }
}
