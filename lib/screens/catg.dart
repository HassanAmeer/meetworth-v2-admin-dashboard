import 'package:meetworth_admin/const/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../vm/homeVm.dart';
import '../widgets/dotloader.dart';
import '../widgets/minicard.dart';

class CatgPage extends ConsumerStatefulWidget {
  const CatgPage({super.key});

  @override
  ConsumerState<CatgPage> createState() => _CatgPageState();
}

class _CatgPageState extends ConsumerState<CatgPage> {
  TextEditingController nameController = TextEditingController();
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
      if (home.businessCategoryList.isEmpty) {
        home
            .getBusinessCategoryListF(showLoading: true, loadingFor: "catg")
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
            Text('Pages / Category',
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
                                Text("Add Business Category",
                                    style: TextTheme.of(context).labelLarge)
                              ])),
                          Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.all(4),
                              child: TextField(
                                  controller: nameController,
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

                          SizedBox(
                              width: w * 0.3,
                              child: OutlinedButton(
                                  onPressed: () {
                                    p
                                        .addBusinessCategoryListF(
                                            showLoading: true,
                                            loadingFor: 'addCatgBtn',
                                            name: nameController.text)
                                        .then((v) {
                                      nameController.clear();
                                    });
                                  },
                                  style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          width: 1, color: AppColors.textGold)),
                                  child: p.isLoading &&
                                          p.isLoadingFor == "addCatgBtn"
                                      ? const DotLoader()
                                      : Text("Add Category",
                                          style: TextTheme.of(context)
                                              .labelSmall!
                                              .copyWith(
                                                  color: AppColors.textGold)))),

                          const SizedBox(height: 30),
                        ])),
                CardWidget(
                    widthRatio: 0.3,
                    heightRatio: 0.4,
                    child: p.isLoading && p.isLoadingFor == "catg"
                        ? const Center(child: DotLoader())
                        : ListView.separated(
                            shrinkWrap: true,
                            controller: ScrollController(),
                            physics: const BouncingScrollPhysics(
                                parent: ClampingScrollPhysics()),
                            separatorBuilder: (context, index) => const Divider(
                                height: 1,
                                thickness: 1,
                                color: AppColors.bgField),
                            itemCount: p.businessCategoryList.length,
                            itemBuilder: (context, index) {
                              var data = p.businessCategoryList[index];
                              return ListTile(
                                  leading: CircleAvatar(
                                      backgroundColor: AppColors.bgCard,
                                      child: Text("${index + 1}",
                                          style: TextTheme.of(context)
                                              .titleMedium)),
                                  title: Text(data.name,
                                      style: TextTheme.of(context).titleMedium),
                                  trailing: IconButton(
                                      onPressed: () {
                                        p.delBusinessCategoryListF(
                                            docId: data.id,
                                            showLoading: true,
                                            loadingFor: "$index");
                                      },
                                      icon: p.isLoading &&
                                              p.isLoadingFor == "$index"
                                          ? const DotLoader(
                                              color: AppColors.pieChartColor2)
                                          : const Icon(Icons.close)));
                            }))
              ]),
        ]),
      ));
    } catch (e, st) {
      debugPrint("👉 CatgPage page error : $e, st: $st");
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
