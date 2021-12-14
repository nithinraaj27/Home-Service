import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:home_service/sizeconfig.dart';

class current_card extends StatelessWidget {

  final String name;
  final String service;
  final String subservice;
  final String date;
  final String time;
  final String id;
  final String mobile;
  final String image;

  const current_card({Key? key, required this.name, required this.service, required this.subservice, required this.date, required this.time, required this.id, required this.mobile, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.height! * 13,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.2,color: Colors.lightBlue.shade900)
        )
      ),
      padding: EdgeInsets.only(bottom: SizeConfig.height! * 1),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(image),
              ),
            ),
          ),
          SizedBox(width: SizeConfig.width! * 1,),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(name,style: TextStyle(fontSize: SizeConfig.height! * 2,fontWeight: FontWeight.w900),)),
                  ),
                  Expanded(
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(subservice,style: TextStyle(fontSize: SizeConfig.height! * 1.8,fontWeight: FontWeight.w600),)),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(date,style: TextStyle(fontSize: SizeConfig.height! * 1.8,fontWeight: FontWeight.w600),),
                        ),
                        Expanded(
                          child: Text(time,style: TextStyle(fontSize: SizeConfig.height! * 1.8,fontWeight: FontWeight.w600),),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Expanded(child: Container(child: InkWell(
                      onTap: (){
                        FlutterPhoneDirectCaller.callNumber(mobile);
                      },
                      child: Icon(Icons.call,color: Colors.green,size: SizeConfig.height! * 3.5,)),)),
                  Expanded(child: Container(child: InkWell(
                      onTap: (){

                      },
                      child: Icon(Icons.cancel,color: Colors.red,size: SizeConfig.height! * 3.5,)),)),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
