import 'package:flutter/material.dart';

class ServiceProvidersCard extends StatelessWidget {
  final String name;
  final String image;
  final String mobile;
  final String service;
  final String status;
  final String experience;
  final String description;
  final String mail;
  final String qualification;

  const ServiceProvidersCard(
      {Key? key,
      required this.name,
      required this.image,
      required this.mobile,
      required this.service,
      required this.status,
      required this.experience,
      required this.description,
      required this.mail,
      required this.qualification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Hello" + name);
    return ListTile(
      title: Text(name),
      subtitle: Text(mail),
    );
  }
}
