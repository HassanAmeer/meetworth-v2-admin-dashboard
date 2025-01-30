class FeedbackModel {
  bool isPositive;
  String msg;
  String timestamp;
  String uid;

  FeedbackModel({
    this.isPositive = false,
    this.msg = "",
    this.timestamp = "",
    this.uid = "",
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      isPositive: json['isPositive'] ?? true,
      msg: json['msg'] ?? "",
      timestamp: json['timestamp'] ?? DateTime.timestamp().toString(),
      uid: json['uid'] ?? "",
    );
  }
}

// Usage
FeedbackModel feedback = FeedbackModel.fromJson({
  'isPositive': true,
  'msg': 'nice app',
  'timestamp': '1738083272151',
  'uid': 'A87WbTFgL3MVO3GFN5r0cxnpHmI3',
});
