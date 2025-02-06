import 'package:admin_panel/const/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../vm/homeVm.dart';
import '../widgets/dotloader.dart';
import '../widgets/minicard.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // syncFirstF();
  }

  @override
  void dispose() {
    super.dispose();
  }

  syncFirstF() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var home = ref.read(homeVm);
      if (home.businessCategoryList.isEmpty) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    var p = ref.watch(homeVm);
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    try {
      return Scaffold(
          // appBar: AppBar(backgroundColor: Colors.transparent),
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          // const DashboardHeader(),

          const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            // SizedBox(height: h * 0.2),
            Text('Pages / Profile',
                style: TextStyle(color: Colors.white54, fontSize: 14))
          ]),

          SizedBox(height: h * 0.05),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardWidget(
                    widthRatio: 0.4,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // const SizedBox(height: 25),
                          const SizedBox(height: 10),
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(children: [
                                Text("Change Password",
                                    style: TextTheme.of(context).labelLarge)
                              ])),
                          Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.all(4),
                              child: TextField(
                                  controller: emailController,
                                  cursorHeight: 12,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    filled: true,
                                    fillColor: Colors.black,
                                    prefixIcon: const Icon(Icons.title,
                                        color: Colors.white, size: 17),
                                    hintText: "Enter Email",
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide.none),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide.none),
                                  ))),
                          // const SizedBox(height: 20),

                          SizedBox(
                              width: w * 0.3,
                              child: OutlinedButton(
                                  onPressed: () {
                                    if (emailController.text !=
                                        "team@meetworth.com") {
                                      EasyLoading.showError("Invalid Email");
                                      return;
                                    }
                                    p
                                        .forgetPassword(
                                            showLoading: true,
                                            loadingFor: 'resetBtn',
                                            email: emailController.text)
                                        .then((v) {
                                      emailController.clear();
                                    });
                                  },
                                  style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          width: 1, color: AppColors.textGold)),
                                  child: p.isLoading &&
                                          p.isLoadingFor == "resetBtn"
                                      ? const DotLoader()
                                      : Text("Reset Password",
                                          style: TextTheme.of(context)
                                              .labelSmall!
                                              .copyWith(
                                                  color: AppColors.textGold)))),

                          const SizedBox(height: 30),
                        ])),
              ]),
        ]),
      ));
    } catch (e, st) {
      debugPrint("👉 ProfilePage page error : $e, st: $st");
      return const Center(child: DotLoader(color: AppColors.gold));
      // return Center(child: Text("👉 Reload this page : $e"));
    }
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////// This page Widgets //////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
