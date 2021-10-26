import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_service/screens/Admin/service_providers/delete_service.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../../sizeconfig.dart';

class deleteservice extends StatefulWidget {
  const deleteservice({Key? key}) : super(key: key);

  @override
  _deleteserviceState createState() => _deleteserviceState();
}

class _deleteserviceState extends State<deleteservice> {

  bool ck = false;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      Provider.of<delete_mainService>(context, listen: false).fetch_service_list();
    });
    super.initState();
  }

  Future<void> deleteServicemethod() async {
    String id = Provider.of<delete_mainService>(context,listen: false).id;
    String collectionname =  Provider.of<delete_mainService>(context,listen: false).Selected_service;
    print(id);
    print(collectionname);

    var docref = FirebaseFirestore.instance
        .collection("services")
        .doc(id).collection(collectionname);

    var snapshot = await docref.get();

    for(var doc in snapshot.docs)
      {
        await doc.reference.delete();
      }

    await FirebaseFirestore.instance.collection("services").doc(id).delete();
    await _alertDialogBox("Deleted Successfully");
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
  }

  Future<void> _alert() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: Text(
                "It will delete the sub service related to this service",
                style: TextStyle(
                    color: Colors.black54, fontSize: SizeConfig.height! * 2),
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    deleteServicemethod();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          );
        });
  }

  Future<void> _alertDialogBox(String error) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: Text(
                error,
                style: TextStyle(
                    color: Colors.black54, fontSize: SizeConfig.height! * 2),
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Delete Main Service",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Select Main Service",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .merge(TextStyle(
                              fontSize: SizeConfig.height! * 3)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.width! * 1),
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.width! * 10),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            focusColor: Colors.blue,
                            dropdownColor: Colors.blue.shade50,
                            items: context.watch<delete_mainService>().services_list
                                .map((list) {
                              return DropdownMenuItem(
                                  value: list,
                                  child: Text(
                                    list,
                                    style: TextStyle(
                                        fontSize:
                                        SizeConfig.height! * 2.1,
                                        color: Color(0xff303132)),
                                  ));
                            }).toList(),
                            onChanged: (type) {
                              setState(() {
                                ck = true;
                              });
                              context
                                  .read<delete_mainService>()
                                  .set_selected_service(type.toString());
                            },
                            value: context
                                .watch<delete_mainService>()
                                .Selected_service,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ck
                ? Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width! * 4,
                  vertical: SizeConfig.height! * 2,
                ),
                child: Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 1;
                        i <
                            context
                                .watch<delete_mainService>()
                                .categories
                                .length;
                        i++)
                          Container(
                            height: SizeConfig.height! * 7,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black38.withOpacity(0.1),
                            ),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.width! * 3),
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.width! * 3,
                                vertical: SizeConfig.height! * 1),
                            child: Text(
                              "$i). ${(context.watch<delete_mainService>().categories[i])}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3,
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            )
                : Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                          image: AssetImage("assets/loading.gif"),
                          fit: BoxFit.fill)),
                )),
            ck ? Expanded(
              child: Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: ()  {
                    _alert();
                    print("pressed");
                  },
                  child: Container(
                    height: SizeConfig.height! * 7,
                    width: SizeConfig.width! * 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue,
                    ),
                    alignment: Alignment.center,
                    child: Text("Delete Service",style: Theme.of(context).textTheme.subtitle2,),
                  ),
                ),
              ),
            ): Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}