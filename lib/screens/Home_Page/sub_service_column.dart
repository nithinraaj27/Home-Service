import 'package:flutter/material.dart';
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
        Expanded(
          flex: 1,
          child:Row(
            children: [
              Expanded(
                child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.chevron_left,
                      color: Color(0xff23ADE8),
                      size: SizeConfig.height! * 4,
                    )),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  "What Service do you need?",
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: SizeConfig.height! * 2.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          ),
        Expanded(
          flex: 6,
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
