import 'package:admin_panel_design/const/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              MiniTileCardWidget(
                                  title: Text("Pending Verifications",
                                      style: TextTheme.of(context)
                                          .labelMedium!
                                          .copyWith(
                                              color: AppColors.textSilver)),
                                  trailing: Text("100",
                                      style: TextTheme.of(context)
                                          .headlineSmall!)),
                              MiniTileCardWidget(
                                  title: Text("Verified",
                                      style: TextTheme.of(context)
                                          .labelMedium!
                                          .copyWith(
                                              color: AppColors.textSilver)),
                                  trailing: Text("1500",
                                      style: TextTheme.of(context)
                                          .headlineSmall!)),
                              CardWidget(
                                  widthRatio: 0.05,
                                  child: Icon(Icons.refresh, size: 20))
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Users verification",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
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
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 10),
                                                filled: true,
                                                fillColor: Colors.black,
                                                prefixIcon: Icon(Icons.search,
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
                                                style:
                                                    TextStyle(fontSize: 11))),
                                        DataColumn(
                                            label: Text('NAME',
                                                style:
                                                    TextStyle(fontSize: 11))),
                                        DataColumn(
                                            label: Text('',
                                                style:
                                                    TextStyle(fontSize: 11))),
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
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                  overflow:
                                                      TextOverflow.visible,
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
                                                          color: AppColors
                                                              .gold)))),
                                        ]),
                                      )),
                                )
                              ])),
                          CardWidget(
                              widthRatio: 0.23,
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
                                            title: Text("Twitter Username",
                                                style: TextStyle(
                                                    color: AppColors
                                                        .textSilverDark)),
                                            trailing: Row(children: [
                                              Icon(size: 20, Icons.copy),
                                              SizedBox(width: 7),
                                              Image.asset(
                                                  width: 20, AppImages.shareIos)
                                            ])))),
                                Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.black),
                                        child: CupertinoListTile(
                                            leading: Image.asset(
                                                AppImages.insta,
                                                width: 30),
                                            title: Text("Instagram Username",
                                                style: TextStyle(
                                                    color: AppColors
                                                        .textSilverDark)),
                                            trailing: Row(children: [
                                              Icon(size: 20, Icons.copy),
                                              SizedBox(width: 7),
                                              Image.asset(
                                                  width: 20, AppImages.shareIos)
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
                                            title: Text("Website URL",
                                                style: TextStyle(
                                                    color: AppColors
                                                        .textSilverDark)),
                                            trailing: Row(children: [
                                              Icon(size: 20, Icons.copy),
                                              SizedBox(width: 7),
                                              Image.asset(
                                                  width: 20, AppImages.shareIos)
                                            ])))),
                                SizedBox(height: 20),
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
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Image.asset(
                                                    AppImages.twitter,
                                                    width: 35)),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Image.asset(
                                                    AppImages.insta,
                                                    width: 35)),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Image.asset(
                                                    AppImages.global,
                                                    width: 35))
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
                                                          child: CircleAvatar(
                                                              radius: 38,
                                                              backgroundImage:
                                                                  AssetImage(
                                                                      AppImages
                                                                          .profile2)))),
                                                  Positioned(
                                                      right: 0,
                                                      bottom: 0,
                                                      child: Image.asset(
                                                          width: 40,
                                                          AppImages.goldcoin))
                                                ]),
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20)),
                                                        border: Border(
                                                          top: BorderSide(
                                                              width: 1,
                                                              color: AppColors
                                                                  .gold),
                                                          left: BorderSide(
                                                              width: 1,
                                                              color: AppColors
                                                                  .gold),
                                                          bottom: BorderSide(
                                                              width: 1,
                                                              color: AppColors
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
                                                        Text(" Estonia")
                                                      ]),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20)),
                                                        border: Border(
                                                          top: BorderSide(
                                                              width: 1,
                                                              color: AppColors
                                                                  .gold),
                                                          left: BorderSide(
                                                              width: 1,
                                                              color: AppColors
                                                                  .gold),
                                                          bottom: BorderSide(
                                                              width: 1,
                                                              color: AppColors
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
                                                        Text(" 3,2 KM")
                                                      ]),
                                                    ),
                                                  ),
                                                ]),
                                          ]),
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text("John Doe, 27 "),
                                                Image.asset(
                                                    width: 20,
                                                    AppImages.checkGold)
                                              ]),
                                          SizedBox(height: 5),
                                          Row(children: [
                                            Text("Consulting Business ",
                                                style: TextStyle(
                                                    color: AppColors.gold))
                                          ]),
                                          SizedBox(height: 5),
                                          Row(children: [
                                            Image.asset(AppImages.lang,
                                                width: 15),
                                            Text(
                                                "  Estonian 🇪🇪 • Russian 🇷🇺 • English 🇬🇧 ",
                                                style: TextTheme.of(context)
                                                    .labelSmall!)
                                          ]),
                                          SizedBox(height: 5),
                                          Text(
                                              """Guiding businesses' success through strategic.| Problem Solver | Empowering Growth 🌱 Let's solve challenges together! 💼 """,
                                              style: TextTheme.of(context)
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: AppColors
                                                          .textSilverDark)),
                                          SizedBox(height: 5),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: List.generate(
                                                  3,
                                                  (index) => Expanded(
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  width: 1,
                                                                  color:
                                                                      AppColors
                                                                          .gold,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              ),
                                                              child: Image.asset(
                                                                  AppImages
                                                                      .profile2)))))),
                                          SizedBox(height: 5),
                                          Row(children: [Text("Goals")]),
                                          SizedBox(height: 5),
                                          Row(children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors.gold)),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Text(
                                                        " 🤝 Find partners",
                                                        style: TextTheme.of(
                                                                context)
                                                            .labelSmall))),
                                            SizedBox(width: 8),
                                            Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors.gold)),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Text(
                                                        " 🌐 Network with others",
                                                        style: TextTheme.of(
                                                                context)
                                                            .labelSmall))),
                                          ]),
                                          SizedBox(height: 10),
                                          Row(children: [Text("Interest")]),
                                          SizedBox(height: 5),
                                          Wrap(
                                              direction: Axis.horizontal,
                                              alignment: WrapAlignment.start,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.start,
                                              runSpacing: 10,
                                              spacing: 10,
                                              children: [
                                                Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: AppColors
                                                                .gold)),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Text(
                                                            " 🖼️ Outdoor activites",
                                                            style: TextTheme.of(
                                                                    context)
                                                                .labelSmall))),
                                                Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: AppColors
                                                                .gold)),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Text(
                                                            " 🥋 Martial Arts",
                                                            style: TextTheme.of(
                                                                    context)
                                                                .labelSmall))),
                                                SizedBox(width: 18),
                                                Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: AppColors
                                                                .gold)),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Text(
                                                            " 📱 Social Media",
                                                            style: TextTheme.of(
                                                                    context)
                                                                .labelSmall))),
                                              ]),

                                          /////////////////
                                        ]),
                                      )
                                    ]),
                                  ),
                                ),
                                //////

                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(children: [
                                    Opacity(
                                      opacity: 0.3,
                                      child: OutlinedButton.icon(
                                          style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                  width: 1,
                                                  color: AppColors.textGreen)),
                                          icon: Icon(Icons.check_circle,
                                              color: AppColors.textGreen),
                                          onPressed: () {},
                                          label: Text("Valid",
                                              style: TextStyle(
                                                  color: AppColors.textGreen))),
                                    ),
                                    SizedBox(width: 10),
                                    OutlinedButton.icon(
                                        style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                                width: 1,
                                                color: AppColors.textRed)),
                                        icon: Icon(Icons.cancel,
                                            color: AppColors.textRed),
                                        onPressed: () {},
                                        label: Text("Invalid",
                                            style: TextStyle(
                                                color: AppColors.textRed)))
                                  ]),
                                ),
                                TextFormField(
                                  minLines: 3,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                      fillColor: Colors.black,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      hintText: "Reason why it's invalid"),
                                )
                              ])),
                          Column(children: [
                            CardWidget(
                              widthRatio: 0.2,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    Text("Idendity Card"),
                                    SizedBox(height: 5),
                                    TextFormField(
                                      minLines: 3,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                          fillColor: Colors.black,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          hintText: ""),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(children: [
                                        Opacity(
                                          opacity: 1,
                                          child: OutlinedButton.icon(
                                              style: OutlinedButton.styleFrom(
                                                  side: BorderSide(
                                                      width: 1,
                                                      color:
                                                          AppColors.textGreen)),
                                              icon: Icon(Icons.check_circle,
                                                  color: AppColors.textGreen),
                                              onPressed: () {},
                                              label: Text("Valid",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .textGreen))),
                                        ),
                                        SizedBox(width: 10),
                                        Opacity(
                                          opacity: 0.3,
                                          child: OutlinedButton.icon(
                                              style: OutlinedButton.styleFrom(
                                                  side: BorderSide(
                                                      width: 1,
                                                      color:
                                                          AppColors.textRed)),
                                              icon: Icon(Icons.cancel,
                                                  color: AppColors.textRed),
                                              onPressed: () {},
                                              label: Text("Invalid",
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.textRed))),
                                        )
                                      ]),
                                    ),
                                    TextFormField(
                                        minLines: 2,
                                        maxLines: 3,
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
                              widthRatio: 0.2,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    Text("Business Registration Proof"),
                                    SizedBox(height: 5),
                                    TextFormField(
                                      minLines: 3,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                          fillColor: Colors.black,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          hintText: ""),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(children: [
                                        Opacity(
                                          opacity: 1,
                                          child: OutlinedButton.icon(
                                              style: OutlinedButton.styleFrom(
                                                  side: BorderSide(
                                                      width: 1,
                                                      color:
                                                          AppColors.textGreen)),
                                              icon: Icon(Icons.check_circle,
                                                  color: AppColors.textGreen),
                                              onPressed: () {},
                                              label: Text("Valid",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .textGreen))),
                                        ),
                                        SizedBox(width: 10),
                                        Opacity(
                                          opacity: 0.3,
                                          child: OutlinedButton.icon(
                                              style: OutlinedButton.styleFrom(
                                                  side: BorderSide(
                                                      width: 1,
                                                      color:
                                                          AppColors.textRed)),
                                              icon: Icon(Icons.cancel,
                                                  color: AppColors.textRed),
                                              onPressed: () {},
                                              label: Text("Invalid",
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.textRed))),
                                        )
                                      ]),
                                    ),
                                    TextFormField(
                                        minLines: 2,
                                        maxLines: 3,
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
                                widthRatio: 0.2,
                                padding: EdgeInsets.all(20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          onTap: () {},
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 7),
                                                  child: Text("Done")))),
                                      InkWell(
                                          onTap: () {},
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
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 7),
                                                  child: Text("Back")))),
                                    ]))
                          ])
                        ])
                  ]),
            )));
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////// This page Widgets ///////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
