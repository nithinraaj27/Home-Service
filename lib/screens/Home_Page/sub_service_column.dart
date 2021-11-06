import 'package:flutter/material.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/screens/Home_Page/service_cards.dart';
import 'package:home_service/screens/Home_Page/sub_service_cards.dart';
import 'package:provider/provider.dart';

import '../../sizeconfig.dart';

class SubHomeColumn extends StatefulWidget {
  @override
  _SubHomeColumnState createState() => _SubHomeColumnState();
}

class _SubHomeColumnState extends State<SubHomeColumn> {
  @override
  Widget build(BuildContext context) {
    final List<SubServiceCards> service_detail =
        Provider.of<List<SubServiceCards>>(context);

    print("HELLO" + service_detail.toString());
    return Column(
      children: <Widget>[
        SizedBox(
          height: SizeConfig.height! * 2,
        ),
        Expanded(
          flex: 1,
          child: FadeAnimation(
            1,
            Text(
              "What Service do you need?",
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: SizeConfig.height! * 3.7,
                    fontWeight: FontWeight.bold,
                  ),
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
            children: List.generate(service_detail.length, (index) {
              return service_detail[index];
            }),
          ),
        ),
      ],
    );
  }
}