import 'package:meetworth_admin/helpers/nullables.dart';

class PostsModel {
  String address;
  String body;
  int commentCount;
  String date;
  String file;
  String id;
  bool isPublic;
  List<String> likes;
  dynamic location;
  int type;
  String userId;
  String userImg;
  String userName;

  PostsModel({
    this.address = "",
    this.body = "",
    this.commentCount = 0,
    this.date = "",
    this.file = "",
    this.id = "",
    this.isPublic = false,
    this.likes = const [],
    this.location = "",
    this.type = 0,
    this.userId = "",
    this.userImg = "",
    this.userName = "",
  });

  factory PostsModel.fromMap(Map<String, dynamic> jsonMap) {
    return PostsModel(
      address: jsonMap['address'].toString().toNullString(),
      body: jsonMap['body'].toString().toNullString(),
      commentCount: jsonMap['commentCount'] ?? 0,
      date: jsonMap['date'].toString().toNullString(),
      file: jsonMap['file'].toString().toNullString(),
      id: jsonMap['id'].toString().toNullString(),
      isPublic: jsonMap['isPublic'] ?? false,
      likes: List<String>.from(jsonMap['likes'] ?? []),
      location: jsonMap['location'],
      type: jsonMap['type'] ?? 0,
      userId: jsonMap['userId'].toString().toNullString(),
      userImg: jsonMap['userImg'].toString().toNullString(),
      userName: jsonMap['userName'].toString().toNullString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'body': body,
      'commentCount': commentCount,
      'date': DateTime.parse(date.toString()),
      'file': file,
      'id': id,
      'isPublic': isPublic,
      'likes': likes,
      'location': location,
      'type': type,
      'userId': userId,
      'userImg': userImg,
      'userName': userName,
    };
  }
}
