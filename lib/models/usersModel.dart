import 'package:meetworth_admin/helpers/nullables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class UserModel {
  String? firstname,
      lastname,
      email,
      phone,
      bio,
      image,
      adminActiveMemebership,
      fcm,
      username,
      loginType,
      uid,
      gender,
      businessCategory,
      membership = "Free",
      planKey = "",
      file1,
      file2,
      country;
  List<dynamic>? galleryImages, bookmark = [];
  int? varifiedStatus, age;
  int? referLinkUserCount = 0;
  bool? profileCompleted, enable;
  List<String>? splashTimes = [];
  List<String>? interests = [];
  List<String>? languages = [];
  DateTime? creationDate;
  List<String> likes = [];
  List<Map<String, dynamic>>? linked = [];
  List<String>? goals = [];
  GeoPoint? point;
  List<String>? friends = [];
  String dob, deadlinemembership;
  String monthlyAppUsageInSeconds;
  String accountCreationLocation;

  String iCardDesc = "";
  String bCardDesc = "";
  bool isValidICard = false;
  bool isValidBCard = false;

  UserModel({
    this.firstname,
    this.lastname,
    this.email,
    this.username,
    this.phone,
    this.image,
    this.uid,
    this.dob = "",
    this.fcm,
    this.gender,
    this.adminActiveMemebership,
    this.businessCategory,
    this.goals,
    this.languages,
    this.referLinkUserCount,
    this.splashTimes = const [],
    this.interests,
    this.deadlinemembership = "",
    this.galleryImages,
    this.varifiedStatus,
    this.profileCompleted,
    this.linked,
    this.bookmark,
    this.file1,
    this.file2,
    this.loginType,
    this.membership = "Free",
    this.age,
    this.planKey,
    this.point,
    this.bio,
    this.creationDate,
    this.enable,
    this.friends,
    this.country,
    this.accountCreationLocation = "",
    this.monthlyAppUsageInSeconds = "0",
    this.bCardDesc = "",
    this.iCardDesc = "",
    this.isValidBCard = false,
    this.isValidICard = false,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstname: map['firstname'].toString().replaceAll('\n', '').toTitleCase(),
      lastname: map['lastname'].toString().replaceAll('\n', '').toTitleCase(),
      email: map['email'].toString().toNullString(),
      phone: map['phone'].toString().toNullString().isEmpty
          ? "Not Given"
          : map['phone'].toString().toNullString(),
      bio: map['bio'].toString().toNullString(),
      referLinkUserCount: map['referLinkUserCount'] ?? 0,
      image: map['image'].toString().toNullString(),
      country: map['country'].toString().toNullString(),
      fcm: map['fcm'].toString().toNullString(),
      age: map['age'] != null ? int.tryParse(map['age'].toString()) ?? 0 : 0,
      adminActiveMemebership:
          map['adminActiveMemebership'].toString().toNullString(),
      file1: map['file1'].toString().toNullString(),
      file2: map['file2'].toString().toNullString(),
      uid: map['uid'].toString().toNullString(),
      loginType: map['loginType'].toString().toNullString(),
      username: map['username'].toString().toNullString().toTitleCase(),
      dob: map['dob'].toString().toNullString(),
      deadlinemembership: map['deadlinemembership'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  int.tryParse(map['deadlinemembership'].toString()) ?? 0)
              .toIso8601String()
              .split('T')
              .first
          : DateTime.now().toIso8601String().split('T').first,
      gender: map['gender'].toString().toNullString(),
      splashTimes: List<String>.from(map["splashTimes"] ?? <String>[]),
      interests: List<String>.from(map["interests"] ?? <String>[]),
      goals: List<String>.from(map['goals'] ?? <String>[]),
      businessCategory: map['businessCategory'] ?? "",
      membership: map['membership'].toString().toNullString(),
      point: map['position'] == null
          ? const GeoPoint(0, 0)
          : map['position']['geopoint'] as GeoPoint?,
      friends: map['friends'] == null
          ? <String>[]
          : List<String>.from(map['friends']),
      linked: map['linked'] == null
          ? <Map<String, dynamic>>[]
          : List<Map<String, dynamic>>.from(map['linked']),
      languages:
          map['languages'] == null ? [] : List<String>.from(map['languages']),
      enable: map['enable'] ?? true,
      bookmark:
          map['bookmark'] == null ? null : List<String>.from(map['bookmark']),
      galleryImages: map['galleryImages'] == null
          ? []
          : List<String>.from(map['galleryImages']),
      varifiedStatus: map['varifiedStatus'] ?? 0,
      profileCompleted: map['profileCompleted'] ?? false,
      creationDate: map['creationDate'] == null
          ? DateTime.now()
          : map['creationDate']?.toDate() ?? DateTime.now(),
      planKey: map['planKey'].toString().toNullString(),
      accountCreationLocation:
          map['accountCreationLocation'].toString().toNullString(),
      monthlyAppUsageInSeconds:
          map['monthlyAppUsageInSeconds'].toString().toNullString(),
      iCardDesc: map['iCardDesc'].toString().toNullString(),
      bCardDesc: map['bCardDesc'].toString().toNullString(),
      isValidICard: map['isValidICard'] ?? false,
      isValidBCard: map['isValidBCard'] ?? false,
    );
  }
}

List<String> generateArray(String name) {
  List<String> list = [];
  name = name.toLowerCase();
  for (int i = 0; i < name.length; i++) {
    list.add(name.substring(0, i + 1));
  }
  for (String test in name.split(' ')) {
    for (int i = 0; i < test.length; i++) {
      list.add(test.substring(0, i + 1));
    }
  }
  return list;
}
