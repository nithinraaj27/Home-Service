import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/screens/Admin/service/add_services.dart';
import 'package:home_service/screens/Admin/service/add_subservices.dart';
import 'package:home_service/sizeconfig.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'addsubservicehelper.dart';

class addsubservice extends StatefulWidget {
  const addsubservice({Key? key}) : super(key: key);

  @override
  _addsubserviceState createState() => _addsubserviceState();
}

class _addsubserviceState extends State<addsubservice> {

  final _formKey = GlobalKey<FormState>();
  bool ck = false;
  bool _autovalidate = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    XFile? selected = (await _picker.pickImage(source: ImageSource.gallery));
    File sle = File(selected!.path);
    context.read<add_services>().set_imagefile(sle);
    print((Provider.of<add_services>(context, listen: false).imageFile)
        .toString());
  }

  Future<void> uploadFile() async {
    File? _imageFile =
        Provider.of<add_services>(context, listen: false).imageFile;
    print(_imageFile);
    String filename = _imageFile!.path.split('/').last;
    print(filename);
    Reference storageref =
    FirebaseStorage.instance.ref().child("Service/$filename");
    final UploadTask uploadtask = storageref.putFile(_imageFile);
    final TaskSnapshot downloadurl = await uploadtask;
    final String url = await downloadurl.ref.getDownloadURL();
    context.read<add_services>().set_image(url);
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
                    Navigator.pop(context);
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
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<add_subservices>(context, listen: false).fetch_service_list();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Sub Services"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.height! * 90,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text("Select master service",style: Theme.of(context).textTheme.subtitle1,),
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
                              items: context.watch<add_subservices>().service_list
                                  .map((list) {
                                return DropdownMenuItem(
                                    value: list,
                                    child: Text(
                                      list,
                                      style: TextStyle(
                                          fontSize: SizeConfig.height! * 2.1,
                                          color: Color(0xff303132)),
                                    ));
                              }).toList(),
                              onChanged: (type) {
                                setState(() {
                                  ck  =true;
                                });
                                context
                                    .read<add_subservices>()
                                    .set_selected_service(type.toString());
                              },
                              value: context.watch<add_subservices>().selected_service,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ck ? Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 4,vertical: SizeConfig.height! * 2,),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for(int i=1; i<context.watch<add_subservices>().sub_services.length; i++)
                          Container(
                            height: SizeConfig.height! * 5,
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 3,vertical: SizeConfig.height! * 1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("$i). ",style: Theme.of(context).textTheme.headline3,),
                                Text(context.watch<add_subservices>().sub_services[i],style: Theme.of(context).textTheme.headline3,),
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ): Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                          image: AssetImage("assets/loading.gif"),
                        fit: BoxFit.fill
                      )
                    ),
                  )),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => addsubservicehelper()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      alignment: Alignment.center,
                      height: SizeConfig.height! * 5,
                      width: SizeConfig.width!  * 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue,
                      ),
                      child: Text(
                        "Add Services",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
