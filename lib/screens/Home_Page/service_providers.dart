import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_service/screens/Home_Page/serviceProvidercard.dart';
import 'package:home_service/screens/Home_Page/service_column.dart';
import 'package:home_service/screens/Home_Page/service_providers_column.dart';
import 'package:home_service/screens/Home_Page/sub_service_cards.dart';
import 'package:home_service/screens/Home_Page/sub_service_column.dart';
import 'package:provider/provider.dart';

import '../../sizeconfig.dart';

class ServiceProviders extends StatefulWidget {
  final String uid;
  final String name;
  final String mainname;
  final String mainuid;

  const ServiceProviders(
      {Key? key,
      required this.uid,
      required this.name,
      required this.mainname,
      required this.mainuid})
      : super(key: key);

  @override
  _ServiceProvidersState createState() => _ServiceProvidersState();
}

class _ServiceProvidersState extends State<ServiceProviders> {
  final CollectionReference serviceCollection =
      FirebaseFirestore.instance.collection('services');

  List<ServiceProvidersCard> _serviceListFromSnapshot(
      QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return ServiceProvidersCard(
        name: doc['name'] ?? '',
        image: doc['image'] ?? '',
        mobile: doc['mobile'] ?? '',
        service: doc['service'] ?? '',
        status: doc['status'] ?? '',
        experience: doc['experience'] ?? '',
        qualification: doc['qualification'] ?? '',
        description: doc['description'] ?? '',
        mail: doc['mail'] ?? '',
        subService: doc['subService'] ?? '',
        location: doc['location'] ?? '',
        uid: doc.id,
      );
    }).toList();
  }

  Stream<List<ServiceProvidersCard>> get sub_service_getter {
    return serviceCollection
        .doc(widget.mainuid)
        .collection(widget.mainname)
        .doc(widget.uid)
        .collection("unblocked")
        .snapshots()
        .map(_serviceListFromSnapshot);
  }

  @override
  Widget build(BuildContext context) {
    print("MAIN PRINT PLACE : " + widget.uid);
    return StreamProvider<List<ServiceProvidersCard>>.value(
      value: sub_service_getter,
      initialData: [],
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: SizeConfig.height! * 150,
          child: ServiceProviderColumn(),
        ),
      ),
    );
  }
}
