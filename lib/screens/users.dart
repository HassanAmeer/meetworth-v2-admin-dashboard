import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:meetworth_admin/const/appColors.dart';
import 'package:meetworth_admin/const/appimages.dart';
import 'package:meetworth_admin/widgets/dotloader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meetworth_admin/widgets/imagePreview.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../vm/homeVm.dart';
import '../widgets/dropdownwidget.dart';
import '../widgets/headers.dart';
import '../widgets/minicard.dart';

class UsersPage extends ConsumerStatefulWidget {
  const UsersPage({super.key});

  @override
  ConsumerState<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends ConsumerState<UsersPage> {
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
      } else if (home.geted13usersList.isEmpty) {
        home.get13UsersF(loadingFor: 'users', showLoading: true);
      }

      // if (home.userFilterIndexFrom == 0) {
      //   home.get13UsersF(loadingFor: 'users', showLoading: true);
      // }
    });
  }

  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var home = ref.read(homeVm);
      // if (home.userFilterIndexFrom == 0) {
      //   home.get13UsersF(loadingFor: 'users', showLoading: true);
      // } else

      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        home.get13UsersF(loadingFor: 'users', showLoading: true);
      }
    });
  }

  TextEditingController queryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var p = ref.watch(homeVm);
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    // var isPhone = w <= 424;
    // try {
    return Scaffold(
        // appBar: AppBar(backgroundColor: Colors.transparent),
        body: ResponsiveSizer(builder: (context, orientation, screenType) {
      var isPhone = Device.screenType == ScreenType.mobile;

      return Padding(
        padding: EdgeInsets.all(isPhone ? 2 : 14),
        child: SingleChildScrollView(
            controller: _scrollController,
            physics:
                const ClampingScrollPhysics(parent: BouncingScrollPhysics()),
            child: Opacity(
              opacity: p.isLoading && p.isLoadingFor == "" ? 0.7 : 1,
              child: Skeletonizer(
                effect: const SoldColorEffect(),
                switchAnimationConfig: const SwitchAnimationConfig(
                  duration: Duration(milliseconds: 800),
                  // layoutBuilder: (currentChild, previousChildren) => ,
                ),
                enableSwitchAnimation: p.isLoading && p.isLoadingFor == "",
                enabled: p.isLoading && p.isLoadingFor == "",
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DashboardHeader(),
                      Flex(
                          direction: isPhone ? Axis.vertical : Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CardWidget(
                                widthRatio: isPhone ? 1 : 0.52,
                                child: Column(children: [
                                  const SizedBox(height: 10),

                                  isPhone
                                      ? Flex(
                                          direction: isPhone
                                              ? Axis.vertical
                                              : Axis.horizontal,
                                          children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text("All Users",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20)),
                                                    OutlinedButton(
                                                        onPressed: () {
                                                          p.downloadUsersCsv(
                                                              loadingFor: 'csv',
                                                              showLoading:
                                                                  true);
                                                        },
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                          side: const BorderSide(
                                                              width: 1,
                                                              color: AppColors
                                                                  .gold),
                                                        ),
                                                        child: p.isLoading &&
                                                                p.isLoadingFor ==
                                                                    'csv'
                                                            ? const DotLoader()
                                                            : Text(
                                                                "Download Users CSV",
                                                                style: TextTheme.of(
                                                                        context)
                                                                    .labelSmall!
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .gold))),
                                                  ]),
                                              Container(
                                                  width:
                                                      isPhone ? w * 0.85 : 200,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  child: TextField(
                                                    controller: queryController,
                                                    onEditingComplete:
                                                        () async {
                                                      p.searchUsersF(
                                                          loadingFor: 'search',
                                                          showLoading: true,
                                                          query: queryController
                                                              .text);
                                                    },
                                                    cursorHeight: 12,
                                                    cursorColor: Colors.grey,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
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
                                                                  AppColors
                                                                      .gold)
                                                          : IconButton(
                                                              onPressed:
                                                                  () async {
                                                                await p.searchUsersF(
                                                                    loadingFor:
                                                                        'search',
                                                                    showLoading:
                                                                        true,
                                                                    query: queryController
                                                                        .text);
                                                              },
                                                              icon: const Icon(
                                                                  Icons.search,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 17),
                                                            ),
                                                      hintText: "Search",
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                    ),
                                                  )),
                                            ])
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                              Row(children: [
                                                const Text("All Users    ",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20)),
                                                p.isLoading &&
                                                        p.isLoadingFor ==
                                                            "clear"
                                                    ? const DotLoader(
                                                        color: AppColors.gold)
                                                    : OutlinedButton(
                                                        onPressed: () {
                                                          p.dropDownUsersFilterF(
                                                              showLoading: true,
                                                              loadingFor:
                                                                  "clear",
                                                              clearAll: true);
                                                        },
                                                        style: OutlinedButton.styleFrom(
                                                            side: const BorderSide(
                                                                width: 1,
                                                                color: AppColors
                                                                    .gold)),
                                                        child: Text(
                                                            "Clear Filter",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .gold))),
                                                const SizedBox(width: 10),
                                                p.isLoading &&
                                                        p.isLoadingFor == "desc"
                                                    ? const DotLoader(
                                                        color: AppColors.gold)
                                                    : OutlinedButton(
                                                        onPressed: () {
                                                          p.decAcUsersF(
                                                              showLoading: true,
                                                              loadingFor:
                                                                  "desc",
                                                              desc: !p
                                                                  .isDecending);
                                                        },
                                                        style: OutlinedButton.styleFrom(
                                                            side: const BorderSide(
                                                                width: 1,
                                                                color: AppColors
                                                                    .gold)),
                                                        child: Text(
                                                            p.isDecending
                                                                ? "Decending"
                                                                : "Ascending",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .gold))),
                                              ]),
                                              Row(children: [
                                                OutlinedButton(
                                                    onPressed: () {
                                                      p.downloadUsersCsv(
                                                          loadingFor: 'csv',
                                                          showLoading: true);
                                                    },
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      side: const BorderSide(
                                                          width: 1,
                                                          color:
                                                              AppColors.gold),
                                                    ),
                                                    child: Text("Download CSV",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .gold))),
                                                const SizedBox(width: 15),
                                                Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    child: TextField(
                                                        controller:
                                                            queryController,
                                                        onEditingComplete:
                                                            () async {
                                                          WidgetsBinding
                                                              .instance
                                                              .addPostFrameCallback(
                                                                  (_) {
                                                            p.searchUsersF(
                                                                loadingFor:
                                                                    'search',
                                                                showLoading:
                                                                    true,
                                                                query:
                                                                    queryController
                                                                        .text);
                                                          });
                                                        },
                                                        cursorHeight: 12,
                                                        cursorColor:
                                                            Colors.grey,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 10),
                                                          filled: true,
                                                          fillColor:
                                                              Colors.black,
                                                          prefixIcon: p.isLoading &&
                                                                  p.isLoadingFor ==
                                                                      "search"
                                                              ? const CircularProgressIndicator
                                                                  .adaptive(
                                                                  strokeWidth:
                                                                      2,
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .gold)
                                                              : IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    await p.searchUsersF(
                                                                        loadingFor:
                                                                            'search',
                                                                        showLoading:
                                                                            true,
                                                                        query: queryController
                                                                            .text);
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .search,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 17),
                                                                ),
                                                          hintText: "Search",
                                                          disabledBorder:
                                                              OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none),
                                                        ))),
                                              ]),
                                            ]),
                                  SizedBox(height: isPhone ? 10 : 0),
                                  isPhone
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                              OutlinedButton(
                                                  onPressed: () {
                                                    p.dropDownUsersFilterF(
                                                        showLoading: true,
                                                        loadingFor: "clear",
                                                        clearAll: true);
                                                  },
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                          side: const BorderSide(
                                                              width: 1,
                                                              color: AppColors
                                                                  .gold)),
                                                  child: Text("Clear Filter",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .gold))),
                                              const SizedBox(width: 10),
                                              p.isLoading &&
                                                      p.isLoadingFor == "desc"
                                                  ? const DotLoader(
                                                      color: AppColors.gold)
                                                  : OutlinedButton(
                                                      onPressed: () {
                                                        p.decAcUsersF(
                                                            showLoading: true,
                                                            loadingFor: "desc",
                                                            desc:
                                                                !p.isDecending);
                                                      },
                                                      style: OutlinedButton.styleFrom(
                                                          side: const BorderSide(
                                                              width: 1,
                                                              color: AppColors
                                                                  .gold)),
                                                      child: Text(
                                                          p.isDecending
                                                              ? "Decending"
                                                              : "Ascending",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .labelSmall!
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .gold))),
                                            ])
                                      : const SizedBox.shrink(),
                                  ///////////////////////////////////////////////////////
                                  SizedBox(
                                    width: isPhone ? w * 1 : w * 0.75,
                                    child: SingleChildScrollView(
                                      controller: ScrollController(),
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                          columnSpacing: isPhone ? 8 : w * 0.02,
                                          // dataRowHeight: 40,
                                          dividerThickness: 0.1,
                                          border: const TableBorder(
                                              horizontalInside: BorderSide.none,
                                              verticalInside: BorderSide.none),
                                          columns: [
                                            const DataColumn(
                                                label: Text('User',
                                                    style: TextStyle(
                                                        fontSize: 11))),
                                            const DataColumn(
                                                label: Text('Email',
                                                    style: TextStyle(
                                                        fontSize: 11))),
                                            DataColumn(
                                                label: p.isLoading &&
                                                        p.isLoadingFor ==
                                                            "Gender"
                                                    ? const Center(
                                                        child: DotLoader())
                                                    : DropDownWidget(
                                                        isPhone: isPhone,
                                                        hint: "Gender",
                                                        onChanged: (value) {
                                                          p.dropDownUsersFilterF(
                                                              showLoading: true,
                                                              loadingFor:
                                                                  "Gender",
                                                              gender: value);
                                                        },
                                                        items: const [
                                                          'Male',
                                                          'Female',
                                                        ],
                                                        selectedValue:
                                                            "${p.dropDownValueGender}",
                                                      )),
                                            const DataColumn(
                                              label: Text('USERNAME',
                                                  style:
                                                      TextStyle(fontSize: 11)),
                                            ),
                                            DataColumn(
                                                label: p.isLoading &&
                                                        p.isLoadingFor ==
                                                            "VERIFICATION"
                                                    ? const Center(
                                                        child: DotLoader())
                                                    : DropDownWidget(
                                                        hint: "VERIFICATION",
                                                        isPhone: isPhone,
                                                        onChanged: (value) {
                                                          p.dropDownUsersFilterF(
                                                              showLoading: true,
                                                              loadingFor:
                                                                  "VERIFICATION",
                                                              verification:
                                                                  value);
                                                        },
                                                        items: const [
                                                          'Verified',
                                                          'Not Verified',
                                                          '⁠Verification Pending'
                                                        ],
                                                        selectedValue:
                                                            "${p.dropDownValueVerification}",
                                                      )),
                                            DataColumn(
                                                label: p.isLoading &&
                                                        p.isLoadingFor ==
                                                            "MEMBERSHIP"
                                                    ? const Center(
                                                        child: DotLoader())
                                                    : DropDownWidget(
                                                        hint: "MEMBERSHIP",
                                                        isPhone: isPhone,
                                                        onChanged: (value) {
                                                          p.dropDownUsersFilterF(
                                                              showLoading: true,
                                                              loadingFor:
                                                                  "MEMBERSHIP",
                                                              membership:
                                                                  value);
                                                        },
                                                        items: const [
                                                          'Free',
                                                          'Silver',
                                                          'Gold'
                                                        ],
                                                        selectedValue:
                                                            "${p.dropDownValueMembership}",
                                                      )),
                                            DataColumn(
                                                label: p.isLoading &&
                                                        p.isLoadingFor ==
                                                            "STATUS"
                                                    ? const Center(
                                                        child: DotLoader())
                                                    : DropDownWidget(
                                                        hint: "STATUS",
                                                        isPhone: isPhone,
                                                        onChanged: (value) {
                                                          p.dropDownUsersFilterF(
                                                              showLoading: true,
                                                              loadingFor:
                                                                  "STATUS",
                                                              status: value);
                                                        },
                                                        items: const [
                                                          'Enabled',
                                                          'Block',
                                                        ],
                                                        selectedValue:
                                                            "${p.dropDownValueStatus}",
                                                      )),
                                            // const DataColumn(
                                            //     label: Text('MEMBERSHIP',
                                            //         style: TextStyle(
                                            //             fontSize: 11))),
                                            // const DataColumn(
                                            //     label: Text('STATUS',
                                            //         style: TextStyle(
                                            //             fontSize: 11))),
                                            // const DataColumn(
                                            //     label: Text('STATUS',
                                            //         style: TextStyle(
                                            //             fontSize: 11))),
                                            const DataColumn(
                                                label: Text('ACTION',
                                                    style: TextStyle(
                                                        fontSize: 11))),
                                          ],
                                          rows: p.geted13usersList.isEmpty
                                              ? []
                                              : List.generate(
                                                  p.geted13usersList.length,
                                                  (index) {
                                                  var user = p.isDecending
                                                      ? p.geted13usersList
                                                          .reversed
                                                          .toList()[index]
                                                      : p.geted13usersList[
                                                          index];
                                                  // var user =
                                                  //     p.geted13usersList[index];
                                                  return DataRow(cells: [
                                                    DataCell(onTap: () {
                                                      imagePreview(context,
                                                          imageUrl: user.image!);
                                                      // p.selectUserIndexF(index,
                                                      //     showLoading: true,
                                                      //     loadingFor:
                                                      //         "selectinguser");
                                                    },
                                                        Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              110),
                                                                  child: CircleAvatar(
                                                                      radius: 14,
                                                                      backgroundColor: AppColors.silverGold,
                                                                      child: ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(110),
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
                                                              SizedBox(
                                                                  width: 67,
                                                                  child: Text(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      "  ${user.firstname!} ${user.lastname!}",
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              10),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .visible,
                                                                      maxLines:
                                                                          3))
                                                            ])),
                                                    DataCell(onTap: () {
                                                      p.selectUserIndexF(index,
                                                          showLoading: true,
                                                          loadingFor:
                                                              "selectinguser");
                                                    },
                                                        SizedBox(
                                                            width: 90,
                                                            child:
                                                                Wrap(children: [
                                                              Text(
                                                                  '${user.email}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          10),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .fade)
                                                            ]))),
                                                    DataCell(onTap: () {
                                                      p.selectUserIndexF(index,
                                                          showLoading: true,
                                                          loadingFor:
                                                              "selectinguser");
                                                    },
                                                        Row(children: [
                                                          Text(
                                                              '${user.gender}  ',
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          Icon(
                                                              user.gender ==
                                                                      'Male'
                                                                  ? Icons.male
                                                                  : Icons
                                                                      .female,
                                                              size: 12),
                                                        ])),
                                                    DataCell(onTap: () {
                                                      p.selectUserIndexF(index,
                                                          showLoading: true,
                                                          loadingFor:
                                                              "selectinguser");
                                                    },
                                                        SizedBox(
                                                            width: 80,
                                                            child: Text(
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                '${user.username}',
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            10),
                                                                overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                maxLines: 3))),
                                                    DataCell(onTap: () {
                                                      p.selectUserIndexF(index,
                                                          showLoading: true,
                                                          loadingFor:
                                                              "selectinguser");
                                                    },
                                                        SizedBox(
                                                            width: 80,
                                                            child: Text(
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                user.varifiedStatus ==
                                                                        0
                                                                    ? "Not Verified "
                                                                    : user.varifiedStatus ==
                                                                            1
                                                                        ? "Verification Pending"
                                                                        : "Verified",
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            10),
                                                                overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                maxLines: 3))),
                                                    DataCell(
                                                      // onTap: () {
                                                      //   p.selectUserIndexF(
                                                      //       index,
                                                      //       showLoading: true,
                                                      //       loadingFor:
                                                      //           "selectinguser");
                                                      // },
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 2),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .silverGold
                                                                  .withOpacity(
                                                                      0.2)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            child: Wrap(
                                                                spacing: 3,
                                                                runSpacing: 3,
                                                                children: [
                                                                  Opacity(
                                                                      opacity: user.membership ==
                                                                              'Free'
                                                                          ? 1
                                                                          : 0.5,
                                                                      child: InkWell(
                                                                          onTap: () {
                                                                            p.setMembershipUserF(
                                                                                uid: user.uid,
                                                                                showLoading: true,
                                                                                membership: 'Free',
                                                                                loadingFor: "membership");
                                                                          },
                                                                          child: Container(
                                                                            decoration:
                                                                                BoxDecoration(color: AppColors.bgColor, borderRadius: BorderRadius.circular(10)),
                                                                            child:
                                                                                const Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                                                                              child: Text('Bronze', style: TextStyle(fontSize: 10, color: Colors.white)),
                                                                            ),
                                                                          ))),
                                                                  Opacity(
                                                                      opacity: user.membership ==
                                                                              'Silver'
                                                                          ? 1
                                                                          : 0.5,
                                                                      child: InkWell(
                                                                          onTap: () {
                                                                            p.setMembershipUserF(
                                                                                uid: user.uid,
                                                                                showLoading: true,
                                                                                membership: 'Silver',
                                                                                loadingFor: "membership");
                                                                          },
                                                                          child: Container(
                                                                            decoration:
                                                                                BoxDecoration(color: AppColors.bgColor, borderRadius: BorderRadius.circular(10)),
                                                                            child:
                                                                                const Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                                                                              child: Text('Silver', style: TextStyle(fontSize: 10, color: Colors.white)),
                                                                            ),
                                                                          ))),
                                                                  Opacity(
                                                                      opacity: user.membership ==
                                                                              'Gold'
                                                                          ? 1
                                                                          : 0.5,
                                                                      child: InkWell(
                                                                          onTap: () {
                                                                            p.setMembershipUserF(
                                                                                uid: user.uid,
                                                                                showLoading: true,
                                                                                membership: "Gold",
                                                                                loadingFor: "membership");
                                                                          },
                                                                          child: Container(
                                                                            decoration:
                                                                                BoxDecoration(color: AppColors.bgColor, borderRadius: BorderRadius.circular(10)),
                                                                            child:
                                                                                const Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                                                                              child: Text('Gold', style: TextStyle(fontSize: 10, color: Colors.white)),
                                                                            ),
                                                                          ))),
                                                                ]),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            InkWell(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              onTap: () {
                                                                p.activeOrBanUserF(
                                                                    showLoading:
                                                                        true,
                                                                    loadingFor:
                                                                        'block',
                                                                    docId: user
                                                                        .uid!,
                                                                    status:
                                                                        false);
                                                              },
                                                              child: Opacity(
                                                                opacity: !user
                                                                        .enable!
                                                                    ? 1
                                                                    : 0.5,
                                                                child: Row(
                                                                    children: [
                                                                      Opacity(
                                                                          opacity: user.enable!
                                                                              ? 0.5
                                                                              : 1,
                                                                          child: const Icon(
                                                                              Icons.cancel,
                                                                              size: 18,
                                                                              color: AppColors.textRed)),
                                                                      p.isLoading &&
                                                                              p.isLoadingFor ==
                                                                                  "block"
                                                                          ? const DotLoader()
                                                                          : const Text(
                                                                              ' Block',
                                                                              style: TextStyle(fontSize: 10))
                                                                    ]),
                                                              ),
                                                            ),
                                                            InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                onTap: () {
                                                                  p.activeOrBanUserF(
                                                                      showLoading:
                                                                          true,
                                                                      loadingFor:
                                                                          'active',
                                                                      docId: user
                                                                          .uid!,
                                                                      status:
                                                                          true);
                                                                },
                                                                child: Opacity(
                                                                  opacity:
                                                                      user.enable!
                                                                          ? 1
                                                                          : 0.5,
                                                                  child: Row(
                                                                      children: [
                                                                        const Icon(
                                                                            Icons
                                                                                .check_circle,
                                                                            size:
                                                                                18,
                                                                            color:
                                                                                AppColors.textGreen),
                                                                        p.isLoading &&
                                                                                p.isLoadingFor == "active"
                                                                            ? const DotLoader()
                                                                            : const Text(' Active', style: TextStyle(fontSize: 10))
                                                                      ]),
                                                                ))
                                                          ]),
                                                    ),
                                                    DataCell(Row(children: [
                                                      InkWell(
                                                          onTap: () {
                                                            showCupertinoDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return CupertinoAlertDialog(
                                                                    title: Text(
                                                                        'Delete This: ${p.geted13usersList[index].username} ?'),
                                                                    actions: [
                                                                      CupertinoButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              const Text('No')),
                                                                      CupertinoButton(
                                                                          onPressed:
                                                                              () {
                                                                            p.deleteUserByUidF(context,
                                                                                showLoading: true,
                                                                                loadingFor: "$index",
                                                                                uid: p.geted13usersList[index].uid);
                                                                          },
                                                                          child: const Text(
                                                                              'yes',
                                                                              style: TextStyle(color: Colors.red))),
                                                                    ],
                                                                    insetAnimationCurve:
                                                                        Curves
                                                                            .slowMiddle,
                                                                    insetAnimationDuration:
                                                                        const Duration(
                                                                            seconds:
                                                                                2),
                                                                  );
                                                                });
                                                            //  if (p
                                                            //     .geted13usersList[
                                                            //         index]
                                                            //     .enable!) {
                                                            //   p.activeOrBanUserF(
                                                            //     showLoading:
                                                            //         true,
                                                            //     loadingFor:
                                                            //         "$index",
                                                            //         docId:  p
                                                            //     .geted13usersList[
                                                            //         index]
                                                            //     .uid,
                                                            //     status: false);
                                                            // }
                                                          },
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: const Icon(
                                                              Icons
                                                                  .delete_outline,
                                                              size: 18,
                                                              color: AppColors
                                                                  .textRed)),
                                                      const SizedBox(width: 7),
                                                      InkWell(
                                                          onTap: () {
                                                            p.selectUserIndexF(
                                                                index,
                                                                showLoading:
                                                                    true,
                                                                loadingFor:
                                                                    "selectinguser");
                                                          },
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Image.asset(
                                                              width: 15,
                                                              AppImages
                                                                  .shareIos))
                                                    ])),
                                                  ]);
                                                })),
                                    ),
                                  ),

                                  p.isLoading && p.isLoadingFor == 'users'
                                      ? const Center(
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, bottom: 20),
                                              child: DotLoader(
                                                  color: AppColors.gold)))
                                      : p.geted13usersList.isEmpty
                                          ? Center(
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: isPhone ? 30 : 200,
                                                      bottom:
                                                          isPhone ? 30 : 200),
                                                  child: const Text("Empty",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .bold))))
                                          : const SizedBox.shrink()
                                ])),
                            Column(children: [
                              // CardWidget(
                              //     padding: const EdgeInsets.all(15),
                              //     widthRatio: isPhone ? 1 : 0.25,
                              //     child: Column(children: [
                              //       Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.center,
                              //           children: [
                              //             const Text("GENDER: ",
                              //                 style: TextStyle(
                              //                     color: AppColors.silverGold)),
                              //             Row(children: [
                              //               Opacity(
                              //                   opacity:
                              //                       p.filteredGender == 'Male'
                              //                           ? 1.0
                              //                           : 0.5,
                              //                   child: OutlinedButton(
                              //                       onPressed: () {
                              //                         p.choosFilterOptionsF(
                              //                             gender: 'Male');
                              //                       },
                              //                       style: OutlinedButton.styleFrom(
                              //                           side: const BorderSide(
                              //                               width: 1,
                              //                               color: AppColors
                              //                                   .textSilver)),
                              //                       child: Text("Male",
                              //                           style: Theme.of(context)
                              //                               .textTheme
                              //                               .labelSmall!
                              //                               .copyWith(
                              //                                   color: AppColors
                              //                                       .textSilver)))),
                              //               const SizedBox(width: 10),
                              //               Opacity(
                              //                   opacity:
                              //                       p.filteredGender == 'Female'
                              //                           ? 1.0
                              //                           : 0.5,
                              //                   child: OutlinedButton(
                              //                       onPressed: () {
                              //                         p.choosFilterOptionsF(
                              //                             gender: 'Female');
                              //                       },
                              //                       style: OutlinedButton.styleFrom(
                              //                           side: const BorderSide(
                              //                               width: 1,
                              //                               color: AppColors
                              //                                   .textSilver)),
                              //                       child: Text("Female",
                              //                           style: Theme.of(context)
                              //                               .textTheme
                              //                               .labelSmall!
                              //                               .copyWith(
                              //                                   color: AppColors
                              //                                       .textSilver))))
                              //             ])
                              //           ]),
                              //       const Row(children: [
                              //         Text("Verifications: ",
                              //             style: TextStyle(
                              //                 color: AppColors.silverGold))
                              //       ]),
                              //       const SizedBox(height: 4),
                              //       Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Opacity(
                              //                 opacity:
                              //                     p.filteredVerfication == 0
                              //                         ? 1.0
                              //                         : 0.5,
                              //                 child: OutlinedButton(
                              //                     onPressed: () {
                              //                       p.choosFilterOptionsF(
                              //                           verfication: 0);
                              //                     },
                              //                     style:
                              //                         OutlinedButton.styleFrom(
                              //                             side: const BorderSide(
                              //                                 width: 1,
                              //                                 color: AppColors
                              //                                     .textSilver)),
                              //                     child: Text("Not Apply",
                              //                         style: TextTheme.of(
                              //                                 context)
                              //                             .labelSmall!
                              //                             .copyWith(
                              //                                 color: AppColors
                              //                                     .textSilver)))),
                              //             Opacity(
                              //                 opacity:
                              //                     p.filteredVerfication == 1
                              //                         ? 1.0
                              //                         : 0.5,
                              //                 child: OutlinedButton(
                              //                     onPressed: () {
                              //                       p.choosFilterOptionsF(
                              //                           verfication: 1);
                              //                     },
                              //                     style:
                              //                         OutlinedButton.styleFrom(
                              //                             side: const BorderSide(
                              //                                 width: 1,
                              //                                 color: AppColors
                              //                                     .textSilver)),
                              //                     child: Text(
                              //                         isPhone
                              //                             ? "Apply"
                              //                             : "Apply for varify ",
                              //                         style: TextTheme.of(
                              //                                 context)
                              //                             .labelSmall!
                              //                             .copyWith(
                              //                                 color: AppColors
                              //                                     .textSilver)))),
                              //             Opacity(
                              //                 opacity:
                              //                     p.filteredVerfication == 2
                              //                         ? 1.0
                              //                         : 0.5,
                              //                 child: OutlinedButton(
                              //                     onPressed: () {
                              //                       p.choosFilterOptionsF(
                              //                           verfication: 2);
                              //                     },
                              //                     style:
                              //                         OutlinedButton.styleFrom(
                              //                             side: const BorderSide(
                              //                                 width: 1,
                              //                                 color: AppColors
                              //                                     .textSilver)),
                              //                     child: Text("Verfied",
                              //                         style: TextTheme.of(
                              //                                 context)
                              //                             .labelSmall!
                              //                             .copyWith(
                              //                                 color: AppColors
                              //                                     .textSilver)))),
                              //           ]),
                              //       const SizedBox(height: 10),
                              //       const Row(children: [
                              //         Text("Membership: ",
                              //             style: TextStyle(
                              //                 color: AppColors.silverGold))
                              //       ]),
                              //       const SizedBox(height: 4),
                              //       Wrap(
                              //           runSpacing: isPhone ? 10 : 5,
                              //           spacing: isPhone ? 10 : 5,
                              //           // mainAxisAlignment:
                              //           // MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Opacity(
                              //                 opacity:
                              //                     p.filteredMembership == 'Free'
                              //                         ? 1.0
                              //                         : 0.5,
                              //                 child: OutlinedButton(
                              //                     onPressed: () {
                              //                       p.choosFilterOptionsF(
                              //                           membership: 'Free');
                              //                     },
                              //                     style:
                              //                         OutlinedButton.styleFrom(
                              //                             side: const BorderSide(
                              //                                 width: 1,
                              //                                 color: AppColors
                              //                                     .textSilver)),
                              //                     child: Text("Free",
                              //                         style: TextTheme.of(
                              //                                 context)
                              //                             .labelSmall!
                              //                             .copyWith(
                              //                                 color: AppColors
                              //                                     .textSilver)))),
                              //             Opacity(
                              //                 opacity: p.filteredMembership ==
                              //                         'Silver'
                              //                     ? 1.0
                              //                     : 0.5,
                              //                 child: OutlinedButton(
                              //                     onPressed: () {
                              //                       p.choosFilterOptionsF(
                              //                           membership: 'Silver');
                              //                     },
                              //                     style:
                              //                         OutlinedButton.styleFrom(
                              //                             side: const BorderSide(
                              //                                 width: 1,
                              //                                 color: AppColors
                              //                                     .textSilver)),
                              //                     child: Text("Silver",
                              //                         style: TextTheme.of(
                              //                                 context)
                              //                             .labelSmall!
                              //                             .copyWith(
                              //                                 color: AppColors
                              //                                     .textSilver)))),
                              //             Opacity(
                              //                 opacity: p.filteredMembership ==
                              //                         'Bronze'
                              //                     ? 1.0
                              //                     : 0.5,
                              //                 child: OutlinedButton(
                              //                     onPressed: () {
                              //                       p.choosFilterOptionsF(
                              //                           membership: 'Bronze');
                              //                     },
                              //                     style:
                              //                         OutlinedButton.styleFrom(
                              //                             side: const BorderSide(
                              //                                 width: 1,
                              //                                 color: AppColors
                              //                                     .textSilver)),
                              //                     child: Text("Bronze",
                              //                         style: TextTheme.of(
                              //                                 context)
                              //                             .labelSmall!
                              //                             .copyWith(
                              //                                 color: AppColors
                              //                                     .textSilver)))),
                              //             Opacity(
                              //                 opacity:
                              //                     p.filteredMembership == 'Gold'
                              //                         ? 1.0
                              //                         : 0.5,
                              //                 child: OutlinedButton(
                              //                     onPressed: () {
                              //                       p.choosFilterOptionsF(
                              //                           membership: 'Gold');
                              //                     },
                              //                     style:
                              //                         OutlinedButton.styleFrom(
                              //                             side: const BorderSide(
                              //                                 width: 1,
                              //                                 color: AppColors
                              //                                     .textSilver)),
                              //                     child: Text("Gold",
                              //                         style: Theme.of(context)
                              //                             .textTheme
                              //                             .labelSmall!
                              //                             .copyWith(
                              //                                 color: AppColors
                              //                                     .textSilver)))),
                              //           ]),
                              //       const SizedBox(height: 20),
                              //       Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.center,
                              //           children: [
                              //             const Text("STATUS: ",
                              //                 style: TextStyle(
                              //                     color: AppColors.silverGold)),
                              //             Row(children: [
                              //               Opacity(
                              //                   opacity: p.filteredStatus
                              //                       ? 1.0
                              //                       : 0.5,
                              //                   child: OutlinedButton(
                              //                       onPressed: () {
                              //                         p.choosFilterOptionsF(
                              //                             status: true);
                              //                       },
                              //                       style: OutlinedButton.styleFrom(
                              //                           side: const BorderSide(
                              //                               width: 1,
                              //                               color: AppColors
                              //                                   .textSilver)),
                              //                       child: Text("Active",
                              //                           style: Theme.of(context)
                              //                               .textTheme
                              //                               .labelSmall!
                              //                               .copyWith(
                              //                                   color: AppColors
                              //                                       .textSilver)))),
                              //               const SizedBox(width: 10),
                              //               Opacity(
                              //                   opacity: !p.filteredStatus
                              //                       ? 1.0
                              //                       : 0.5,
                              //                   child: OutlinedButton(
                              //                       onPressed: () {
                              //                         p.choosFilterOptionsF(
                              //                             status: false);
                              //                       },
                              //                       style: OutlinedButton.styleFrom(
                              //                           side: const BorderSide(
                              //                               width: 1,
                              //                               color: AppColors
                              //                                   .textSilver)),
                              //                       child: Text("Block",
                              //                           style: Theme.of(context)
                              //                               .textTheme
                              //                               .labelSmall!
                              //                               .copyWith(
                              //                                   color: AppColors
                              //                                       .textSilver))))
                              //             ])
                              //           ]),
                              //       const SizedBox(height: 20),
                              //       SizedBox(
                              //         width: w * 0.24,
                              //         child: OutlinedButton(
                              //             onPressed: () {
                              //               p.filterUsersF(
                              //                   showLoading: true,
                              //                   loadingFor: 'filtering');
                              //             },
                              //             style: OutlinedButton.styleFrom(
                              //                 side: const BorderSide(
                              //                     width: 1,
                              //                     color: AppColors.gold)),
                              //             child: p.isLoading &&
                              //                     p.isLoadingFor == "filtering"
                              //                 ? const DotLoader()
                              //                 : Text("Filter",
                              //                     style: TextTheme.of(context)
                              //                         .labelSmall!
                              //                         .copyWith(
                              //                             color:
                              //                                 AppColors.gold))),
                              //       )
                              //     ])),
                              // p.isUsersFiltered
                              //     ? CardWidget(
                              //         padding: EdgeInsets.all(isPhone ? 3 : 15),
                              //         widthRatio: isPhone ? 1 : 0.25,
                              //         child: Column(children: [
                              //           Row(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceBetween,
                              //               children: [
                              //                 p.isLoading &&
                              //                         p.isLoadingFor ==
                              //                             "selectinguser"
                              //                     ? const DotLoader()
                              //                     : const Text("Filters",
                              //                         style: TextStyle(
                              //                             color: Colors.white,
                              //                             fontSize: 20)),
                              //                 OutlinedButton(
                              //                     onPressed: () {},
                              //                     style:
                              //                         OutlinedButton.styleFrom(
                              //                       side: const BorderSide(
                              //                           width: 1,
                              //                           color: AppColors.gold),
                              //                     ),
                              //                     child: Text("Recent Filters",
                              //                         style: TextTheme.of(
                              //                                 context)
                              //                             .labelSmall!
                              //                             .copyWith(
                              //                                 color: AppColors
                              //                                     .gold))),
                              //               ]),
                              //           Row(children: [
                              //             const Text("GENDER: ",
                              //                 style: TextStyle(
                              //                     color: AppColors.silverGold)),
                              //             Row(children: [
                              //               Text(p.filteredGender),
                              //               const SizedBox(width: 5),
                              //               Icon(
                              //                   p.filteredGender == 'Male'
                              //                       ? Icons.male
                              //                       : Icons.female,
                              //                   size: 12)
                              //             ])
                              //           ]),
                              //           const Divider(thickness: 0.1),
                              //           Row(children: [
                              //             const Text("VARIFICATION: ",
                              //                 style: TextStyle(
                              //                     color: AppColors.silverGold)),
                              //             Row(children: [
                              //               Text(p.filteredVerfication == 0
                              //                   ? 'Not Apply'
                              //                   : p.filteredVerfication == 1
                              //                       ? 'Apply'
                              //                       : 'Verified'),
                              //               const SizedBox(width: 5),
                              //               Icon(
                              //                   p.filteredVerfication == 0
                              //                       ? Icons.close
                              //                       : Icons.check,
                              //                   size: 12)
                              //             ])
                              //           ]),
                              //           const Divider(thickness: 0.1),
                              //           Row(children: [
                              //             const Text("MEMBERSHIP: ",
                              //                 style: TextStyle(
                              //                     color: AppColors.silverGold)),
                              //             Text(p.filteredMembership)
                              //           ]),
                              //           const Divider(thickness: 0.1),
                              //           Row(children: [
                              //             const Text("STATUS: ",
                              //                 style: TextStyle(
                              //                     color: AppColors.silverGold)),
                              //             p.filteredStatus
                              //                 ? const Row(children: [
                              //                     Icon(Icons.cancel,
                              //                         color:
                              //                             AppColors.textGreen,
                              //                         size: 12),
                              //                     SizedBox(width: 5),
                              //                     Text("Active"),
                              //                   ])
                              //                 : const Row(children: [
                              //                     Icon(Icons.cancel,
                              //                         color: AppColors.textRed,
                              //                         size: 12),
                              //                     SizedBox(width: 5),
                              //                     Text("Blocked"),
                              //                   ])
                              //           ]),
                              //         ]))
                              //     : const SizedBox.shrink(),

                              // Flex(
                              //     direction:
                              //         isPhone ? Axis.vertical : Axis.horizontal,
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //   p.geted13usersList.isEmpty
                              //       ? const SizedBox.shrink()
                              //       : CardWidget(
                              //           widthRatio: isPhone ? 1 : 0.12,
                              //           padding: const EdgeInsets.all(15),
                              //           child: Column(children: [
                              //             Text("Selection",
                              //                 style: TextTheme.of(context)
                              //                     .headlineSmall),
                              //             ElevatedButton(
                              //                 style:
                              //                     ElevatedButton.styleFrom(
                              //                         backgroundColor:
                              //                             AppColors.gold),
                              //                 onPressed: () {},
                              //                 child: const Text(
                              //                     "Selection is on",
                              //                     style: TextStyle(
                              //                         color:
                              //                             Colors.white))),
                              //           ])),
                              //   p.geted13usersList.isEmpty
                              //       ? const SizedBox.shrink()
                              //       : CardWidget(
                              //           widthRatio: isPhone ? 1 : 0.12,
                              //           padding: const EdgeInsets.all(15),
                              //           child: Column(children: [
                              //             Text("Action",
                              //                 style: TextTheme.of(context)
                              //                     .headlineSmall),
                              //             const SizedBox(height: 12),
                              //             Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment
                              //                         .spaceEvenly,
                              //                 children: [
                              //                   InkWell(
                              //                     borderRadius:
                              //                         BorderRadius.circular(
                              //                             10),
                              //                     onTap: () {
                              //                       p.activeOrBanUserF(
                              //                           showLoading: true,
                              //                           loadingFor: 'block',
                              //                           docId: p
                              //                               .geted13usersList[
                              //                                   p.selectedUserIndex]
                              //                               .uid!,
                              //                           status: false);
                              //                     },
                              //                     child: Opacity(
                              //                       opacity: !p
                              //                               .geted13usersList[
                              //                                   p.selectedUserIndex]
                              //                               .enable!
                              //                           ? 1
                              //                           : 0.5,
                              //                       child: Row(children: [
                              //                         Opacity(
                              //                             opacity: p
                              //                                     .geted13usersList[p
                              //                                         .selectedUserIndex]
                              //                                     .enable!
                              //                                 ? 0.5
                              //                                 : 1,
                              //                             child: const Icon(
                              //                                 Icons.cancel,
                              //                                 size: 18,
                              //                                 color: AppColors
                              //                                     .textRed)),
                              //                         p.isLoading &&
                              //                                 p.isLoadingFor ==
                              //                                     "block"
                              //                             ? const DotLoader()
                              //                             : const Text(
                              //                                 ' Block',
                              //                                 style: TextStyle(
                              //                                     fontSize:
                              //                                         10))
                              //                       ]),
                              //                     ),
                              //                   ),
                              //                   InkWell(
                              //                       borderRadius:
                              //                           BorderRadius
                              //                               .circular(10),
                              //                       onTap: () {
                              //                         p.activeOrBanUserF(
                              //                             showLoading: true,
                              //                             loadingFor:
                              //                                 'active',
                              //                             docId: p
                              //                                 .geted13usersList[
                              //                                     p.selectedUserIndex]
                              //                                 .uid!,
                              //                             status: true);
                              //                       },
                              //                       child: Opacity(
                              //                         opacity: p
                              //                                 .geted13usersList[
                              //                                     p.selectedUserIndex]
                              //                                 .enable!
                              //                             ? 1
                              //                             : 0.5,
                              //                         child: Row(children: [
                              //                           const Icon(
                              //                               Icons
                              //                                   .check_circle,
                              //                               size: 18,
                              //                               color: AppColors
                              //                                   .textGreen),
                              //                           p.isLoading &&
                              //                                   p.isLoadingFor ==
                              //                                       "active"
                              //                               ? const DotLoader()
                              //                               : const Text(
                              //                                   ' Active',
                              //                                   style: TextStyle(
                              //                                       fontSize:
                              //                                           10))
                              //                         ]),
                              //                       ))
                              //                 ]),
                              //           ])),
                              // ]),
                              p.geted13usersList.isEmpty
                                  ? const SizedBox.shrink()
                                  : CardWidget(
                                      padding: const EdgeInsets.all(15),
                                      widthRatio: isPhone ? 1 : 0.25,
                                      child: Column(children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("Filters",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20)),

                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          110),
                                                  child: InkWell(
                                                    onTap: () {
                                                      imagePreview(context,
                                                          imageUrl: p
                                                              .geted13usersList[
                                                                  p.selectedUserIndex]
                                                              .image!);
                                                    },
                                                    child: CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor:
                                                            AppColors
                                                                .silverGold,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      110),
                                                          child: CircleAvatar(
                                                              backgroundColor:
                                                                  AppColors
                                                                      .bgColor,
                                                              radius: 28,
                                                              child: CachedNetworkImage(
                                                                  imageUrl:
                                                                      "${p.geted13usersList[p.selectedUserIndex].image}",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Opacity(
                                                                          opacity:
                                                                              0.5,
                                                                          child: Image.asset(AppImages
                                                                              .profiledarkgold)),
                                                                  progressIndicatorBuilder: (context,
                                                                          url,
                                                                          progress) =>
                                                                      const Center(
                                                                          child: Padding(padding: EdgeInsets.all(5), child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 1))))),
                                                        )),
                                                  )),
                                              // CircleAvatar(
                                              //     radius: 30,
                                              //     backgroundColor:
                                              //         AppColors.gold,
                                              //     child: CircleAvatar(
                                              //         radius: 28,
                                              //         backgroundImage:
                                              //             AssetImage(AppImages
                                              //                 .profile2))),
                                            ]),
                                        Row(children: [
                                          const Text("Name: ",
                                              style: TextStyle(
                                                  color: AppColors.silverGold)),
                                          Text(
                                            " ${p.geted13usersList[p.selectedUserIndex].firstname} ${p.geted13usersList[p.selectedUserIndex].lastname}",
                                          ),
                                        ]),
                                        const SizedBox(height: 7),
                                        Row(children: [
                                          const Text("Username: ",
                                              style: TextStyle(
                                                  color: AppColors.silverGold)),
                                          Text(
                                            "${p.geted13usersList[p.selectedUserIndex].username}",
                                          ),
                                        ]),
                                        const SizedBox(height: 7),
                                        Row(children: [
                                          const Text("Number: ",
                                              style: TextStyle(
                                                  color: AppColors.silverGold)),
                                          Text(
                                              "${p.geted13usersList[p.selectedUserIndex].phone}"),
                                        ]),
                                        const SizedBox(height: 7),
                                        Row(children: [
                                          const Text("Mail: ",
                                              style: TextStyle(
                                                  color: AppColors.silverGold)),
                                          Text(
                                              "${p.geted13usersList[p.selectedUserIndex].email}"),
                                        ]),
                                        const SizedBox(height: 7),
                                        Row(children: [
                                          const Text("Age: ",
                                              style: TextStyle(
                                                  color: AppColors.silverGold)),
                                          Text(
                                              "${p.geted13usersList[p.selectedUserIndex].age}"),
                                        ]),
                                        const SizedBox(height: 30),
                                        const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("Status: ",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .silverGold)),
                                              Text("Manually varified: ",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .silverGold)),
                                              Text("Membership: ",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .silverGold)),
                                            ]),
                                        const SizedBox(height: 10),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              p
                                                      .geted13usersList[
                                                          p.selectedUserIndex]
                                                      .enable!
                                                  ? const Icon(
                                                      Icons.check_circle,
                                                      color:
                                                          AppColors.textGreen,
                                                      size: 20)
                                                  : const Icon(Icons.cancel,
                                                      color: AppColors.textRed,
                                                      size: 20),
                                              p
                                                          .geted13usersList[p
                                                              .selectedUserIndex]
                                                          .varifiedStatus! ==
                                                      3
                                                  ? const Icon(
                                                      Icons.check_circle,
                                                      color:
                                                          AppColors.textGreen,
                                                      size: 20)
                                                  : const Icon(Icons.cancel,
                                                      color: AppColors.textRed,
                                                      size: 20),
                                              p
                                                          .geted13usersList[p
                                                              .selectedUserIndex]
                                                          .membership! !=
                                                      "Free"
                                                  ? const Icon(
                                                      Icons.check_circle,
                                                      color:
                                                          AppColors.textGreen,
                                                      size: 20)
                                                  : const Icon(Icons.cancel,
                                                      color: AppColors.textRed,
                                                      size: 20),
                                            ]),
                                        const Divider(thickness: 0.1),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(children: [
                                                const Text("Membership: ",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          AppColors.silverGold,
                                                    )),
                                                const SizedBox(width: 5),
                                                Text(
                                                    "${p.geted13usersList[p.selectedUserIndex].membership}",
                                                    style: const TextStyle(
                                                        color: AppColors.gold))
                                              ]),
                                              Row(children: [
                                                const Text("Expire Date: ",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: AppColors
                                                            .silverGold)),
                                                const SizedBox(width: 5),

                                                Text(
                                                  p
                                                      .geted13usersList[
                                                          p.selectedUserIndex]
                                                      .deadlinemembership,
                                                )
                                                // int.tryParse(p
                                                //     .geted13usersList[
                                                //         p.selectedUserIndex]
                                                //     .deadlinemembership.toString()) == null
                                                //     ? const Text("Empty",
                                                //         style: TextStyle(
                                                //           color: AppColors.textRed
                                                //         ))
                                                //     : Text("${DateTime.fromMicrosecondsSinceEpoch(int.parse(p
                                                //         .geted13usersList[
                                                //             p.selectedUserIndex]
                                                //         .deadlinemembership.toString()))}"),
                                              ])
                                            ]),
                                        const Divider(thickness: 0.1),
                                        Row(children: [
                                          const Text("Business Type: ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.silverGold,
                                              )),
                                          const SizedBox(width: 5),
                                          Text(
                                              "${p.geted13usersList[p.selectedUserIndex].businessCategory}")
                                        ]),
                                        const Divider(thickness: 0.1),
                                        Row(children: [
                                          const Text("Verification: ",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.silverGold)),
                                          const SizedBox(width: 5),
                                          Text(p
                                                      .geted13usersList[
                                                          p.selectedUserIndex]
                                                      .varifiedStatus ==
                                                  0
                                              ? 'Not Apply'
                                              : p
                                                          .geted13usersList[p
                                                              .selectedUserIndex]
                                                          .varifiedStatus ==
                                                      1
                                                  ? 'Apply'
                                                  : 'Verified'),
                                        ]),
                                        const Divider(thickness: 0.1),
                                        Row(children: [
                                          const Text("Average session time: ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.silverGold,
                                              )),
                                          const SizedBox(width: 5),
                                          Text("${p.sessionDurationOfUser} min")
                                        ]),
                                        const Divider(thickness: 0.1),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(children: [
                                                const Text("Joine: ",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          AppColors.silverGold,
                                                    )),
                                                const SizedBox(width: 5),
                                                Text(
                                                    "${p.geted13usersList[p.selectedUserIndex].accountCreationLocation.isEmpty ? p.geted13usersList[p.selectedUserIndex].country : p.geted13usersList[p.selectedUserIndex].accountCreationLocation}"),
                                                // Text("${p.userJoinedLocation}")
                                                // Text("${(p.getLocationName(p.geted13usersList[p.selectedUserIndex].point!.latitude, p.geted13usersList[ p.selectedUserIndex].point!.longitude))}")
                                              ]),
                                              Row(children: [
                                                const Text(
                                                    "Number of referrals: ",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: AppColors
                                                            .silverGold)),
                                                const SizedBox(width: 5),
                                                Text(
                                                    "${p.geted13usersList[p.selectedUserIndex].referLinkUserCount}"),
                                              ])
                                            ]),
                                        const Divider(thickness: 0.1),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("User Transactions: ",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.silverGold,
                                                  )),
                                              const SizedBox(width: 5),
                                              OutlinedButton(
                                                  onPressed: () {
                                                    p.downloadTransactionsF(
                                                        uid: p
                                                            .geted13usersList[p
                                                                .selectedUserIndex]
                                                            .uid!,
                                                        loadingFor: 'tr',
                                                        showLoading: true);
                                                  },
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                          side: const BorderSide(
                                                              width: 1,
                                                              color: AppColors
                                                                  .gold)),
                                                  child: p.isLoading &&
                                                          p.isLoadingFor == "tr"
                                                      ? const DotLoader()
                                                      : Text("Download CSV",
                                                          style: TextTheme.of(
                                                                  context)
                                                              .labelSmall!
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .gold)))
                                            ]),
                                        const Divider(thickness: 0.1),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  onTap: () async {
                                                    try {
                                                      if (p
                                                          .geted13usersList[p
                                                              .selectedUserIndex]
                                                          .linked!
                                                          .where((element) =>
                                                              element
                                                                  .containsKey(
                                                                      'Twitter'))
                                                          .isEmpty) {
                                                        EasyLoading.showError(
                                                            "Twitter not found");
                                                        return;
                                                      }
                                                      var username = p
                                                          .geted13usersList[p
                                                              .selectedUserIndex]
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
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Image.asset(
                                                          width: 50,
                                                          AppImages.twitter))),
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(20),
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
                                                        .geted13usersList[
                                                            p.selectedUserIndex]
                                                        .linked!
                                                        .firstWhere((element) =>
                                                            element.containsKey(
                                                                'Instagram'))['Instagram'];
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
                                                        const EdgeInsets.all(5),
                                                    child: Image.asset(
                                                        width: 50,
                                                        AppImages.insta)),
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
                                                          "https://" +
                                                              username);
                                                    }
                                                  } catch (e, st) {
                                                    debugPrint(
                                                        "💥 Website error: $e, st:$st");
                                                  }
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Image.asset(
                                                        width: 50,
                                                        AppImages.global)),
                                              ),
                                            ])
                                      ])),
                            ]),
                          ])
                    ]),
              ),
            )),
        // );
        // }
      );
    }));

    // } catch (e, st) {
    //   debugPrint("👉 users page error : $e, st: $st");
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     // p.get13UsersF(loadingFor: 'users', showLoading: true);
    //   });
    //   return const Center(child: DotLoader(color: AppColors.gold));
    //   return Center(child: Text("👉 Reload users Page : $e"));
    // }
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////// This page Widgets ////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
