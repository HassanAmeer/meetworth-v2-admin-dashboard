import 'package:admin_panel/const/appColors.dart';
import 'package:admin_panel/const/appimages.dart';
import 'package:flutter/material.dart';
import '../widgets/headers.dart';
import '../widgets/minicard.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
        // appBar: AppBar(backgroundColor: Colors.transparent),
        body: Padding(
      padding: const EdgeInsets.all(14),
      child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(parent: BouncingScrollPhysics()),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DashboardHeader(),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CardWidget(
                          widthRatio: 0.52,
                          child: Column(children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("All Users",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                  Row(children: [
                                    OutlinedButton(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              width: 1, color: AppColors.gold),
                                        ),
                                        child: Text("Download CSV",
                                            style: TextTheme.of(context)
                                                .labelSmall!
                                                .copyWith(
                                                    color: AppColors.gold))),
                                    const SizedBox(width: 15),
                                    Container(
                                        width: 200,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: TextField(
                                            cursorHeight: 12,
                                            cursorColor: Colors.grey,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 10),
                                              filled: true,
                                              fillColor: Colors.black,
                                              prefixIcon: const Icon(
                                                  Icons.search,
                                                  color: Colors.white,
                                                  size: 17),
                                              hintText: "Search",
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide:
                                                          BorderSide.none),
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
                                ]),
                            ///////////////////////////////////////////////////////
                            SizedBox(
                              width: w * 0.75,
                              child: DataTable(
                                  columnSpacing: 0,
                                  // dataRowHeight: 40,
                                  dividerThickness: 0.1,
                                  border: const TableBorder(
                                      horizontalInside: BorderSide.none,
                                      verticalInside: BorderSide.none),
                                  columns: const [
                                    DataColumn(
                                        label: Text('User',
                                            style: TextStyle(fontSize: 11))),
                                    DataColumn(
                                        label: Text('Email',
                                            style: TextStyle(fontSize: 11))),
                                    DataColumn(
                                        label: Text('Gender',
                                            style: TextStyle(fontSize: 11))),
                                    DataColumn(
                                        label: Text('USERNAME',
                                            style: TextStyle(fontSize: 11))),
                                    DataColumn(
                                        label: Text('VERIFICATION',
                                            style: TextStyle(fontSize: 11))),
                                    DataColumn(
                                        label: Text('MEMBERSHIP',
                                            style: TextStyle(fontSize: 11))),
                                    DataColumn(
                                        label: Text('STATUS',
                                            style: TextStyle(fontSize: 11))),
                                    DataColumn(
                                        label: Text('ACTION',
                                            style: TextStyle(fontSize: 11))),
                                  ],
                                  rows: List.generate(
                                    20,
                                    (index) => DataRow(cells: [
                                      DataCell(Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircleAvatar(
                                                radius: 14,
                                                backgroundColor: AppColors.gold,
                                                child: CircleAvatar(
                                                    radius: 13,
                                                    backgroundImage: AssetImage(
                                                        AppImages.profile2))),
                                            const SizedBox(
                                                width: 70,
                                                child: Text(
                                                    textAlign: TextAlign.center,
                                                    '  limoouesla-testlonger',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                    overflow:
                                                        TextOverflow.visible,
                                                    maxLines: 3))
                                          ])),
                                      const DataCell(SizedBox(
                                        width: 90,
                                        child: Wrap(
                                          children: [
                                            Text('Limo.oueslati@gmail.com',
                                                style: TextStyle(fontSize: 10),
                                                overflow: TextOverflow.fade),
                                          ],
                                        ),
                                      )),
                                      const DataCell(Row(children: [
                                        Text('Male  ',
                                            style: TextStyle(fontSize: 10)),
                                        Icon(Icons.male, size: 12),
                                      ])),
                                      const DataCell(SizedBox(
                                          width: 80,
                                          child: Text(
                                              textAlign: TextAlign.start,
                                              'limoouesla',
                                              style: TextStyle(fontSize: 10),
                                              overflow: TextOverflow.visible,
                                              maxLines: 3))),
                                      const DataCell(SizedBox(
                                          width: 80,
                                          child: Text(
                                              textAlign: TextAlign.start,
                                              'Verified',
                                              style: TextStyle(fontSize: 10),
                                              overflow: TextOverflow.visible,
                                              maxLines: 3))),
                                      const DataCell(
                                        Text('FREE',
                                            style: TextStyle(fontSize: 10)),
                                      ),
                                      DataCell(Row(children: [
                                        InkWell(
                                            onTap: () {},
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: const Icon(
                                                Icons.check_circle,
                                                size: 18,
                                                color: AppColors.textGreen)),
                                        const Text(' ACTIVE',
                                            style: TextStyle(fontSize: 10))
                                      ])),
                                      DataCell(Row(children: [
                                        InkWell(
                                            onTap: () {},
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: const Icon(Icons.cancel,
                                                size: 18,
                                                color: AppColors.textRed)),
                                        const SizedBox(width: 7),
                                        InkWell(
                                            onTap: () {},
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                                width: 15, AppImages.shareIos))
                                      ])),
                                    ]),
                                  )),
                            )
                          ])),
                      Column(children: [
                        CardWidget(
                            padding: const EdgeInsets.all(15),
                            widthRatio: 0.25,
                            child: Column(children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Filters",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                    OutlinedButton(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              width: 1, color: AppColors.gold),
                                        ),
                                        child: Text("Recent Filters",
                                            style: TextTheme.of(context)
                                                .labelSmall!
                                                .copyWith(
                                                    color: AppColors.gold))),
                                  ]),
                              const Row(children: [
                                Text("GENDER: ",
                                    style:
                                        TextStyle(color: AppColors.silverGold)),
                                Row(children: [
                                  Text("Male"),
                                  SizedBox(width: 5),
                                  Icon(Icons.male, size: 12)
                                ])
                              ]),
                              const Divider(thickness: 0.1),
                              const Row(children: [
                                Text("VARIFICATION: ",
                                    style:
                                        TextStyle(color: AppColors.silverGold)),
                                Row(children: [
                                  Text("Verified"),
                                  SizedBox(width: 5),
                                  Icon(Icons.check, size: 12)
                                ])
                              ]),
                              const Divider(thickness: 0.1),
                              const Row(children: [
                                Text("MEMBERSHIP: ",
                                    style:
                                        TextStyle(color: AppColors.silverGold)),
                                Text(
                                  "Bronze",
                                ),
                              ]),
                              const Divider(thickness: 0.1),
                              const Row(children: [
                                Text("STATUS: ",
                                    style:
                                        TextStyle(color: AppColors.silverGold)),
                                Row(children: [
                                  Icon(Icons.cancel,
                                      color: AppColors.textRed, size: 12),
                                  SizedBox(width: 5),
                                  Text("Blocked"),
                                ])
                              ]),
                            ])),
                        Row(children: [
                          CardWidget(
                              widthRatio: 0.12,
                              padding: const EdgeInsets.all(15),
                              child: Column(children: [
                                Text("Selection",
                                    style: TextTheme.of(context).headlineSmall),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.gold),
                                    onPressed: () {},
                                    child: const Text("Selection is on",
                                        style: TextStyle(color: Colors.white))),
                              ])),
                          CardWidget(
                              widthRatio: 0.12,
                              padding: const EdgeInsets.all(15),
                              child: Column(children: [
                                Text("Action",
                                    style: TextTheme.of(context).headlineSmall),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(children: [
                                      InkWell(
                                          onTap: () {},
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: const Icon(Icons.cancel,
                                              size: 18,
                                              color: AppColors.textRed)),
                                      const Text(' Block',
                                          style: TextStyle(fontSize: 10))
                                    ]),
                                    Row(children: [
                                      InkWell(
                                          onTap: () {},
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: const Icon(Icons.check_circle,
                                              size: 18,
                                              color: AppColors.textGreen)),
                                      const Text(' Unblock',
                                          style: TextStyle(fontSize: 10))
                                    ]),
                                  ],
                                )
                              ])),
                        ]),
                        CardWidget(
                            padding: const EdgeInsets.all(15),
                            widthRatio: 0.25,
                            child: Column(children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Filters",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                    CircleAvatar(
                                        radius: 30,
                                        backgroundColor: AppColors.gold,
                                        child: CircleAvatar(
                                            radius: 28,
                                            backgroundImage: AssetImage(
                                                AppImages.profile2))),
                                  ]),
                              const Row(children: [
                                Text("Name: ",
                                    style:
                                        TextStyle(color: AppColors.silverGold)),
                                Text("Limo Oueslati"),
                              ]),
                              const SizedBox(height: 7),
                              const Row(children: [
                                Text("Username: ",
                                    style:
                                        TextStyle(color: AppColors.silverGold)),
                                Text("Limo Oueslati"),
                              ]),
                              const SizedBox(height: 7),
                              const Row(children: [
                                Text("Number: ",
                                    style:
                                        TextStyle(color: AppColors.silverGold)),
                                Text("Not given"),
                              ]),
                              const SizedBox(height: 7),
                              const Row(children: [
                                Text("Mail: ",
                                    style:
                                        TextStyle(color: AppColors.silverGold)),
                                Text("limo.oueslati@gmail.com"),
                              ]),
                              const SizedBox(height: 7),
                              const Row(children: [
                                Text("Age: ",
                                    style:
                                        TextStyle(color: AppColors.silverGold)),
                                Text("25"),
                              ]),
                              const SizedBox(height: 30),
                              const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Status: ",
                                        style: TextStyle(
                                            color: AppColors.silverGold)),
                                    Text("Manually varified: ",
                                        style: TextStyle(
                                            color: AppColors.silverGold)),
                                    Text("Membership: ",
                                        style: TextStyle(
                                            color: AppColors.silverGold)),
                                  ]),
                              const SizedBox(height: 10),
                              const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.check_circle,
                                        color: AppColors.textGreen, size: 20),
                                    Icon(Icons.check_circle,
                                        color: AppColors.textGreen, size: 20),
                                    Icon(Icons.cancel,
                                        color: AppColors.textRed, size: 20),
                                  ]),
                              const Divider(thickness: 0.1),
                              const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Text("Membership: ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.silverGold,
                                          )),
                                      SizedBox(width: 5),
                                      Text("Gold",
                                          style:
                                              TextStyle(color: AppColors.gold))
                                    ]),
                                    Row(children: [
                                      Text("Expire Date: ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.silverGold)),
                                      SizedBox(width: 5),
                                      Text("08/06/2023"),
                                    ])
                                  ]),
                              const Divider(thickness: 0.1),
                              const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Text("Business Type: ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.silverGold,
                                          )),
                                      SizedBox(width: 5),
                                      Text("Family Law")
                                    ]),
                                    Row(children: [
                                      Text("Verification: ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.silverGold)),
                                      SizedBox(width: 5),
                                      Text("Verified"),
                                    ])
                                  ]),
                              const Divider(thickness: 0.1),
                              const Row(children: [
                                Text("Average session time: ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.silverGold,
                                    )),
                                SizedBox(width: 5),
                                Text("10 minutes")
                              ]),
                              const Divider(thickness: 0.1),
                              const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Text("Joine: ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.silverGold,
                                          )),
                                      SizedBox(width: 5),
                                      Text("03/10/2024 at Paris")
                                    ]),
                                    Row(children: [
                                      Text("Number of referrals: ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.silverGold)),
                                      SizedBox(width: 5),
                                      Text("123"),
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
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              width: 1, color: AppColors.gold),
                                        ),
                                        child: Text("Download CSV",
                                            style: TextTheme.of(context)
                                                .labelSmall!
                                                .copyWith(
                                                    color: AppColors.gold))),
                                  ]),
                              const Divider(thickness: 0.1),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Image.asset(
                                            width: 50, AppImages.twitter)),
                                    Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Image.asset(
                                            width: 50, AppImages.insta)),
                                    Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Image.asset(
                                            width: 50, AppImages.global)),
                                  ])
                            ])),
                      ]),
                    ])
              ])),
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
