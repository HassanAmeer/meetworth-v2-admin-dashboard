import 'package:admin_panel/helpers/nullables.dart';

class AppInfoModel {
  String info;
  String type;
  DateTime? date;

  AppInfoModel({
    this.info = "",
    this.type = "",
    this.date,
  });

  factory AppInfoModel.fromJson(Map<String, dynamic> json) {
    return AppInfoModel(
      info: json['info'].toString().toNullString(),
      type: json['type'].toString().toNullString(),
      date: json['date'] != null
          ? DateTime.parse((json['date']).toDate().toString())
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'info': info,
      'type': type,
      'date': date,
    };
  }
}
