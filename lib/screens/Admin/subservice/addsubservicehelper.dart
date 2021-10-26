import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/screens/Admin/service_providers/add_subservices.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../sizeconfig.dart';
import '../Admin_main.dart';
import 'addsubservice.dart';

class addsubservicehelper extends StatefulWidget {
  const addsubservicehelper({Key? key}) : super(key: key);

  @override
  _addsubservicehelperState createState() => _addsubservicehelperState();
}

class _addsubservicehelperState extends State<addsubservicehelper> {
  String? sub_service_name;
  bool _autovalidate = false;
  String? image;
  bool ck = false;
  //File? _imageFile;

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    XFile? selected = (await _picker.pickImage(source: ImageSource.gallery));
    File sle = File(selected!.path);
    context.read<add_subservices>().set_imagefile(sle);
    print((Provider.of<add_subservices>(context, listen: false).imageFile)
        .toString());
  }

  Future<void> uploadFile() async {
    File? _imageFile =
        Provider.of<add_subservices>(context, listen: false).imageFile;
    print(_imageFile);
    String filename = _imageFile!.path.split('/').last;
    print(filename);
    Reference storageref = FirebaseStorage.instance.ref().child("Service/$filename");
    final UploadTask uploadtask = storageref.putFile(_imageFile);
    final TaskSnapshot downloadurl = await uploadtask;
    final String url = await downloadurl.ref.getDownloadURL();
    context.read<add_subservices>().set_image(url);
  }

  Future<void> _submitform() async {
    String? feedback =
    await Provider.of<add_subservices>(context, listen: false).add();
    _alertDialogBox(feedback);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => adminMain()));
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
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              "Add sub service",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: SizeConfig.height! * 90,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                              child: FadeAnimation(
                                1,
                                Form(
                                  key: _formKey,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: SizeConfig.width! * 6),
                                    height: SizeConfig.height! * 4,
                                    alignment: Alignment.center,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5, color: Colors.grey.shade500),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: TextFormField(
                                        onChanged: (val) {
                                          if (!val.isEmpty || val != "") {
                                            context
                                                .read<add_subservices>()
                                                .set_subserviceName(val);
                                          }
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty && value == "") {
                                            return "Sub Service name not be left empty";
                                          }
                                          return null;
                                        },
                                        autovalidate: _autovalidate,
                                        decoration: InputDecoration(
                                            hintText: " Sub Service Name",
                                            errorMaxLines: 1,
                                            prefixIcon: Icon(
                                              Icons.miscellaneous_services_rounded,
                                              size: SizeConfig.height! * 3,
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: SizeConfig.height! * 2.3,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey),
                                            border: InputBorder.none),
                                        style: GoogleFonts.poppins(
                                            fontSize: SizeConfig.height! * 2,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                          Expanded(
                            child: FadeAnimation(
                              1.1,
                              Container(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    _pickImage().whenComplete(() => {
                                      uploadFile().whenComplete(() => {
                                        setState(() {
                                          ck = true;
                                        })
                                      })
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: SizeConfig.height! * 7,
                                    width: SizeConfig.width! * 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.blue.shade100),
                                    child: Text(
                                      "Add Image",
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (ck)
                            Expanded(
                              flex: 3,
                              child: FadeAnimation(
                                1,
                                Container(
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: SizeConfig.width! * 5,
                                        vertical: SizeConfig.height! * 1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: new DecorationImage(
                                          image: AssetImage("assets/loading.gif"),
                                          fit: BoxFit.fill),
                                    ),
                                    child: Image.network(
                                      Provider.of<add_subservices>(context,
                                          listen: false)
                                          .imageName,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          else
                            Expanded(
                              flex: 3,
                              child: FadeAnimation(
                                1.3,
                                Container(
                                  alignment: Alignment.center,
                                  child: Container(
                                    //color: Colors.green,
                                    height: SizeConfig.height! * 35,
                                    width: SizeConfig.width! * 80,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            height: SizeConfig.height! * 22,
                                            width: SizeConfig.width! * 60,
                                            decoration: BoxDecoration(
                                              image: new DecorationImage(
                                                  image: AssetImage(
                                                      "assets/loading.gif"),
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              "No Preview Available",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: FadeAnimation(
                      1.4,
                      Container(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              if (!_formKey.currentState!.validate()) {
                                setState(() {
                                  _autovalidate = true;
                                });
                                _alertDialogBox("No field should be left Empty");
                              } else {
                                setState(() {
                                  _autovalidate = false;
                                });
                                _submitform();
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: SizeConfig.height! * 7,
                              width: SizeConfig.width! * 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue.shade500),
                              child: Text(
                                "Add Service",
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

