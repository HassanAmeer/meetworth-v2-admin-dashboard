class TypeModel {
  String id = "";
  String name = "";
  DateTime creationDate = DateTime.now();

  TypeModel({this.id = "", this.name = "", required this.creationDate});

  TypeModel.fromMap(Map<String, dynamic> jsonMap) {
    name = jsonMap['name'] ?? "";
    id = jsonMap['id'] ?? "";
    creationDate = jsonMap['creationDate'] == null
        ? DateTime(1000)
        : jsonMap['creationDate'].toDate();
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> jsonMap = <String, dynamic>{};
    jsonMap['name'] = name;
    jsonMap['id'] = id;
    jsonMap["creationDate"] = DateTime.now();
    return jsonMap;
  }
}
