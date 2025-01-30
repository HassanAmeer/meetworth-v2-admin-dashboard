class FaqModel {
  String id = "";
  String answer = "";

  String question = "";
  FaqModel();

  FaqModel.toModel(Map<String, dynamic> jsonMap) {
    answer = jsonMap['answer'] ?? "";
    question = jsonMap['question'] ?? "";

    id = jsonMap['id'] ?? "";
  }
  Map<String, dynamic> toSaveJSON() {
    Map<String, dynamic> jsonMap = <String, dynamic>{};
    jsonMap['answer'] = answer;
    jsonMap['question'] = question;
    jsonMap['id'] = id;
    return jsonMap;
  }
}
