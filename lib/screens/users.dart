import 'package:meetworth_admin/const/appColors.dart';
import 'package:meetworth_admin/const/appimages.dart';
import 'package:meetworth_admin/widgets/dotloader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../vm/homeVm.dart';
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

    try {
      return Scaffold(
          // appBar: AppBar(backgroundColor: Colors.transparent),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
        var isPhone = constraints.maxWidth <= 424;
        var isTablet =
            (constraints.maxWidth >= 424 && constraints.maxWidth <= 1024);
        return Padding(
          padding:  EdgeInsets.all(isPhone? 2: 14),
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
                        const DashboardHeader(),
                        Flex(
                            direction:
                                isPhone ? Axis.vertical : Axis.horizontal,
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
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20)),
                                                      OutlinedButton(
                                                          onPressed: () {},
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            side: const BorderSide(
                                                                width: 1,
                                                                color: AppColors
                                                                    .gold),
                                                          ),
                                                          child: Text(
                                                              "Download CSV",
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
                                                                    'users',
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
                                                          prefixIcon:
                                                              IconButton(
                                                            onPressed:
                                                                () async {
                                                              WidgetsBinding
                                                                  .instance
                                                                  .addPostFrameCallback(
                                                                      (_) async {
                                                                await p.searchUsersF(
                                                                    loadingFor:
                                                                        'users',
                                                                    showLoading:
                                                                        true,
                                                                    query: queryController
                                                                        .text);
                                                              });
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
                                                        ))),
                                              ])
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                                const Text("All Users",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20)),
                                                Row(children: [
                                                  OutlinedButton(
                                                      onPressed: () {},
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        side: const BorderSide(
                                                            width: 1,
                                                            color:
                                                                AppColors.gold),
                                                      ),
                                                      child: Text(
                                                          "Download CSV",
                                                          style: TextTheme.of(
                                                                  context)
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
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
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
                                                                      'users',
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
                                                            border: InputBorder
                                                                .none,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        12,
                                                                    vertical:
                                                                        10),
                                                            filled: true,
                                                            fillColor:
                                                                Colors.black,
                                                            prefixIcon:
                                                                IconButton(
                                                              onPressed:
                                                                  () async {
                                                                WidgetsBinding
                                                                    .instance
                                                                    .addPostFrameCallback(
                                                                        (_) async {
                                                                  await p.searchUsersF(
                                                                      loadingFor:
                                                                          'users',
                                                                      showLoading:
                                                                          true,
                                                                      query: queryController
                                                                          .text);
                                                                });
                                                              },
                                                              icon: const Icon(
                                                                  Icons.search,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 17),
                                                            ),
                                                            hintText: "Search",
                                                            disabledBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                            focusedBorder: OutlineInputBorder(
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
                                    ///////////////////////////////////////////////////////
                                    SizedBox(
                                      width: isPhone? w*1: w * 0.75,
                                      child: SingleChildScrollView(
                                        controller: ScrollController(),
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                            columnSpacing: isPhone? 8:  0,
                                            // dataRowHeight: 40,
                                            dividerThickness: 0.1,
                                            border: const TableBorder(
                                                horizontalInside: BorderSide.none,
                                                verticalInside: BorderSide.none),
                                            columns: const [
                                              DataColumn(
                                                  label: Text('User',
                                                      style: TextStyle(
                                                          fontSize: 11))),
                                              DataColumn(
                                                  label: Text('Email',
                                                      style: TextStyle(
                                                          fontSize: 11))),
                                              DataColumn(
                                                  label: Text('Gender',
                                                      style: TextStyle(
                                                          fontSize: 11))),
                                              DataColumn(
                                                  label: Text('USERNAME',
                                                      style: TextStyle(
                                                          fontSize: 11))),
                                              DataColumn(
                                                  label: Text('VERIFICATION',
                                                      style: TextStyle(
                                                          fontSize: 11))),
                                              DataColumn(
                                                  label: Text('MEMBERSHIP',
                                                      style: TextStyle(
                                                          fontSize: 11))),
                                              DataColumn(
                                                  label: Text('STATUS',
                                                      style: TextStyle(
                                                          fontSize: 11))),
                                              DataColumn(
                                                  label: Text('ACTION',
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
                                                    return DataRow(cells: [
                                                      DataCell(onTap: () {
                                                        p.selectUserIndexF(index);
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
                                                                        user
                                                                            .firstname!,
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
                                                        p.selectUserIndexF(index);
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
                                                        p.selectUserIndexF(index);
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
                                                        p.selectUserIndexF(index);
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
                                                        p.selectUserIndexF(index);
                                                      },
                                                          SizedBox(
                                                              width: 80,
                                                              child: Text(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  user.varifiedStatus ==
                                                                          0
                                                                      ? "Not Apply for varify"
                                                                      : user.varifiedStatus ==
                                                                              1
                                                                          ? "Apply for varify"
                                                                          : "Varified",
                                                                  style:
                                                                      const TextStyle(
                                                                          fontSize:
                                                                              10),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .visible,
                                                                  maxLines: 3))),
                                                      DataCell(
                                                        onTap: () {
                                                          p.selectUserIndexF(
                                                              index);
                                                        },
                                                        Text('${user.membership}',
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: user.membership ==
                                                                        'Gold'
                                                                    ? AppColors
                                                                        .gold
                                                                    : user.membership ==
                                                                            'Free'
                                                                        ? AppColors
                                                                            .silverGold
                                                                        : AppColors
                                                                            .pieChartColor2)),
                                                      ),
                                                      DataCell(onTap: () {
                                                        p.selectUserIndexF(index);
                                                      },
                                                          Row(children: [
                                                            InkWell(
                                                                onTap: () {},
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: const Icon(
                                                                    Icons
                                                                        .check_circle,
                                                                    size: 18,
                                                                    color: AppColors
                                                                        .textGreen)),
                                                            Text(
                                                                user.enable!
                                                                    ? 'Active'
                                                                    : 'Blocked',
                                                                style: TextStyle(
                                                                    fontSize: 10,
                                                                    color: user
                                                                            .enable!
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .grey
                                                                            .shade500))
                                                          ])),
                                                      DataCell(onTap: () {
                                                        p.selectUserIndexF(index);
                                                      },
                                                          Row(children: [
                                                            InkWell(
                                                                onTap: () {},
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: const Icon(
                                                                    Icons.cancel,
                                                                    size: 18,
                                                                    color: AppColors
                                                                        .textRed)),
                                                            const SizedBox(
                                                                width: 7),
                                                            InkWell(
                                                                onTap: () {},
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
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
                                            ?  Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: isPhone? 30: 200, bottom: isPhone? 30: 200),
                                                    child: const Text("Empty",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))))
                                            : const SizedBox.shrink()
                                  ])),
                              Column(children: [
                                CardWidget(
                                    padding: const EdgeInsets.all(15),
                                    widthRatio: isPhone? 1: 0.25,
                                    child: Column(children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text("GENDER: ",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.silverGold)),
                                            Row(children: [
                                              Opacity(
                                                  opacity:
                                                      p.filteredGender == 'Male'
                                                          ? 1.0
                                                          : 0.5,
                                                  child: OutlinedButton(
                                                      onPressed: () {
                                                        p.choosFilterOptionsF(
                                                            gender: 'Male');
                                                      },
                                                      style: OutlinedButton.styleFrom(
                                                          side: const BorderSide(
                                                              width: 1,
                                                              color: AppColors
                                                                  .textSilver)),
                                                      child: Text("Male",
                                                          style: TextTheme.of(
                                                                  context)
                                                              .labelSmall!
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .textSilver)))),
                                              const SizedBox(width: 10),
                                              Opacity(
                                                  opacity: p.filteredGender ==
                                                          'Female'
                                                      ? 1.0
                                                      : 0.5,
                                                  child: OutlinedButton(
                                                      onPressed: () {
                                                        p.choosFilterOptionsF(
                                                            gender: 'Female');
                                                      },
                                                      style: OutlinedButton.styleFrom(
                                                          side: const BorderSide(
                                                              width: 1,
                                                              color: AppColors
                                                                  .textSilver)),
                                                      child: Text("Female",
                                                          style: TextTheme.of(
                                                                  context)
                                                              .labelSmall!
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .textSilver))))
                                            ])
                                          ]),
                                      const Row(children: [
                                        Text("Verifications: ",
                                            style: TextStyle(
                                                color: AppColors.silverGold))
                                      ]),
                                      const SizedBox(height: 4),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Opacity(
                                                opacity:
                                                    p.filteredVerfication == 0
                                                        ? 1.0
                                                        : 0.5,
                                                child: OutlinedButton(
                                                    onPressed: () {
                                                      p.choosFilterOptionsF(
                                                          verfication: 0);
                                                    },
                                                    style: OutlinedButton.styleFrom(
                                                        side: const BorderSide(
                                                            width: 1,
                                                            color: AppColors
                                                                .textSilver)),
                                                    child: Text("Not Apply",
                                                        style: TextTheme.of(
                                                                context)
                                                            .labelSmall!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textSilver)))),
                                            Opacity(
                                                opacity:
                                                    p.filteredVerfication == 1
                                                        ? 1.0
                                                        : 0.5,
                                                child: OutlinedButton(
                                                    onPressed: () {
                                                      p.choosFilterOptionsF(
                                                          verfication: 1);
                                                    },
                                                    style: OutlinedButton.styleFrom(
                                                        side: const BorderSide(
                                                            width: 1,
                                                            color: AppColors
                                                                .textSilver)),
                                                    child: Text(
                                                       isPhone? "Apply" : "Apply for varify ",
                                                        style: TextTheme.of(
                                                                context)
                                                            .labelSmall!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textSilver)))),
                                            Opacity(
                                                opacity:
                                                    p.filteredVerfication == 2
                                                        ? 1.0
                                                        : 0.5,
                                                child: OutlinedButton(
                                                    onPressed: () {
                                                      p.choosFilterOptionsF(
                                                          verfication: 2);
                                                    },
                                                    style: OutlinedButton.styleFrom(
                                                        side: const BorderSide(
                                                            width: 1,
                                                            color: AppColors
                                                                .textSilver)),
                                                    child: Text("Verfied",
                                                        style: TextTheme.of(
                                                                context)
                                                            .labelSmall!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textSilver)))),
                                          ]),
                                      const SizedBox(height: 10),
                                      const Row(children: [
                                        Text("Membership: ",
                                            style: TextStyle(
                                                color: AppColors.silverGold))
                                      ]),
                                      const SizedBox(height: 4),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Opacity(
                                                opacity: p.filteredMembership ==
                                                        'Free'
                                                    ? 1.0
                                                    : 0.5,
                                                child: OutlinedButton(
                                                    onPressed: () {
                                                      p.choosFilterOptionsF(
                                                          membership: 'Free');
                                                    },
                                                    style: OutlinedButton.styleFrom(
                                                        side: const BorderSide(
                                                            width: 1,
                                                            color: AppColors
                                                                .textSilver)),
                                                    child: Text("Free",
                                                        style: TextTheme.of(
                                                                context)
                                                            .labelSmall!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textSilver)))),
                                            Opacity(
                                                opacity: p.filteredMembership ==
                                                        'Silver'
                                                    ? 1.0
                                                    : 0.5,
                                                child: OutlinedButton(
                                                    onPressed: () {
                                                      p.choosFilterOptionsF(
                                                          membership: 'Silver');
                                                    },
                                                    style: OutlinedButton.styleFrom(
                                                        side: const BorderSide(
                                                            width: 1,
                                                            color: AppColors
                                                                .textSilver)),
                                                    child: Text("Silver",
                                                        style: TextTheme.of(
                                                                context)
                                                            .labelSmall!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textSilver)))),
                                            Opacity(
                                                opacity: p.filteredMembership ==
                                                        'Bronze'
                                                    ? 1.0
                                                    : 0.5,
                                                child: OutlinedButton(
                                                    onPressed: () {
                                                      p.choosFilterOptionsF(
                                                          membership: 'Bronze');
                                                    },
                                                    style: OutlinedButton.styleFrom(
                                                        side: const BorderSide(
                                                            width: 1,
                                                            color: AppColors
                                                                .textSilver)),
                                                    child: Text("Bronze",
                                                        style: TextTheme.of(
                                                                context)
                                                            .labelSmall!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textSilver)))),
                                            Opacity(
                                                opacity: p.filteredMembership ==
                                                        'Gold'
                                                    ? 1.0
                                                    : 0.5,
                                                child: OutlinedButton(
                                                    onPressed: () {
                                                      p.choosFilterOptionsF(
                                                          membership: 'Gold');
                                                    },
                                                    style: OutlinedButton.styleFrom(
                                                        side: const BorderSide(
                                                            width: 1,
                                                            color: AppColors
                                                                .textSilver)),
                                                    child: Text("Gold",
                                                        style: TextTheme.of(
                                                                context)
                                                            .labelSmall!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textSilver)))),
                                          ]),
                                      const SizedBox(height: 20),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text("STATUS: ",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.silverGold)),
                                            Row(children: [
                                              Opacity(
                                                  opacity: p.filteredStatus
                                                      ? 1.0
                                                      : 0.5,
                                                  child: OutlinedButton(
                                                      onPressed: () {
                                                        p.choosFilterOptionsF(
                                                            status: true);
                                                      },
                                                      style: OutlinedButton.styleFrom(
                                                          side: const BorderSide(
                                                              width: 1,
                                                              color: AppColors
                                                                  .textSilver)),
                                                      child: Text("Active",
                                                          style: TextTheme.of(
                                                                  context)
                                                              .labelSmall!
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .textSilver)))),
                                              const SizedBox(width: 10),
                                              Opacity(
                                                  opacity: !p.filteredStatus
                                                      ? 1.0
                                                      : 0.5,
                                                  child: OutlinedButton(
                                                      onPressed: () {
                                                        p.choosFilterOptionsF(
                                                            status: false);
                                                      },
                                                      style: OutlinedButton.styleFrom(
                                                          side: const BorderSide(
                                                              width: 1,
                                                              color: AppColors
                                                                  .textSilver)),
                                                      child: Text("Block",
                                                          style: TextTheme.of(
                                                                  context)
                                                              .labelSmall!
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .textSilver))))
                                            ])
                                          ]),
                                      const SizedBox(height: 20),
                                      SizedBox(
                                        width: w * 0.24,
                                        child: OutlinedButton(
                                            onPressed: () {
                                              p.filterUsersF();
                                            },
                                            style: OutlinedButton.styleFrom(
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: AppColors.gold)),
                                            child: Text("Filter",
                                                style: TextTheme.of(context)
                                                    .labelSmall!
                                                    .copyWith(
                                                        color:
                                                            AppColors.gold))),
                                      )
                                    ])),
                                p.isUsersFiltered
                                    ? CardWidget(
                                        padding:  EdgeInsets.all( isPhone? 3: 15),
                                        widthRatio: isPhone ? 1:  0.25,
                                        child: Column(children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Filters",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20)),
                                                OutlinedButton(
                                                    onPressed: () {},
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      side: const BorderSide(
                                                          width: 1,
                                                          color:
                                                              AppColors.gold),
                                                    ),
                                                    child: Text(
                                                        "Recent Filters",
                                                        style: TextTheme.of(
                                                                context)
                                                            .labelSmall!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .gold))),
                                              ]),
                                          Row(children: [
                                            const Text("GENDER: ",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.silverGold)),
                                            Row(children: [
                                              Text(p.filteredGender),
                                              const SizedBox(width: 5),
                                              Icon(
                                                  p.filteredGender == 'Male'
                                                      ? Icons.male
                                                      : Icons.female,
                                                  size: 12)
                                            ])
                                          ]),
                                          const Divider(thickness: 0.1),
                                          Row(children: [
                                            const Text("VARIFICATION: ",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.silverGold)),
                                            Row(children: [
                                              Text(p.filteredVerfication == 0
                                                  ? 'Not Apply'
                                                  : p.filteredVerfication == 1
                                                      ? 'Apply'
                                                      : 'Verified'),
                                              const SizedBox(width: 5),
                                              Icon(
                                                  p.filteredVerfication == 0
                                                      ? Icons.close
                                                      : Icons.check,
                                                  size: 12)
                                            ])
                                          ]),
                                          const Divider(thickness: 0.1),
                                          Row(children: [
                                            const Text("MEMBERSHIP: ",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.silverGold)),
                                            Text(p.filteredMembership)
                                          ]),
                                          const Divider(thickness: 0.1),
                                          Row(children: [
                                            const Text("STATUS: ",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.silverGold)),
                                            p.filteredStatus
                                                ? const Row(children: [
                                                    Icon(Icons.cancel,
                                                        color:
                                                            AppColors.textGreen,
                                                        size: 12),
                                                    SizedBox(width: 5),
                                                    Text("Active"),
                                                  ])
                                                : const Row(children: [
                                                    Icon(Icons.cancel,
                                                        color:
                                                            AppColors.textRed,
                                                        size: 12),
                                                    SizedBox(width: 5),
                                                    Text("Blocked"),
                                                  ])
                                          ]),
                                        ]))
                                    : const SizedBox.shrink(),
                                Flex(
                                  direction: isPhone? Axis.vertical: Axis.horizontal,
                                  children: [
                                  CardWidget(
                                      widthRatio: isPhone? 1:  0.12,
                                      padding: const EdgeInsets.all(15),
                                      child: Column(children: [
                                        Text("Selection",
                                            style: TextTheme.of(context)
                                                .headlineSmall),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.gold),
                                            onPressed: () {},
                                            child: const Text("Selection is on",
                                                style: TextStyle(
                                                    color: Colors.white))),
                                      ])),
                                  p.geted13usersList.isEmpty
                                      ? const SizedBox.shrink()
                                      : CardWidget(
                                          widthRatio: isPhone? 1: 0.12,
                                          padding: const EdgeInsets.all(15),
                                          child: Column(children: [
                                            Text("Action",
                                                style: TextTheme.of(context)
                                                    .headlineSmall),
                                            const SizedBox(height: 12),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(children: [
                                                  Opacity(
                                                    opacity: p
                                                            .geted13usersList[p
                                                                .selectedUserIndex]
                                                            .enable!
                                                        ? 1
                                                        : 0.5,
                                                    child: InkWell(
                                                        onTap: () {},
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: const Icon(
                                                            Icons.cancel,
                                                            size: 18,
                                                            color: AppColors
                                                                .textRed)),
                                                  ),
                                                  const Text(' Block',
                                                      style: TextStyle(
                                                          fontSize: 10))
                                                ]),
                                                Row(children: [
                                                  Opacity(
                                                    opacity: p
                                                            .geted13usersList[p
                                                                .selectedUserIndex]
                                                            .enable!
                                                        ? 0.5
                                                        : 1,
                                                    child: InkWell(
                                                        onTap: () {},
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: const Icon(
                                                            Icons.check_circle,
                                                            size: 18,
                                                            color: AppColors
                                                                .textGreen)),
                                                  ),
                                                  const Text(' Unblock',
                                                      style: TextStyle(
                                                          fontSize: 10))
                                                ]),
                                              ],
                                            )
                                          ])),
                                ]),
                                p.geted13usersList.isEmpty
                                    ? const SizedBox.shrink()
                                    : CardWidget(
                                        padding: const EdgeInsets.all(15),
                                        widthRatio: isPhone? 1: 0.25,
                                        child: Column(children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Filters",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20)),
                                                CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor:
                                                        AppColors.gold,
                                                    child: CircleAvatar(
                                                        radius: 28,
                                                        backgroundImage:
                                                            AssetImage(AppImages
                                                                .profile2))),
                                              ]),
                                          Row(children: [
                                            const Text("Name: ",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.silverGold)),
                                            Text(
                                              " ${p.geted13usersList[p.selectedUserIndex].firstname}",
                                            ),
                                          ]),
                                          const SizedBox(height: 7),
                                          Row(children: [
                                            const Text("Username: ",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.silverGold)),
                                            Text(
                                              "${p.geted13usersList[p.selectedUserIndex].username}",
                                            ),
                                          ]),
                                          const SizedBox(height: 7),
                                          Row(children: [
                                            const Text("Number: ",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.silverGold)),
                                            Text(
                                                "${p.geted13usersList[p.selectedUserIndex].phone}"),
                                          ]),
                                          const SizedBox(height: 7),
                                          Row(children: [
                                            const Text("Mail: ",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.silverGold)),
                                            Text(
                                                "${p.geted13usersList[p.selectedUserIndex].email}"),
                                          ]),
                                          const SizedBox(height: 7),
                                          Row(children: [
                                            const Text("Age: ",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.silverGold)),
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
                                                        color:
                                                            AppColors.textRed,
                                                        size: 20),
                                                p
                                                            .geted13usersList[p
                                                                .selectedUserIndex]
                                                            .varifiedStatus! ==
                                                        0
                                                    ? const Icon(
                                                        Icons.check_circle,
                                                        color:
                                                            AppColors.textGreen,
                                                        size: 20)
                                                    : const Icon(Icons.cancel,
                                                        color:
                                                            AppColors.textRed,
                                                        size: 20),
                                                p
                                                            .geted13usersList[p
                                                                .selectedUserIndex]
                                                            .varifiedStatus! ==
                                                        0
                                                    ? const Icon(
                                                        Icons.check_circle,
                                                        color:
                                                            AppColors.textGreen,
                                                        size: 20)
                                                    : const Icon(Icons.cancel,
                                                        color:
                                                            AppColors.textRed,
                                                        size: 20),
                                              ]),
                                          const Divider(thickness: 0.1),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(children: [
                                                  const Text("Membership: ",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: AppColors
                                                            .silverGold,
                                                      )),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                      "${p.geted13usersList[p.selectedUserIndex].membership}",
                                                      style: const TextStyle(
                                                          color:
                                                              AppColors.gold))
                                                ]),
                                                Row(children: [
                                                  const Text("Expire Date: ",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: AppColors
                                                              .silverGold)),
                                                  const SizedBox(width: 5),
                                                  Text(p
                                                      .geted13usersList[
                                                          p.selectedUserIndex]
                                                      .deadlinemembership),
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
                                                    color:
                                                        AppColors.silverGold)),
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
                                            Text(
                                              "${((int.parse(p.geted13usersList[p.selectedUserIndex].monthlyAppUsageInSeconds) / 30) / 60).toStringAsFixed(2)} min",
                                            ),
                                          ]),
                                          const Divider(thickness: 0.1),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(children: [
                                                  const Text("Joine: ",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: AppColors
                                                            .silverGold,
                                                      )),
                                                  const SizedBox(width: 5),
                                                  Text(p
                                                      .geted13usersList[
                                                          p.selectedUserIndex]
                                                      .accountCreationLocation)
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                    "User Transactions: ",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          AppColors.silverGold,
                                                    )),
                                                const SizedBox(width: 5),
                                                OutlinedButton(
                                                    onPressed: () {},
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                            side: const BorderSide(
                                                                width: 1,
                                                                color: AppColors
                                                                    .gold)),
                                                    child: Text("Download CSV",
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
                                                        BorderRadius.circular(
                                                            20),
                                                    onTap: () async {
                                                      try {
                                                        if (p
                                                            .geted13usersList[p
                                                                .selectedUserIndex]
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
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Image.asset(
                                                            width: 50,
                                                            AppImages
                                                                .twitter))),
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
                                                                  'Instagram'))['Instagram'];
                                                      if (!await launchUrl(
                                                          Uri.parse(
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
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Image.asset(
                                                          width: 50,
                                                          AppImages.insta)),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    try {
                                                      if (p
                                                          .geted13usersList[p
                                                              .selectedUserIndex]
                                                          .linked!
                                                          .where((element) =>
                                                              element
                                                                  .containsKey(
                                                                      'Website'))
                                                          .isEmpty) {
                                                        EasyLoading.showError(
                                                            "Website not found");
                                                        return;
                                                      }
                                                      var username = p
                                                          .geted13usersList[p
                                                              .selectedUserIndex]
                                                          .linked!
                                                          .firstWhere((element) =>
                                                              element.containsKey(
                                                                  'Website'))['Website'];
                                                      if (!await launchUrl(
                                                          Uri.parse(
                                                              username))) {
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
                                                          const EdgeInsets.all(
                                                              5),
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
        );
      }));
    } catch (e, st) {
      debugPrint("👉 users page error : $e, st: $st");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        p.get13UsersF(loadingFor: 'users', showLoading: true);
      });
      return const Center(child: DotLoader(color: AppColors.gold));
      return Center(child: Text("👉 Reload users Page : $e"));
    }
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////// This page Widgets ///////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
