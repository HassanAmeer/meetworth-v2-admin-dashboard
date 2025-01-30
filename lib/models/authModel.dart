import 'package:admin_panel/helpers/nullables.dart';

class AuthModel {
  String uid;
  String profileImage;
  String parentName;
  String babyName;
  String babyAge;
  bool isMale;
  String email;
  // String password;
  String lang;
  String planType;
  String planPrice;
  String planEnd;

  AuthModel({
    this.uid = "",
    this.profileImage = "",
    this.parentName = "",
    this.babyName = "",
    this.babyAge = "",
    this.isMale = true,
    this.email = "",
    // this.password = "",
    this.lang = "en",
    this.planType = "free", // monthly // yearly
    this.planPrice = "0", // $ // 7 // 70
    this.planEnd = "", // timestamp
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      uid: json['uid'].toString().toNullString(),
      profileImage: json['profileImage'].toString().toNullString(),
      parentName: json['parentName'].toString().toNullString(),
      babyName: json['babyName'].toString().toNullString(),
      babyAge: json['babyAge'].toString().toNullString(),
      isMale: json['isMale'] ?? true,
      email: json['email'].toString().toNullString(),
      // password: json['password'].toString().toNullString(),
      lang: json['lang'].toString().toNullString() ?? "en",
      planType: json['planType'].toString().toNullString() ?? "free",
      planPrice: json['planPrice'].toString().toNullString() ?? "0",
      planEnd: json['planEnd'].toString().toNullString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'profileImage': profileImage,
      'parentName': parentName,
      'babyName': babyName,
      'babyAge': babyAge,
      'isMale': isMale,
      'email': email,
      // 'password': password,
      'lang': lang,
      'planType': planType,
      'planPrice': planPrice,
      'planEnd': planEnd,
    };
  }
}
