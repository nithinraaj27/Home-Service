import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_service/screens/Profile_Page/Edit%20Profile/change_password.dart';

class add_subservices with ChangeNotifier{

  var _services = ["Select Service"];
  var _sub_service = ["Select Catagories", ""];

  String _selected_service = "Select Service";
  String _selected_catogories = "Select Categories";
  String _subserviceName = "";
  File? _imageFile;
  String _image = "";

  String get subserviceName => _subserviceName;
  String get imageName => _image;
  File? get imageFile => _imageFile;


  String _selected_service_docID = "";

  List<String> get service_list => _services;
  List<String> get sub_services => _sub_service;

  String get selected_service => _selected_service;
  String get selected_sub_service => _selected_catogories;

  Future<void> set_subserviceName(String a) async{
    this._subserviceName = a;
    notifyListeners();
  }

  Future<void> set_image(String a) async{
    this._image = a;
  }

  Future<void> set_imagefile(File a) async{
    this._imageFile = a;
  }

  Future<String> add() async{
    Map<String, dynamic> data = {
      "name": this._subserviceName,
      "image": this._image,
    };
    DocumentReference dc = FirebaseFirestore.instance.collection("services").doc(this._selected_service_docID).collection(this._selected_service).doc(this._subserviceName);
    await dc.set(data);
    notifyListeners();
    return "Sub Services Added Successfuly";
  }

  void set_selected_service(String a) async {
    this._selected_service = a;
    if (_selected_service != "Select Services") {
      this._sub_service.removeRange(1, _sub_service.length);
      await FirebaseFirestore.instance
          .collection('services')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if (element['name'] == _selected_service) {
            this._selected_service_docID = element.id;
          }
        });
      });
      await FirebaseFirestore.instance
          .collection('services')
          .doc(_selected_service_docID)
          .collection(_selected_service)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          this._sub_service.add(element.id);
        });
      });
    } else {
      this._sub_service.add("");
      this._sub_service.removeRange(2, _sub_service.length);
    }

    notifyListeners();
  }

  Future<void> fetch_service_list() async {
    if (_services.length <= 1) {
      await FirebaseFirestore.instance
          .collection('services')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          this._services.add(element['name']);
        });
      });
    }
    notifyListeners();
  }

}