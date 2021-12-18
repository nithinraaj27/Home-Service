import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class user_details with ChangeNotifier{

  User? user = FirebaseAuth.instance.currentUser;
  String _name = "";
  String _mobile = "";
  String _email = "";
  String _location = "";

  String _updatedName = "";
  String _updatedMobile = "";
  String _updatedEmail = "";
  String _updatedLoc = "";

  String _new_loc = "Location";

  String _mobile_user_loc = "Location";


  String get Name => _name;
  String get Mobile => _mobile;
  String get Email => _email;
  String get Loc => _location;

  String get New_Loc => _new_loc;

  String get Update_Loc => _updatedLoc;

  String get Mobile_Loc => _mobile_user_loc;


  Future<void> set_data() async{
    await FirebaseFirestore.instance.collection("userdetails").doc(user!.uid).get().then((doc) =>
    {
      this._name = doc['Name'],
      this._updatedName = doc['Name'],
      this._mobile = doc['Mobile'],
      this._updatedMobile = doc['Mobile'],
      this._email = doc['E-mail'],
      this._updatedEmail = doc['E-mail'],
      this._location = doc['location'],
      this._updatedLoc = doc['location'],
    });
    notifyListeners();
  }

  Future<void> update_name(String a) async{
    this._updatedName = a;
    notifyListeners();
  }

  Future<void> update_mobile(String a) async{
    this._updatedMobile = a;
    notifyListeners();
  }

  Future<void> update_email(String a) async{
    this._updatedEmail = a;
    notifyListeners();
  }

  Future<void> update_loc(String a) async{
    this._updatedLoc = a;
    notifyListeners();
  }

  Future<void> set_new_loc(String a) async{
    this._new_loc = a;
    notifyListeners();
  }

  Future<void> set_mob_loc(String a) async{
    this._mobile_user_loc = a;
    notifyListeners();
  }


  Future<String> update() async{
    Map<String, dynamic> data = {
      "Name": this._updatedName,
      "Mobile": this._updatedMobile,
      "E-mail": this._updatedEmail,
      "location" : this._updatedLoc,
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
      this._location = doc['location'],
    });

    notifyListeners();

    return "Update Successful";
  }

}