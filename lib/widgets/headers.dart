import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../const/appColors.dart';
import '../const/appImages.dart';
import '../vm/homeVm.dart';

class DashboardHeader extends ConsumerStatefulWidget {
  DashboardHeader({super.key});

  @override
  ConsumerState<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends ConsumerState<DashboardHeader> {
  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var p = ref.watch(homeVm);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      var isPhone = constraints.maxWidth <= 424;
      var isTablet =
          (constraints.maxWidth >= 424 && constraints.maxWidth <= 1024);
      return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: isPhone ? 4 : 16.0, vertical: isPhone ? 12 : 24.0),
          child: Flex(
              direction: isPhone ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: isPhone
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left: Title and Breadcrumb
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          width: isPhone ? 230 : 200,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(4),
                          child: TextField(
                              onSubmitted: (query) {
                                p.searchUsersF(
                                    loadingFor: 'search',
                                    showLoading: true,
                                    query: queryController.text);
                              },
                              onTap: () {
                                p.searchUsersF(
                                    loadingFor: 'search',
                                    showLoading: true,
                                    query: queryController.text);
                              },
                              cursorHeight: 12,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                filled: true,
                                fillColor: Colors.black,
                                prefixIcon: const Icon(Icons.search,
                                    color: Colors.white, size: 17),
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
                      // SizedBox(width: isPhone ? 7 : 16),
                      // Notification Icon
                      IconButton(
                          onPressed: () {
                            p.setTabSelectedIndexF(3);
                          },
                          icon: const Icon(Icons.notifications_outlined,
                              color: Colors.white, size: 24)),
                      // SizedBox(width: isPhone ? 7 : 16),
                      // Info Icon
                      // IconButton(
                      //   onPressed: () {
                      //     p.setTabSelectedIndexF(9);
                      //   },
                      //   icon: const Icon(Icons.info_outline,
                      //       color: Colors.white, size: 24),
                      // ),
                      // SizedBox(width: isPhone ? 7 : 16),
                      // Profile Image
                      isPhone
                          ? const SizedBox.shrink()
                          : InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {
                                p.setTabSelectedIndexF(9);
                              },
                              child: ClipOval(
                                  child: Image.asset(AppImages.profile2,
                                      width: 36,
                                      height: 36,
                                      fit: BoxFit.cover)),
                            ),
                      const SizedBox(width: 4),
                    ]))
              ]));
    });
  }
}
/////////////
