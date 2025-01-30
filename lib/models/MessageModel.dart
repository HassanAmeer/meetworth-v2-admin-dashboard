class MessageModel {
  String id = "";
  String senderId = "";
  String receiverId = "";
  String body = "click to start a chat";
  DateTime creationDate = DateTime(1000);
  String name = "", image = "";

  MessageModel();

  MessageModel.toModel(jsonMap) {
    id = jsonMap['id'] ?? "";
    name = jsonMap['name'] ?? "";
    image = jsonMap['image'] ?? "";
    body = jsonMap['body'] ?? "click to start a chat";
    senderId = jsonMap['senderId'] ?? "";
    receiverId = jsonMap['receiverId'] ?? "";
    creationDate = jsonMap['creationDate'] == null
        ? DateTime(1000)
        : jsonMap['creationDate'].toDate();
  }
  Map<String, dynamic> toJSON() {
    Map<String, dynamic> jsonMap = <String, dynamic>{};
    jsonMap['id'] = id;
    if (name != "") {
      jsonMap['name'] = name;
      jsonMap['image'] = image;
    }
    jsonMap['body'] = body;
    jsonMap['senderId'] = senderId;
    jsonMap['receiverId'] = receiverId;
    jsonMap["creationDate"] = DateTime.now();
    return jsonMap;
  }
}
