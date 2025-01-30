// class TransactionModel {
//   String id = "";

//   String stripePaymentIntentClientSecret = "";
//   String stripeCustomerId = "";
//   double vendorAmount = 0.0; // chagecardfee + joinfee
//   double adminAmount = 0.0; // servicefee + tax
//   double totalAmount = 0.0;
//   String eventId = "";
//   String eventName = "";
//   String organizerId = "";
//   String organizerName = "";
//   String userName = "";
//   String userId = "";
//   String userRoutingNumber = "";
//   String userAccountNumber = "";

//   // 0:"Join fee", 1:"Change Card fee"
//   int transactionType = 0;
  
//   // 0: admin receive amount, 1: send vendor amount(completed)
//   int transactionStatus = 0;
  
//   DateTime data = DateTime.now();

//   TransactionModel();

//   TransactionModel.toModel(Map<String, dynamic> jsonMap) {
//     id = jsonMap['id'] ?? '';
//     stripePaymentIntentClientSecret =
//         jsonMap['stripePaymentIntentClientSecret'] ?? '';
//     stripeCustomerId = jsonMap['stripeCustomerId'] ?? '';
//     vendorAmount = (jsonMap['vendorAmount'] ?? 0.0) + 0.0;
//     adminAmount = (jsonMap['adminAmount'] ?? 0.0) + 0.0;
//     totalAmount = (jsonMap['totalAmount'] ?? 0.0) + 0.0;
//     eventId = jsonMap['eventId'] ?? '';
//     eventName = jsonMap['eventName'] ?? '';
//     organizerId = jsonMap['organizerId'] ?? '';
//     organizerName = jsonMap['organizerName'] ?? '';
//     userName = jsonMap['userName'] ?? '';
//     userId = jsonMap['userId'] ?? '';
//     userRoutingNumber = jsonMap['userRoutingNumber'] ?? '';
//     userAccountNumber = jsonMap['userAccountNumber'] ?? '';
//     transactionType = jsonMap['transactionType'] ?? 0;
//     transactionStatus = jsonMap['transactionStatus'] ?? 0;
//     data = jsonMap['data'].toDate();
//   }
//   Map<String, dynamic> toJSON() {
//     Map<String, dynamic> jsonMap = <String, dynamic>{};
//     jsonMap['id'] = id;
//     jsonMap['stripePaymentIntentClientSecret'] =
//         stripePaymentIntentClientSecret;
//     jsonMap['stripeCustomerId'] = stripeCustomerId;
//     jsonMap['vendorAmount'] = vendorAmount;
//     jsonMap['adminAmount'] = adminAmount;
//     jsonMap['organizerId'] = organizerId;
//     jsonMap['totalAmount'] = totalAmount;
//     jsonMap['eventId'] = eventId;
//     jsonMap['eventName'] = eventName;
//     jsonMap['organizerName'] = organizerName;
//     jsonMap['userName'] = userName;
//     jsonMap['userId'] = userId;
//     jsonMap['data'] = DateTime.now();
//     jsonMap['userRoutingNumber'] = userRoutingNumber;
//     jsonMap['userAccountNumber'] = userAccountNumber;
//     jsonMap['transactionType'] = transactionType;
//     jsonMap['transactionStatus'] = transactionStatus;
//     return jsonMap;
//   }
// }
