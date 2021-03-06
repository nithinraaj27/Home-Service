import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/screens/main.dart';
import 'package:home_service/screens/Main_Page/signin.dart';
import 'package:home_service/service/get_services.dart';
import 'package:home_service/service/user_details.dart';
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
                        return userfinder();
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<user_details>.value(value: (user_details())),
      ],
      child: Consumer<AppStateNotifier>(builder: (context, appState, child) {
        return MaterialApp(
          home: signin(),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
        );
      }),
    );
  }
}

class helpertwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<user_details>.value(value: (user_details())),
        ChangeNotifierProvider<get_services>.value(value: (get_services())),
      ],
      child: Consumer<AppStateNotifier>(builder: (context, appState, child) {
        return MaterialApp(
          home: mainPage(),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
        );
      }),
    );
  }
}

class helperthree extends StatefulWidget {
  const helperthree({Key? key}) : super(key: key);

  @override
  _helperthreeState createState() => _helperthreeState();
}

class _helperthreeState extends State<helperthree> {
  @override
  Widget build(BuildContext context) {
    return helperfour();
  }
}

class helperfour extends StatefulWidget {
  const helperfour({Key? key}) : super(key: key);

  @override
  _helperfourState createState() => _helperfourState();
}

class _helperfourState extends State<helperfour> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      FirebaseAuth.instance.signOut();
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Color(0xff23ADE8),
            leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => helperone()));
                },
                child: Icon(
                  Icons.chevron_left,
                  size: SizeConfig.height! * 3.5,
                  color: Colors.white,
                )),
            title: Text(
              "Error Message",
              style: GoogleFonts.poppins(
                  fontSize: SizeConfig.height! * 2.5, color: Colors.white),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "You have no permisson",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: SizeConfig.height! * 4,
                      color: Color(0xff23ADE8),
                      fontWeight: FontWeight.w600),
                ),
                Image.asset(
                  "assets/error.gif",
                  fit: BoxFit.fill,
                ),
                Text(
                  "Download the USER APP",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: SizeConfig.height! * 4,
                      color: Colors.red,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ));
  }
}


class userfinder extends StatefulWidget {

  @override
  _userfinderState createState() => _userfinderState();
}

class _userfinderState extends State<userfinder> {
  String? role = "Service Provider";

  Future<void> checkrole() async {
    User user = FirebaseAuth.instance.currentUser!;
    final DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("userdetails")
        .doc(user.uid)
        .get();
    setState(() {
      role = snap['Role'];
    });
    print("Printing role");
    print(role);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkrole();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return role == 'user'? helpertwo() : role == 'Service Provider' || role == 'admin' ? helperthree() : helperone();
  }
}
