import 'package:flutter/material.dart';
import 'package:home_service/Animation/animation.dart';

import '../../sizeconfig.dart';

class ServiceCards extends StatelessWidget {
  final String image;
  final String name;
  const ServiceCards({
    Key? key,
    required this.image,
    required this.name,
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

  FadeAnimation _serviceBox(Color _color, BuildContext context) {
    return FadeAnimation(
      1.5,
      Container(
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
                child: Image.network(
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
      ),
    );
  }
}
