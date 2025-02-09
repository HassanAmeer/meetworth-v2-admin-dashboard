import 'package:clipboard/clipboard.dart';
import 'package:meetworth_admin/const/appColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../const/appimages.dart';
import '../vm/homeVm.dart';
import '../widgets/dotloader.dart';
import '../widgets/headers.dart';
import '../widgets/minicard.dart';
import '../widgets/mintile.dart';

class VerificatiosPage extends ConsumerStatefulWidget {
  const VerificatiosPage({super.key});

  @override
  ConsumerState<VerificatiosPage> createState() => _VerificatiosPageState();
}

class _VerificatiosPageState extends ConsumerState<VerificatiosPage> {
  @override
  void initState() {
    super.initState();
    syncFirstF();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  syncFirstF() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var home = ref.read(homeVm);
      await home.selectUserIndexF(0);
      if (home.allUsersList.isEmpty) {
        home
            .getUsersF(context,
                showLoading: true, loadingFor: "users", onlyUsers: true)
            .then((v) {});
      }
      if (home.userFilterIndexFrom == 0) {
        home.get13UsersF(loadingFor: 'users', showLoading: true);
      }
      if (home.currentLat != 0) {
        home.getCurrentLocationF();
      }
    });
  }

  final ScrollController _scrollController = ScrollController();
  TextEditingController queryController = TextEditingController();
  TextEditingController iCardDescController = TextEditingController();
  TextEditingController bCardDescController = TextEditingController();

  void _onScroll() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var home = ref.read(homeVm);
      if (home.userFilterIndexFrom == 0) {
        home.get13UsersF(loadingFor: 'users', showLoading: true);
      } else if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        home.get13UsersF(loadingFor: 'users', showLoading: true);
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
          body: ResponsiveSizer(builder: (context, orientation, screenType) {
        var isPhone = Device.screenType == ScreenType.mobile;
        return Padding(
            padding: EdgeInsets.all(isPhone ? 2 : 14),
            child: SingleChildScrollView(
              controller: isPhone ? ScrollController() : _scrollController,
              physics:
                  const ClampingScrollPhysics(parent: BouncingScrollPhysics()),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 30),
                    // Text("Pages/Dashobard", style: TextTheme.of(context).labelLarge),
                    // SizedBox(height: 5),
                    // Text("Dashobard", style: TextTheme.of(context).headlineLarge),

                     DashboardHeader(),
                    SizedBox(
                        height: 70,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              MiniTileCardWidget(
                                  title: Text("Pending Verifications",
                                      style: TextTheme.of(context)
                                          .labelMedium!
                                          .copyWith(
                                              color: AppColors.textSilver)),
                                  trailing: Text(
                                      "${p.allUsersList.where((e) => e.varifiedStatus == 0 || e.varifiedStatus == 1).toList().length}",
                                      style: TextTheme.of(context)
                                          .headlineSmall!)),
                              MiniTileCardWidget(
                                  title: Text("Verified",
                                      style: TextTheme.of(context)
                                          .labelMedium!
                                          .copyWith(
                                              color: AppColors.textSilver)),
                                  trailing: Text(
                                      "${p.allUsersList.where((e) => e.varifiedStatus == 2 || e.varifiedStatus == 3).toList().length}",
                                      style: TextTheme.of(context)
                                          .headlineSmall!)),
                              InkWell(
                                borderRadius: BorderRadius.circular(13),
                                onTap: () {
                                      p.selectUserIndexF(0);
                                      p.getUsersF(context,
                                              showLoading: true, loadingFor: "users", onlyUsers: true)
                                          .then((v) {});
                                      p.get13UsersF(loadingFor: 'users', showLoading: true);
                                    
                                    if (p.currentLat != 0) {
                                      p.getCurrentLocationF();
                                     }
                                },
                                child: CardWidget(
                                    widthRatio: isPhone ? 0.2 : 0.05,
                                    child: p.isLoading && p.isLoadingFor=="users" ? const CircularProgressIndicator.adaptive()  :const Icon(Icons.refresh, size: 20)),
                              )
                            ])),
                    //////////////////
                    Flex(
                        direction: isPhone ? Axis.vertical : Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CardWidget(
                              widthRatio: isPhone ? 1 : 0.3,
                              child: Column(children: [
                                Flex(
                                    direction: isPhone
                                        ? Axis.vertical
                                        : Axis.horizontal,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Users verification",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                      const SizedBox(width: 15),
                                      Container(
                                          width: isPhone ? w * 0.9 : 200,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          padding: const EdgeInsets.all(4),
                                          child: TextField(
                                              cursorHeight: 12,
                                              cursorColor: Colors.grey,
                                              controller: queryController,
                                              onSubmitted: (query) {
                                                p.searchUsersF(
                                                    loadingFor: 'search',
                                                    showLoading: true,
                                                    query:
                                                        queryController.text);
                                              },
                                              onTap: () {
                                                p.searchUsersF(
                                                    loadingFor: 'search',
                                                    showLoading: true,
                                                    query:
                                                        queryController.text);
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 10),
                                                filled: true,
                                                fillColor: Colors.black,
                                                prefixIcon: p.isLoading &&
                                                        p.isLoadingFor ==
                                                            "search"
                                                    ? const CircularProgressIndicator
                                                        .adaptive(
                                                        strokeWidth: 2,
                                                        backgroundColor:
                                                            AppColors.gold)
                                                    : const Icon(Icons.search,
                                                        color: Colors.white,
                                                        size: 17),
                                                hintText: "Search by Username",
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide:
                                                            BorderSide.none),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide:
                                                            BorderSide.none),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide:
                                                            BorderSide.none),
                                              ))),
                                    ]),
                                ///////////////////////////////////////////////////////
                                SizedBox(
                                    width: isPhone ? w * 1 : w * 0.75,
                                    height: isPhone ? h * 0.5 : null,
                                    child: SingleChildScrollView(
                                      controller: isPhone
                                          ? _scrollController
                                          : ScrollController(),
                                      physics: isPhone
                                          ? const ClampingScrollPhysics()
                                          : const NeverScrollableScrollPhysics(),
                                      child: DataTable(
                                          columnSpacing: isPhone ? 10 : 0,
                                          // dataRowHeight: 40,
                                          dividerThickness: 0.1,
                                          border: const TableBorder(
                                              horizontalInside: BorderSide.none,
                                              verticalInside: BorderSide.none),
                                          columns: const [
                                            DataColumn(
                                                label: Text('PICTURE',
                                                    style: TextStyle(
                                                        fontSize: 11))),
                                            DataColumn(
                                                label: Text('NAME',
                                                    style: TextStyle(
                                                        fontSize: 11))),
                                            DataColumn(
                                                label: Text('',
                                                    style: TextStyle(
                                                        fontSize: 11))),
                                          ],
                                          rows: p.geted13usersList.isEmpty
                                              ? []
                                              : List.generate(
                                                  p.geted13usersList.length,
                                                  (index) {
                                                  var user =
                                                      p.geted13usersList[index];

                                                  // p.geted13usersList
                                                  //     .where((e) =>
                                                  //         e.varifiedStatus ==
                                                  //             0 ||
                                                  //         e.varifiedStatus == 1)
                                                  //     .toList()
                                                  //     .length, (index) {
                                                  // var user = p.geted13usersList
                                                  //     .where((e) =>
                                                  //         e.varifiedStatus ==
                                                  //             0 ||
                                                  //         e.varifiedStatus == 1)
                                                  //     .toList()[index];

                                                  return DataRow(cells: [
                                                    DataCell(
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      110),
                                                          child: CircleAvatar(
                                                              radius: 14,
                                                              backgroundColor:
                                                                  AppColors
                                                                      .silverGold,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            110),
                                                                child: CircleAvatar(
                                                                    backgroundColor: AppColors.bgColor,
                                                                    radius: 13,
                                                                    child: CachedNetworkImage(
                                                                        imageUrl: user.image!,
                                                                        fit: BoxFit.cover,
                                                                        errorWidget: (
                                                                          context,
                                                                          url,
                                                                          error,
                                                                        ) =>
                                                                            Opacity(opacity: 0.5, child: Image.asset(AppImages.profiledarkgold)),
                                                                        progressIndicatorBuilder: (context, url, progress) => const Center(child: Padding(padding: EdgeInsets.all(5), child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 1))))),
                                                              ))),
                                                    ),
                                                    DataCell(SizedBox(
                                                        width: 70,
                                                        child: Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            '${user.username}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        10),
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            maxLines: 3))),
                                                    DataCell(OutlinedButton(
                                                        onPressed: () {
                                                          p.selectUserIndexF(
                                                              index);
                                                        },
                                                        style: OutlinedButton.styleFrom(
                                                            side: const BorderSide(
                                                                width: 1,
                                                                color: AppColors
                                                                    .gold)),
                                                        child: Text("Select",
                                                            style: TextTheme.of(
                                                                    context)
                                                                .labelSmall!
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .gold)))),
                                                  ]);
                                                })),
                                    )),
                                p.isLoading && p.isLoadingFor == 'users'
                                    ? const Center(
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 5, bottom: 100),
                                            child: DotLoader(
                                                color: AppColors.gold)))
                                    : p.geted13usersList.isEmpty
                                        ? Center(
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: isPhone ? 20 : 200,
                                                    bottom: isPhone ? 20 : 200),
                                                child: const Text("Empty",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold))))
                                        : const SizedBox.shrink()
                              ])),
                          CardWidget(
                              widthRatio: isPhone ? 1 : 0.23,
                              child: Column(children: [
                                Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.black,
                                        ),
                                        child: CupertinoListTile(
                                            leading: Image.asset(
                                                AppImages.twitter,
                                                width: 30),
                                            title: Text(
                                                p.geted13usersList[p.selectedUserIndex].linked!
                                                        .where((element) =>
                                                            element.containsKey(
                                                                'Twitter'))
                                                        .isEmpty
                                                    ? "Empty"
                                                    : p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .linked!
                                                        .firstWhere((element) =>
                                                            element.containsKey('Twitter'))['Twitter'],
                                                style: const TextStyle(color: AppColors.textSilverDark)),
                                            trailing: Row(children: [
                                              IconButton(
                                                  onPressed: () {
                                                      FlutterClipboard.copy(p.geted13usersList[p.selectedUserIndex].linked!
                                                        .where((element) =>
                                                            element.containsKey(
                                                                'Twitter'))
                                                        .isEmpty
                                                    ? "Empty"
                                                    : p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .linked!
                                                        .firstWhere((element) =>
                                                            element.containsKey('Twitter'))['Twitter'])
                                                        .then((value) {
                                                      EasyLoading.showSuccess(
                                                          "Copied");
                                                    });
                                                  },
                                                  icon: const Icon(
                                                      size: 20, Icons.copy)),
                                              const SizedBox(width: 7),
                                              InkWell(
                                                onTap: () async{
                                                  if(p.geted13usersList[p.selectedUserIndex].linked!
                                                        .where((element) =>
                                                            element.containsKey(
                                                                'Instagram'))
                                                        .isEmpty ) {
                                                      EasyLoading.showError("Empty");
                                                    }else if (!await launchUrl((Uri.parse( p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .linked!
                                                        .firstWhere((element) =>
                                                            element.containsKey('Twitter'))['Twitter'])))) {
                                                            EasyLoading.showError("Failed to launch URL");
                                                          }
                                                },
                                                child: Image.asset(
                                                    width: 20, AppImages.shareIos),
                                              )
                                            ])))),
                                Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.black),
                                        child: CupertinoListTile(
                                            leading: Image.asset(AppImages.insta,
                                                width: 30),
                                            title: Text(
                                                p.geted13usersList[p.selectedUserIndex].linked!
                                                        .where((element) =>
                                                            element.containsKey(
                                                                'Instagram'))
                                                        .isEmpty
                                                    ? "Empty"
                                                    : p.geted13usersList[p.selectedUserIndex].linked!
                                                        .firstWhere((element) =>
                                                            element
                                                                .containsKey('Instagram'))['Instagram'],
                                                style: const TextStyle(color: AppColors.textSilverDark)),
                                            trailing: Row(children: [
                                               IconButton(
                                                  onPressed: () {
                                                      FlutterClipboard.copy(p.geted13usersList[p.selectedUserIndex].linked!
                                                        .where((element) =>
                                                            element.containsKey(
                                                                'Instagram'))
                                                        .isEmpty
                                                    ? "Empty"
                                                    : p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .linked!
                                                        .firstWhere((element) =>
                                                            element.containsKey('Instagram'))['Instagram'])
                                                        .then((value) {
                                                      EasyLoading.showSuccess(
                                                          "Copied");
                                                    });
                                                  },
                                                  icon: const Icon(
                                                      size: 20, Icons.copy)),
                                              const SizedBox(width: 7),
                                              InkWell(
                                                onTap: () async{
                                                        if(p.geted13usersList[p.selectedUserIndex].linked!
                                                        .where((element) =>
                                                            element.containsKey(
                                                                'Instagram'))
                                                        .isEmpty ) {
                                                      EasyLoading.showError("Empty");
                                                    }else if (!await launchUrl((Uri.parse(p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .linked!
                                                        .firstWhere((element) =>
                                                            element.containsKey('Instagram'))['Instagram'])))) {
                                                            EasyLoading.showError("Failed to launch URL");
                                                          }
                                                },
                                                child: Image.asset(
                                                    width: 20, AppImages.shareIos),
                                              )
                                            ])))),
                                Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.black,
                                        ),
                                        child: CupertinoListTile(
                                            leading: Image.asset(
                                                AppImages.global,
                                                width: 30),
                                            title: Text(
                                                p.geted13usersList[p.selectedUserIndex].linked!
                                                        .where((element) =>
                                                            element.containsKey(
                                                                'Website'))
                                                        .isEmpty
                                                    ? "Empty"
                                                    : p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .linked!
                                                        .firstWhere((element) =>
                                                            element.containsKey('Website'))['Website'],
                                                style: const TextStyle(color: AppColors.textSilverDark)),
                                            trailing: Row(children: [
                                               IconButton(
                                                  onPressed: () {
                                                      FlutterClipboard.copy(p.geted13usersList[p.selectedUserIndex].linked!
                                                        .where((element) =>
                                                            element.containsKey(
                                                                'Website'))
                                                        .isEmpty
                                                    ? "Empty"
                                                    : p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .linked!
                                                        .firstWhere((element) =>
                                                            element.containsKey('Website'))['Website'])
                                                        .then((value) {
                                                      EasyLoading.showSuccess(
                                                          "Copied");
                                                    });
                                                  },
                                                  icon: const Icon(
                                                      size: 20, Icons.copy)),
                                              const SizedBox(width: 7),
                                              InkWell(
                                                onTap: () async{
                                         
                                                    if(p.geted13usersList[p.selectedUserIndex].linked!
                                                        .where((element) =>
                                                            element.containsKey(
                                                                'Website'))
                                                        .isEmpty ) {
                                                      EasyLoading.showError("Empty");
                                                    }else if (!await launchUrl((Uri.parse(p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .linked!
                                                        .firstWhere((element) =>
                                                            element.containsKey('Website'))['Website'])))) {
                                                            EasyLoading.showError("Failed to launch URL");
                                                          }
                                                },
                                                child: Image.asset(
                                                    width: 20, AppImages.shareIos),
                                              )
                                            ])))),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      border: Border.all(
                                          width: 1, color: AppColors.gold),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primary
                                              .withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                try {
                                                  if (p
                                                      .geted13usersList[
                                                          p.selectedUserIndex]
                                                      .linked!
                                                      .where((element) =>
                                                          element.containsKey(
                                                              'Twitter'))
                                                      .isEmpty) {
                                                    EasyLoading.showError(
                                                        "Twitter not found");
                                                    return;
                                                  }
                                                  var username = p
                                                      .geted13usersList[
                                                          p.selectedUserIndex]
                                                      .linked!
                                                      .firstWhere((element) =>
                                                          element.containsKey(
                                                              'Twitter'))['Twitter'];
                                                  if (!await launchUrl(
                                                      Uri.parse(
                                                          'https://x.com/' +
                                                              username))) {
                                                    await launchUrlString(
                                                        mode: LaunchMode
                                                            .externalApplication,
                                                        'https://x.com/' +
                                                            username);
                                                  }
                                                } catch (e, st) {
                                                  debugPrint(
                                                      "💥 Twitter error: $e, st:$st");
                                                }
                                              },
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Image.asset(
                                                      AppImages.twitter,
                                                      width: 35)),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                try {
                                                  if (p
                                                      .geted13usersList[
                                                          p.selectedUserIndex]
                                                      .linked!
                                                      .where((element) =>
                                                          element.containsKey(
                                                              'Instagram'))
                                                      .isEmpty) {
                                                    EasyLoading.showError(
                                                        "Instagram not found");
                                                    return;
                                                  }
                                                  var username = p
                                                          .geted13usersList[p
                                                              .selectedUserIndex]
                                                          .linked!
                                                          .firstWhere((element) =>
                                                              element.containsKey(
                                                                  'Instagram'))[
                                                      'Instagram'];
                                                  if (!await launchUrl(Uri.parse(
                                                      'https://www.instagram.com/' +
                                                          username))) {
                                                    await launchUrlString(
                                                        'https://www.instagram.com/' +
                                                            username);
                                                  }
                                                } catch (e, st) {
                                                  debugPrint(
                                                      "💥 Instagram error: $e, st:$st");
                                                }
                                              },
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Image.asset(
                                                      AppImages.insta,
                                                      width: 35)),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                try {
                                                  if (p
                                                      .geted13usersList[
                                                          p.selectedUserIndex]
                                                      .linked!
                                                      .where((element) =>
                                                          element.containsKey(
                                                              'Website'))
                                                      .isEmpty) {
                                                    EasyLoading.showError(
                                                        "Website not found");
                                                    return;
                                                  }
                                                  var username = p
                                                      .geted13usersList[
                                                          p.selectedUserIndex]
                                                      .linked!
                                                      .firstWhere((element) =>
                                                          element.containsKey(
                                                              'Website'))['Website'];
                                                  if (!await launchUrl(
                                                      Uri.parse(username))) {
                                                    await launchUrlString(
                                                        "https://" + username);
                                                  }
                                                } catch (e, st) {
                                                  debugPrint(
                                                      "💥 Website error: $e, st:$st");
                                                }
                                              },
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Image.asset(
                                                      AppImages.global,
                                                      width: 35)),
                                            )
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: CircleAvatar(
                                                          radius: 40,
                                                          backgroundColor:
                                                              AppColors.gold,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                            child: CircleAvatar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .black,
                                                                radius: 38,
                                                                child:
                                                                    CachedNetworkImage(
                                                                        imageUrl: p
                                                                            .geted13usersList[p
                                                                                .selectedUserIndex]
                                                                            .image!,
                                                                        progressIndicatorBuilder: (context,
                                                                                url,
                                                                                downloadProgress) =>
                                                                            CircularProgressIndicator(
                                                                              value: downloadProgress.progress,
                                                                              color: AppColors.gold,
                                                                            ),
                                                                        errorWidget: (context, url, error) => const Icon(
                                                                            Icons
                                                                                .image_not_supported_outlined,
                                                                            color:
                                                                                AppColors.gold))),
                                                          ))),
                                                  Positioned(
                                                      right: 0,
                                                      bottom: 0,
                                                      child: Image.asset(
                                                          width: 40,
                                                          p.geted13usersList[p.selectedUserIndex].membership! ==
                                                                      'Free' ||
                                                                  p
                                                                          .geted13usersList[p
                                                                              .selectedUserIndex]
                                                                          .membership! ==
                                                                      'Bronze'
                                                              ? AppImages.bronze
                                                              : p.geted13usersList[p.selectedUserIndex].membership! ==
                                                                      'Silver'
                                                                  ? AppImages
                                                                      .silver
                                                                  : AppImages
                                                                      .goldcoin))
                                                ]),
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20)),
                                                            border: Border(
                                                              top: BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      AppColors
                                                                          .gold),
                                                              left: BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      AppColors
                                                                          .gold),
                                                              bottom: BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      AppColors
                                                                          .gold),
                                                            )),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Row(children: [
                                                        Image.asset(
                                                            width: 12,
                                                            AppImages.location),
                                                        Text(
                                                          " ${p.geted13usersList[p.selectedUserIndex].country} ",
                                                          style: TextTheme.of(
                                                                  context)
                                                              .labelLarge,
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20)),
                                                            border: Border(
                                                              top: BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      AppColors
                                                                          .gold),
                                                              left: BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      AppColors
                                                                          .gold),
                                                              bottom: BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      AppColors
                                                                          .gold),
                                                            )),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Row(children: [
                                                        Image.asset(
                                                            width: 12,
                                                            AppImages.send),
                                                        Text(p.calculateDistanceInMiles(
                                                            p
                                                                .geted13usersList[p
                                                                    .selectedUserIndex]
                                                                .point!
                                                                .latitude,
                                                            p
                                                                .geted13usersList[
                                                                    p.selectedUserIndex]
                                                                .point!
                                                                .longitude,
                                                            p.currentLat,
                                                            p.currentLon))
                                                        // const Text(" 3,2 KM")
                                                      ]),
                                                    ),
                                                  ),
                                                ]),
                                          ]),
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .username!),
                                                    Image.asset(
                                                        width: 20,
                                                        AppImages.checkGold)
                                                  ]),
                                              const SizedBox(height: 5),
                                              const Row(children: [
                                                Text("Consulting Business ",
                                                    style: TextStyle(
                                                        color: AppColors.gold))
                                              ]),
                                              const SizedBox(height: 5),
                                              Wrap(
                                                  spacing: 5,
                                                  children: [
                                                    Image.asset(AppImages.lang,
                                                        width: 15)
                                                  ]..addAll(
                                                      p
                                                          .geted13usersList[p
                                                              .selectedUserIndex]
                                                          .languages!
                                                          .map((e) => Text(
                                                              " $e" + ',',
                                                              style: TextTheme.of(
                                                                      context)
                                                                  .labelSmall!))
                                                          .toList(),
                                                    )),
                                              // Row(children: [
                                              //   Image.asset(AppImages.lang,
                                              //       width: 15),
                                              //   Text(
                                              //       " ${p.geted13usersList[p.selectedUserIndex].languages!}",
                                              //       // "  Estonian 🇪🇪 • Russian 🇷🇺 • English 🇬🇧 ",
                                              //       style: TextTheme.of(context)
                                              //           .labelSmall!)
                                              // ]),
                                              const SizedBox(height: 5),
                                              Text(
                                                  """${p.geted13usersList[p.selectedUserIndex].bio!} """,
                                                  // """Guiding businesses' success through strategic.| Problem Solver | Empowering Growth 🌱 Let's solve challenges together! 💼 """,
                                                  style: TextTheme.of(context)
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: AppColors
                                                              .textSilverDark)),
                                              const SizedBox(height: 5),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: List.generate(
                                                      p
                                                          .geted13usersList[p
                                                              .selectedUserIndex]
                                                          .galleryImages!
                                                          .length,
                                                      (index) => Expanded(
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: Container(
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color: AppColors
                                                                              .gold),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15)),
                                                                  child: CachedNetworkImage(
                                                                      imageUrl: p.geted13usersList[p.selectedUserIndex].galleryImages![index],
                                                                      progressIndicatorBuilder: (context, url, downloadProgress) => const SizedBox(height: 60, child: DotLoader(color: AppColors.pieChartColor2)),
                                                                      errorWidget: (context, url, error) => Container(
                                                                          decoration: BoxDecoration(color: AppColors.bgColor, borderRadius: BorderRadius.circular(15)),
                                                                          child: const SizedBox(
                                                                              height: 60,
                                                                              child: Icon(
                                                                                Icons.image_not_supported_outlined,
                                                                                color: AppColors.pieChartColor2,
                                                                              ))),
                                                                      fit: BoxFit.cover)))))),
                                              const SizedBox(height: 5),
                                              const Row(
                                                  children: [Text("Goals")]),
                                              const SizedBox(height: 5),
                                              SizedBox(
                                                height: 28,
                                                child: ListView(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    controller:
                                                        ScrollController(),
                                                    children: List.generate(
                                                        p
                                                            .geted13usersList[p
                                                                .selectedUserIndex]
                                                            .goals!
                                                            .length, (index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: AppColors
                                                                        .gold)),
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child: Text(
                                                                    " ${p.geted13usersList[p.selectedUserIndex].goals![index]}",
                                                                    // " 🤝 Find partners",
                                                                    style: TextTheme.of(
                                                                            context)
                                                                        .labelSmall))),
                                                      );
                                                    })),
                                              ),

                                              const SizedBox(height: 10),
                                              const Row(
                                                  children: [Text("Interest")]),
                                              const SizedBox(height: 5),
                                              Wrap(
                                                  direction: Axis.horizontal,
                                                  alignment:
                                                      WrapAlignment.start,
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.start,
                                                  runSpacing: 10,
                                                  spacing: 10,
                                                  children: List.generate(
                                                      p
                                                          .geted13usersList[p
                                                              .selectedUserIndex]
                                                          .interests!
                                                          .length, (index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: AppColors
                                                                      .gold)),
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: Text(
                                                                  " ${p.geted13usersList[p.selectedUserIndex].interests![index]}",
                                                                  style: TextTheme.of(context)
                                                                      .labelSmall))),
                                                    );
                                                  })),

                                              /////////////////
                                            ]),
                                      )
                                    ]),
                                  ),
                                ),
                                //////

                                // const SizedBox(height: 20),
                                // Padding(
                                //   padding: const EdgeInsets.all(10),
                                //   child: Row(children: [
                                //     Opacity(
                                //       opacity: 0.3,
                                //       child: OutlinedButton.icon(
                                //           style: OutlinedButton.styleFrom(
                                //               side: const BorderSide(
                                //                   width: 1,
                                //                   color: AppColors.textGreen)),
                                //           icon: const Icon(Icons.check_circle,
                                //               color: AppColors.textGreen),
                                //           onPressed: () {},
                                //           label: const Text("Valid",
                                //               style: TextStyle(
                                //                   color: AppColors.textGreen))),
                                //     ),
                                //     const SizedBox(width: 10),
                                //     OutlinedButton.icon(
                                //         style: OutlinedButton.styleFrom(
                                //             side: const BorderSide(
                                //                 width: 1,
                                //                 color: AppColors.textRed)),
                                //         icon: const Icon(Icons.cancel,
                                //             color: AppColors.textRed),
                                //         onPressed: () {},
                                //         label: const Text("Invalid",
                                //             style: TextStyle(
                                //                 color: AppColors.textRed)))
                                //   ]),
                                // ),
                                // TextFormField(
                                //   minLines: 3,
                                //   maxLines: 5,
                                //   decoration: InputDecoration(
                                //       fillColor: Colors.black,
                                //       filled: true,
                                //       border: OutlineInputBorder(
                                //           borderSide: BorderSide.none,
                                //           borderRadius:
                                //               BorderRadius.circular(15)),
                                //       hintText: "Reason why it's invalid"),
                                // )
                              ])),
                          Column(children: [
                            CardWidget(
                              widthRatio: isPhone ? 1 : 0.2,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    const Text("Idendity Card"),
                                    const SizedBox(height: 5),
                                    InkWell(
                                      onTap: () async{
                                        if(p
                                                .geted13usersList[
                                                    p.selectedUserIndex]
                                                .file1!
                                                        .isEmpty ) {
                                                      EasyLoading.showError("Empty");
                                                    }else if (!await launchUrl((Uri.parse(p
                                                .geted13usersList[
                                                    p.selectedUserIndex]
                                                .file1!)))) {
                                                            EasyLoading.showError("Failed to Open");
                                                          }
                                      },
                                      child: Container(
                                        width: isPhone ? w * 1 : w * 0.2,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: CachedNetworkImage(
                                            imageUrl: p
                                                .geted13usersList[
                                                    p.selectedUserIndex]
                                                .file1!,
                                            placeholder: (context, url) =>
                                                const Center(child: DotLoader()),
                                            errorWidget: (context, url, error) =>
                                                Center(
                                                    child: SizedBox(
                                                        height: h * 0.15,
                                                        width: isPhone
                                                            ? w * 1
                                                            : w * 0.2,
                                                        child: const Icon(
                                                            Icons
                                                                .image_not_supported_outlined,
                                                            color: AppColors
                                                                .silverGold))),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(children: [
                                        Opacity(
                                          opacity: p
                                                  .geted13usersList[
                                                      p.selectedUserIndex]
                                                  .isValidICard
                                              ? 1
                                              : 0.5,
                                          child: OutlinedButton.icon(
                                              style: OutlinedButton.styleFrom(
                                                  side: const BorderSide(
                                                      width: 1,
                                                      color:
                                                          AppColors.textGreen)),
                                              icon: const Icon(
                                                  Icons.check_circle,
                                                  color: AppColors.textGreen),
                                              onPressed: () {
                                                p.setVerifBoolF(
                                                    docId: p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .uid!,
                                                    verifiedStatus: p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .isValidBCard ? 2: p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .file1!.isEmpty ?   0 : 1,
                                                    isValidICard: true);
                                              },
                                              label: const Text("Valid",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .textGreen))),
                                        ),
                                        const SizedBox(width: 10),
                                        Opacity(
                                          opacity: p
                                                      .geted13usersList[
                                                          p.selectedUserIndex]
                                                      .isValidICard ==
                                                  false
                                              ? 1.0
                                              : 0.3,
                                          child: OutlinedButton.icon(
                                              style: OutlinedButton.styleFrom(
                                                  side: const BorderSide(
                                                      width: 1,
                                                      color:
                                                          AppColors.textRed)),
                                              icon: const Icon(Icons.cancel,
                                                  color: AppColors.textRed),
                                              onPressed: () {
                                                p.setVerifBoolF(
                                                    docId: p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .uid!,
                                                      verifiedStatus:  p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .file1!.isEmpty ?   0 : 1,
                                                    isValidICard: false);
                                              },
                                              label: const Text("Invalid",
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.textRed))),
                                        )
                                      ]),
                                    ),
                                    p.geted13usersList[p.selectedUserIndex]
                                            .iCardDesc.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Text(
                                                "Previously: ${p.geted13usersList[p.selectedUserIndex].iCardDesc}",
                                                style: const TextStyle(
                                                    color: AppColors
                                                        .textSilverDark)),
                                          )
                                        : const SizedBox.shrink(),
                                    TextFormField(
                                        minLines: 2,
                                        maxLines: 3,
                                        controller: iCardDescController,
                                        decoration: InputDecoration(
                                            fillColor: Colors.black,
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            hintText:
                                                "Reason why it's invalid")),
                                  ]),
                            ),
                            const SizedBox(height: 8),
                            CardWidget(
                              widthRatio: isPhone ? 1 : 0.2,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    const Text("Business Registration Proof"),
                                    const SizedBox(height: 8),
                                    InkWell(
                                      onTap: () async{
                                        if(p
                                                .geted13usersList[
                                                    p.selectedUserIndex]
                                                .file2!
                                                        .isEmpty ) {
                                                      EasyLoading.showError("Empty");
                                                    }else if (!await launchUrl((Uri.parse(p
                                                .geted13usersList[
                                                    p.selectedUserIndex]
                                                .file2!)))) {
                                                            EasyLoading.showError("Failed to Open");
                                                          }
                                      },
                                      child: Container(
                                        width: isPhone ? w * 1 : w * 0.2,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: CachedNetworkImage(
                                            imageUrl: p
                                                .geted13usersList[
                                                    p.selectedUserIndex]
                                                .file2!,
                                            placeholder: (context, url) =>
                                                const Center(child: DotLoader()),
                                            errorWidget: (context, url, error) =>
                                                Center(
                                                    child: SizedBox(
                                                        height: h * 0.15,
                                                        width: isPhone
                                                            ? w * 1
                                                            : w * 0.2,
                                                        child: const Icon(
                                                            Icons
                                                                .image_not_supported_outlined,
                                                            color: AppColors
                                                                .silverGold))),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // TextFormField(
                                    //   minLines: 3,
                                    //   maxLines: 5,
                                    //   decoration: InputDecoration(
                                    //       fillColor: Colors.black,
                                    //       filled: true,
                                    //       border: OutlineInputBorder(
                                    //           borderSide: BorderSide.none,
                                    //           borderRadius:
                                    //               BorderRadius.circular(15)),
                                    //       hintText: ""),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(children: [
                                        Opacity(
                                          opacity: p
                                                  .geted13usersList[
                                                      p.selectedUserIndex]
                                                  .isValidBCard
                                              ? 1
                                              : 0.3,
                                          child: OutlinedButton.icon(
                                              style: OutlinedButton.styleFrom(
                                                  side: const BorderSide(
                                                      width: 1,
                                                      color:
                                                          AppColors.textGreen)),
                                              icon: const Icon(
                                                  Icons.check_circle,
                                                  color: AppColors.textGreen),
                                              onPressed: () {
                                                p.setVerifBoolF(
                                                    docId: p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .uid!,
                                                    verifiedStatus: p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .isValidICard ? 2: p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .file1!.isEmpty ? 0 : 1,
                                                    isValidBCard: true);
                                              },
                                              label: const Text("Valid",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .textGreen))),
                                        ),
                                        const SizedBox(width: 10),
                                        Opacity(
                                          opacity: p
                                                      .geted13usersList[
                                                          p.selectedUserIndex]
                                                      .isValidBCard ==
                                                  false
                                              ? 1
                                              : 0.3,
                                          child: OutlinedButton.icon(
                                              style: OutlinedButton.styleFrom(
                                                  side: const BorderSide(
                                                      width: 1,
                                                      color:
                                                          AppColors.textRed)),
                                              icon: const Icon(Icons.cancel,
                                                  color: AppColors.textRed),
                                              onPressed: () {
                                                p.setVerifBoolF(
                                                    docId: p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .uid!,
                                                        verifiedStatus:  p
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .file2!.isEmpty ? 0 : 1,
                                                    isValidBCard: false);
                                              },
                                              label: const Text("Invalid",
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.textRed))),
                                        )
                                      ]),
                                    ),

                                    p.geted13usersList[p.selectedUserIndex]
                                            .bCardDesc.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Text(
                                                "Previously: ${p.geted13usersList[p.selectedUserIndex].bCardDesc}",
                                                style: const TextStyle(
                                                    color: AppColors
                                                        .textSilverDark)),
                                          )
                                        : const SizedBox.shrink(),
                                    TextFormField(
                                        minLines: 2,
                                        maxLines: 3,
                                        controller: bCardDescController,
                                        decoration: InputDecoration(
                                            fillColor: Colors.black,
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            hintText:
                                                "Reason why it's invalid")),
                                  ]),
                            ),
                            CardWidget(
                                widthRatio: isPhone ? 1 : 0.2,
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            p.verifyUsersF(
                                                showLoading: true,
                                                loadingFor: 'verifying',
                                                docId: p
                                                    .geted13usersList[
                                                        p.selectedUserIndex]
                                                    .uid!,
                                                iCardDesc:
                                                    iCardDescController.text,
                                                bCardDesc:
                                                    bCardDescController.text);
                                          },
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        AppColors.gold,
                                                        AppColors.primaryMid
                                                      ])),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 20,
                                                          vertical: 7),
                                                  child: p.isLoading &&
                                                          p.isLoadingFor ==
                                                              'verifying'
                                                      ? const DotLoader(
                                                          color: Colors.white)
                                                      : const Text("Done")))),
                                      InkWell(
                                          onTap: () {
                                            p.selectUserIndexF(0);
                                          },
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  gradient:
                                                      LinearGradient(colors: [
                                                    Colors.black,
                                                    Colors.grey.shade800,
                                                  ])),
                                              child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 7),
                                                  child: Text("Un select")))),
                                    ]))
                          ])
                        ])
                  ]),
            ));
      }));
    } catch (e, st) {
      debugPrint("👉 verifications page error : $e, st: $st");
      p.get13UsersF(loadingFor: 'users', showLoading: true);
      return const Center(child: DotLoader(color: AppColors.gold));
      // return Center(child: Text("👉 Reload users Page : $e"));
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////// This page Widgets //////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////
