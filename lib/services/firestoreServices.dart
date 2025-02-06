import 'package:admin_panel/models/appinfoModel.dart';
import 'package:admin_panel/models/feedbackModel.dart';
import 'package:admin_panel/models/friendsModel.dart';
import 'package:admin_panel/models/postsModel.dart';
import 'package:admin_panel/models/transactionsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../models/categories.dart';
import '../models/chatModel.dart';
import '../models/usersModel.dart';
import '/models/basicContent.dart';
import '/models/event.dart';
import '/models/faqModel.dart';
import '/models/gameModel.dart';
import '/models/notificationModel.dart';
import '/models/paymentModel.dart';
import '/models/typeModel.dart';

List<String> generateArray(String name) {
  List<String> list = [];
  for (int i = 0; i < name.length; i++) {
    list.add(name.substring(0, i + 1));
  }
  // for (String test in name.split(' ')) {
  //   for (int i = 0; i < test.length; i++) {
  //     list.add(test.substring(0, i + 1));
  //   }
  // }
  return list;
}

class FStore {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  FStore() {
    checkInterNet();
  }

  checkInterNet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      EasyLoading.showInfo("🛜 No Internet");
      return;
    }
  }

  clearLocalData() {
    _instance.clearPersistence();
  }

  setBuisnessType(TypeModel model) async {
    String id = _instance
        .collection('adminSettings')
        .doc('types')
        .collection('businessTypes')
        .doc()
        .id;
    model.id = id;
    await _instance
        .collection('adminSettings')
        .doc('types')
        .collection('businessTypes')
        .doc(model.id)
        .set(model.toSaveJSON());
  }

  setGoals(TypeModel model) async {
    String id = _instance
        .collection('adminSettings')
        .doc('types')
        .collection('goals')
        .doc()
        .id;
    model.id = id;
    await _instance
        .collection('adminSettings')
        .doc('types')
        .collection('goals')
        .doc(model.id)
        .set(model.toSaveJSON());
  }

  setFaq(FaqModel model) async {
    String id = _instance.collection('faqs').doc().id;
    model.id = id;
    await _instance.collection('faqs').doc(model.id).set(model.toSaveJSON());
  }

  setBuisnessCategories(TypeModel model) async {
    String id = _instance
        .collection('adminSettings')
        .doc('types')
        .collection('businessCategories')
        .doc()
        .id;
    model.id = id;
    await _instance
        .collection('adminSettings')
        .doc('types')
        .collection('businessCategories')
        .doc(model.id)
        .set(model.toSaveJSON());
  }

  setInterests(TypeModel model) async {
    String id = _instance
        .collection('adminSettings')
        .doc('types')
        .collection('intrests')
        .doc()
        .id;
    model.id = id;
    await _instance
        .collection('adminSettings')
        .doc('types')
        .collection('intrests')
        .doc(model.id)
        .set(model.toSaveJSON());
  }

  setLanguages(TypeModel model) async {
    String id = _instance
        .collection('adminSettings')
        .doc('types')
        .collection('languages')
        .doc()
        .id;
    model.id = id;
    await _instance
        .collection('adminSettings')
        .doc('types')
        .collection('languages')
        .doc(model.id)
        .set(model.toSaveJSON());
  }

  Query getBuisnessType() {
    return FirebaseFirestore.instance
        .collection('adminSettings')
        .doc('types')
        .collection('businessTypes')
        .orderBy('creationDate', descending: true);
  }

  Query getGoals() {
    return FirebaseFirestore.instance
        .collection('adminSettings')
        .doc('types')
        .collection('goals')
        .orderBy('creationDate', descending: true);
  }

  Query getFaqs() {
    return FirebaseFirestore.instance
        .collection('faqs')
        .orderBy('answer', descending: true);
  }

  deleteFaqs(String id) {
    return FirebaseFirestore.instance.collection('faqs').doc(id).delete();
  }

  Query getInterests() {
    return FirebaseFirestore.instance
        .collection('adminSettings')
        .doc('types')
        .collection('intrests')
        .orderBy('creationDate', descending: true);
  }

  Query getLanguages() {
    return FirebaseFirestore.instance
        .collection('adminSettings')
        .doc('types')
        .collection('languages')
        .orderBy('creationDate', descending: true);
  }

  Query getBusinessCategories() {
    return FirebaseFirestore.instance
        .collection('adminSettings')
        .doc('types')
        .collection('businessCategories')
        .orderBy('creationDate', descending: true);
  }

  Future<UserModel> getUser(String userId) async {
    if (userId == "") return UserModel();
    UserModel user = UserModel();
    try {
      DocumentSnapshot dsnap =
          await _instance.collection('userProfile').doc(userId).get();
      if (dsnap.exists) {
        user = UserModel.fromMap(dsnap.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print(e.toString());
    }
    return user;
  }

  Query getEvents() {
    return _instance.collection('events').orderBy('date', descending: true);
  }

  Query getEventsbyKey(String key) {
    return _instance
        .collection('events')
        .where("searchParameter", arrayContains: key.toLowerCase())
        .orderBy('date', descending: true);
  }

  // Query getTransactions() {
  //   return _instance
  //       .collection('transaction')
  //       .orderBy('data', descending: true);
  // }

  // Query getTransactionsByEvent(String key) {
  //   return _instance
  //       .collection('transaction')
  //       .where("searchParameter", arrayContains: key.toLowerCase())
  //       .orderBy('data', descending: true);
  // }

  // Query getUserTransactions(String id) {
  //   return _instance
  //       .collection('transaction')
  //       .where('userId', isEqualTo: id)
  //       .orderBy('data', descending: true);
  // }

  Query getMyEvents() {
    return _instance
        .collection('events')
        .where('userOwner', isEqualTo: UserModel().uid)
        .where('status', whereIn: [0, 1]).orderBy('date', descending: true);
  }

  Future<List<EventModel>> getLatestEvent() async {
    List<EventModel> myEvent = [];
    try {
      QuerySnapshot<Map<String, dynamic>> dsnaps;
      dsnaps = await _instance
          .collection('events')
          .where("userIds", arrayContains: UserModel().uid)
          .orderBy('date', descending: true)
          .limit(1)
          .get();
      if (dsnaps.docs.isNotEmpty) {
        if (dsnaps.docs.first.exists) {
          myEvent.add(EventModel.toModel(dsnaps.docs.first.data()));
        }
      }
      return myEvent;
    } catch (e) {
      print(e.toString());
      return myEvent;
    }
  }

  Query getJoinEvents() {
    return _instance
        .collection('events')
        .where("userIds", arrayContains: UserModel().uid)
        .orderBy('date', descending: true);
  }

  getAllMyEvents() async {
    List<EventModel> events = [];
    try {
      QuerySnapshot<Map<String, dynamic>> dsnap = await _instance
          .collection('events')
          .where('userOwner', isEqualTo: UserModel().uid)
          .where('status', whereIn: [0, 1]).get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> item in dsnap.docs) {
        if (item.exists) {
          EventModel post = EventModel.toModel(item.data());
          events.add(post);
        }
      }
    } catch (e) {
      return [];
    }
    return events;
  }

  List profilesDocIds = [];
  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> users = [];
    try {
      QuerySnapshot<Map<String, dynamic>> dsnap = await _instance
          .collection('userProfile')
          .orderBy('creationDate', descending: true)
          .get();

      // debugPrint("👉 getAllUsers start");
      // log("${dsnap.docs.map((e) => {'id': e.id, 'data': e.data()}).toList()}");
      // debugPrint("👉 getAllUsers end");

      for (QueryDocumentSnapshot<Map<String, dynamic>> item in dsnap.docs) {
        if (item.exists) {
          profilesDocIds = dsnap.docs.map((e) => e.id).toList();
          UserModel user = UserModel.fromMap(item.data());
          users.add(user);
        }
      }
    } catch (e, st) {
      debugPrint("💥 getAllUsers: $e, st:$st");
    }
    return users;
  }

  Future<List<TransactionsModel>> getTransactions() async {
    List<TransactionsModel> data = [];
    try {
      QuerySnapshot<Map<String, dynamic>> dsnap = await _instance
          .collection('transactions')
          // .where('timestamp',
          //     isLessThanOrEqualTo: DateTime.now()
          //         .subtract(const Duration(days: 180))
          //         .millisecondsSinceEpoch)
          //         .orderBy('timestamp', descending: true)
          .get();

      data.clear();
      for (QueryDocumentSnapshot<Map<String, dynamic>> item in dsnap.docs) {
        if (item.exists) {
          int timestamp = int.parse(item.data()['timestamp'].toString());

          if (DateTime.now()
                  // .subtract(const Duration(days: 215)) // 7 month
                  .subtract(const Duration(days: 185)) // 6 month
                  .millisecondsSinceEpoch <
              timestamp) {
            TransactionsModel d = TransactionsModel.fromMap(item.data());
            data.add(d);
          }
        }
      }
    } catch (e, st) {
      debugPrint("💥 getTransactions: $e, st:$st");
    }
    return data;
  }

  Future<List<ChatModel>> getAllChatsF() async {
    List<ChatModel> data = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collectionGroup("chat")
          // .orderBy('lastMsg', descending: true)
          // .where('date',
          //     isGreaterThanOrEqualTo: Timestamp.fromMillisecondsSinceEpoch(
          //         DateTime.now()
          //             .subtract(const Duration(days: 180))
          //             .millisecondsSinceEpoch))
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        data.clear();
        for (var doc in querySnapshot.docs) {
          data.add(ChatModel.fromMap(doc.data() as Map<String, dynamic>));
          // debugPrint("Chat Data: ${doc.data()}");
        }
      }
    } catch (e, st) {
      debugPrint("💥 getAllChatsF: $e, st:$st");
    }
    return data;
  }

  Future<List<PostsModel>> getAllPostsF() async {
    List<PostsModel> data = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("post")
          // .orderBy('lastMsg', descending: true)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        data.clear();
        for (var doc in querySnapshot.docs) {
          data.add(PostsModel.fromMap(doc.data() as Map<String, dynamic>));
          // debugPrint("Chat Data: ${doc.data()}");
        }
      }
    } catch (e, st) {
      debugPrint("💥 getAllPostsF: $e, st:$st");
    }
    return data;
  }

  Future<List<FriendsModel>> getAllFriendsF() async {
    List<FriendsModel> data = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collectionGroup("friends")
          // .orderBy('lastMsg', descending: true)
          // .where('date',
          //     isGreaterThanOrEqualTo: Timestamp.fromMillisecondsSinceEpoch(
          //         DateTime.now()
          //             .subtract(const Duration(days: 180))
          //             .millisecondsSinceEpoch))
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        data.clear();
        for (var doc in querySnapshot.docs) {
          // debugPrint("👉 getAllFriendsF Data: ${doc.data()}");
          data.add(FriendsModel.fromJson(doc.data() as Map<String, dynamic>));
          // debugPrint("Chat Data: ${doc.data()}");
        }
      }
    } catch (e, st) {
      debugPrint("💥 getFriendsF: $e, st:$st");
    }
    return data;
  }

  Future<List<AppInfoModel>> getAppInfoListF() async {
    List<AppInfoModel> data = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("appInfo")
          .orderBy('date', descending: true)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        data.clear();
        for (var doc in querySnapshot.docs) {
          // debugPrint("👉 getAppInfoListF Data: ${doc.data()}");
          data.add(AppInfoModel.fromJson(doc.data() as Map<String, dynamic>));
        }
      }
    } catch (e, st) {
      debugPrint("💥 getAppInfoListF: $e, st:$st");
    }
    return data;
  }

  Future<List<FeedbackModel>> getFeedbacksF() async {
    List<FeedbackModel> data = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("feedbacks")
          .orderBy('timestamp', descending: true)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        data.clear();
        for (var doc in querySnapshot.docs) {
          // debugPrint("👉 getFeedbacksF Data: ${doc.data()}");
          data.add(FeedbackModel.fromJson(doc.data() as Map<String, dynamic>));
        }
      }
    } catch (e, st) {
      debugPrint("💥 getFeedbacksF: $e, st:$st");
    }
    return data;
  }

  Future getLoadTimeF() async {
    List<int> data = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collectionGroup("loadTime")
          // .orderBy('loadTimeInSeconds', descending: true)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        data.clear();
        for (var doc in querySnapshot.docs) {
          // debugPrint("👉 getLoadTimeF Data: ${doc.data()}");
          var dataMap = doc.data() as Map<String, dynamic>;
          var loadTime = int.parse("${dataMap['loadTimeInSeconds']}");
          data.add(loadTime);
        }
      }
    } catch (e, st) {
      debugPrint("💥 getLoadTimeF: $e, st:$st");
    }
    return data;
  }

  getAllJoinEvents() async {
    List<EventModel> events = [];
    try {
      QuerySnapshot<Map<String, dynamic>> dsnap = await _instance
          .collection('events')
          .where("userIds", arrayContains: UserModel().uid)
          .orderBy('date')
          .get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> item in dsnap.docs) {
        if (item.exists) {
          EventModel post = EventModel.toModel(item.data());
          events.add(post);
        }
      }
    } catch (e, st) {
      print("💥 getAllJoinEvents: $e, st:$st");
    }
    return events;
  }

  Query allUsers() {
    return _instance
        .collection('userProfile')
        .orderBy('varifiedStatus', descending: true);
  }

  deleteType(String id) {
    _instance
        .collection('adminSettings')
        .doc('types')
        .collection('businessTypes')
        .doc(id)
        .delete();
  }

  Future<bool> deleteBCategory(String id) async {
    try {
      await _instance
          .collection('adminSettings')
          .doc('types')
          .collection('businessCategories')
          .doc(id)
          .delete();
      return true;
    } catch (e) {
      debugPrint("Error deleting business category: $e");
      return false;
    }
  }

  Future<bool> deleteInterest(String id) async {
    try {
      _instance
          .collection('adminSettings')
          .doc('types')
          .collection('intrests')
          .doc(id)
          .delete();
      return true;
    } catch (e) {
      debugPrint("Error deleting business category: $e");
      return false;
    }
  }

  Future<bool> deleteLanguage(String id) async {
    try {
      _instance
          .collection('adminSettings')
          .doc('types')
          .collection('languages')
          .doc(id)
          .delete();
      return true;
    } catch (e) {
      debugPrint("Error deleting business category: $e");
      return false;
    }
  }

  Future<bool> deleteGoals(String id) async {
    try {
      _instance
          .collection('adminSettings')
          .doc('types')
          .collection('goals')
          .doc(id)
          .delete();
      return true;
    } catch (e) {
      debugPrint("Error deleting business category: $e");
      return false;
    }
  }

  Query allUsersSearch(String key) {
    return _instance
        .collection('userProfile')
        .where("searchParameter", arrayContains: key.toLowerCase())
        .orderBy('username', descending: true);
  }

  //searchParameter
  Query searchEvents(String key) {
    return _instance
        .collection('events')
        .where('status', whereIn: [1])
        .where("searchParameter", arrayContains: key.toLowerCase())
        .orderBy('date', descending: true);
  }

  Future<bool> setGame(GameModel game) async {
    try {
      await _instance
          .collection('events')
          .doc(game.pokerId)
          .collection("participants")
          .doc(game.userId)
          .set(game.toSaveJSON(), SetOptions(merge: true));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<GameModel> getGame(String pokerId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> data = await _instance
          .collection('events')
          .doc(pokerId)
          .collection("participants")
          .doc(UserModel().uid)
          .get();
      if (data.exists) {
        return GameModel.toModel(data.data() ?? {});
      } else {
        return GameModel();
      }
    } catch (e) {
      return GameModel();
    }
  }

  deleteEvent(eventId) async {
    _instance.collection('events').doc(eventId).delete();
  }

  init() {
    _instance
        .enablePersistence(const PersistenceSettings(synchronizeTabs: true));
    _instance.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  }

  // ** Users

  Query getVendors(
    DateTime? start,
    DateTime? end,
    String searchkey,
    int searchType,
    String vendorKey,
    String selectCategory,
    String subcriptionType,
  ) {
    if (vendorKey == "") {
      if (start != null) {
        return _instance
            .collection('userProfile')
            .where('subcriptionDeadLine', isGreaterThanOrEqualTo: start)
            .where('subcriptionDeadLine', isLessThanOrEqualTo: end)
            .orderBy('subcriptionDeadLine', descending: true);
      }
      if (searchkey != "") {
        if (searchType == 0) {
          return _instance
              .collection('userProfile')
              .where('search', arrayContains: searchkey.toLowerCase())
              .orderBy('subcriptionDeadLine', descending: true);
        } else {
          return _instance
              .collection('userProfile')
              .where('search2', arrayContains: searchkey.toUpperCase())
              .orderBy('subcriptionDeadLine', descending: true);
        }
      }
      if (selectCategory != "") {
        if (selectCategory != "Others") {
          return _instance
              .collection('userProfile')
              .where('productType', isEqualTo: selectCategory)
              .orderBy('subcriptionDeadLine', descending: true);
        } else {
          // before use this
          // 👉 this should be used out side
          List<CategoryModel> allCategories = [];
          return _instance
              .collection('userProfile')
              .where("productType",
                  whereNotIn: allCategories.map((e) => e.name).toList())
              .orderBy('productType', descending: true);
        }
      }
      if (subcriptionType != "") {
        return _instance
            .collection('userProfile')
            .where('subcriptionType',
                isEqualTo: subcriptionType == "Basic"
                    ? 0
                    : subcriptionType == "Premium"
                        ? 1
                        : 2)
            .orderBy('subcriptionDeadLine', descending: true);
      }
    } else {
      if (vendorKey != "Others") {
        if (start != null) {
          return _instance
              .collection('userProfile')
              .where('productType', isEqualTo: vendorKey)
              .where('subcriptionDeadLine', isGreaterThanOrEqualTo: start)
              .where('subcriptionDeadLine', isLessThanOrEqualTo: end)
              .orderBy('subcriptionDeadLine', descending: true);
        }
        if (searchkey != "") {
          if (searchType == 0) {
            return _instance
                .collection('userProfile')
                .where('productType', isEqualTo: vendorKey)
                .where('search', arrayContains: searchkey.toLowerCase())
                .orderBy('subcriptionDeadLine', descending: true);
          } else {
            return _instance
                .collection('userProfile')
                .where('productType', isEqualTo: vendorKey)
                .where('search2', arrayContains: searchkey.toUpperCase())
                .orderBy('subcriptionDeadLine', descending: true);
          }
        }
        if (subcriptionType != "") {
          return _instance
              .collection('userProfile')
              .where('productType', isEqualTo: vendorKey)
              .where('subcriptionType',
                  isEqualTo: subcriptionType == "Basic"
                      ? 0
                      : subcriptionType == "Premium"
                          ? 1
                          : 2)
              .orderBy('subcriptionDeadLine', descending: true);
        }
        return _instance
            .collection('userProfile')
            .where('productType', isEqualTo: vendorKey)
            .orderBy('subcriptionDeadLine', descending: true);
      } else {
        // before use this
        // 👉 this should be used out side
        List<CategoryModel> allCategories = [];
        return _instance
            .collection('userProfile')
            .where("productType",
                whereNotIn: allCategories.map((e) => e.name).toList())
            .orderBy('productType', descending: true);
      }
    }
    return _instance
        .collection('userProfile')
        .orderBy('subcriptionDeadLine', descending: true);
  }

  getCustomer() {
    return _instance.collection('customers').orderBy('name');
  }

  getVideos() {
    return _instance.collection('videos').orderBy('title');
  }

  deleteVideo(String id) {
    _instance.collection('videos').doc(id).delete();
  }

  getCountingInfo() async {
    Map<String, dynamic> count = {};
    DocumentSnapshot<Map<String, dynamic>> data =
        await _instance.collection('info').doc('count').get();
    if (data.exists) {
      count = data.data() ?? {};
    }
    return count;
  }

  // Future<List<TransactionModel>> getNTransactions() async {
  //   List<TransactionModel> list = [];
  //   QuerySnapshot<Map<String, dynamic>> data = await _instance
  //       .collection('transaction')
  //       .orderBy('data', descending: true)
  //       .limit(10)
  //       .get();

  //   for (var element in data.docs) {
  //     if (element.exists) {
  //       TransactionModel trans = TransactionModel.toModel(element.data());
  //       list.add(trans);
  //     }
  //   }

  //   return list;
  // }

  Future<List<String>> getStatsInfo() async {
    List<String> stats = ['0', '0', '0', '0'];
    DocumentSnapshot<Map<String, dynamic>> data =
        await _instance.collection('info').doc('stats').get();
    if (data.exists) {
      Map<String, dynamic>? days = data.data();
      try {
        stats[3] = days!['income'].toStringAsFixed(2);
      } catch (e) {
        debugPrint(e.toString());
      }
      try {
        stats[1] = days!['pokerruns'].toString();
      } catch (e) {
        debugPrint(e.toString());
      }
      try {
        stats[2] = days!['transactions'].toStringAsFixed(2);
      } catch (e) {
        debugPrint(e.toString());
      }
      try {
        stats[0] = days!['users'].toString();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return stats;
  }

  addFaq(String title, String message) async {
    String id = _instance.collection('faqs').doc().id;
    await _instance
        .collection('faqs')
        .doc(id)
        .set({"title": title, "message": message, "id": id});
  }

  addVideo(String title, String thumnail, String link) async {
    String id = _instance.collection('videos').doc().id;
    await _instance
        .collection('videos')
        .doc(id)
        .set({"title": title, "thumnail": thumnail, "link": link, "id": id});
  }

  enableVideo(String id, bool status) {
    _instance
        .collection('videos')
        .doc(id)
        .set(({"status": status}), SetOptions(merge: true));
  }

  deleteFaq(String id) {
    _instance.collection('faqs').doc(id).delete();
  }

  enableFaq(String id, bool status) {
    _instance
        .collection('faqs')
        .doc(id)
        .set(({"status": status}), SetOptions(merge: true));
  }

  getCategories(String search) {
    if (search == "") {
      return _instance.collection('catagories').orderBy('name');
    } else {
      return _instance
          .collection('catagories')
          .where('search', arrayContains: search.toLowerCase())
          .orderBy('name');
    }
  }

  setCategory(String name, String image) {
    String id = _instance.collection('catagories').doc().id;
    return _instance.collection('catagories').doc(id).set({
      "enable": true,
      "id": id,
      "image": image,
      "name": name,
      "search": generateArray(name)
    });
  }

  changeStatusUser(UserModel user) {
    _instance
        .collection('userProfile')
        .doc(user.uid)
        .set({"enable": !user.enable!}, SetOptions(merge: true));
  }

  changeMemberShip(UserModel user, String status) {
    _instance.collection('userProfile').doc(user.uid).set({
      "adminActiveMemebership": status,
    }, SetOptions(merge: true));
  }

  changeVarificationStatusUser(UserModel user, int status) {
    if (status == 0) {
      // reject
      NotificationModel notification = NotificationModel();
      notification.id = _instance.collection('notification').doc().id;
      notification.receiverId = user.uid!;
      notification.userId = user.uid!;
      notification.userImg = "";
      notification.title = "We couldn't verify you";
      notification.additionalId = "";
      notification.type = 4;
      notification.body =
          "We've reviewed your documents and couldn't verify your account. Please try again and make you follow all the requirements.";
      _instance
          .collection('notification')
          .doc(notification.id)
          .set(notification.toMap(), SetOptions(merge: true));
      _instance.collection('userProfile').doc(user.uid).set(
          {"varifiedStatus": status, "file1": null, "file2": null},
          SetOptions(merge: true));
    } else {
      // accept
      NotificationModel notification = NotificationModel();
      notification.id = _instance.collection('notification').doc().id;
      notification.receiverId = user.uid!;
      notification.userId = user.uid!;
      notification.userImg = "";
      notification.title = "Your account got verified";
      notification.additionalId = "";
      notification.type = 4;
      notification.body =
          "Congratulations, your documents have been approved and you are now verified.";
      _instance
          .collection('notification')
          .doc(notification.id)
          .set(notification.toMap(), SetOptions(merge: true));
      _instance
          .collection('userProfile')
          .doc(user.uid)
          .set({"varifiedStatus": status}, SetOptions(merge: true));
    }
  }

  setServiceFee(String uid, double? fee) {
    _instance.collection('userProfile').doc(uid).set({
      "serviceFee": fee,
    }, SetOptions(merge: true));
  }

  setBaicInfo(BasicContent content) {
    _instance
        .collection('info')
        .doc('basic')
        .set({"number": content.number}, SetOptions(merge: true));

    _instance.collection('info').doc('price').set({
      "serviceFee": content.serviceFee,
      "persantageChangeCardFee": content.persantageFee,
    }, SetOptions(merge: true));
  }

  Future<BasicContent> getBaicInfo() async {
    BasicContent content = BasicContent();

    try {
      DocumentSnapshot<Map<String, dynamic>> data =
          await _instance.collection('info').doc('basic').get();
      if (data.exists) {
        content.number = (data.data())!['number'];
      }
    } catch (_) {
      content.number = "";
    }

    DocumentSnapshot<Map<String, dynamic>> data =
        await _instance.collection('info').doc('price').get();
    try {
      if (data.exists) {
        content.serviceFee = (data.data())!['serviceFee'];
      }
    } catch (_) {
      content.serviceFee = 0.0;
    }
    try {
      if (data.exists) {
        content.persantageFee = (data.data())!['persantageChangeCardFee'];
      }
    } catch (_) {
      content.persantageFee = 0.0;
    }

    return content;
  }

  about(String link) {
    _instance
        .collection('info')
        .doc('about')
        .set({"link": link}, SetOptions(merge: true));
  }

  Future<List<PaymentModel>> getTransaction(userId) async {
    List<PaymentModel> list = [];
    var data = await _instance
        .collection('userProfile')
        .doc(userId)
        .collection("payments")
        .orderBy('creatingDate')
        .limit(60)
        .get();
    for (var item in data.docs) {
      if (item.exists) {
        list.add(PaymentModel.toModel(item.data()));
      }
    }
    return list;
  }

  // deleteUser(UserModel user) {
  //   _instance.collection('userProfile').doc(user.id).delete();
  // }

  deleteCategory(String id) {
    _instance.collection('catagories').doc(id).delete();
  }

  updateCategory(String id, bool enable) {
    _instance
        .collection('catagories')
        .doc(id)
        .set({'enable': enable}, SetOptions(merge: true));
  }
}
