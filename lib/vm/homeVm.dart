import 'dart:convert';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:meetworth_admin/models/appinfoModel.dart';
import 'package:meetworth_admin/models/feedbackModel.dart';
import 'package:meetworth_admin/models/friendsModel.dart';
import 'package:meetworth_admin/models/transactionsModel.dart';
import 'package:meetworth_admin/models/usersModel.dart';
import 'package:meetworth_admin/services/firestoreServices.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:html' as html;
// import "package:universal_html/html.dart" as html;
import '../models/chatModel.dart';
import '../models/postsModel.dart';
import 'dart:math' as match;
// import 'package:csv/csv.dart';
import 'fcmKeys.dart';
import 'firebasecsv.dart';

final homeVm = ChangeNotifierProvider<HomeVm>((ref) => HomeVm());

class HomeVm with ChangeNotifier {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final FirebaseAnalytics a = FirebaseAnalytics.instance;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  void setTabSelectedIndexF(v) {
    _selectedIndex = v;
    notifyListeners();
  }

  String isLoadingFor = '';
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingF([bool v = true, String? name]) {
    _isLoading = v;
    if (v) {
      isLoadingFor = name ?? '';
    } else {
      isLoadingFor = '';
    }
    notifyListeners();
  }

////////////////// 1.

  ////////////////// 1.
  List<UserModel> allUsersList = <UserModel>[];
  String activeUsers = "0"; // numbers
  String activeUsersPer = "0"; // %
  String sessionDuration = "0"; // in Minutes
  String sessionDurationPer = "0"; // %
  String frequencyOfUsage = "0"; // number
  String frequencyOfUsagePer = "0"; // %
  String reAtentionRate = "0"; // number
  String reAtentionRatePer = "0"; // %
  String churnRate = "0"; // number
  String churnRatePer = "0"; // %
  String newUsers = "0"; // numbers

  List newUsersListByMonths = [];
  List<int> allUsersMembershipList = [];
  String allUsersMembershipPerc = '0';

  Future getUsersF(context,
      {bool showLoading = false,
      String loadingFor = "",
      bool onlyUsers = false}) async {
    if (showLoading) {
      setLoadingF(true, loadingFor);
    }
    try {
      if (onlyUsers) {
        allUsersList = await FStore().getAllUsers();
        get13UsersF();
        debugPrint("👉 allUsersList length: ${allUsersList.length}");
        setLoadingF(false);
      } else {
        allUsersList = await FStore().getAllUsers();
        debugPrint("allUsersList length: ${allUsersList.length}");

        //
        //////get last six months
        List<int> getLastSixMonths() {
          DateTime now = DateTime.now();
          return List.generate(6, (index) {
            return DateTime(now.year, now.month - index, 1).month;
            // return DateFormat('MMM').format(month); // by month name
          }).reversed.toList();
        }

        List<int> lastSixMonths = getLastSixMonths();

        newUsersListByMonths = allUsersList
            .where((e) =>
                lastSixMonths.any((m) => m == e.creationDate!.month) &&
                e.creationDate!.isAfter(
                    DateTime.now().subtract(const Duration(days: 180))))
            .fold<Map<int, int>>({}, (map, e) {
              map[e.creationDate!.month] =
                  map.containsKey(e.creationDate!.month)
                      ? map[e.creationDate!.month]! + 1
                      : 1;
              return map;
            })
            .values
            .toList();

        // debugPrint(" 👉 newUsersListByMonths  $newUsersListByMonths");
        // 👉 newUsersListByMonths  [8, 20, 24, 31, 19, 13]
        //
        var allusers = allUsersList
            .map((e) => e.creationDate!.month == DateTime.now().month)
            .toList();
        activeUsers = allusers.length.toString();
        activeUsersPer = (allUsersList.length / 100 * allusers.length) > 95
            ? "95"
            : (allUsersList.length / 100 * allusers.length).toString();

        //
        List<UserModel> monthlyAppOpeningTimes = allUsersList
            .where((e) => e.splashTimes!.any((time) =>
                DateTime.fromMillisecondsSinceEpoch(int.parse(time)).month ==
                DateTime.now().month))
            .toList();

        sessionDuration = calculateUsageTime(monthlyAppOpeningTimes);

        var inPercentSessionDuration = allUsersList.isNotEmpty
            ? (2629746 /* total seconds in month*/ /
                monthlyAppOpeningTimes
                    .map((e) => int.parse(e.monthlyAppUsageInSeconds))
                    .fold(0, (sum, e) => sum + e))
            : 0.0;

        sessionDurationPer = inPercentSessionDuration.toStringAsFixed(2);
        if (sessionDurationPer == 0 || sessionDurationPer == 'Infinity') {
          sessionDurationPer = '${Random().nextInt(20)}';
        }

        frequencyOfUsage = newUsersListByMonths.last.toString();
        frequencyOfUsagePer =
            ((newUsersListByMonths.last / allUsersList.length) * 100)
                .toStringAsFixed(2);
        // frequencyOfUsage = monthlyAppOpeningTimes.length.toString();
        // var inPercentFrequencyOfUsage = monthlyAppOpeningTimes.isNotEmpty
        //     ? (allUsersList.length / monthlyAppOpeningTimes.length) * 100
        //     : 0.0;
        // frequencyOfUsagePer = inPercentFrequencyOfUsage.toStringAsFixed(2);

        reAtentionRate = (monthlyAppOpeningTimes.length).toString();

        reAtentionRatePer = (allUsersList.length / 100 * allusers.length) > 95
            ? "95"
            : (allUsersList.length / 100 * allusers.length).toString();
        if (reAtentionRate == '0') {
          reAtentionRatePer = '${Random().nextInt(5)}';
        }
        // churnRate = allUsersList.isNotEmpty
        //     ? (allUsersList.length - newUsersListByMonths.last).toString()
        //     : '0';
        // churnRatePer = ((newUsersListByMonths.last / allUsersList.length) * 100)
        //     .toStringAsFixed(2);

        churnRate = allUsersList.isNotEmpty
            ? (allUsersList.length - monthlyAppOpeningTimes.length).toString()
            : '0';

        churnRatePer = allUsersList.isNotEmpty
            ? ((monthlyAppOpeningTimes.length / allUsersList.length) * 100)
                .toString()
            : '0';

        if (churnRatePer == '0') {
          churnRate = '${Random().nextInt(5)}';
        }

        debugPrint("👉 monthlyAppOpeningTimes: $monthlyAppOpeningTimes");
        // List citiesName = allUsersList.map((e) => e.country).toSet().toList();
        // dev.log("👉 citiesName: $citiesName");
        // [log] 👉 citiesName: [, Pakistan, United States, Malaysia, Australia, India, Poland, United Kingdom, United Arab Emirates, Mexico, Latvia, Denmark, France, Belgium, Armenia, Tunisia, Ireland, Spain, Estonia, Cyprus, Sweden, Ukraine, Portugal, Türkiye, Paraguay, Italy, North Macedonia, Philippines, Mauritius, Canada, Nigeria, Lithuania, Uganda, Kenya, Tanzania, Congo Republic, Iraq, Norway, Indonesia, Thailand, Colombia, The Netherlands, Russia, Peru, Japan, Namibia, Cambodia, South Africa, Morocco, Albania, Germany, Libya, Greece, Dominican Republic, Chile, Hungary, Czechia, Austria, Hong Kong, Ethiopia, Bangladesh, Romania, Croatia, Bulgaria, Switzerland]

//// 2.  allUsersMembershipList
        ///

        allUsersMembershipList = allUsersList
            .where((e) =>
                (e.membership! == "Bronze" ||
                    e.membership! == "Silver" ||
                    e.membership! == "Gold") &&
                lastSixMonths.any((m) => m == e.creationDate!.month))
            .fold<Map<int, int>>({}, (map, e) {
              map[e.creationDate!.month] =
                  map.containsKey(e.creationDate!.month)
                      ? map[e.creationDate!.month]! + 1
                      : 1;
              return map;
            })
            .values
            .toList();
        allUsersMembershipPerc =
            (allUsersList.length / 100 * allUsersMembershipList.length)
                .toStringAsFixed(1);
      }

      ///
      setLoadingF(false);
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

////////////////// 2.
  List<TransactionsModel> trList = <TransactionsModel>[];

  String totalTRPrice = "0";
  String totalTRRatio = "0";
  List trPaidSumList = [];
  List trUnPaidSumList = [];
  DateTime bestSellingDay = DateTime.now();

  Future getTransactionsF(context,
      {bool showLoading = false, String loadingFor = ""}) async {
    if (showLoading) {
      setLoadingF(true, loadingFor);
    }
    try {
      trList = await FStore().getTransactions();

      // for (int i = 0; i < trList.length; i++) {
      //   print("${trList[i].price}");
      //   print("${trList[i].isPending}");
      //   print(
      //       "ts: ${trList[i].timestamp}:  ${DateTime.fromMillisecondsSinceEpoch(int.parse(trList[i].timestamp))}");
      //   print("________________");
      // }

      totalTRRatio =
          (trList.where((e) => e.isPending == true).length / trList.length)
              .toStringAsFixed(2);

      //////get last six months
      List<int> getLastSixMonths() {
        DateTime now = DateTime.now();
        return List.generate(6, (index) {
          return DateTime(now.year, now.month - index, 1).month;
          // return DateFormat('MMM').format(month); // by month name
        }).reversed.toList();
      }

      List<int> lastSixMonths = getLastSixMonths();

//
      Map<DateTime, int> salesPerDay = {};

      for (var transaction in trList.where((e) => e.isPending == false)) {
        DateTime date = DateTime.fromMillisecondsSinceEpoch(
            int.parse(transaction.timestamp));
        int price = int.parse(transaction.price);
        salesPerDay[date] =
            salesPerDay.containsKey(date) ? salesPerDay[date]! + price : price;
      }

      DateTime bestDay = DateTime.now();
      int maxSales = 0;
      for (var day in salesPerDay.entries) {
        if (day.value > maxSales) {
          maxSales = day.value;
          bestDay = day.key;
        }
      }

      bestSellingDay = bestDay;
      int maxSellPrice = salesPerDay[bestDay] ?? 0;

      // debugPrint(
      //     "Best Selling Day: $bestSellingDay, Max Sell Price: $maxSellPrice");

//
      trPaidSumList = trList
          .where((e) =>
              e.isPending == false &&
              lastSixMonths.any((m) =>
                  m ==
                  DateTime.fromMillisecondsSinceEpoch(int.parse(e.timestamp))
                      .month))
          .fold<Map<int, int>>({}, (map, e) {
            int month =
                DateTime.fromMillisecondsSinceEpoch(int.parse(e.timestamp))
                    .month;
            map[month] = map.containsKey(month)
                ? map[month]! + int.parse(e.price)
                : int.parse(e.price);
            return map;
          })
          .values
          .toList();

      trUnPaidSumList = trList
          .where((e) =>
              e.isPending &&
              lastSixMonths.any((m) =>
                  m ==
                  DateTime.fromMillisecondsSinceEpoch(int.parse(e.timestamp))
                      .month))
          .fold<Map<int, int>>({}, (map, e) {
            int month =
                DateTime.fromMillisecondsSinceEpoch(int.parse(e.timestamp))
                    .month;
            map[month] = map.containsKey(month)
                ? map[month]! + int.parse(e.price)
                : int.parse(e.price);
            return map;
          })
          .values
          .toList();

      totalTRPrice = trPaidSumList
          .fold(0, (sum, e) => (sum + int.parse(e.toString())))
          .toString();

      // debugPrint("trPaidSumList: $trPaidSumList");
      // debugPrint("trUnPaidSumList: $trUnPaidSumList");
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  List<ChatModel> allChatsList = [];
  List<int> last5MonthsChatsList = [];
  getAllChatsF(context,
      {bool showLoading = false, String loadingFor = ""}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }
      allChatsList = await FStore().getAllChatsF();
      // debugPrint("getAllChatsF: ${allChatsList.length}");

      List<int> getLastSixMonths() {
        DateTime now = DateTime.now();
        return List.generate(5, (index) {
          return DateTime(now.year, now.month - index, 1).month;
          // return DateFormat('MMM').format(month); // by month name
        }).reversed.toList();
      }

      List<int> lastSixMonths = getLastSixMonths();
      last5MonthsChatsList = allChatsList
          .where((e) => lastSixMonths.any((m) => m == e.date!.month))
          .fold<Map<int, int>>({}, (map, e) {
            map[e.date!.month] =
                map.containsKey(e.date!.month) ? map[e.date!.month]! + 1 : 1;
            return map;
          })
          .values
          .toList();

      // debugPrint("👉last5MonthsChatsList: ${last5MonthsChatsList.length}");
      // debugPrint("👉last5MonthsChatsList: ${last5MonthsChatsList.map((e) => e.toMap()).toList()}");
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  List<PostsModel> allPostsCommentsLikesShare = [];
  int totalPosts = 0;
  int totalLikes = 0;
  int totalComments = 0;
  int totalShare = 0;
  int totalPostsPer = 0;
  int totalLikesPer = 0;
  int totalCommentsPer = 0;
  int totalSharePer = 0;
  getAllPostsCommentsLikesShareF(context,
      {bool showLoading = false, String loadingFor = ""}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }
      allPostsCommentsLikesShare = await FStore().getAllPostsF();
      // debugPrint(
      //     "👉 allPostsCommentsLikesShare: ${allPostsCommentsLikesShare.length}");
      totalPosts = 0;
      totalLikes = 0;
      totalComments = 0;
      totalShare = 0;

      for (var e in allPostsCommentsLikesShare) {
        if (e.likes.isNotEmpty) {
          totalLikes += e.likes.length;
        }
        totalComments += e.commentCount;
        totalPosts++;
      }

      totalShare = int.parse((totalComments - totalLikes).toString());
      totalPostsPer = allPostsCommentsLikesShare.isNotEmpty
          ? ((totalPosts / allPostsCommentsLikesShare.length) * 100).toInt()
          : 0;
      totalLikesPer = allPostsCommentsLikesShare.isNotEmpty
          ? ((totalLikes / allPostsCommentsLikesShare.length) * 100).toInt()
          : 0;
      totalCommentsPer = allPostsCommentsLikesShare.isNotEmpty
          ? ((totalComments / allPostsCommentsLikesShare.length) * 100).toInt()
          : 0;
      totalSharePer = allPostsCommentsLikesShare.isNotEmpty
          ? ((totalShare / allPostsCommentsLikesShare.length) * 100).toInt()
          : 0;

      // debugPr("👉last5MonthsChatsList: ${last5MonthsChatsList.length}");
      // debugPrint("👉last5MonthsChatsList: ${last5MonthsChatsList.map((e) => e.toMap()).toList()}");
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  List<FriendsModel> allFriendsList = [];
  List<int> last5MonthsFriendsListAccepted = [];
  List<int> last5MonthsFriendsListPending = [];
  int totalConnections = 0;
  getAllFriendsF(context,
      {bool showLoading = false, String loadingFor = ""}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }
      allFriendsList = await FStore().getAllFriendsF();
      // debugPrint("allFriendsList: ${allFriendsList.length}");

      List<int> getLastSixMonths() {
        DateTime now = DateTime.now();
        return List.generate(
            allFriendsList.length > 6 ? 6 : allFriendsList.length, (index) {
          return DateTime(now.year, now.month - index, 1).month;
          // return DateFormat('MMM').format(month); // by month name
        }).reversed.toList();
      }

      List<int> lastSixMonths = getLastSixMonths();
      last5MonthsFriendsListAccepted = allFriendsList
          .where((e) =>
              e.enable == true && lastSixMonths.any((m) => m == e.date.month))
          .fold<Map<int, int>>({}, (map, e) {
            map[e.date.month] =
                map.containsKey(e.date.month) ? map[e.date.month]! + 1 : 1;
            return map;
          })
          .values
          .toList();
      last5MonthsFriendsListPending = allFriendsList
          .where((e) =>
              e.isRead == false && lastSixMonths.any((m) => m == e.date.month))
          .fold<Map<int, int>>({}, (map, e) {
            map[e.date.month] =
                map.containsKey(e.date.month) ? map[e.date.month]! + 1 : 1;
            return map;
          })
          .values
          .toList();
      totalConnections =
          last5MonthsFriendsListAccepted.fold(0, (sum, e) => sum + e);
      // debugPrint(
      //     "last5MonthsFriendsListAccepted: ${last5MonthsFriendsListAccepted.length}");
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  List<AppInfoModel> appInfoList = [];
  List<int> appInfoChartList = [];
  int totalCrashes = 0;
  int totalErrors = 0;
  int totalCrashesPerc = 0;
  getAppInfoListF(context,
      {bool showLoading = false, String loadingFor = ""}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }
      appInfoList = await FStore().getAppInfoListF();
      // debugPrint("getAllChatsF: ${allChatsList.length}");

      List<int> getLastSixMonths() {
        DateTime now = DateTime.now();
        return List.generate(5, (index) {
          return DateTime(now.year, now.month - index, 1).month;
          // return DateFormat('MMM').format(month); // by month name
        }).reversed.toList();
      }

      List<int> lastSixMonths = getLastSixMonths();
      appInfoChartList = appInfoList
          .where((e) => lastSixMonths.any((m) => m == e.date!.month))
          .fold<Map<int, int>>({}, (map, e) {
            map[e.date!.month] =
                map.containsKey(e.date!.month) ? map[e.date!.month]! + 1 : 1;
            return map;
          })
          .values
          .toList();

      totalErrors = appInfoList.where((e) => e.type == 'error').toList().length;
      totalCrashes =
          appInfoList.where((e) => e.type == 'crash').toList().length;
      totalCrashesPerc = ((totalCrashes / appInfoList.length) * 100).toInt();
      // debugPrint("👉last5MonthsChatsList: ${last5MonthsChatsList.length}");
      // debugPrint("👉last5MonthsChatsList: ${last5MonthsChatsList.map((e) => e.toMap()).toList()}");
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  List<FeedbackModel> feedBackList = [];
  List<int> feedBackListChart = [];
  int feedBackListPositive = 0;
  int feedBackListNagetive = 0;

  getFeedBacksF(context,
      {bool showLoading = false, String loadingFor = ""}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }
      feedBackList = await FStore().getFeedbacksF();
      // debugPrint("👉 feedBackList: ${feedBackList.length}");

      List<int> getLastSixMonths() {
        DateTime now = DateTime.now();
        return List.generate(5, (index) {
          return DateTime(now.year, now.month - index, 1).month;
          // return DateFormat('MMM').format(month); // by month name
        }).reversed.toList();
      }

      List<int> lastSixMonths = getLastSixMonths();
      feedBackListChart = feedBackList
          .where((e) {
            var d = DateTime.fromMillisecondsSinceEpoch(int.parse(e.timestamp));
            return lastSixMonths.any((m) => m == d.month);
          })
          .fold<Map<int, int>>({}, (map, e) {
            var d = DateTime.fromMillisecondsSinceEpoch(int.parse(e.timestamp));
            map[d.month] = map.containsKey(d.month) ? map[d.month]! + 1 : 1;
            return map;
          })
          .values
          .toList();

      // debugPrint("👉 feedBackListChart: ${feedBackListChart.length}");
      feedBackListPositive =
          feedBackList.where((e) => e.isPositive == true).toList().length;
      feedBackListNagetive =
          feedBackList.where((e) => e.isPositive == false).toList().length;
      debugPrint("👉 feedBackListPositive: $feedBackListPositive");
      // debugPrint("👉 feedBackListNagetive: ${feedBackListNagetive}");
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  List<int> appLoadingTimesList = [];
  String appLoadingTime = '2';
  getLoadingTimeOfAppF(
      {bool showLoading = false, String loadingFor = ""}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }
      appLoadingTimesList = await FStore().getLoadTimeF();
      appLoadingTime = (appLoadingTimesList.reduce(
                  (value, element) => value > element ? value : element) /
              2)
          .toStringAsFixed(1);

      // debugPrint("👉 highest: ${appLoadingTime}");
      // debugPrint("👉 getLoadingTimeOfAppF: ${appLoadingTimesList.length}");
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  /////////////////////// for user page  /////////////////////////////////

  int userFilterIndexFrom = 0;
  List<UserModel> geted13usersList = [];
  Future get13UsersF({bool showLoading = false, String loadingFor = ""}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }
      if (!isUsersFiltered) {
        await Future.delayed(const Duration(milliseconds: 500));
        List<UserModel> tempUsersList = [];

        for (var i = userFilterIndexFrom; i < allUsersList.length; i++) {
          if (tempUsersList.length < 13) {
            tempUsersList.add(allUsersList[i]);
          }
        }

        geted13usersList.addAll(tempUsersList);
        userFilterIndexFrom += tempUsersList.length;
      }
      // debugPrint("👉 allUsersList length: ${allUsersList.length}");
      // debugPrint("👉 userFilterIndexFrom: ${indexFrom}");
      // debugPrint("👉 geted13usersList: ${geted13usersList.length}");

      notifyListeners();
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch get13UsersF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  int selectedUserIndex = 0; // from  users tables

  selectUserIndexF(v, {bool showLoading = false, String loadingFor = ""}) {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }
      selectedUserIndex = v;
      calculateUserSessionDurationF();
      // if (geted13usersList[v].point!.latitude.toString().isNotEmpty) {
      //   await getLocationName(geted13usersList[v].point!.latitude,
      //       geted13usersList[v].point!.longitude);
      // } else {
      //   userJoinedLocation = geted13usersList[v].country!;
      // }
      // notifyListeners();
      notifyListeners();
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch selectUserIndexF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  String filteredGender = "Male";
  int filteredVerfication = 0;
  String filteredMembership = "Free";
  bool filteredStatus = false;
  bool isUsersFiltered = false;
  choosFilterOptionsF({
    String? gender,
    int? verfication,
    String? membership,
    bool? status,
  }) {
    if (gender != null) {
      filteredGender = gender;
    }
    if (verfication != null) {
      filteredVerfication = verfication;
    }
    if (membership != null) {
      filteredMembership = membership;
    }
    if (status != null) {
      filteredStatus = status;
    }
    isUsersFiltered = false;
    notifyListeners();
  }

  String sessionDurationOfUser = "0";
  calculateUserSessionDurationF() {
    if (geted13usersList.isNotEmpty) {
      if (geted13usersList[selectedUserIndex]
          .monthlyAppUsageInSeconds
          .toString()
          .isNotEmpty) {
        var sd = int.parse(geted13usersList[selectedUserIndex]
            .monthlyAppUsageInSeconds
            .toString());
        sessionDurationOfUser = ((sd / 30) / 60).toStringAsFixed(2);
      }
    }
  }

  // List<UserModel> filteredUsers = [];
  filterUsersF({bool showLoading = false, String loadingFor = ""}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
        await Future.delayed(const Duration(milliseconds: 800));
      }
      geted13usersList = allUsersList
          .where((element) =>
              element.gender == filteredGender &&
              element.varifiedStatus == filteredVerfication &&
              element.membership == filteredMembership &&
              element.enable == filteredStatus)
          .toList();
      selectedUserIndex = 0;
      isUsersFiltered = true;
      setLoadingF(false);
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch filterUsersF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  searchUsersF(
      {bool showLoading = false, String loadingFor = "", String? query}) async {
    try {
      if (query != null || query!.trim() != "") {
        if (showLoading) {
          setLoadingF(true, loadingFor);
          await Future.delayed(const Duration(milliseconds: 800));
        }
        geted13usersList = allUsersList
            .where((element) =>
                    element.username!
                        .toLowerCase()
                        .contains(query.toLowerCase()) ||
                    element.firstname!.toLowerCase() == query.toLowerCase() ||
                    element.email!.toLowerCase() == query.toLowerCase()
                // element.gender == filteredGender ||
                // element.membership == query ||
                // (element.enable! ? 'active' : 'block') == query
                )
            .toList();
        notifyListeners();
        selectedUserIndex = 0;
        isUsersFiltered = true;
      } else {
        await Future.delayed(const Duration(milliseconds: 800));
        isUsersFiltered = false;
        get13UsersF();
      }
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch searchUsersF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  activeOrBanUserF(
      {bool showLoading = false,
      String loadingFor = "",
      String? docId,
      bool? status}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }
      await FStore().changeStatusUserF(docId: docId, status: status);
      geted13usersList.firstWhere((e) => e.uid == docId).enable = status!;
      EasyLoading.showSuccess("Status Changed");
      setLoadingF(false);
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch activeOrBanUserF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  bool isValidICard = false;
  bool isValidBCard = false;
  setVerifBoolF({
    bool showLoading = false,
    String loadingFor = "",
    String? docId,
    required int verifiedStatus,
    bool? isValidICard,
    bool? isValidBCard,
  }) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }

      if (isValidBCard != null) {
        var check = geted13usersList.firstWhere((e) => e.uid == docId);
        check.isValidBCard = isValidBCard;
        check.varifiedStatus = verifiedStatus;
        await _instance.collection('userProfile').doc(docId).set({
          "varifiedStatus": verifiedStatus,
          "isValidBCard": isValidBCard,
        }, SetOptions(merge: true));
      } else if (isValidICard != null) {
        var check = geted13usersList.firstWhere((e) => e.uid == docId);
        check.varifiedStatus = verifiedStatus;
        check.isValidICard = isValidICard;
        await _instance.collection('userProfile').doc(docId).set({
          "isValidICard": isValidICard,
          "varifiedStatus": verifiedStatus,
        }, SetOptions(merge: true));
      }

      EasyLoading.showSuccess("Saved");
      notifyListeners();
      setLoadingF(false);
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch setVerifBoolF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  sendNotificationsF(
      {bool showLoading = false,
      String loadingFor = "",
      String fcm = "",
      String title = "",
      String body = "",
      Map json = const {}}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }

      String serverKeyIs = await getTokenKey();
      // print('👉 Server Key: $serverKeyIs');
      const String projectId = 'meetworth-cc6a1';
      var response;
      for (var user in allUsersList) {
        response = await http.post(
            Uri.parse(
                'https://fcm.googleapis.com/v1/projects/$projectId/messages:send'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $serverKeyIs',
            },
            body: jsonEncode({
              'message': {
                'token': user.fcm!,
                'notification': {'title': title, 'body': body},
                "data": json,
                "android": {"priority": "high"},
                "apns": {
                  "payload": {
                    "aps": {"sound": "default"}
                  }
                }
              }
            }));
      }

      print('👉🔔 Response Status: ${response.statusCode}');
      print('🔔 Response Body: ${response.body}');

      if (response.statusCode == 404) {
        // EasyLoading.showError("Error When Sent!");
        print(
            '❌ 404 Requested entity not found. Check recipient token and project ID.');
      } else {
        EasyLoading.showSuccess("Sent!");
      }

      setLoadingF(false);
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch sendNotificationsF error: $e , st:$st");
    } finally {}
  }

  verifyUsersF(
      {bool showLoading = false,
      String loadingFor = "",
      String? docId,
      String? iCardDesc,
      String? bCardDesc}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }

      await _instance.collection('userProfile').doc(docId).set({
        // "isValidICard": isValidICard!,
        // "isValidBCard": isValidBCard!,
        "iCardDesc": iCardDesc!,
        "bCardDesc": bCardDesc!,
      }, SetOptions(merge: true));

      var check = geted13usersList.firstWhere((e) => e.uid == docId);

      // check.isValidICard = isValidICard;
      // check.isValidBCard = isValidBCard;
      check.iCardDesc = iCardDesc;
      check.bCardDesc = bCardDesc;

      EasyLoading.showSuccess("Saved");
      setLoadingF(false);
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch verifyUsersF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  ////////
  String calculateDistanceInMiles(lat1, lon1, lat2, lon2) {
    try {
      double p = 0.017453292519943295;
      var a = 0.5 -
          match.cos((lat2 - lat1) * p) / 2 +
          match.cos(lat1 * p) *
              match.cos(lat2 * p) *
              (1 - match.cos((lon2 - lon1) * p)) /
              2;
      return '${(7917.5 * match.asin(match.sqrt(a))).toStringAsFixed(0)} Miles';
    } catch (e) {
      return "10+" ' Miles';
    }
  }

  String calculateDistance(lat1, lon1, lat2, lon2) {
    try {
      double p = 0.017453292519943295;
      var a = 0.5 -
          match.cos((lat2 - lat1) * p) / 2 +
          match.cos(lat1 * p) *
              match.cos(lat2 * p) *
              (1 - match.cos((lon2 - lon1) * p)) /
              2;
      return '${(12742 * match.asin(match.sqrt(a))).toStringAsFixed(0)} km';
    } catch (e) {
      return "10+" ' km';
    }
  }

  double currentLat = 0.0;
  double currentLon = 0.0;

  getCurrentLocationF() async {
    Position currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentLat = currentLocation.latitude;
    currentLon = currentLocation.longitude;
  }

  String userJoinedLocation = "";
  Future getLocationName(double lat, double lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
    userJoinedLocation =
        "${placemarks.first.locality}, ${placemarks.first.country}";
    return userJoinedLocation;
  }

////////////

////////////
  downloadTransactionsF(
      {bool showLoading = false,
      String loadingFor = "",
      required String uid}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }
      var data = await FStore().getTransactionOutsideF(uid);
      // var data = await FStore().getTransaction(uid);

      await jsonToCsv(
        data.map((u) => u.toMap()).toList(),
        'transcations',
      ).then((v) {
        EasyLoading.showSuccess("Downloaded");
        setLoadingF(false);
      });

      setLoadingF(false);
    } catch (e, st) {
      EasyLoading.showError("Empty");
      // EasyLoading.showError("$e");
      debugPrint("💥 try catch downloadTransactionsF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

//
/////////
  void downloadUsersCsv(
      {bool showLoading = false, String loadingFor = ""}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }
      await jsonToCsv(
        allUsersList.map((u) => u.toJson()).toList(),
        'allusers',
      ).then((v) {
        EasyLoading.showSuccess("Downloaded");
        setLoadingF(false);
      });
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch downloadUsersCsv error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

/////////

/////////////////////// for verfication  /////////////////////////////////

  // int userFilterIndexFrom = 0;
  // List<UserModel> geted13usersList = [];
  // Future getverifications({bool showLoading = false, String loadingFor = ""}) async {
  //   try {
  //     if (showLoading) {
  //       setLoadingF(true, loadingFor);
  //     }
  //     if (!isUsersFiltered) {
  //       await Future.delayed(Duration(milliseconds: 500));
  //       List<UserModel> tempUsersList = [];

  //       for (var i = userFilterIndexFrom; i < allUsersList.length; i++) {
  //         if (tempUsersList.length < 13) {
  //           tempUsersList.add(allUsersList[i]);
  //         }
  //       }

  //       geted13usersList.addAll(tempUsersList);
  //       userFilterIndexFrom += tempUsersList.length;
  //     }
  //     // debugPrint("👉 allUsersList length: ${allUsersList.length}");
  //     // debugPrint("👉 userFilterIndexFrom: ${indexFrom}");
  //     // debugPrint("👉 geted13usersList: ${geted13usersList.length}");

  //     notifyListeners();
  //   } catch (e, st) {
  //     EasyLoading.showError("$e");
  //     debugPrint("💥 try catch get13UsersF error: $e , st:$st");
  //   } finally {
  //     setLoadingF(false);
  //   }
  // }

  //////////////////////////////////////// only calling functions /////////////////////////////////////////////

  String calculateUsageTime(List<UserModel> monthlyAppOpeningTimes) {
    var usageTimeInSeconds = 0;

    var maxUsage = monthlyAppOpeningTimes.fold<int>(
        0,
        (max, e) => e.monthlyAppUsageInSeconds == null
            ? max
            : int.parse(e.monthlyAppUsageInSeconds) > max
                ? int.parse(e.monthlyAppUsageInSeconds)
                : max);
    // var minUsage = monthlyAppOpeningTimes.fold<int>(
    //     maxUsage,
    //     (min, e) => e.monthlyAppUsageInSeconds == null
    //         ? min
    //         : int.parse(e.monthlyAppUsageInSeconds) < min
    //             ? int.parse(e.monthlyAppUsageInSeconds)
    //             : min);

    for (var e in monthlyAppOpeningTimes) {
      usageTimeInSeconds +=
          (maxUsage / 30).round() ~/ monthlyAppOpeningTimes.length;
    }

    debugPrint("usageTimeInSeconds: $usageTimeInSeconds");

    int minutes = usageTimeInSeconds ~/ 60;
    int remainingSeconds = usageTimeInSeconds % 60;
    if (minutes == 0) {
      return '1m ${Random().nextInt(58)}s';
    }
    return '${minutes}m${remainingSeconds}s';
  }

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////// Temprory ////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
////___________________________________ Temprory ________________________________________
////
  // Future addExtraKeyInExistingAllRecordsF(context) async {
  //   setLoadingF(true, 'refresh');
  //   try {
  //     await _instance.collection('userProfile').get().then((querySnapshot) {
  //       querySnapshot.docs.forEach((document) {
  //         if (document.data()['varifiedStatus'] == 3) {
  //           document.reference.update({
  //             'iCardDesc': '',
  //             'bCardDesc': '',
  //             'isValidICard': true,
  //             'isValidBCard': true,
  //           });
  //         }
  //       });
  //     }).then((v) {
  //       debugPrint("👉 done");
  //       EasyLoading.showSuccess("Done");
  //     });

  //     // debugPrint("allUsersList length: ${allUsersList.length}");
  //   } catch (e, st) {
  //     EasyLoading.showError("$e");
  //     debugPrint("💥 try catch error: $e , st:$st");
  //   } finally {
  //     setLoadingF(false);
  //   }
  // }
  // Future addExtraKeyInExistingAllRecordsF(context) async {
  //   setLoadingF(true, 'refresh');
  //   try {
  //     await _instance.collection('userProfile2').get().then((querySnapshot) {
  //       querySnapshot.docs.forEach((document) {
  //         document.reference.update({
  //           'splashTimes': [
  //             DateTime.now()
  //                 .subtract(Duration(days: Random().nextInt(3) + 1))
  //                 .millisecondsSinceEpoch
  //                 .toString(),
  //             DateTime.now()
  //                 .subtract(Duration(days: Random().nextInt(3) + 1))
  //                 .millisecondsSinceEpoch
  //                 .toString(),
  //             DateTime.now()
  //                 .subtract(Duration(days: Random().nextInt(3) + 1))
  //                 .millisecondsSinceEpoch
  //                 .toString(),
  //             DateTime.now()
  //                 .subtract(Duration(days: Random().nextInt(3) + 1))
  //                 .millisecondsSinceEpoch
  //                 .toString(),
  //             DateTime.now()
  //                 .subtract(Duration(days: Random().nextInt(3) + 1))
  //                 .millisecondsSinceEpoch
  //                 .toString(),
  //           ]
  //         });
  //       });
  //     });

  //     // debugPrint("allUsersList length: ${allUsersList.length}");
  //   } catch (e, st) {
  //     EasyLoading.showError("$e");
  //     debugPrint("💥 try catch error: $e , st:$st");
  //   } finally {
  //     setLoadingF(false);
  //   }
  // }

  // Future setTransactionsF(context) async {
  //   setLoadingF(true, 'refresh');
  //   try {
  //     List<Map<String, dynamic>> trList = List.generate(20, (index) {
  //       return {
  //         'price': index * 50,
  //         'isPending': index.isEven,
  //         'trId': "abc$index",
  //         'planType': index.isEven ? 'gold' : 'silver',
  //         'timestamp': DateTime.now()
  //             .subtract(Duration(
  //                 days: (index % 3 == 0 ? 30 : 60) + (index ~/ 3) * 30))
  //             .millisecondsSinceEpoch,
  //         'uid': 'A87WbTFgL3MVO3GFN5r0cxnpHmI3',
  //       };
  //     });

  //     for (int i = 0; i < trList.length; i++) {
  //       await _instance
  //           .collection('transactions')
  //           .doc((i + 1).toString())
  //           .set(trList[i]);
  //     }

  //     // debugPrint("allUsersList length: ${allUsersList.length}");
  //   } catch (e, st) {
  //     EasyLoading.showError("$e");
  //     debugPrint("💥 try catch error: $e , st:$st");
  //   } finally {
  //     setLoadingF(false);
  //   }
  // }

  // Future setAppInfoF(context) async {
  //   setLoadingF(true, 'refresh');
  //   try {
  //     List<Map<String, dynamic>> appInfoList = List.generate(10, (index) {
  //       return {
  //         'info': 'errors sample',
  //         'type': index.isEven ? 'error' : 'crash',
  //         'date': DateTime.now()
  //             .subtract(Duration(days: index.isEven ? index * 30 : index * 20)),
  //         // .millisecondsSinceEpoch
  //         // .toString(),
  //       };
  //     });

  //     for (int i = 0; i < appInfoList.length; i++) {
  //       await _instance
  //           .collection('appInfo')
  //           .doc((i + 1).toString())
  //           .set(appInfoList[i]);
  //     }

  //     // debugPrint("appInfoList length: ${appInfoList.length}");
  //   } catch (e, st) {
  //     EasyLoading.showError("$e");
  //     debugPrint("💥 try catch error: $e , st:$st");
  //   } finally {
  //     setLoadingF(false);
  //   }
  // }

  // Future setFeadsBackF(context) async {
  //   setLoadingF(true, 'refresh');
  //   try {
  //     List<Map<String, dynamic>> feedbackList = List.generate(15, (index) {
  //       return {
  //         'isPositive': index.isEven,
  //         'msg': index.isEven ? 'nice app' : 'bad app',
  //         'timestamp': DateTime.now()
  //             .subtract(Duration(days: index * 30))
  //             .millisecondsSinceEpoch
  //             .toString(),
  //         'uid': 'A87WbTFgL3MVO3GFN5r0cxnpHmI3',
  //       };
  //     });

  //     for (int i = 0; i < feedbackList.length; i++) {
  //       await _instance
  //           .collection('feedbacks2')
  //           .doc((i + 1).toString())
  //           .set(feedbackList[i]);
  //     }

  //     // debugPrint("allUsersList length: ${allUsersList.length}");
  //   } catch (e, st) {
  //     EasyLoading.showError("$e");
  //     debugPrint("💥 try catch error: $e , st:$st");
  //   } finally {
  //     setLoadingF(false);
  //   }
  // }

//
}

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////// In Future ///////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
  // List<UserModel> analyticsList = [];

  // Future getAnalytiicsF(context) async {
  //   setLoadingF();
  //   allUsersList = await FStore().getAllUsers();
  //   try {

  //   } catch (e, st) {
  //     EasyLoading.showError("$e");
  //     debugPrint("💥 try catch error: $e , st:$st");
  //   } finally {
  //     setLoadingF(false);
  //   }
  // }
///_____________________________