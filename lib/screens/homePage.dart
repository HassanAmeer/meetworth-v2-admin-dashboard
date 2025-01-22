import 'package:admin_panel_design/const/appColors.dart';
import 'package:admin_panel_design/const/appImages.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
        // appBar: AppBar(backgroundColor: Colors.transparent),
        body: Padding(
      padding: const EdgeInsets.all(14),
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(parent: BouncingScrollPhysics()),
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
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    CardWidget(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Icon(Icons.calendar_month),
                          SizedBox(width: 10),
                          Text("This Month"),
                        ])),
                    MiniTileCardWidget(
                      title: Text("Active Users",
                          style: TextTheme.of(context)
                              .labelMedium!
                              .copyWith(color: AppColors.textSilver)),
                      subtitle: Text("+2.45%",
                          style: TextTheme.of(context)
                              .labelSmall!
                              .copyWith(color: AppColors.textGreen)),
                      trailing: Text("2.579",
                          style: TextTheme.of(context).headlineSmall!),
                    ),
                    MiniTileCardWidget(
                      title: Text("Session Duration:",
                          style: TextTheme.of(context)
                              .labelMedium!
                              .copyWith(color: AppColors.textSilver)),
                      subtitle: Text("+2.45%",
                          style: TextTheme.of(context)
                              .labelSmall!
                              .copyWith(color: AppColors.textGreen)),
                      trailing: Text("2m46",
                          style: TextTheme.of(context).headlineSmall!),
                    ),
                    MiniTileCardWidget(
                      title: Text("Frequency of use:",
                          style: TextTheme.of(context)
                              .labelMedium!
                              .copyWith(color: AppColors.textSilver)),
                      subtitle: Text("+2.45%",
                          style: TextTheme.of(context)
                              .labelSmall!
                              .copyWith(color: AppColors.textGreen)),
                      trailing: Text("413",
                          style: TextTheme.of(context).headlineSmall!),
                    ),
                    MiniTileCardWidget(
                      title: Text("Retention Rate:",
                          style: TextTheme.of(context)
                              .labelMedium!
                              .copyWith(color: AppColors.textSilver)),
                      subtitle: Text("+2.45%",
                          style: TextTheme.of(context)
                              .labelSmall!
                              .copyWith(color: AppColors.textGreen)),
                      trailing: Text("56%",
                          style: TextTheme.of(context).headlineSmall!),
                    ),
                    MiniTileCardWidget(
                      title: Text("Churn Rate:",
                          style: TextTheme.of(context)
                              .labelMedium!
                              .copyWith(color: AppColors.textSilver)),
                      subtitle: Text("+2.45%",
                          style: TextTheme.of(context)
                              .labelSmall!
                              .copyWith(color: AppColors.textGreen)),
                      trailing: Text("10%",
                          style: TextTheme.of(context).headlineSmall!),
                    ),
                    CardWidget(
                      widthRatio: 0.05,
                      child: Icon(Icons.refresh, size: 20),
                    )
                  ])),
              //////////////////

              Wrap(children: [
                CardWidget(
                    heightRatio: 0.15,
                    widthRatio: 0.33,
                    padding: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("\$3,000",
                                    style:
                                        TextTheme.of(context).headlineSmall!),
                                Row(children: [
                                  Text("\$3,000",
                                      style: TextTheme.of(context)
                                          .labelSmall!
                                          .copyWith(
                                              color: AppColors.textSilver)),
                                  Text("  +2.45%",
                                      style: TextTheme.of(context)
                                          .labelSmall!
                                          .copyWith(
                                              color: AppColors.textGreen)),
                                ]),
                                Spacer(),
                                Text("Actually",
                                    style: TextTheme.of(context)
                                        .labelSmall!
                                        .copyWith(color: AppColors.textGold)),
                                SizedBox(height: 30),
                                Text("Previously",
                                    style: TextTheme.of(context)
                                        .labelSmall!
                                        .copyWith(color: AppColors.textSilver)),
                                Spacer(),
                              ]),
                          CardWidget(
                              // heightRatio: 0.15,
                              widthRatio: 0.25,
                              child: LineChartWidget()),
                        ])),
                CardWidget(
                    widthRatio: 0.2,
                    heightRatio: 0.15,
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(children: [
                              Text("\$3,000",
                                  style: TextTheme.of(context).headlineSmall!),
                              Text("\$3,000",
                                  style: TextTheme.of(context)
                                      .labelSmall!
                                      .copyWith(color: AppColors.textSilver)),
                            ]),
                            Text("  +2.45%",
                                style: TextTheme.of(context)
                                    .labelSmall!
                                    .copyWith(color: AppColors.textGreen)),
                          ]),
                      CardWidget(heightRatio: 0.1, child: BarChartWidget())
                    ])),
                CardWidget(
                    widthRatio: 0.21,
                    heightRatio: 0.15,
                    child: Row(children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Memeberships: ",
                                style: TextTheme.of(context)
                                    .labelSmall!
                                    .copyWith()),
                            Row(children: [
                              Text("Free: ",
                                  style: TextTheme.of(context)
                                      .labelSmall!
                                      .copyWith(color: AppColors.silverGold)),
                              Text("25%",
                                  style: TextTheme.of(context).labelSmall!),
                            ]),
                            Row(children: [
                              Text("Bronze: ",
                                  style: TextTheme.of(context)
                                      .labelSmall!
                                      .copyWith(
                                          color: AppColors.pieChartColor2)),
                              Text("25%",
                                  style: TextTheme.of(context).labelSmall!),
                            ]),
                            Row(children: [
                              Text("Silver: ",
                                  style: TextTheme.of(context)
                                      .labelSmall!
                                      .copyWith(color: AppColors.textSilver)),
                              Text("25%",
                                  style: TextTheme.of(context).labelSmall!),
                            ]),
                            Row(children: [
                              Text("Gold: ",
                                  style: TextTheme.of(context)
                                      .labelSmall!
                                      .copyWith(color: AppColors.gold)),
                              Text("25%",
                                  style: TextTheme.of(context).labelSmall!),
                            ]),
                            Row(children: [
                              Text("PaidMemebership: ",
                                  style: TextTheme.of(context)
                                      .labelSmall!
                                      .copyWith(color: AppColors.textSilver)),
                              Text("25%",
                                  style: TextTheme.of(context).labelSmall!),
                            ]),
                          ]),
                      Expanded(
                          // heightRatio: 0.1,
                          // widthRatio: 0.2,
                          child: PieChartWidget())
                    ])),
                CardWidget(
                  heightRatio: 0.18,
                  widthRatio: 0.34,
                  child: Row(children: [
                    SizedBox(
                      width: w * 0.28,
                      child: SimpleMap(
                          instructions: SMapWorld.instructions,
                          defaultColor: Colors.grey,
                          colors: SMapWorldColors(
                            uS: AppColors.gold,
                            cN: AppColors.gold, // This makes China green
                            iN: AppColors.gold, // This makes Russia green
                          ).toMap(),
                          callback: (id, name, tapDetails) {}),
                    ),
                    Column(children: [
                      Row(children: [
                        Text("Russia: ",
                            style: TextTheme.of(context)
                                .labelSmall!
                                .copyWith(color: AppColors.textSilver)),
                        Text("10%", style: TextTheme.of(context).labelSmall!),
                      ]),
                      SizedBox(height: 10),
                      Row(children: [
                        Text("Russia: ",
                            style: TextTheme.of(context)
                                .labelSmall!
                                .copyWith(color: AppColors.textSilver)),
                        Text("10%", style: TextTheme.of(context).labelSmall!),
                      ]),
                      SizedBox(height: 10),
                      Row(children: [
                        Text("Russia: ",
                            style: TextTheme.of(context)
                                .labelSmall!
                                .copyWith(color: AppColors.textSilver)),
                        Text("10%", style: TextTheme.of(context).labelSmall!),
                      ]),
                    ])
                  ]),
                ),
                CardWidget(
                    widthRatio: 0.18,
                    heightRatio: 0.18,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(children: [
                            Text("New Subscriptions",
                                style: TextTheme.of(context).labelSmall!)
                          ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("\$3,000",
                                      style:
                                          TextTheme.of(context).headlineSmall!),
                                  Text("\$3,000",
                                      style: TextTheme.of(context)
                                          .labelSmall!
                                          .copyWith(
                                              color: AppColors.textSilver)),
                                ]),
                                Text("  +2.45%",
                                    style: TextTheme.of(context)
                                        .labelSmall!
                                        .copyWith(color: AppColors.textGreen)),
                              ]),
                          CardWidget(heightRatio: 0.1, child: BarChartWidget())
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
                          displayedMonthDate: DateTime.now(),
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
                            selectedYearTextStyle:
                                TextStyle(color: Colors.white),
                            disabledDayTextStyle: TextStyle(
                                color: AppColors.textSilver.withOpacity(0.7)),
                            controlsTextStyle:
                                TextStyle(color: AppColors.textSilver),
                            todayTextStyle:
                                TextStyle(color: AppColors.textSilver),
                            monthTextStyle:
                                TextStyle(color: AppColors.textSilver),
                            yearTextStyle:
                                TextStyle(color: AppColors.textSilver),
                            dayTextStyle:
                                TextStyle(color: AppColors.textSilver),
                            selectedDayTextStyle:
                                TextStyle(color: Colors.white),
                            calendarType: CalendarDatePicker2Type.single,
                          ),
                          value: [DateTime.now()],
                        )),
                        Positioned(
                          top: 3,
                          right: 10,
                          child: Text("Best Selling day",
                              style: TextTheme.of(context).labelSmall!),
                        ),
                      ],
                    )),
                /////////////////

                CardWidget(
                    widthRatio: 0.22,
                    heightRatio: 0.15,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text("Messages Sent / Received",
                                      style: TextTheme.of(context)
                                          .labelSmall!
                                          .copyWith(
                                              color: AppColors.textSilver)),
                                  Text("\$3,000",
                                      style:
                                          TextTheme.of(context).headlineSmall!),
                                ]),
                                Text("  +2.45%",
                                    style: TextTheme.of(context)
                                        .labelSmall!
                                        .copyWith(color: AppColors.textGreen)),
                              ]),
                          CardWidget(heightRatio: 0.1, child: MsgChartWidget())
                        ])),
                CardWidget(
                    widthRatio: 0.19,
                    heightRatio: 0.15,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(children: [
                            Text("Posts/Updates",
                                style: TextTheme.of(context)
                                    .labelSmall!
                                    .copyWith(color: AppColors.textSilver))
                          ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Text("11235",
                                      style:
                                          TextTheme.of(context).headlineSmall!),
                                  Text("Posts",
                                      style: TextTheme.of(context)
                                          .labelSmall!
                                          .copyWith(
                                              color: AppColors.textSilver)),
                                ]),
                                Text("  +2.45%",
                                    style: TextTheme.of(context)
                                        .labelSmall!
                                        .copyWith(color: AppColors.textGreen)),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Text("11235",
                                      style:
                                          TextTheme.of(context).headlineSmall!),
                                  Text("Likes",
                                      style: TextTheme.of(context)
                                          .labelSmall!
                                          .copyWith(
                                              color: AppColors.textSilver)),
                                ]),
                                Text("  +2.45%",
                                    style: TextTheme.of(context)
                                        .labelSmall!
                                        .copyWith(color: AppColors.textGreen)),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Text("11235",
                                      style:
                                          TextTheme.of(context).headlineSmall!),
                                  Text("Comments",
                                      style: TextTheme.of(context)
                                          .labelSmall!
                                          .copyWith(
                                              color: AppColors.textSilver)),
                                ]),
                                Text("  +2.45%",
                                    style: TextTheme.of(context)
                                        .labelSmall!
                                        .copyWith(color: AppColors.textGreen)),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Text("11235",
                                      style:
                                          TextTheme.of(context).headlineSmall!),
                                  Text("Shares",
                                      style: TextTheme.of(context)
                                          .labelSmall!
                                          .copyWith(
                                              color: AppColors.textSilver)),
                                ]),
                                Text("  +2.45%",
                                    style: TextTheme.of(context)
                                        .labelSmall!
                                        .copyWith(color: AppColors.textGreen)),
                              ]),
                        ])),
                CardWidget(
                    heightRatio: 0.15,
                    widthRatio: 0.33,
                    padding: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("\$3,000",
                                    style:
                                        TextTheme.of(context).headlineSmall!),
                                Row(children: [
                                  Text("\$3,000",
                                      style: TextTheme.of(context)
                                          .labelSmall!
                                          .copyWith(
                                              color: AppColors.textSilver)),
                                  Text("  +2.45%",
                                      style: TextTheme.of(context)
                                          .labelSmall!
                                          .copyWith(
                                              color: AppColors.textGreen)),
                                ]),
                                Spacer(),
                                Text("Actually",
                                    style: TextTheme.of(context)
                                        .labelSmall!
                                        .copyWith(color: AppColors.textGold)),
                                SizedBox(height: 30),
                                Text("Previously",
                                    style: TextTheme.of(context)
                                        .labelSmall!
                                        .copyWith(color: AppColors.textSilver)),
                                Spacer(),
                              ]),
                          CardWidget(
                              // heightRatio: 0.15,
                              widthRatio: 0.25,
                              child: LineChartWidget()),
                        ])),
                CardWidget(
                    widthRatio: 0.18,
                    heightRatio: 0.18,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(children: [
                            Text("Conversion Rate",
                                style: TextTheme.of(context).labelSmall!)
                          ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Text("17000",
                                            style: TextTheme.of(context)
                                                .headlineSmall!),
                                        Text("users",
                                            style: TextTheme.of(context)
                                                .labelSmall!
                                                .copyWith(
                                                    color:
                                                        AppColors.textSilver)),
                                      ]),
                                      Row(children: [
                                        Text("11000",
                                            style: TextTheme.of(context)
                                                .headlineSmall!),
                                        Text("Membership",
                                            style: TextTheme.of(context)
                                                .labelSmall!
                                                .copyWith(
                                                    color:
                                                        AppColors.textSilver)),
                                      ]),
                                    ]),
                                Column(children: [
                                  Text("  +2.45%",
                                      style: TextTheme.of(context)
                                          .labelSmall!
                                          .copyWith(
                                              color: AppColors.textGreen)),
                                  Text("  15%",
                                      style:
                                          TextTheme.of(context).titleMedium!),
                                ]),
                              ]),
                          CardWidget(heightRatio: 0.1, child: BarChartWidget())
                        ])),
                CardWidget(
                    widthRatio: 0.18,
                    heightRatio: 0.18,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(children: [
                            Text("App Crashes/Errors",
                                style: TextTheme.of(context).labelSmall!)
                          ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Text("100",
                                            style: TextTheme.of(context)
                                                .headlineSmall!),
                                        Text("Crashes",
                                            style: TextTheme.of(context)
                                                .labelSmall!
                                                .copyWith(
                                                    color:
                                                        AppColors.textSilver)),
                                      ]),
                                      Row(children: [
                                        Text("100",
                                            style: TextTheme.of(context)
                                                .headlineSmall!),
                                        Text("Errors",
                                            style: TextTheme.of(context)
                                                .labelSmall!
                                                .copyWith(
                                                    color:
                                                        AppColors.textSilver)),
                                      ]),
                                    ]),
                                Column(children: [
                                  Text("  +2.45%",
                                      style: TextTheme.of(context)
                                          .labelSmall!
                                          .copyWith(color: AppColors.textRed)),
                                  Text("  15%",
                                      style:
                                          TextTheme.of(context).titleMedium!),
                                ]),
                              ]),
                          CardWidget(heightRatio: 0.1, child: BarChartWidget())
                        ])),

                CardWidget(
                    widthRatio: 0.15,
                    heightRatio: 0.18,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Errors",
                                    style: TextTheme.of(context)
                                        .labelSmall!
                                        .copyWith(color: AppColors.textSilver)),
                                Text("  +2.45%",
                                    style: TextTheme.of(context)
                                        .labelSmall!
                                        .copyWith(color: AppColors.textGreen)),
                              ]),
                          Center(
                              child:
                                  Stack(alignment: Alignment.center, children: [
                            SizedBox(
                              width: 170,
                              height: 170,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: CircularProgressIndicator(
                                    value: 0.7,
                                    strokeWidth: 20,
                                    backgroundColor: AppColors.bgField,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.gold)),
                              ),
                            ),
                            Text("1.2 sec",
                                style: TextTheme.of(context)
                                    .titleMedium!
                                    .copyWith(
                                        color: AppColors.textSilver,
                                        fontWeight: FontWeight.bold)),
                          ]))
                        ])),
                CardWidget(
                    widthRatio: 0.22,
                    heightRatio: 0.18,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(children: [
                            Text("Users feedback",
                                style: TextTheme.of(context).labelSmall!)
                          ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Text("100",
                                            style: TextTheme.of(context)
                                                .headlineSmall!),
                                        Text("Positive",
                                            style: TextTheme.of(context)
                                                .labelSmall!
                                                .copyWith(
                                                    color:
                                                        AppColors.textSilver)),
                                      ]),
                                      Row(children: [
                                        Text("100",
                                            style: TextTheme.of(context)
                                                .headlineSmall!),
                                        Text("Nagetive",
                                            style: TextTheme.of(context)
                                                .labelSmall!
                                                .copyWith(
                                                    color:
                                                        AppColors.textSilver)),
                                      ]),
                                    ]),
                                Column(children: [
                                  Text("  +2.45%",
                                      style: TextTheme.of(context)
                                          .labelSmall!
                                          .copyWith(
                                              color: AppColors.textGreen)),
                                  Text("  15%",
                                      style:
                                          TextTheme.of(context).titleMedium!),
                                ]),
                              ]),
                          CardWidget(heightRatio: 0.1, child: BarChartWidget())
                        ])),
              ]),
            ]),
      ),
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
  const MsgChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        rotationQuarterTurns: 1,
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    interval: 1,
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      switch (value.toInt()) {
                        case 0:
                          return Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: Text('07',
                                  style: TextStyle(
                                      color: AppColors.textSilver,
                                      fontSize: 11)));
                        case 1:
                          return Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: Text('08',
                                  style: TextStyle(
                                      color: AppColors.textSilver,
                                      fontSize: 11)));
                        case 2:
                          return Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: Text('09',
                                  style: TextStyle(
                                      color: AppColors.textSilver,
                                      fontSize: 11)));
                        case 3:
                          return Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: Text('10',
                                  style: TextStyle(
                                      color: AppColors.textSilver,
                                      fontSize: 11)));
                        case 4:
                          return Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: Text('11',
                                  style: TextStyle(
                                      color: AppColors.textSilver,
                                      fontSize: 11)));

                        default:
                          return Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: Text('',
                                  style: TextStyle(
                                      color: AppColors.textSilver,
                                      fontSize: 11)));
                      }
                    })),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(
                toY: 3,
                width: 12,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [AppColors.primaryMid, AppColors.gold]))
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(
                toY: 2,
                width: 12,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [AppColors.primaryMid, AppColors.gold]))
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(
                toY: 4,
                width: 12,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [AppColors.primaryMid, AppColors.gold]))
          ]),
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(
                toY: 5,
                width: 12,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [AppColors.primaryMid, AppColors.gold]))
          ]),
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(
                toY: 4,
                width: 12,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [AppColors.primaryMid, AppColors.gold]))
          ]),
        ],
      ),
    );
  }
}

class MiniTileCardWidget extends StatelessWidget {
  final double? widthRatio;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final EdgeInsetsGeometry padding;
  final double borderRradius;

  const MiniTileCardWidget({
    super.key,
    this.widthRatio,
    this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.borderRradius = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
          width: widthRatio != null
              ? MediaQuery.of(context).size.width * widthRatio!
              : null,
          decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(borderRradius)),
          child: Padding(
              padding: padding,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                    padding: EdgeInsets.only(right: leading == null ? 0 : 11),
                    child: leading ?? SizedBox.shrink()),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      title ?? SizedBox.shrink(),
                      subtitle ?? SizedBox.shrink()
                    ]),
                Padding(
                    padding: EdgeInsets.only(left: trailing == null ? 0 : 11),
                    child: trailing ?? SizedBox.shrink()),
              ]))),
    );
  }
}

class CardWidget extends StatelessWidget {
  final double? widthRatio;
  final double? heightRatio;
  final Widget? child;
  final EdgeInsetsGeometry padding;
  final double borderRradius;

  const CardWidget({
    super.key,
    this.widthRatio,
    this.heightRatio,
    this.child,
    this.borderRradius = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
          width: widthRatio != null
              ? MediaQuery.of(context).size.width * widthRatio!
              : null,
          height: heightRatio != null
              ? MediaQuery.of(context).size.width * heightRatio!
              : null,
          decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(borderRradius)),
          child: Padding(padding: padding, child: child)),
    );
  }
}

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          // Left: Title and Breadcrumb
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Pages / Dashboard',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Right: Search, Icons, and Profile
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.bgCard,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    )
                  ]),
              child: Row(children: [
                // Search Bar
                Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: TextField(
                        cursorHeight: 12,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          filled: true,
                          fillColor: Colors.black,
                          prefixIcon:
                              Icon(Icons.search, color: Colors.white, size: 17),
                          hintText: "Search",
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
                const SizedBox(width: 16),
                // Notification Icon
                const Icon(Icons.notifications_outlined,
                    color: Colors.white, size: 24),
                const SizedBox(width: 16),
                // Info Icon
                const Icon(Icons.info_outline, color: Colors.white, size: 24),
                const SizedBox(width: 16),
                // Profile Image
                ClipOval(
                    child: Image.asset(AppImages.profile2,
                        width: 36, height: 36, fit: BoxFit.cover)),
                const SizedBox(width: 4),
              ]))
        ]));
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
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.white)),
          SizedBox(height: 8),
          Text(value, style: TextStyle(color: Colors.orange, fontSize: 24)),
          if (growth != null)
            Text(growth!, style: TextStyle(color: AppColors.textGreen)),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      interval: 1,
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        // debugPrint(" meta: ${meta.appliedInterval}");
                        switch (value.toInt()) {
                          case 0:
                            return Padding(
                                padding: const EdgeInsets.only(top: 13),
                                child: Text('Jan',
                                    style: TextStyle(
                                        color: AppColors.textSilver,
                                        fontSize: 11)));
                          case 1:
                            return Padding(
                                padding: const EdgeInsets.only(top: 13),
                                child: Text('Feb',
                                    style: TextStyle(
                                        color: AppColors.textSilver,
                                        fontSize: 11)));
                          case 2:
                            return Padding(
                                padding: const EdgeInsets.only(top: 13),
                                child: Text('Mar',
                                    style: TextStyle(
                                        color: AppColors.textSilver,
                                        fontSize: 11)));
                          case 3:
                            return Padding(
                                padding: const EdgeInsets.only(top: 13),
                                child: Text('Apr',
                                    style: TextStyle(
                                        color: AppColors.textSilver,
                                        fontSize: 11)));
                          case 4:
                            return Padding(
                                padding: const EdgeInsets.only(top: 13),
                                child: Text('May',
                                    style: TextStyle(
                                        color: AppColors.textSilver,
                                        fontSize: 11)));
                          case 5:
                            return Padding(
                                padding: const EdgeInsets.only(top: 13),
                                child: Text('Jun',
                                    style: TextStyle(
                                        color: AppColors.textSilver,
                                        fontSize: 11)));
                          default:
                            return Padding(
                                padding: const EdgeInsets.only(top: 13),
                                child: Text('',
                                    style: TextStyle(
                                        color: AppColors.textSilver,
                                        fontSize: 11)));
                        }
                      })),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 2),
                FlSpot(1, 3),
                FlSpot(2, 3),
                FlSpot(3, 4),
                FlSpot(4, 4),
                FlSpot(5, 5),
              ],
              isCurved: true,
              color: AppColors.silverGold,
            ),
            LineChartBarData(
              spots: [
                FlSpot(0, 3),
                FlSpot(1, 4),
                FlSpot(2, 4),
                FlSpot(3, 5),
                FlSpot(4, 5),
                FlSpot(5, 6),
              ],
              isCurved: true,
              color: AppColors.gold,
            ),
          ]),
    );
  }
}

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    interval: 1,
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      switch (value.toInt()) {
                        case 0:
                          return Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: Text('Jan',
                                  style: TextStyle(
                                      color: AppColors.textSilver,
                                      fontSize: 11)));
                        case 1:
                          return Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: Text('Feb',
                                  style: TextStyle(
                                      color: AppColors.textSilver,
                                      fontSize: 11)));
                        case 2:
                          return Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: Text('Mar',
                                  style: TextStyle(
                                      color: AppColors.textSilver,
                                      fontSize: 11)));
                        case 3:
                          return Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: Text('Apr',
                                  style: TextStyle(
                                      color: AppColors.textSilver,
                                      fontSize: 11)));
                        case 4:
                          return Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: Text('May',
                                  style: TextStyle(
                                      color: AppColors.textSilver,
                                      fontSize: 11)));
                        case 5:
                          return Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: Text('Jun',
                                  style: TextStyle(
                                      color: AppColors.textSilver,
                                      fontSize: 11)));
                        default:
                          return Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: Text('',
                                  style: TextStyle(
                                      color: AppColors.textSilver,
                                      fontSize: 11)));
                      }
                    })),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(
                toY: 3,
                width: 12,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [AppColors.primaryMid, AppColors.gold]))
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(
                toY: 2,
                width: 12,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [AppColors.primaryMid, AppColors.gold]))
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(
                toY: 4,
                width: 12,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [AppColors.primaryMid, AppColors.gold]))
          ]),
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(
                toY: 5,
                width: 12,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [AppColors.primaryMid, AppColors.gold]))
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(
                toY: 3,
                width: 12,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [AppColors.primaryMid, AppColors.gold]))
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(
                toY: 4,
                width: 12,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [AppColors.primaryMid, AppColors.gold]))
          ]),
        ],
      ),
    );
  }
}

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key});

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
              value: 30,
              color: AppColors.gold,
              title: '',
            ),
            PieChartSectionData(
              value: 20,
              color: AppColors.silverGold,
              title: '',
            ),
            PieChartSectionData(
              value: 25,
              color: AppColors.pieChartColor2,
              title: '',
            ),
            PieChartSectionData(
              value: 25,
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
