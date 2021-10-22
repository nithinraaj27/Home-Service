import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_service/sizeconfig.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ServiceCards> _serviceCards = [
      ServiceCards(
        image: "assets/plumbing.png",
        name: "Hydraulic Services",
        index: 0,
      ),
      ServiceCards(
        image: "assets/masonry.png",
        name: "Masonry",
        index: 1,
      ),
      ServiceCards(
        image: "assets/electrician.png",
        name: "Electrical",
        index: 2,
      ),
      ServiceCards(
        image: "assets/painting.png",
        name: "Painting",
        index: 3,
      ),
      ServiceCards(
        image: "assets/plumbing.png",
        name: "Hydraulic Services",
        index: 0,
      ),
      ServiceCards(
        image: "assets/masonry.png",
        name: "Masonry",
        index: 1,
      ),
      ServiceCards(
        image: "assets/electrician.png",
        name: "Electrical",
        index: 2,
      ),
      ServiceCards(
        image: "assets/painting.png",
        name: "Painting",
        index: 3,
      ),
    ];

    Color _color = Colors.grey[200]!;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: SizeConfig.height! * 150,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.height! * 2,
            ),
            Expanded(
              flex: 1,
              child: Text(
                "Which service do you need?",
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: SizeConfig.height! * 3.7,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(
              height: SizeConfig.height! * 2,
            ),
            Expanded(
              flex: 5,
              child: GridView.count(
                physics: ScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 15.0,
                children: List.generate(_serviceCards.length, (index) {
                  return _serviceCards[index];
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Services {
  final String image;
  final String name;

  Services({required this.image, required this.name});
}

class ServiceCards extends StatelessWidget {
  final String image;
  final String name;
  final int index;
  const ServiceCards({
    Key? key,
    required this.image,
    required this.name,
    required this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color _color = Colors.grey[200]!;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Container(color: Colors.blueAccent),
          ),
        );
      },
      child: _serviceBox(_color, context),
    );
  }

  Container _serviceBox(Color _color, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(color: Colors.grey)),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                image,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              name,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: SizeConfig.height! * 1.7,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
