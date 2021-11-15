import 'package:flutter/material.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/screens/Home_Page/serviceProvidercard.dart';
import 'package:home_service/screens/Home_Page/service_cards.dart';
import 'package:provider/provider.dart';

import '../../sizeconfig.dart';

class ServiceProviderColumn extends StatefulWidget {
  @override
  _ServiceProviderColumnState createState() => _ServiceProviderColumnState();
}

class _ServiceProviderColumnState extends State<ServiceProviderColumn> {
  @override
  Widget build(BuildContext context) {
    final List<ServiceProvidersCard> service_detail =
        Provider.of<List<ServiceProvidersCard>>(context);

    print("SERVICE DETAIL : " + service_detail.toString());
    return Column(
      children: <Widget>[
        SizedBox(
          height: SizeConfig.height! * 2,
        ),
        FadeAnimation(
          1,
          Text(
            "Service Providers List!",
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: SizeConfig.height! * 3.7,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Expanded(
          flex: 5,
          child: ListView(
            physics: ScrollPhysics(),
            children: List.generate(service_detail.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FadeAnimation(1, service_detail[index]),
              );
            }),
          ),
        ),
      ],
    );
  }
}
