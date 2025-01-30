import 'package:admin_panel/helpers/nullables.dart';

class ChatModel {
  bool isRead;
  String type;
  DateTime? date;
  String ownerId;
  String file;
  String userName;
  String id;
  String message;

  ChatModel({
    this.isRead = false,
    this.type = "",
    this.date,
    this.ownerId = "",
    this.file = "",
    this.userName = "",
    this.id = "",
    this.message = "",
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      isRead: map['isRead'] ?? true,
      type: map['type'].toString().toNullString(),
      date: map['date'].toDate() ?? DateTime.now(),
      ownerId: map['ownerId'].toString().toNullString(),
      file: map['file'].toString().toNullString(),
      userName: map['userName'].toString().toNullString(),
      id: map['id'].toString().toNullString(),
      message: map['message'].toString().toNullString(),
    );
  }
}
