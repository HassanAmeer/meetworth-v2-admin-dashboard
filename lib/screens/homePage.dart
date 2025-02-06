import 'package:meetworth_admin/const/appColors.dart';
import 'package:meetworth_admin/vm/homeVm.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/headers.dart';
import '../widgets/minicard.dart';
import '../widgets/mintile.dart';
import '../widgets/screenTimeWidget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // bool isLoading = true;

  @override
  void initState() {
    super.initState();
    syncFirstF();
  }

  syncFirstF() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeVm).getUsersF(context, showLoading: true);
      ref.read(homeVm).getTransactionsF(context);
      ref.read(homeVm).getAllChatsF(context);
      ref.read(homeVm).getAllPostsCommentsLikesShareF(context);
      ref.read(homeVm).getAllFriendsF(context);
      ref.read(homeVm).getAppInfoListF(context);
      ref.read(homeVm).getFeedBacksF(context, showLoading: true);
    });
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("👉 state: $state");
  }

  @override
  Widget build(BuildContext context) {
    var p = ref.watch(homeVm);
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
        // appBar: AppBar(backgroundColor: Colors.transparent),
        body: Padding(
      padding: const EdgeInsets.all(14),
      child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(parent: BouncingScrollPhysics()),
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
                          const SizedBox(
                              height: 80,
                              child: ScreenTimeSummaryWidget(
                                textStyle: TextStyle(color: Colors.white),
                              )),
                          // SizedBox(height: 30),
                          // Text("Pages/Dashobard", style: TextTheme.of(context).labelLarge),
                          // SizedBox(height: 5),
                          // Text("Dashobard", style: TextTheme.of(context).headlineLarge),

                          const DashboardHeader(),
                          SizedBox(
                              height: 70,
                              child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    const CardWidget(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                          Icon(Icons.calendar_month),
                                          SizedBox(width: 10),
                                          Text("This Month"),
                                        ])),
                                    MiniTileCardWidget(
                                      title: Text("Active Users",
                                          style: TextTheme.of(context)
                                              .labelMedium!
                                              .copyWith(
                                                  color: AppColors.textSilver)),
                                      subtitle: Text("${p.activeUsersPer}%",
                                          style: TextTheme.of(context)
                                              .labelSmall!
                                              .copyWith(
                                                  color: AppColors.textGreen)),
                                      trailing: Text(p.activeUsers,
                                          style: TextTheme.of(context)
                                              .headlineSmall!),
                                    ),
                                    MiniTileCardWidget(
                                      title: Text("Session Duration:",
                                          style: TextTheme.of(context)
                                              .labelMedium!
                                              .copyWith(
                                                  color: AppColors.textSilver)),
                                      subtitle: Text("${p.sessionDurationPer}%",
                                          style: TextTheme.of(context)
                                              .labelSmall!
                                              .copyWith(
                                                  color: AppColors.textGreen)),
                                      trailing: Text(p.sessionDuration,
                                          style: TextTheme.of(context)
                                              .headlineSmall!),
                                    ),
                                    MiniTileCardWidget(
                                      title: Text("Frequency of use:",
                                          style: TextTheme.of(context)
                                              .labelMedium!
                                              .copyWith(
                                                  color: AppColors.textSilver)),
                                      subtitle: Text(
                                          "${p.frequencyOfUsagePer}%",
                                          style: TextTheme.of(context)
                                              .labelSmall!
                                              .copyWith(
                                                  color: AppColors.textGreen)),
                                      trailing: Text(p.frequencyOfUsage,
                                          style: TextTheme.of(context)
                                              .headlineSmall!),
                                    ),
                                    MiniTileCardWidget(
                                      title: Text("Retention Rate:",
                                          style: TextTheme.of(context)
                                              .labelMedium!
                                              .copyWith(
                                                  color: AppColors.textSilver)),
                                      subtitle: Text("${p.reAtentionRatePer}%",
                                          style: TextTheme.of(context)
                                              .labelSmall!
                                              .copyWith(
                                                  color: AppColors.textGreen)),
                                      trailing: Text(p.reAtentionRate,
                                          style: TextTheme.of(context)
                                              .headlineSmall!),
                                    ),
                                    MiniTileCardWidget(
                                        title: Text("Churn Rate:",
                                            style: TextTheme.of(context)
                                                .labelMedium!
                                                .copyWith(
                                                    color:
                                                        AppColors.textSilver)),
                                        subtitle: Text(
                                            int.parse(p.churnRatePer) <= 1
                                                ? '0%'
                                                : '${p.churnRatePer}%',
                                            style: TextTheme.of(context)
                                                .labelSmall!
                                                .copyWith(
                                                    color: int.parse(p.churnRatePer) < 0
                                                        ? AppColors.textGreen
                                                        : AppColors.textRed)),
                                        trailing: Text(p.churnRate,
                                            style: TextTheme.of(context)
                                                .headlineSmall!)),
                                    InkWell(
                                        onTap: () {
                                          p.getLoadingTimeOfAppF(
                                              loadingFor: "refresh");
                                          // p.getAllPostsCommentsLikesShareF(
                                          //     context,
                                          //     showLoading: true,
                                          //     loadingFor: "refresh");
                                        },
                                        borderRadius: BorderRadius.circular(15),
                                        child: CardWidget(
                                            widthRatio: 0.05,
                                            child: p.isLoading &&
                                                    p.isLoadingFor == "refresh"
                                                ? SizedBox(
                                                    child: CircularProgressIndicator
                                                        .adaptive(
                                                            strokeWidth: 2,
                                                            backgroundColor:
                                                                AppColors
                                                                    .primaryMid))
                                                : const Icon(Icons.refresh,
                                                    size: 20)))
                                  ])),
                          //////////////////

                          Wrap(children: [
                            CardWidget(
                                heightRatio: 0.15,
                                widthRatio: 0.33,
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("\$${p.totalTRPrice}",
                                                style: TextTheme.of(context)
                                                    .headlineSmall!),
                                            Row(children: [
                                              Text("Total Income",
                                                  style: TextTheme.of(context)
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: AppColors
                                                              .textSilver)),
                                              Text("  ${p.totalTRRatio}%",
                                                  style: TextTheme.of(context)
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: AppColors
                                                              .textGreen)),
                                            ]),
                                            const Spacer(),
                                            Text("Actually",
                                                style: TextTheme.of(context)
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .textGold)),
                                            const SizedBox(height: 30),
                                            Text("Previously",
                                                style: TextTheme.of(context)
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .textSilver)),
                                            const Spacer(),
                                          ]),
                                      CardWidget(
                                          // heightRatio: 0.15,
                                          widthRatio: 0.22,
                                          child: LineChartWidget(
                                            dataListGold: p.trPaidSumList,
                                            dataListSilver: p.trUnPaidSumList,
                                          )),
                                    ])),
                            CardWidget(
                                widthRatio: 0.2,
                                heightRatio: 0.15,
                                child: Column(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(children: [
                                          Text(
                                              "${p.newUsersListByMonths.fold(0, (sum, e) => sum + int.parse(e.toString()))}",
                                              style: TextTheme.of(context)
                                                  .headlineSmall!),
                                          Text("New Users",
                                              style: TextTheme.of(context)
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: AppColors
                                                          .textSilver)),
                                        ]),
                                        Text(
                                            "  ${(p.allUsersList.length / p.newUsersListByMonths.length).toStringAsFixed(1)}%",
                                            style: TextTheme.of(context)
                                                .labelSmall!
                                                .copyWith(
                                                    color:
                                                        AppColors.textGreen)),
                                      ]),
                                  CardWidget(
                                      heightRatio: 0.1,
                                      child: BarChartWidget(
                                          dataList: p.newUsersListByMonths))
                                ])),
                            CardWidget(
                                widthRatio: 0.21,
                                heightRatio: 0.15,
                                child: Row(children: [
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Memeberships Chart ",
                                            style: TextTheme.of(context)
                                                .labelSmall!
                                                .copyWith()),
                                        Row(children: [
                                          Text("Free: ",
                                              style: TextTheme.of(context)
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: AppColors
                                                          .silverGold)),
                                          Text(
                                              " ${(p.allUsersList.where((e) => e.membership == "Free").length / p.allUsersList.length * 100).toStringAsFixed(1)} %",
                                              style: TextTheme.of(context)
                                                  .labelSmall!),
                                        ]),
                                        Row(children: [
                                          Text("Bronze: ",
                                              style: TextTheme.of(context)
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: AppColors
                                                          .pieChartColor2)),
                                          Text(
                                              " ${(p.allUsersList.where((e) => e.membership == "Bronze").length / p.allUsersList.length * 100).toStringAsFixed(1)} %",
                                              style: TextTheme.of(context)
                                                  .labelSmall!),
                                        ]),
                                        Row(children: [
                                          Text("Silver: ",
                                              style: TextTheme.of(context)
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: AppColors
                                                          .textSilver)),
                                          Text(
                                              " ${(p.allUsersList.where((e) => e.membership == "Silver").length / p.allUsersList.length * 100).toStringAsFixed(1)} %",
                                              style: TextTheme.of(context)
                                                  .labelSmall!),
                                        ]),
                                        Row(children: [
                                          Text("Gold: ",
                                              style: TextTheme.of(context)
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: AppColors.gold)),
                                          Text(
                                              " ${(p.allUsersList.where((e) => e.membership == "Gold").length / p.allUsersList.length * 100).toStringAsFixed(1)} %",
                                              style: TextTheme.of(context)
                                                  .labelSmall!),
                                        ]),
                                        Row(children: [
                                          Text("Paid Memebership: ",
                                              style: TextTheme.of(context)
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: AppColors
                                                          .textSilver)),
                                          Text(
                                              " ${(p.allUsersList.where((e) => e.membership == "Gold" || e.membership == "Silver" || e.membership == "Bronze").length / p.allUsersList.length * 100).toStringAsFixed(1)} %",
                                              style: TextTheme.of(context)
                                                  .labelSmall!),
                                        ]),
                                      ]),
                                  Expanded(
                                      // heightRatio: 0.1,
                                      // widthRatio: 0.2,
                                      child: PieChartWidget(
                                          dataList: p.allUsersList))
                                ])),
                            CardWidget(
                                heightRatio: 0.18,
                                widthRatio: 0.34,
                                child: Row(children: [
                                  SizedBox(
                                    width: w * 0.26,
                                    child: SimpleMap(
                                        instructions: SMapWorld.instructions,
                                        defaultColor: Colors.grey,
                                        colors: SMapWorldColors(
                                          uS: p.allUsersList.any((e) =>
                                                  e.country == "United States")
                                              ? AppColors.gold
                                              : null,

                                          cN: AppColors
                                              .gold, // This makes China green
                                          iN: AppColors
                                              .gold, // This makes Russia green
                                          aF: p.allUsersList.any((e) =>
                                                  e.country == "Afghanistan")
                                              ? AppColors.gold
                                              : null,
                                          aL: p.allUsersList.any(
                                                  (e) => e.country == "Albania")
                                              ? AppColors.gold
                                              : null,
                                          dZ: p.allUsersList.any(
                                                  (e) => e.country == "Algeria")
                                              ? AppColors.gold
                                              : null,
                                          aO: p.allUsersList.any(
                                                  (e) => e.country == "Angola")
                                              ? AppColors.gold
                                              : null,
                                          aR: p.allUsersList.any((e) =>
                                                  e.country == "Argentina")
                                              ? AppColors.gold
                                              : null,
                                          aM: p.allUsersList.any(
                                                  (e) => e.country == "Armenia")
                                              ? AppColors.gold
                                              : null,
                                          aW: p.allUsersList.any(
                                                  (e) => e.country == "Aruba")
                                              ? AppColors.gold
                                              : null,
                                          aU: p.allUsersList.any((e) =>
                                                  e.country == "Australia")
                                              ? AppColors.gold
                                              : null,
                                          aT: p.allUsersList.any(
                                                  (e) => e.country == "Austria")
                                              ? AppColors.gold
                                              : null,
                                          aZ: p.allUsersList.any((e) =>
                                                  e.country == "Azerbaijan")
                                              ? AppColors.gold
                                              : null,
                                          bS: p.allUsersList.any(
                                                  (e) => e.country == "Bahamas")
                                              ? AppColors.gold
                                              : null,
                                          bH: p.allUsersList.any(
                                                  (e) => e.country == "Bahrain")
                                              ? AppColors.gold
                                              : null,
                                          bD: p.allUsersList.any((e) =>
                                                  e.country == "Bangladesh")
                                              ? AppColors.gold
                                              : null,
                                          bB: p.allUsersList.any((e) =>
                                                  e.country == "Barbados")
                                              ? AppColors.gold
                                              : null,
                                          bY: p.allUsersList.any(
                                                  (e) => e.country == "Belarus")
                                              ? AppColors.gold
                                              : null,
                                          bE: p.allUsersList.any(
                                                  (e) => e.country == "Belgium")
                                              ? AppColors.gold
                                              : null,
                                          bZ: p.allUsersList.any(
                                                  (e) => e.country == "Belize")
                                              ? AppColors.gold
                                              : null,
                                          bJ: p.allUsersList.any(
                                                  (e) => e.country == "Benin")
                                              ? AppColors.gold
                                              : null,
                                          bO: p.allUsersList.any(
                                                  (e) => e.country == "Bolivia")
                                              ? AppColors.gold
                                              : null,
                                          bA: p.allUsersList.any((e) =>
                                                  e.country ==
                                                  "Bosnia and Herzegovina")
                                              ? AppColors.gold
                                              : null,
                                          bW: p.allUsersList.any((e) =>
                                                  e.country == "Botswana")
                                              ? AppColors.gold
                                              : null,
                                          bR: p.allUsersList.any(
                                                  (e) => e.country == "Brazil")
                                              ? AppColors.gold
                                              : null,
                                          bN: p.allUsersList.any(
                                                  (e) => e.country == "Brunei")
                                              ? AppColors.gold
                                              : null,
                                          bG: p.allUsersList.any((e) =>
                                                  e.country == "Bulgaria")
                                              ? AppColors.gold
                                              : null,
                                          bF: p.allUsersList.any((e) =>
                                                  e.country == "Burkina Faso")
                                              ? AppColors.gold
                                              : null,
                                          bI: p.allUsersList.any(
                                                  (e) => e.country == "Burundi")
                                              ? AppColors.gold
                                              : null,
                                          kH: p.allUsersList.any((e) =>
                                                  e.country == "Cambodia")
                                              ? AppColors.gold
                                              : null,
                                          cM: p.allUsersList.any((e) =>
                                                  e.country == "Cameroon")
                                              ? AppColors.gold
                                              : null,
                                          cA: p.allUsersList.any(
                                                  (e) => e.country == "Canada")
                                              ? AppColors.gold
                                              : null,
                                          cV: p.allUsersList.any((e) =>
                                                  e.country == "Cape Verde")
                                              ? AppColors.gold
                                              : null,
                                          cF: p.allUsersList.any((e) =>
                                                  e.country ==
                                                  "Central African Republic")
                                              ? AppColors.gold
                                              : null,
                                          tD: p.allUsersList.any(
                                                  (e) => e.country == "Chad")
                                              ? AppColors.gold
                                              : null,
                                          cL: p.allUsersList.any(
                                                  (e) => e.country == "Chile")
                                              ? AppColors.gold
                                              : null,

                                          pK: p.allUsersList.any((e) =>
                                                  e.country == "Pakistan")
                                              ? AppColors.gold
                                              : null,

                                          mY: p.allUsersList.any((e) =>
                                                  e.country == "Malaysia")
                                              ? AppColors.gold
                                              : null,
                                          pL: p.allUsersList.any(
                                                  (e) => e.country == "Poland")
                                              ? AppColors.gold
                                              : null,
                                          aE: p.allUsersList.any((e) =>
                                                  e.country ==
                                                  "United Arab Emirates")
                                              ? AppColors.gold
                                              : null,
                                          mX: p.allUsersList.any(
                                                  (e) => e.country == "Mexico")
                                              ? AppColors.gold
                                              : null,
                                          lV: p.allUsersList.any(
                                                  (e) => e.country == "Latvia")
                                              ? AppColors.gold
                                              : null,
                                          dK: p.allUsersList.any(
                                                  (e) => e.country == "Denmark")
                                              ? AppColors.gold
                                              : null,
                                          fR: p.allUsersList.any(
                                                  (e) => e.country == "France")
                                              ? AppColors.gold
                                              : null,

                                          tN: p.allUsersList.any(
                                                  (e) => e.country == "Tunisia")
                                              ? AppColors.gold
                                              : null,
                                          iE: p.allUsersList.any(
                                                  (e) => e.country == "Ireland")
                                              ? AppColors.gold
                                              : null,
                                          eS: p.allUsersList.any(
                                                  (e) => e.country == "Spain")
                                              ? AppColors.gold
                                              : null,
                                          eE: p.allUsersList.any(
                                                  (e) => e.country == "Estonia")
                                              ? AppColors.gold
                                              : null,
                                          cY: p.allUsersList.any(
                                                  (e) => e.country == "Cyprus")
                                              ? AppColors.gold
                                              : null,
                                          sE: p.allUsersList.any(
                                                  (e) => e.country == "Sweden")
                                              ? AppColors.gold
                                              : null,
                                          uA: p.allUsersList.any(
                                                  (e) => e.country == "Ukraine")
                                              ? AppColors.gold
                                              : null,
                                          pT: p.allUsersList.any((e) =>
                                                  e.country == "Portugal")
                                              ? AppColors.gold
                                              : null,
                                          tR: p.allUsersList.any(
                                                  (e) => e.country == "Türkiye")
                                              ? AppColors.gold
                                              : null,
                                          pY: p.allUsersList.any((e) =>
                                                  e.country == "Paraguay")
                                              ? AppColors.gold
                                              : null,
                                          iT: p.allUsersList.any(
                                                  (e) => e.country == "Italy")
                                              ? AppColors.gold
                                              : null,

                                          nG: p.allUsersList.any(
                                                  (e) => e.country == "Nigeria")
                                              ? AppColors.gold
                                              : null,
                                          lT: p.allUsersList.any((e) =>
                                                  e.country == "Lithuania")
                                              ? AppColors.gold
                                              : null,
                                          uG: p.allUsersList.any(
                                                  (e) => e.country == "Uganda")
                                              ? AppColors.gold
                                              : null,
                                          kE: p.allUsersList.any(
                                                  (e) => e.country == "Kenya")
                                              ? AppColors.gold
                                              : null,
                                          tZ: p.allUsersList.any((e) =>
                                                  e.country == "Tanzania")
                                              ? AppColors.gold
                                              : null,
                                          cG: p.allUsersList.any((e) =>
                                                  e.country == "Congo Republic")
                                              ? AppColors.gold
                                              : null,
                                          iQ: p.allUsersList.any(
                                                  (e) => e.country == "Iraq")
                                              ? AppColors.gold
                                              : null,
                                          nO: p.allUsersList.any(
                                                  (e) => e.country == "Norway")
                                              ? AppColors.gold
                                              : null,
                                          iD: p.allUsersList.any((e) =>
                                                  e.country == "Indonesia")
                                              ? AppColors.gold
                                              : null,
                                          tH: p.allUsersList.any((e) =>
                                                  e.country == "Thailand")
                                              ? AppColors.gold
                                              : null,
                                          cO: p.allUsersList.any((e) =>
                                                  e.country == "Colombia")
                                              ? AppColors.gold
                                              : null,
                                          nL: p.allUsersList.any((e) =>
                                                  e.country ==
                                                  "The Netherlands")
                                              ? AppColors.gold
                                              : null,
                                          rU: p.allUsersList.any(
                                                  (e) => e.country == "Russia")
                                              ? AppColors.gold
                                              : null,
                                          pE: p.allUsersList.any(
                                                  (e) => e.country == "Peru")
                                              ? AppColors.gold
                                              : null,
                                          jP: p.allUsersList.any(
                                                  (e) => e.country == "Japan")
                                              ? AppColors.gold
                                              : null,
                                          nA: p.allUsersList.any(
                                                  (e) => e.country == "Namibia")
                                              ? AppColors.gold
                                              : null,

                                          zA: p.allUsersList.any((e) =>
                                                  e.country == "South Africa")
                                              ? AppColors.gold
                                              : null,
                                          mA: p.allUsersList.any(
                                                  (e) => e.country == "Morocco")
                                              ? AppColors.gold
                                              : null,

                                          dE: p.allUsersList.any(
                                                  (e) => e.country == "Germany")
                                              ? AppColors.gold
                                              : null,
                                          lY: p.allUsersList.any(
                                                  (e) => e.country == "Libya")
                                              ? AppColors.gold
                                              : null,
                                          gR: p.allUsersList.any(
                                                  (e) => e.country == "Greece")
                                              ? AppColors.gold
                                              : null,
                                          dO: p.allUsersList.any((e) =>
                                                  e.country ==
                                                  "Dominican Republic")
                                              ? AppColors.gold
                                              : null,

                                          hU: p.allUsersList.any(
                                                  (e) => e.country == "Hungary")
                                              ? AppColors.gold
                                              : null,
                                          cZ: p.allUsersList.any(
                                                  (e) => e.country == "Czechia")
                                              ? AppColors.gold
                                              : null,

                                          hK: p.allUsersList.any((e) =>
                                                  e.country == "Hong Kong")
                                              ? AppColors.gold
                                              : null,
                                          eT: p.allUsersList.any((e) =>
                                                  e.country == "Ethiopia")
                                              ? AppColors.gold
                                              : null,

                                          rO: p.allUsersList.any(
                                                  (e) => e.country == "Romania")
                                              ? AppColors.gold
                                              : null,
                                          hR: p.allUsersList.any(
                                                  (e) => e.country == "Croatia")
                                              ? AppColors.gold
                                              : null,

                                          cH: p.allUsersList.any((e) =>
                                                  e.country == "Switzerland")
                                              ? AppColors.gold
                                              : null,
                                        ).toMap(),
                                        callback: (id, name, tapDetails) {}),
                                  ),
                                  Expanded(
                                    // width: w* 0.5,
                                    //        height:h* 0.18,
                                    child: ListView(
                                        shrinkWrap: true,
                                        controller: ScrollController(),
                                        children: p.allUsersList
                                            .map((e) => e.country)
                                            .toSet()
                                            .toList()
                                            .map((e) => Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          // mainAxisSize:
                                                          //     MainAxisSize
                                                          //         .min,
                                                          children: [
                                                            Text(
                                                                "${e.toString().length > 10 ? "${e.toString().substring(0, 10)}..." : e}",
                                                                style: TextTheme.of(
                                                                        context)
                                                                    .labelSmall!
                                                                    .copyWith(
                                                                        fontSize:
                                                                            9,
                                                                        color: AppColors
                                                                            .textSilver)),
                                                            Text(
                                                                "${(p.allUsersList.where((element) => element.country == e).length * 100 / p.allUsersList.length).toStringAsFixed(1)}%",
                                                                style: TextTheme.of(
                                                                        context)
                                                                    .labelSmall!)
                                                          ]),
                                                      Divider(
                                                          // height: 3,
                                                          color: AppColors
                                                              .silverGold
                                                              .withOpacity(0.3))
                                                    ]))
                                            .toList()),
                                  ),
                                ])),
                            CardWidget(
                                widthRatio: 0.18,
                                heightRatio: 0.18,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(children: [
                                        Text("New Subscriptions",
                                            style: TextTheme.of(context)
                                                .labelLarge!)
                                      ]),
                                      // This makes Other countries green
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("\$${p.totalTRPrice}",
                                                style: TextTheme.of(context)
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .textSilver)),
                                            Text("  ${p.totalTRRatio}%",
                                                style: TextTheme.of(context)
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .textGreen)),
                                          ]),
                                      CardWidget(
                                          heightRatio: 0.1,
                                          child: BarChartWidget(
                                              dataList: p.trPaidSumList))
                                    ])),
                            CardWidget(
                                widthRatio: 0.22,
                                heightRatio: 0.18,
                                padding: const EdgeInsets.all(0),
                                child: Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    SizedBox(
                                        child: CalendarDatePicker2(
                                      displayedMonthDate: p.bestSellingDay,
                                      config: CalendarDatePicker2Config(
                                        hideLastMonthIcon: true,
                                        hideMonthPickerDividers: true,
                                        hideNextMonthIcon: true,
                                        hideScrollViewMonthWeekHeader: true,
                                        hideScrollViewTopHeaderDivider: true,
                                        hideYearPickerDividers: true,
                                        hideScrollViewTopHeader: true,
                                        selectedDayHighlightColor:
                                            AppColors.gold.withOpacity(0.9),
                                        selectedYearTextStyle: const TextStyle(
                                            color: Colors.white),
                                        disabledDayTextStyle: TextStyle(
                                            color: AppColors.textSilver
                                                .withOpacity(0.7)),
                                        controlsTextStyle: const TextStyle(
                                            color: AppColors.textSilver),
                                        todayTextStyle: const TextStyle(
                                            color: AppColors.textSilver),
                                        monthTextStyle: const TextStyle(
                                            color: AppColors.textSilver),
                                        yearTextStyle: const TextStyle(
                                            color: AppColors.textSilver),
                                        dayTextStyle: const TextStyle(
                                            color: AppColors.textSilver),
                                        selectedDayTextStyle: const TextStyle(
                                            color: Colors.white),
                                        calendarType:
                                            CalendarDatePicker2Type.single,
                                      ),
                                      value: [p.bestSellingDay],
                                    )),
                                    Positioned(
                                      top: 3,
                                      right: 10,
                                      child: Text("Best Selling day",
                                          style: TextTheme.of(context)
                                              .labelSmall!),
                                    ),
                                  ],
                                )),
                            /////////////////

                            CardWidget(
                                widthRatio: 0.22,
                                heightRatio: 0.15,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(children: [
                                              Text("Messages",
                                                  style: TextTheme.of(context)
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: AppColors
                                                              .textSilver)),
                                              Text(
                                                  "${p.last5MonthsChatsList.fold(0, (int a, b) => a + b)}",
                                                  style: TextTheme.of(context)
                                                      .headlineSmall!),
                                            ]),
                                            Text("  Sent / Received",
                                                style: TextTheme.of(context)
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .textGreen)),
                                          ]),
                                      CardWidget(
                                          heightRatio: 0.1,
                                          child: MsgChartWidget(
                                              dataList: p.last5MonthsChatsList))
                                    ])),
                            CardWidget(
                                widthRatio: 0.19,
                                heightRatio: 0.15,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(children: [
                                        Text("Posts/Updates",
                                            style: TextTheme.of(context)
                                                .labelSmall!
                                                .copyWith(
                                                    color:
                                                        AppColors.textSilver))
                                      ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                              Text("${p.totalPosts}",
                                                  style: TextTheme.of(context)
                                                      .headlineSmall!),
                                              Text("Posts",
                                                  style: TextTheme.of(context)
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: AppColors
                                                              .textSilver)),
                                            ]),
                                            Text("  ${p.totalPostsPer}%",
                                                style: TextTheme.of(context)
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .textGreen)),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                              Text("${p.totalLikes}",
                                                  style: TextTheme.of(context)
                                                      .headlineSmall!),
                                              Text("Likes",
                                                  style: TextTheme.of(context)
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: AppColors
                                                              .textSilver)),
                                            ]),
                                            Text("   ${p.totalLikesPer}%",
                                                style: TextTheme.of(context)
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .textGreen)),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                              Text("${p.totalComments}",
                                                  style: TextTheme.of(context)
                                                      .headlineSmall!),
                                              Text("Comments",
                                                  style: TextTheme.of(context)
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: AppColors
                                                              .textSilver)),
                                            ]),
                                            Text("   ${p.totalComments}%",
                                                style: TextTheme.of(context)
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .textGreen)),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                              Text("${p.totalShare}",
                                                  style: TextTheme.of(context)
                                                      .headlineSmall!),
                                              Text("Shares",
                                                  style: TextTheme.of(context)
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: AppColors
                                                              .textSilver)),
                                            ]),
                                            Text("   ${p.totalSharePer}%",
                                                style: TextTheme.of(context)
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .textGreen)),
                                          ]),
                                    ])),
                            CardWidget(
                                heightRatio: 0.15,
                                widthRatio: 0.33,
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Connection Made",
                                                style: TextTheme.of(context)
                                                    .labelMedium!),
                                            Row(children: [
                                              Text("Total",
                                                  style: TextTheme.of(context)
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: AppColors
                                                              .textSilver)),
                                              Text("   ${p.totalConnections}",
                                                  style: TextTheme.of(context)
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: AppColors
                                                              .textGreen)),
                                            ]),
                                            const Spacer(),
                                            Text("Actually",
                                                style: TextTheme.of(context)
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .textGold)),
                                            const SizedBox(height: 30),
                                            Text("Previously",
                                                style: TextTheme.of(context)
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .textSilver)),
                                            const Spacer(),
                                          ]),
                                      CardWidget(
                                          // heightRatio: 0.15,
                                          widthRatio: 0.23,
                                          child: LineChartWidget(
                                            dataListGold: p
                                                .last5MonthsFriendsListAccepted,
                                            dataListSilver:
                                                p.last5MonthsFriendsListPending,
                                          )),
                                    ])),
                            CardWidget(
                                widthRatio: 0.18,
                                heightRatio: 0.18,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(children: [
                                        Text("Conversion Rate",
                                            style: TextTheme.of(context)
                                                .labelSmall!)
                                      ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(children: [
                                                    Text(
                                                        "${p.allUsersList.length}",
                                                        style: TextTheme.of(
                                                                context)
                                                            .headlineSmall!),
                                                    Text("users",
                                                        style: TextTheme.of(
                                                                context)
                                                            .labelSmall!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textSilver)),
                                                  ]),
                                                  Row(children: [
                                                    Text(
                                                        "${p.allUsersMembershipList.fold(0, (sum, s) => sum + s)}",
                                                        style: TextTheme.of(
                                                                context)
                                                            .headlineSmall!),
                                                    Text("Membership",
                                                        style: TextTheme.of(
                                                                context)
                                                            .labelSmall!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textSilver)),
                                                  ]),
                                                ]),
                                            Column(children: [
                                              Text(
                                                  "  ${p.allUsersMembershipPerc}%",
                                                  style: TextTheme.of(context)
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: AppColors
                                                              .textGreen)),
                                              // Text("  15%",
                                              //     style: TextTheme.of(context)
                                              //         .titleMedium!),
                                            ]),
                                          ]),
                                      CardWidget(
                                          heightRatio: 0.1,
                                          child: BarChartWidget(
                                            dataList: p.allUsersMembershipList,
                                          ))
                                    ])),
                            CardWidget(
                                widthRatio: 0.18,
                                heightRatio: 0.18,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(children: [
                                        Text("App Crashes/Errors",
                                            style: TextTheme.of(context)
                                                .labelSmall!)
                                      ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(children: [
                                                    Text("${p.totalCrashes}",
                                                        style: TextTheme.of(
                                                                context)
                                                            .headlineSmall!),
                                                    Text("Crashes",
                                                        style: TextTheme.of(
                                                                context)
                                                            .labelSmall!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textSilver)),
                                                  ]),
                                                  Row(children: [
                                                    Text("${p.totalErrors}",
                                                        style: TextTheme.of(
                                                                context)
                                                            .headlineSmall!),
                                                    Text("Errors",
                                                        style: TextTheme.of(
                                                                context)
                                                            .labelSmall!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textSilver)),
                                                  ]),
                                                ]),
                                            Column(children: [
                                              Text("  -${p.totalCrashesPerc}%",
                                                  style: TextTheme.of(context)
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: AppColors
                                                              .textRed)),
                                              Text(
                                                  "  ${p.totalCrashes + p.totalErrors}",
                                                  style: TextTheme.of(context)
                                                      .titleMedium!),
                                            ]),
                                          ]),
                                      CardWidget(
                                          heightRatio: 0.1,
                                          child: BarChartWidget(
                                            dataList: p.appInfoChartList,
                                          ))
                                    ])),

                            CardWidget(
                                widthRatio: 0.15,
                                heightRatio: 0.18,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Load Time",
                                                style: TextTheme.of(context)
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .textSilver)),
                                            Text(
                                                "  +${double.parse(p.appLoadingTime) / 100 * 10}%",
                                                style: TextTheme.of(context)
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .textGreen))
                                          ]),
                                      Center(
                                          child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                            SizedBox(
                                                width: 170,
                                                height: 170,
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: CircularProgressIndicator(
                                                        value: double.parse(p
                                                                .appLoadingTime) /
                                                            100 *
                                                            10,
                                                        strokeWidth: 20,
                                                        backgroundColor:
                                                            AppColors.bgField,
                                                        valueColor:
                                                            const AlwaysStoppedAnimation<
                                                                    Color>(
                                                                AppColors
                                                                    .gold)))),
                                            Text(" ${p.appLoadingTime} sec",
                                                style: TextTheme.of(context)
                                                    .titleMedium!
                                                    .copyWith(
                                                        color: AppColors
                                                            .textSilver,
                                                        fontWeight:
                                                            FontWeight.bold))
                                          ]))
                                    ])),
                            CardWidget(
                                widthRatio: 0.22,
                                heightRatio: 0.18,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(children: [
                                        Text("Users feedback",
                                            style: TextTheme.of(context)
                                                .labelSmall!)
                                      ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(children: [
                                                    Text(
                                                        "${p.feedBackListPositive}",
                                                        style: TextTheme.of(
                                                                context)
                                                            .headlineSmall!),
                                                    Text("Positive",
                                                        style: TextTheme.of(
                                                                context)
                                                            .labelSmall!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textSilver)),
                                                  ]),
                                                  Row(children: [
                                                    Text(
                                                        "${p.feedBackListNagetive}",
                                                        style: TextTheme.of(
                                                                context)
                                                            .headlineSmall!),
                                                    Text("Nagetive",
                                                        style: TextTheme.of(
                                                                context)
                                                            .labelSmall!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .textSilver)),
                                                  ]),
                                                ]),
                                            Column(children: [
                                              Text(
                                                  "  -${(p.feedBackListNagetive / p.feedBackList.length).toStringAsFixed(1)}%",
                                                  style: TextTheme.of(context)
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: AppColors
                                                              .textRed)),
                                            ]),
                                          ]),
                                      CardWidget(
                                          heightRatio: 0.1,
                                          child: BarChartWidget(
                                              dataList: p.feedBackListChart))
                                    ])),
                          ]),
                        ]))
                .animate(
                    // autoPlay: p.isLoading,
                    onPlay: (controller) => controller.repeat(
                        count: 2,
                        period: Duration(
                            seconds:
                                p.isLoading && p.isLoadingFor == "" ? 2 : 100)))
                .shimmer(
                    color: Colors.white24,
                    duration: const Duration(milliseconds: 300)),
          )),
    ));
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////// This page Widgets ///////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class MsgChartWidget extends StatelessWidget {
  final List dataList;
  const MsgChartWidget({super.key, required this.dataList});
  List<int> getLastSixMonths() {
    DateTime now = DateTime.now();
    return List.generate(dataList.isNotEmpty ? dataList.length : 6, (index) {
      return DateTime(now.year, now.month - index, 1).month;
      // return DateFormat('MMM').format(month); // by month name
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("👉 dataList length: ${dataList.length}");
    return BarChart(
      BarChartData(
        rotationQuarterTurns: 1,
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    interval: 2,
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      List<int> lastSixMonths = getLastSixMonths();
                      if (value.toInt() >= 0 &&
                          value.toInt() < lastSixMonths.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 13),
                          child: Text(
                            lastSixMonths[value.toInt()].toString(),
                            style: const TextStyle(
                                color: AppColors.textSilver, fontSize: 11),
                          ),
                        );
                      }

                      return const Padding(
                        padding: EdgeInsets.only(top: 13),
                        child: Text('',
                            style: TextStyle(
                                color: AppColors.textSilver, fontSize: 11)),
                      );
                    })),
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false))),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(
          dataList.length,
          (index) => BarChartGroupData(x: index, barRods: [
            BarChartRodData(
                toY: dataList[index],
                width: 12,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [AppColors.primaryMid, AppColors.gold]))
          ]),
        ),
      ),
    );
  }
}

/////////////
class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String? growth;
  final Widget child;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    this.growth,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(color: Colors.orange, fontSize: 24)),
          if (growth != null)
            Text(growth!, style: const TextStyle(color: AppColors.textGreen)),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  final List dataListGold;
  final List dataListSilver;
  const LineChartWidget(
      {super.key, required this.dataListSilver, required this.dataListGold});

  @override
  Widget build(BuildContext context) {
    List<String> getLastSixMonths() {
      DateTime now = DateTime.now();
      return List.generate(dataListGold.isEmpty ? 6 : dataListGold.length,
          (index) {
        // by month numbers until 6
        DateTime month = DateTime(now.year, now.month - index, 1);
        return DateFormat('MMM').format(month);
      }).reversed.toList();
    }

    return LineChart(
      LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      interval: 1,
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        List<String> lastSixMonths = getLastSixMonths();

                        if (value.toInt() >= 0 &&
                            value.toInt() < lastSixMonths.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 13),
                            child: Text(
                              lastSixMonths[value.toInt()],
                              style: const TextStyle(
                                  color: AppColors.textSilver, fontSize: 11),
                            ),
                          );
                        }

                        return const Padding(
                          padding: EdgeInsets.only(top: 13),
                          child: Text('',
                              style: TextStyle(
                                  color: AppColors.textSilver, fontSize: 11)),
                        );
                      })),
              leftTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false))),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(dataListSilver.length,
                  (index) => FlSpot(index.toDouble(), dataListSilver[index])),
              // [
              //   const FlSpot(0, 2),
              //   const FlSpot(1, 3),
              //   const FlSpot(2, 3),
              //   const FlSpot(3, 4),
              //   const FlSpot(4, 4),
              //   const FlSpot(5, 5),
              // ],
              isCurved: true,
              color: AppColors.silverGold,
            ),
            LineChartBarData(
              spots: List.generate(
                  dataListGold.length,
                  (index) => FlSpot(index.toDouble(),
                      dataListGold[index])), //List.generate(6, generator)
              isCurved: true,
              color: AppColors.gold,
            ),
          ]),
    );
  }
}

class BarChartWidget extends StatelessWidget {
  final List dataList;
  const BarChartWidget({super.key, required this.dataList});

  @override
  Widget build(BuildContext context) {
    List<String> getLastSixMonths() {
      DateTime now = DateTime.now();
      return List.generate(dataList.length, (index) {
        // by month numbers until 6
        DateTime month = DateTime(now.year, now.month - index, 1);
        return DateFormat('MMM').format(month);
      }).reversed.toList();
    }

    return BarChart(BarChartData(
      gridData: const FlGridData(show: false),
      titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  interval: 1,
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) {
                    List<String> lastSixMonths = getLastSixMonths();

                    if (value.toInt() >= 0 &&
                        value.toInt() < lastSixMonths.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 13),
                        child: Text(
                          lastSixMonths[value.toInt()],
                          style: const TextStyle(
                              color: AppColors.textSilver, fontSize: 11),
                        ),
                      );
                    }

                    return const Padding(
                      padding: EdgeInsets.only(top: 13),
                      child: Text('',
                          style: TextStyle(
                              color: AppColors.textSilver, fontSize: 11)),
                    );
                  })),
          leftTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false))),
      borderData: FlBorderData(show: false),
      barGroups: List.generate(
        dataList.length,
        (index) => BarChartGroupData(x: index, barRods: [
          BarChartRodData(
              toY: dataList[index],
              width: 12,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [AppColors.primaryMid, AppColors.gold]))
        ]),
      ),
    ));
  }
}

class PieChartWidget extends StatelessWidget {
  // final int total;
  final List dataList;
  const PieChartWidget({super.key, required this.dataList});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.7,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 0,
          sectionsSpace: 0,
          startDegreeOffset: 180,
          sections: [
            PieChartSectionData(
              value: dataList.where((e) => e.membership == "Gold").length /
                  dataList.length *
                  100,
              color: AppColors.gold,
              title: '',
            ),
            PieChartSectionData(
              value: dataList.where((e) => e.membership == "Free").length /
                  dataList.length *
                  100,
              color: AppColors.silverGold,
              title: '',
            ),
            PieChartSectionData(
              value: dataList.where((e) => e.membership == "Bronze").length /
                  dataList.length *
                  100,
              color: AppColors.pieChartColor2,
              title: '',
            ),
            PieChartSectionData(
              value: dataList.where((e) => e.membership == "Silver").length /
                  dataList.length *
                  100,
              color: AppColors.pieChartColor1,
              title: '',
            ),
          ],
          titleSunbeamLayout: false,
        ),
      ),
    );
  }
}
