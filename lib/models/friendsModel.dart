import 'package:admin_panel/helpers/nullables.dart';

class FriendsModel {
  String businessCategory;
  DateTime date;
  String distance;
  bool enable;
  String file;
  String id;
  String image;
  bool isRead;
  String message;
  String name;
  String ownerId;
  List<String> searchParameter;
  int type;
  bool varifiedStatus;

  FriendsModel({
    this.businessCategory = "",
    required this.date,
    this.distance = "",
    this.enable = false,
    this.file = "",
    this.id = "",
    this.image = "",
    this.isRead = false,
    this.message = "",
    this.name = "",
    this.ownerId = "",
    this.searchParameter = const [],
    this.type = 0,
    this.varifiedStatus = false,
  });

  factory FriendsModel.fromJson(Map<String, dynamic> json) {
    return FriendsModel(
        businessCategory: json['businessCategory'].toString().toNullString(),
        date: json['date'].toDate() ?? DateTime.now(),
        distance: json['distance'].toString().toNullString(),
        enable: json['enable'] ?? false,
        file: json['file'].toString().toNullString(),
        id: json['id'].toString().toNullString(),
        image: json['image'].toString().toNullString(),
        isRead: json['isRead'] ?? false,
        message: json['message'].toString().toNullString(),
        name: json['name'].toString().toNullString(),
        ownerId: json['ownerId'].toString().toNullString(),
        searchParameter: List<String>.from(json['searchParameter'] ?? []),
        type: json['type'] ?? 0,
        varifiedStatus: json['varifiedStatus'] ?? false);
  }
}
