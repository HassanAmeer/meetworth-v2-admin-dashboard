class NotificationModel {
  String id = "", body = "";
  bool read = false;
  String userImg = "", userId = "", title = ""; // title : user name or post des
  String receiverId = ""; // receive the notification
  DateTime date = DateTime.now();
  int type =
      0; // // 0: message, 1: comment, 2: like, 3: app, 4: admin, 5: match, 6: share(remaing)
  String additionalId =
      ""; // friendId, postId, postId, additionalId, additionalId

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "body": body,
      "date": date,
      "type": type,
      "userId": userId,
      "userImg": userImg,
      "read": read,
      "receiverId": receiverId,
      "title": title.toString(),
      "additionalId": additionalId
    };
  }

  NotificationModel();

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    NotificationModel model = NotificationModel();
    model.id = map['id'];
    model.type = map['type'];
    model.body = map['body'];
    model.userId = map['userId'];
    model.read = map['read'] ?? false;
    model.userImg = map['userImg'];
    model.receiverId = map['receiverId'];
    model.title = map['title'];
    model.date = map['date'].toDate();
    model.additionalId = map['additionalId'];
    return model;
  }
}
