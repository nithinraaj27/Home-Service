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

    //print("First Service: " + service_detail[0].toString());
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: SizeConfig.height! * 1,
          ),
          FadeAnimation(
            1,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                    child: Icon(
                  Icons.chevron_left,
                  color: Color(0xff23ADE8),
                  size: SizeConfig.height! * 4,
                )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: SizeConfig.width!*3),
                  child: Text(
                    "Service Providers List!",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: SizeConfig.height! * 2.5,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.height! * 2,
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
      ),
    );
  }
}
