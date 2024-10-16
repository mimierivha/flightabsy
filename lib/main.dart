import 'package:new_version_plus/new_version_plus.dart';
import 'package:tourstravels/Splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'ABISINIYA',
      home: Splashscreen(),  // Setting Splash screen as the initial route
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedScreenIndex = 0;

  // Initialization: Check for updates when the app starts
  @override
  void initState() {
    super.initState();
    _checkVersion();  // Automatically checks app version on start
  }

  // Version checking function
  void _checkVersion() async {
    print('Checking app version...');

    final newVersion = NewVersionPlus(
      androidId: "com.Abisiniya.Abisiniya",  // Replace with your app's package ID
    );

    final status = await newVersion.getVersionStatus();
    print(status?.localVersion);
    print(status?.storeVersion);

    if (status?.localVersion != status?.storeVersion) {
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status!,
        allowDismissal: false,
        dialogTitle: "UPDATE",
        dialogText: "Please update the app from version ${status.localVersion} to ${status.storeVersion}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset("images/logo.jpg", height: 50.0),  // Logo image in the AppBar
        ),
        title: const Text(
          'ABISINIYA',
          style: TextStyle(
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: Center(
        child: Text("Welcome to Abisiniya!"),  // Placeholder for the body content
      ),
    );
  }
}
