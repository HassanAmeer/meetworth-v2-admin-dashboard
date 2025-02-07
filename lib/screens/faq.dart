import 'package:meetworth_admin/const/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meetworth_admin/vm/typesVm.dart';
import '../vm/homeVm.dart';
import '../widgets/dotloader.dart';
import '../widgets/minicard.dart';

class FaqPages extends ConsumerStatefulWidget {
  const FaqPages({super.key});

  @override
  ConsumerState<FaqPages> createState() => _FaqPagesState();
}

class _FaqPagesState extends ConsumerState<FaqPages> {
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
      var home = ref.read(typesVm);
      if (home.faqList.isEmpty) {
        home.getFaqListF(showLoading: true, loadingFor: "faq").then((v) {});
      }
    });
  }

  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var p = ref.watch(typesVm);
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    try {
      return Scaffold(
          // appBar: AppBar(backgroundColor: Colors.transparent),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
        var isPhone = constraints.maxWidth <= 424;
        var isTablet =
            (constraints.maxWidth >= 424 && constraints.maxWidth <= 1024);
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: isPhone ? 1 : 16.0, vertical: 24.0),
          child: SingleChildScrollView(
            controller: ScrollController(),
            physics: isPhone
                ? const ClampingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              // const DashboardHeader(),

              const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                // SizedBox(height: h * 0.2),
                Text('Pages / FAQ',
                    style: TextStyle(color: Colors.white54, fontSize: 14))
              ]),

              SizedBox(height: h * 0.05),
              Flex(
                  direction: isPhone ? Axis.vertical : Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardWidget(
                        widthRatio: isPhone ? 0.78 : 0.4,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // const SizedBox(height: 25),
                              const SizedBox(height: 10),
                              Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(children: [
                                    Text("FAQ",
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
                                      controller: questionController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 10),
                                        filled: true,
                                        fillColor: Colors.black,
                                        prefixIcon: const Icon(Icons.title,
                                            color: Colors.white, size: 17),
                                        hintText: "Enter Question",
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                      controller: answerController,
                                      cursorColor: Colors.grey,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 10),
                                        filled: true,
                                        fillColor: Colors.black,
                                        // prefixIcon: const Icon(Icons.title,
                                        //     color: Colors.white, size: 17),
                                        hintText: "Enter Answer",
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide.none),
                                      ))),
                              const SizedBox(height: 30),

                              SizedBox(
                                  width: w * 0.3,
                                  child: p.isLoading &&
                                          p.isLoadingFor == "addFaqBtn"
                                      ? const Center(child: DotLoader())
                                      : OutlinedButton(
                                          onPressed: () {
                                            // p.choosFilterOptionsF(gender: 'Female');
                                            p
                                                .addFaqListF(
                                                    question:
                                                        questionController.text,
                                                    answer:
                                                        answerController.text,
                                                    showLoading: true,
                                                    loadingFor: "addFaqBtn")
                                                .then((v) {
                                              questionController.clear();
                                              answerController.clear();
                                            });
                                          },
                                          style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: AppColors.textGold)),
                                          child: Text("Add FAQ",
                                              style: TextTheme.of(context)
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: AppColors
                                                          .textGold)))),
                              const SizedBox(height: 30),
                            ])),
                    CardWidget(
                        widthRatio: isPhone ? 0.78 : 0.35,
                        heightRatio: isPhone ? null : 0.45,
                        child: p.isLoading && p.isLoadingFor == "faq"
                            ? const Center(child: DotLoader())
                            : ListView.separated(
                                shrinkWrap: true,
                                controller: ScrollController(),
                                physics: const BouncingScrollPhysics(
                                    parent: ClampingScrollPhysics()),
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: AppColors.bgField),
                                itemCount: p.faqList.length,
                                itemBuilder: (context, index) {
                                  var data = p.faqList[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: CircleAvatar(
                                                        backgroundColor:
                                                            AppColors.bgColor,
                                                        child: Text(
                                                            "${index + 1}",
                                                            style: TextTheme.of(
                                                                    context)
                                                                .titleMedium)),
                                                  ),
                                                  RichText(
                                                      text: TextSpan(
                                                          text: "Question: ",
                                                          style: TextTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              ?.copyWith(
                                                                  color: AppColors
                                                                      .textGold),
                                                          children: [
                                                        TextSpan(
                                                            text: data.question,
                                                            style: TextTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                ?.copyWith(
                                                                    color: AppColors
                                                                        .gold))
                                                      ])),
                                                  RichText(
                                                      text: TextSpan(
                                                          text: "Answer: ",
                                                          style: TextTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              ?.copyWith(
                                                                  color: AppColors
                                                                      .textLight),
                                                          children: [
                                                        TextSpan(
                                                            text: data.answer,
                                                            style: TextTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                ?.copyWith(
                                                                    color: AppColors
                                                                        .textSilver))
                                                      ]))
                                                ])),
                                        IconButton(
                                            onPressed: () {
                                              p.delFaqListF(
                                                  docId: data.id,
                                                  showLoading: true,
                                                  loadingFor: "$index");
                                            },
                                            icon: p.isLoading &&
                                                    p.isLoadingFor == "$index"
                                                ? const DotLoader(
                                                    color: AppColors
                                                        .pieChartColor2)
                                                : const Icon(Icons.close)),
                                      ],
                                    ),
                                  );
                                }))
                  ]),
            ]),
          ),
        );
      }));
    } catch (e, st) {
      debugPrint("👉 FaqPages page error : $e, st: $st");
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
