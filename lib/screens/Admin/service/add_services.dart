import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class add_services with ChangeNotifier{

  String _serviceName = "";
  File? _imageFile;
  String _image = "";

  String get serviceName => _serviceName;
  String get imageName => _image;
  File? get imageFile => _imageFile;


  Future<void> set_serviceName(String a) async{
    this._serviceName = a;
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
      "name": this._serviceName,
      "image": this._image,
    };
    await FirebaseFirestore.instance
        .collection("services")
        .doc()
        .set(data);

    notifyListeners();

    return "Added Successfuly";
  }
}