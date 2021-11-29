import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../sizeconfig.dart';

class FullDetails extends StatefulWidget {
  final String name;
  final String image;
  final String mobile;
  final String service;
  final String status;
  final String experience;
  final String description;
  final String mail;
  final String qualification;

  const FullDetails(
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
  _FullDetailsState createState() => _FullDetailsState();
}

class _FullDetailsState extends State<FullDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          widget.status == "Open" ? Colors.green.shade50 : Colors.red.shade50,
      appBar: AppBar(
        backgroundColor:
            widget.status == "Open" ? Colors.green.shade50 : Colors.red.shade50,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Its " + widget.name + "..!",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: SizeConfig.height! * 2.7),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: CircleAvatar(
              radius: SizeConfig.height! * 10,
              child: Image.network(
                widget.image,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(
              "Has " +
                  widget.experience +
                  " of Experience in " +
                  widget.service.toUpperCase(),
              style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: SizeConfig.height! * 1.6,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Center(
            child: Text(
              "Email : " + widget.mail,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: SizeConfig.height! * 1.4,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              widget.description,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: SizeConfig.height! * 1.7,
                  ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.local_phone_outlined),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }
}