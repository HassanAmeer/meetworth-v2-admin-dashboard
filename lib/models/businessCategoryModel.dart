import 'package:admin_panel/helpers/nullables.dart';

class BusinessCategoryModel {
  String id;
  String name;
  DateTime? creationDate;

  BusinessCategoryModel({this.id = "", this.name = "", this.creationDate});

  BusinessCategoryModel.fromMap(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'].toString().toNullString(),
        name = jsonMap['name'].toString().toNullString(),
        creationDate = jsonMap['creationDate']!.toDate();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'creationDate': creationDate,
    };
  }
}
