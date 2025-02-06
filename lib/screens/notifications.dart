import 'package:admin_panel/const/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../vm/homeVm.dart';
import '../widgets/dotloader.dart';
import '../widgets/minicard.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    syncFirstF();
  }

  @override
  void dispose() {
    super.dispose();
  }

  syncFirstF() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var home = ref.read(homeVm);
      home.selectUserIndexF(0);
      if (home.allUsersList.isEmpty) {
        home
            .getUsersF(context,
                showLoading: true, loadingFor: "users", onlyUsers: true)
            .then((v) {});
      }
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
            Text('Pages / Notifications',
                style: TextStyle(color: Colors.white54, fontSize: 14))
          ]),

          SizedBox(height: h * 0.05),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                            Text("New Notification",
                                style: TextTheme.of(context).labelLarge)
                          ])),
                      Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: TextField(
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
                                hintText: "Title",
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
                      Container(
                          width: double.infinity,
                          // height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: TextField(
                              minLines: 7,
                              maxLines: 11,
                              cursorHeight: 12,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                filled: true,
                                fillColor: Colors.black,
                                // prefixIcon: const Icon(Icons.title,
                                //     color: Colors.white, size: 17),
                                hintText: "Description",
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
                      const SizedBox(height: 30),

                      SizedBox(
                        width: w * 0.3,
                        child: OutlinedButton(
                            onPressed: () {
                              // p.choosFilterOptionsF(gender: 'Female');
                            },
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    width: 1, color: AppColors.textGold)),
                            child: Text("Send Notifications",
                                style: TextTheme.of(context)
                                    .labelSmall!
                                    .copyWith(color: AppColors.textGold))),
                      ),

                      const SizedBox(height: 30),
                    ])),
          ]),
        ]),
      ));
    } catch (e, st) {
      debugPrint("👉 notifications page error : $e, st: $st");
      return const Center(child: DotLoader(color: AppColors.gold));
      // return Center(child: Text("👉 Reload This Page : $e"));
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
