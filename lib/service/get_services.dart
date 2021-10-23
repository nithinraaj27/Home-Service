import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class get_services with ChangeNotifier {
  var _services = ["Select Services"];
  String _selected_service = "Select Services";
  var _sub_services = ["Select Categories",""];
  String _selected_catogories = "Select Categories";
  String _selected_Service_docId = "";

  List<String> get services_list => _services;

  String get Selected_service => _selected_service;

  List<String> get categories => _sub_services;

  String get Selected_categories => _selected_catogories;

  Future<void> fetch_service_list() async {
    if(_services.length <=1){
      await FirebaseFirestore.instance.collection('services').get().then((value) {
        value.docs.forEach((element) {
          this._services.add(element['name']);
        });
      });
    }
    notifyListeners();
  }

  void set_selected_service(String a) async {
    this._selected_service = a;
    if (_selected_service != "Select Services") {
      this._sub_services.removeRange(1, _sub_services.length);
      await FirebaseFirestore.instance.collection('services').get().then((
          value) {
        value.docs.forEach((element) {
          if (element['name'] == _selected_service) {
            this._selected_Service_docId = element.id;
          }
        });
      });
      await FirebaseFirestore.instance.collection('services').doc(
          _selected_Service_docId).collection(_selected_service).get().then((
          value) {
        value.docs.forEach((element) {
          this._sub_services.add(element.id);
        });
      });
    }
    else{
      this._sub_services.add("");
      this._sub_services.removeRange(2, _sub_services.length);
    }

    notifyListeners();
  }

  void set_selected_categories(String a) async{
    this._selected_catogories = a;

    notifyListeners();
  }
}
