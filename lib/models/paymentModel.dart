class PaymentModel {
  String id = "";
  String clientEmail = "";
  String clientNumber = "";
  String amount = "";
  int package = 0; //1,2,3,
  String orderId = "";
  String type = ""; // card, paytm
  String transactionId = "";
  DateTime subcriptionDeadline = DateTime(2022);
  DateTime creatingDate = DateTime(2022);
  bool isSubcription = false;
  PaymentModel();

  PaymentModel.toModel(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] ?? "";
    package = jsonMap['package'] ?? 0;
    clientEmail = jsonMap['clientEmail'] ?? "";
    clientNumber = jsonMap['clientNumber'] ?? "";
    amount = jsonMap['amount'] ?? "";
    orderId = jsonMap['orderId'] ?? "";
    type = jsonMap['type'] ?? "";
    transactionId = jsonMap['transactionId'] ?? "";
    subcriptionDeadline = jsonMap['subcriptionDeadline'].toDate();
    isSubcription = jsonMap['isSubcription'] ?? false;
    creatingDate = jsonMap['creatingDate'].toDate();
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> jsonMap = <String, dynamic>{};
    jsonMap['id'] = id;
    jsonMap['package'] = package;
    jsonMap['clientEmail'] = clientEmail;
    jsonMap['clientNumber'] = clientNumber;
    jsonMap['amount'] = amount;
    jsonMap['type'] = type;
    jsonMap['orderId'] = orderId;
    jsonMap['transactionId'] = transactionId;
    jsonMap['subcriptionDeadline'] = subcriptionDeadline;
    jsonMap['creatingDate'] = creatingDate;
    jsonMap['isSubcription'] = isSubcription;
    return jsonMap;
  }
}
