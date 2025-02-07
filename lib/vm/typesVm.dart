import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/faqModel.dart';
import '../models/typeModel.dart';
import '../services/firestoreServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final typesVm = ChangeNotifierProvider<TypesVm>((ref) => TypesVm());

class TypesVm with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
/////////////////////
  ///
  ///

////////////////// for business category page and interest , languages, goals.

  /////////////
  List<TypeModel> businessCategoryList = [];
  Future getBusinessCategoryListF(
      {bool showLoading = false, String loadingFor = ""}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }

      QuerySnapshot listIs = await FStore().getBusinessCategories().get();
      if (listIs.docs.isNotEmpty) {
        businessCategoryList.clear();
        for (var doc in listIs.docs) {
          businessCategoryList
              .add(TypeModel.fromMap(doc.data() as Map<String, dynamic>));
        }
      }

      notifyListeners();
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch getBusinessCategoryListF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  Future addBusinessCategoryListF(
      {bool showLoading = false,
      String loadingFor = "",
      required String name}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }
      String id = FirebaseFirestore.instance
          .collection('adminSettings')
          .doc('types')
          .collection('businessCategories')
          .doc()
          .id;
      TypeModel model =
          TypeModel(id: id, name: name, creationDate: DateTime.now());
      await FirebaseFirestore.instance
          .collection('adminSettings')
          .doc('types')
          .collection('businessCategories')
          .doc(model.id)
          .set(model.toMap());

      debugPrint("model.toMap() : ${model.toMap()}");
      businessCategoryList.add(model);
      getBusinessCategoryListF();
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch addBusinessCategoryListF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  //////////////
  Future delBusinessCategoryListF(
      {bool showLoading = false,
      String loadingFor = "",
      required String docId}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }

      bool check = await FStore().deleteBCategory(docId);
      if (check) {
        businessCategoryList.removeWhere((e) => e.id == docId);
      }

      notifyListeners();
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch delBusinessCategoryListF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  /////////////
  // this is same with  TypeModel
  List<TypeModel> interestList = [];
  Future getinterestListF(
      {bool showLoading = false, String loadingFor = ""}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }

      QuerySnapshot listIs = await FStore().getInterests().get();
      if (listIs.docs.isNotEmpty) {
        interestList.clear();
        for (var doc in listIs.docs) {
          interestList
              .add(TypeModel.fromMap(doc.data() as Map<String, dynamic>));
        }
      }

      notifyListeners();
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch getinterestListF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  Future addInterestListF(
      {bool showLoading = false,
      String loadingFor = "",
      required String name}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }
      String id = FirebaseFirestore.instance
          .collection('adminSettings')
          .doc('types')
          .collection('intrests')
          .doc()
          .id;
      TypeModel model =
          TypeModel(id: id, name: name, creationDate: DateTime.now());
      await FirebaseFirestore.instance
          .collection('adminSettings')
          .doc('types')
          .collection('intrests')
          .doc(model.id)
          .set(model.toMap());

      debugPrint("model.toMap() : ${model.toMap()}");
      interestList.add(model);
      getinterestListF();
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch addInterestListF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  Future delInterestListF(
      {bool showLoading = false,
      String loadingFor = "",
      required String docId}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }

      bool check = await FStore().deleteInterest(docId);
      if (check) {
        interestList.removeWhere((e) => e.id == docId);
      }

      notifyListeners();
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch delInterestListF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  /////////////
  // this is same with  TypeModel
  List<TypeModel> languageList = [];
  Future getLanguageListF(
      {bool showLoading = false, String loadingFor = ""}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }

      QuerySnapshot listIs = await FStore().getLanguages().get();
      if (listIs.docs.isNotEmpty) {
        languageList.clear();
        for (var doc in listIs.docs) {
          languageList
              .add(TypeModel.fromMap(doc.data() as Map<String, dynamic>));
        }
      }

      notifyListeners();
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch getLanguageListF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  Future addLanguageListF(
      {bool showLoading = false,
      String loadingFor = "",
      required String name}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }
      String id = FirebaseFirestore.instance
          .collection('adminSettings')
          .doc('types')
          .collection('languages')
          .doc()
          .id;
      TypeModel model =
          TypeModel(id: id, name: name, creationDate: DateTime.now());
      await FirebaseFirestore.instance
          .collection('adminSettings')
          .doc('types')
          .collection('languages')
          .doc(model.id)
          .set(model.toMap());

      debugPrint("model.toMap() : ${model.toMap()}");
      languageList.add(model);
      getLanguageListF();
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch addLanguageListF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  Future delLanguageListF(
      {bool showLoading = false,
      String loadingFor = "",
      required String docId}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }

      bool check = await FStore().deleteLanguage(docId);
      if (check) {
        languageList.removeWhere((e) => e.id == docId);
      }

      notifyListeners();
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch delLanguageListF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  /////////////
  // this is same with  TypeModel
  List<TypeModel> goalsList = [];
  Future getGoalsListF(
      {bool showLoading = false, String loadingFor = ""}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }

      QuerySnapshot listIs = await FStore().getGoals().get();
      if (listIs.docs.isNotEmpty) {
        goalsList.clear();
        for (var doc in listIs.docs) {
          goalsList.add(TypeModel.fromMap(doc.data() as Map<String, dynamic>));
        }
      }

      notifyListeners();
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch getGoalsListF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  Future addGoalsListF(
      {bool showLoading = false,
      String loadingFor = "",
      required String name}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }
      String id = FirebaseFirestore.instance
          .collection('adminSettings')
          .doc('types')
          .collection('goals')
          .doc()
          .id;
      TypeModel model =
          TypeModel(id: id, name: name, creationDate: DateTime.now());
      await FirebaseFirestore.instance
          .collection('adminSettings')
          .doc('types')
          .collection('goals')
          .doc(model.id)
          .set(model.toMap());

      debugPrint("model.toMap() : ${model.toMap()}");
      goalsList.add(model);
      setLoadingF(false);
      // getGoalsListF();
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch addGoalsListF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  Future delGoalsListF(
      {bool showLoading = false,
      String loadingFor = "",
      required String docId}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }

      bool check = await FStore().deleteGoals(docId);
      if (check) {
        goalsList.removeWhere((e) => e.id == docId);
      }

      notifyListeners();
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch delGoalsListF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  // this is same with  TypeModel
  List<FaqModel> faqList = [];
  Future getFaqListF({bool showLoading = false, String loadingFor = ""}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }

      QuerySnapshot listIs = await FStore().getFaqs().get();
      if (listIs.docs.isNotEmpty) {
        faqList.clear();
        for (var doc in listIs.docs) {
          faqList.add(FaqModel.toModel(doc.data() as Map<String, dynamic>));
        }
      }

      notifyListeners();
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch getFaqListF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  Future addFaqListF(
      {bool showLoading = false,
      String loadingFor = "",
      required String question,
      required String answer}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }

      await FStore().addFaq(question, answer).then((v) {
        // if (v != null) {}
        getFaqListF();
      });

      setLoadingF(false);
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch addFaqListF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  Future delFaqListF(
      {bool showLoading = false,
      String loadingFor = "",
      required String docId}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }

      bool check = await FStore().deleteFaq(docId);
      if (check) {
        faqList.removeWhere((e) => e.id == docId);
      }

      notifyListeners();
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 try catch delFaqListF error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

///////////////
}
