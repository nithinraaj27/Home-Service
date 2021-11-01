import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/screens/Home_Page/service_cards.dart';
import 'package:home_service/screens/Home_Page/service_column.dart';
import 'package:home_service/sizeconfig.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference serviceCollection =
      FirebaseFirestore.instance.collection('services');

  List<ServiceCards> _serviceListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return ServiceCards(
        name: doc['name'] ?? '',
        image: doc['image'] ?? '',
        uid: doc['uid'] ?? '',
      );
    }).toList();
  }

  Stream<List<ServiceCards>> get service_getter {
    return serviceCollection.snapshots().map(_serviceListFromSnapshot);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ServiceCards>>.value(
      value: service_getter,
      initialData: [],
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: SizeConfig.height! * 150,
          child: HomeColumn(),
        ),
      ),
    );
  }
}
