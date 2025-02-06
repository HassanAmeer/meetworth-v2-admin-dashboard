import 'package:meetworth_admin/helpers/nullables.dart';

class TransactionsModel {
  String price;
  bool isPending;
  String trId;
  String planType;
  String timestamp;
  String uid;

  TransactionsModel({
    this.price = "",
    this.isPending = true,
    this.trId = "",
    this.planType = "",
    this.timestamp = "",
    this.uid = "",
  });

  factory TransactionsModel.fromMap(Map<String, dynamic> map) {
    return TransactionsModel(
      price: map['price'].toString().toNullString(),
      isPending: map['isPending'],
      trId: map['trId'].toString().toNullString(),
      planType: map['planType'].toString().toNullString(),
      timestamp: map['timestamp'].toString().toNullString(),
      uid: map['uid'].toString().toNullString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'isPending': isPending,
      'trId': trId,
      'planType': planType,
      'timestamp': timestamp,
      'uid': uid,
    };
  }
}
