import 'package:admin_panel_design/const/appColors.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';

import '../const/appimages.dart';
import '../widgets/headers.dart';
import '../widgets/minicard.dart';
import '../widgets/mintile.dart';

class VerificatiosPage extends StatefulWidget {
  const VerificatiosPage({super.key});

  @override
  State<VerificatiosPage> createState() => _VerificatiosPageState();
}

class _VerificatiosPageState extends State<VerificatiosPage> {
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
                    MiniTileCardWidget(
                        title: Text("Pending Verifications",
                            style: TextTheme.of(context)
                                .labelMedium!
                                .copyWith(color: AppColors.textSilver)),
                        trailing: Text("100",
                            style: TextTheme.of(context).headlineSmall!)),
                    MiniTileCardWidget(
                        title: Text("Verified",
                            style: TextTheme.of(context)
                                .labelMedium!
                                .copyWith(color: AppColors.textSilver)),
                        trailing: Text("1500",
                            style: TextTheme.of(context).headlineSmall!)),
                    CardWidget(
                        widthRatio: 0.05, child: Icon(Icons.refresh, size: 20))
                  ])),
              //////////////////
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CardWidget(
                        widthRatio: 0.3,
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Users verification",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                SizedBox(width: 15),
                                Container(
                                    width: 200,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                                          prefixIcon: Icon(Icons.search,
                                              color: Colors.white, size: 17),
                                          hintText: "Search by Username",
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
                              ]),
                          ///////////////////////////////////////////////////////
                          SizedBox(
                            width: w * 0.75,
                            child: DataTable(
                                columnSpacing: 0,
                                // dataRowHeight: 40,
                                dividerThickness: 0.1,
                                border: TableBorder(
                                    horizontalInside: BorderSide.none,
                                    verticalInside: BorderSide.none),
                                columns: [
                                  DataColumn(
                                      label: Text('PICTURE',
                                          style: TextStyle(fontSize: 11))),
                                  DataColumn(
                                      label: Text('NAME',
                                          style: TextStyle(fontSize: 11))),
                                  DataColumn(
                                      label: Text('',
                                          style: TextStyle(fontSize: 11))),
                                ],
                                rows: List.generate(
                                  20,
                                  (index) => DataRow(cells: [
                                    DataCell(
                                      CircleAvatar(
                                          radius: 14,
                                          backgroundColor: AppColors.gold,
                                          child: CircleAvatar(
                                              radius: 13,
                                              backgroundImage: AssetImage(
                                                  AppImages.profile2))),
                                    ),
                                    DataCell(SizedBox(
                                        width: 70,
                                        child: Text(
                                            textAlign: TextAlign.center,
                                            'limoouesla-testlonger',
                                            style: TextStyle(fontSize: 10),
                                            overflow: TextOverflow.visible,
                                            maxLines: 3))),
                                    DataCell(OutlinedButton(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                                width: 1,
                                                color: AppColors.gold)),
                                        child: Text("Select",
                                            style: TextTheme.of(context)
                                                .labelSmall!
                                                .copyWith(
                                                    color: AppColors.gold)))),
                                  ]),
                                )),
                          )
                        ])),
                  ])
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
