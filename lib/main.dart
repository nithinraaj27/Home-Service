import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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


class userfinder extends StatefulWidget {

  @override
  _userfinderState createState() => _userfinderState();
}

class _userfinderState extends State<userfinder> {

  String? role;

  Future<void> checkrole() async {
    User user = FirebaseAuth.instance.currentUser!;
    final DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("userdetails")
        .doc(user.uid)
        .get();
    setState(() {
      role = snap['Role'];
    });
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
    return (role == 'user')?  helpertwo() : helperone();
  }
}
