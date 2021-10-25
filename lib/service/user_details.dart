import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class user_details with ChangeNotifier{

  User? user = FirebaseAuth.instance.currentUser;
  String _name = "";
  String _mobile = "";
  String _email = "";

  String _updatedName = "";
  String _updatedMobile = "";
  String _updatedEmail = "";


  String get Name => _name;
  String get Mobile => _mobile;
  String get Email => _email;

  Future<void> set_data() async{
    await FirebaseFirestore.instance.collection("userdetails").doc(user!.uid).get().then((doc) =>
    {
      this._name = doc['Name'],
      this._mobile = doc['Mobile'],
      this._email = doc['E-mail'],
    });
    notifyListeners();
  }

  Future<void> update_name(String a) async{
    this._updatedName = a;
  }

  Future<void> update_mobile(String a) async{
    this._updatedMobile = a;
  }

  Future<void> update_email(String a) async{
    this._updatedEmail = a;
  }



  Future<String> update() async{
    Map<String, dynamic> data = {
      "Name": this._updatedName,
      "Mobile": this._updatedMobile,
      "E-mail": this._updatedEmail,
    };
    FirebaseFirestore.instance
        .collection("userdetails")
        .doc(user!.uid)
        .update(data);

    await FirebaseFirestore.instance.collection("userdetails").doc(user!.uid).get().then((doc) =>
    {
      this._name = doc['Name'],
      this._mobile = doc['Mobile'],
      this._email = doc['E-mail'],
    });

    notifyListeners();

    return "Update Successful";
  }

}