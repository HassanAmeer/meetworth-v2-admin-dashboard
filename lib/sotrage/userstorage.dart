import 'package:shared_preferences/shared_preferences.dart';
import '../models/authModel.dart';

class UserStorage {
  static const String uidKey = 'uid';
  static const String profileImageKey = 'profileImage';
  static const String parentNameKey = 'pname';
  static const String babyNameKey = 'bname';
  static const String babyAgeKey = 'bage';
  static const String isMaleKey = 'gender';
  static const String subscriptionKey = 'subscription';
  static const String emailKey = 'email';
  static const String langKey = 'lang';
  static const String planEndKey = 'planEnd';
  static const String planTypeKey = 'planType';
  static const String planPriceKey = 'planPrice';

  static Future<void> setUserF({
    String uid = "",
    String profileImage = "",
    String parentName = "",
    String babyName = "",
    String babyAge = "",
    String isMale = "",
    String email = "",
    String lang = "",
    String planType = "free",
    String planPrice = "0",
    String planEnd = "",
  }) async {
    await SharedPreferences.getInstance().then((prefs) {
      if (uid.isNotEmpty) {
        prefs.setString(uidKey, uid);
      }
      if (profileImage.isNotEmpty) {
        prefs.setString(profileImageKey, profileImage);
      }
      if (parentName.isNotEmpty) {
        prefs.setString(parentNameKey, parentName);
      }
      if (babyName.isNotEmpty) {
        prefs.setString(babyNameKey, babyName);
      }
      if (babyAge.isNotEmpty) {
        prefs.setString(babyAgeKey, babyAge);
      }
      if (isMale.isNotEmpty) {
        prefs.setString(isMaleKey, isMale);
      }

      if (email.isNotEmpty) {
        prefs.setString(emailKey, email);
      }
      if (lang.isNotEmpty) {
        prefs.setString(langKey, lang);
      }
      if (planType.isNotEmpty) {
        prefs.setString(planTypeKey, planType);
      }
      if (planPrice.isNotEmpty) {
        prefs.setString(planPriceKey, planPrice);
      }
      if (planEnd.isNotEmpty) {
        prefs.setString(planEndKey, planEnd);
      }
    });
  }

  static Future<AuthModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString(uidKey).toString();
    final profileImage = prefs.getString(profileImageKey).toString();
    final parentName = prefs.getString(parentNameKey).toString();
    final babyName = prefs.getString(babyNameKey).toString();
    final babyAge = prefs.getString(babyAgeKey).toString();
    final isMale = prefs.getString(isMaleKey).toString();
    final email = prefs.getString(emailKey).toString();
    final lang = prefs.getString(langKey).toString();
    final planType = prefs.getString(planTypeKey).toString();
    final planPrice = prefs.getString(planPriceKey).toString();
    final planEnd = prefs.getString(planEndKey).toString();

    return AuthModel(
      uid: uid,
      profileImage: profileImage,
      parentName: parentName,
      babyName: babyName,
      babyAge: babyAge,
      isMale: isMale == "true" ? true : false,
      email: email,
      lang: lang,
      planType: planType,
      planPrice: planPrice,
      planEnd: planEnd,
    );
  }

  static clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
