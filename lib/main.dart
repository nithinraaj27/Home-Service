
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/screens/locationgetter.dart';
import 'package:home_service/screens/main.dart';
import 'package:home_service/screens/mobilesignin.dart';
import 'package:home_service/screens/signin.dart';
import 'package:home_service/screens/signup.dart';
import 'package:home_service/sizeconfig.dart';
import 'package:home_service/style/appState.dart';
import 'package:home_service/style/appTheme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(),
      child: MaterialApp(
        home: helperclass(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class helperclass extends StatelessWidget {
  const helperclass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<FirebaseApp> _intialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _intialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Error: ${snapshot.error}"),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, Streamsnapshot) {
                    if (Streamsnapshot.hasError) {
                      return Scaffold(
                        body: Center(
                          child: Text("Error: ${Streamsnapshot.hasError}"),
                        ),
                      );
                    }

                    if (Streamsnapshot.connectionState ==
                        ConnectionState.active) {
                      User? _user = Streamsnapshot.data as User?;
                      if (_user == null) {
                        return helperone();
                      } else {
                        return helpertwo();
                      }
                    }


                    return Scaffold(
                      body: Center(
                        child: Text(
                          "Checking Authentication",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    );
                  });
            }
            return Scaffold(
              body: Center(
                child: Text("Intialising App....."),
              ),
            );
          }),
    );
  }
}

class helperone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Consumer<AppStateNotifier>(builder: (context, appState, child) {
      return MaterialApp(
        home: signin(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
      );
    });
  }
}

class helpertwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Consumer<AppStateNotifier>(builder: (context, appState, child) {
      return MaterialApp(
        home: mainPage(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
      );
    });
  }
}


