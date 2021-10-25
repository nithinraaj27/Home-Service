import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/screens/Admin/addService.dart';
import 'package:home_service/screens/Admin/addsubservice.dart';
import 'package:home_service/sizeconfig.dart';

class adminhome extends StatefulWidget {
  const adminhome({Key? key}) : super(key: key);

  @override
  _adminhomeState createState() => _adminhomeState();
}

class _adminhomeState extends State<adminhome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
          body: Container(
        child: Column(
          children: [
            Expanded(
                child: FadeAnimation(
                  1,Container(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 2),
              alignment: Alignment.bottomLeft,
              child: Text(
                  "Welcome Admin,",
                  style: Theme.of(context).textTheme.headline1,
              ),
            ),
                )),
            Expanded(
                flex: 8,
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => addService()));
                          },
                          child: FadeAnimation(
                            1.1,Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blue.shade100
                              ),
                              margin: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Icon(Icons.home_repair_service,
                                    color: Colors.black,
                                        size: SizeConfig.height! * 5,),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Add Services",style: Theme.of(context).textTheme.subtitle2!.merge(TextStyle(fontSize: SizeConfig.height! * 3,color: Colors.black)),))),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => addsubservice()));
                          },
                          child: FadeAnimation(
                            1.2,Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue.shade100
                              ),
                              margin: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Icon(Icons.home_repair_service,
                                      color: Colors.black,
                                      size: SizeConfig.height! * 5,),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Update Services",style: Theme.of(context).textTheme.subtitle2!.merge(TextStyle(fontSize: SizeConfig.height! * 3,color: Colors.black)),))),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FadeAnimation(
                          1.3,Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blue.shade100
                            ),
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Icon(Icons.delete_sharp,
                                    color: Colors.black,
                                    size: SizeConfig.height! * 5,),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Delete Services",style: Theme.of(context).textTheme.subtitle2!.merge(TextStyle(fontSize: SizeConfig.height! * 3,color: Colors.black)),))),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => addsubservice()));
                          },
                          child: FadeAnimation(
                            1.4,Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blue.shade100
                            ),
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Icon(Icons.home_repair_service_outlined,
                                    color: Colors.black,
                                    size: SizeConfig.height! * 5,),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Add Sub Services",style: Theme.of(context).textTheme.subtitle2!.merge(TextStyle(fontSize: SizeConfig.height! * 3,color: Colors.black)),))),
                              ],
                            ),
                          ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => addsubservice()));
                          },
                          child: FadeAnimation(
                            1.5,Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blue.shade100
                            ),
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Icon(Icons.home_repair_service_outlined,
                                    color: Colors.black,
                                    size: SizeConfig.height! * 5,),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Update Sub Services",style: Theme.of(context).textTheme.subtitle2!.merge(TextStyle(fontSize: SizeConfig.height! * 3,color: Colors.black)),))),
                              ],
                            ),
                          ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => addsubservice()));
                          },
                          child: FadeAnimation(
                            1.6,Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blue.shade100
                            ),
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Icon(Icons.delete,
                                    color: Colors.black,
                                    size: SizeConfig.height! * 5,),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Delete Sub Services",style: Theme.of(context).textTheme.subtitle2!.merge(TextStyle(fontSize: SizeConfig.height! * 3,color: Colors.black)),))),
                              ],
                            ),
                          ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      )),
    );
  }
}
