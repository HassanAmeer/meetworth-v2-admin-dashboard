import 'package:cloud_firestore/cloud_firestore.dart';

class GameModel {
  String userId = '';
  GeoPoint currentLocation = const GeoPoint(0, 0);
  int changeCardAttempts = 0;
  double spends = 0;
  String pokerId = "";
  String rank = "";
  int currentStop = 0;
  List<dynamic> cards = [];
  GameModel();

  GameModel.toModel(Map<String, dynamic> jsonMap) {
    userId = jsonMap['userId'];
    currentLocation = jsonMap['currentLocation'] ?? const GeoPoint(0, 0);
    rank = jsonMap['rank'] ?? "";
    spends = jsonMap['spends'] ?? 0;
    cards = jsonMap['cards'] ?? [];
    currentStop = jsonMap['currentStop'] ?? 0;
    pokerId = jsonMap['pokerId'];
    changeCardAttempts = jsonMap['changeCardAttempts'] ?? 0;
  }

  Map<String, dynamic> toSaveJSON() {
    Map<String, dynamic> jsonMap = <String, dynamic>{};
    jsonMap['userId'] = userId;
    jsonMap['currentLocation'] = currentLocation;
    jsonMap['currentStop'] = currentStop;
    jsonMap['pokerId'] = pokerId;
    jsonMap['cards'] = cards;
    jsonMap['rank'] = rank;
    jsonMap['changeCardAttempts'] = changeCardAttempts;
    jsonMap['spends'] = spends;
    jsonMap['pokerId'] = pokerId;
    return jsonMap;
  }
}
