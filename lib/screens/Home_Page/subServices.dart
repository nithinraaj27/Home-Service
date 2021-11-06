import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_service/screens/Home_Page/service_column.dart';
import 'package:home_service/screens/Home_Page/sub_service_cards.dart';
import 'package:home_service/screens/Home_Page/sub_service_column.dart';
import 'package:provider/provider.dart';

import '../../sizeconfig.dart';

class SubServices extends StatefulWidget {
  final String uid;
  final String name;

  const SubServices({Key? key, required this.uid, required this.name})
      : super(key: key);

  @override
  _SubServicesState createState() => _SubServicesState();
}

class _SubServicesState extends State<SubServices> {
  final CollectionReference serviceCollection =
      FirebaseFirestore.instance.collection('services');

  List<SubServiceCards> _serviceListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return SubServiceCards(
        name: doc['name'] ?? '',
        image: doc['image'] ?? '',
        uid: doc['name'] ?? '',
        mainuid: widget.uid,
        mainname: widget.name,
      );
    }).toList();
  }

  Stream<List<SubServiceCards>> get sub_service_getter {
    return serviceCollection
        .doc(widget.uid)
        .collection(widget.name)
        .snapshots()
        .map(_serviceListFromSnapshot);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<SubServiceCards>>.value(
      value: sub_service_getter,
      initialData: [],
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: SizeConfig.height! * 150,
          child: SubHomeColumn(),
        ),
      ),
    );
  }
}
