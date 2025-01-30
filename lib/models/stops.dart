import 'package:cloud_firestore/cloud_firestore.dart';

class StopsModel {
  int position = 0;
  String name = "";
  String address = '';
  String sponserLink = "";
  String sponserName = "";
  GeoPoint stopLocation = const GeoPoint(0.0, 0.0);
  StopsModel();

  StopsModel.toModel(Map<String, dynamic> jsonMap) {
    address = jsonMap['address'] ?? "";
    sponserName = jsonMap['sponserName'] ?? "";
    sponserLink = jsonMap['sponserLink'] ?? "";
    name = jsonMap['name'] ?? '';
    stopLocation = jsonMap['stopLocation'] ?? const GeoPoint(0.0, 0.0);
  }
  Map<String, dynamic> toSaveJSON() {
    Map<String, dynamic> jsonMap = <String, dynamic>{};
    jsonMap['sponserName'] = sponserName;
    jsonMap['sponserLink'] = sponserLink;
    jsonMap['address'] = address;
    jsonMap['name'] = name;
    jsonMap['stopLocation'] = stopLocation;
    return jsonMap;
  }
}
