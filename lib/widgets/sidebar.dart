import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meetworth_admin/const/appColors.dart';
import 'package:meetworth_admin/const/appImages.dart';
import 'package:meetworth_admin/screens/catg.dart';
import 'package:meetworth_admin/screens/profile.dart';
import 'package:meetworth_admin/screens/verifications.dart';
import 'package:cupertino_sidebar/cupertino_sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../screens/faq.dart';
import '../screens/goals.dart';
import '../screens/interest.dart';
import '../screens/lang.dart';
import '../screens/notifications.dart';
import '../screens/users.dart';
import '../screens/homePage.dart';
import '../vm/authVm.dart';
import '../vm/homeVm.dart';

class SidebarWidget extends ConsumerStatefulWidget {
  const SidebarWidget({super.key});

  @override
  ConsumerState<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends ConsumerState<SidebarWidget> {
  // A list of pages to be displayed as the destination content.
  final _pages = [
    const HomePage(),
    const UsersPage(),
    const VerificatiosPage(),
    const NotificationsPage(),
    const CatgPage(),
    const InerestPage(),
    const LanguagePage(),
    const GoalsPage(),
    const FaqPages(),
    const ProfilePage(),
  ];

  // The index of the currently selected page.
  // int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var p = ref.watch(homeVm);

    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      var isPhone = Device.screenType == ScreenType.mobile;

      return CupertinoPageScaffold(
          child: Row(children: [
        CupertinoSidebar(
            padding: isPhone
                ? const EdgeInsets.all(0)
                : EdgeInsets.symmetric(horizontal: w * 0.02),
            maxWidth: isPhone ? w * 0.13 : w * 0.18,
            backgroundColor: AppColors.bgCard,
            // selectedIndex: _selectedIndex,
            onDestinationSelected: (value) {
              // setState(() {
              //   _selectedIndex = value;
              // });
              p.setTabSelectedIndexF(value);
            },
            ////////////////////////////
            navigationBar: SidebarNavigationBar(
                title: Center(
                    child: Transform.translate(
                        offset: isPhone
                            ? const Offset(-5, -17)
                            : const Offset(0, -20),
                        child: Image.asset(
                            width: MediaQuery.of(context).size.width * 0.1,
                            isPhone ? AppImages.logo : AppImages.logoText)))),
            children: [
              SidebarDestination(
                  // isSelected: _selectedIndex == 0 ? true : false,
                  icon: Icon(CupertinoIcons.home,
                      color: p.selectedIndex == 0
                          ? AppColors.primaryMid
                          : p.selectedIndex == 0
                              ? AppColors.primaryMid
                              : Colors.white),
                  label: isPhone
                      ? const SizedBox.shrink()
                      : Text(
                          'Home',
                          style: TextStyle(
                              color: p.selectedIndex == 0
                                  ? AppColors.primaryMid
                                  : Colors.white),
                        )),
              SidebarDestination(
                  // isSelected: p.selectedIndex == 1 ? true : false,
                  icon: Icon(CupertinoIcons.person,
                      color: p.selectedIndex == 1
                          ? AppColors.primaryMid
                          : Colors.white),
                  label: isPhone
                      ? const SizedBox.shrink()
                      : Text('Users',
                          style: TextStyle(
                              color: p.selectedIndex == 1
                                  ? AppColors.primaryMid
                                  : Colors.white))),
              SidebarDestination(
                  // isSelected: p.selectedIndex == 2 ? true : false,
                  icon: Icon(Icons.verified,
                      color: p.selectedIndex == 2
                          ? AppColors.primaryMid
                          : Colors.white),
                  label: isPhone
                      ? const SizedBox.shrink()
                      : Text('Verifications',
                          style: TextStyle(
                              color: p.selectedIndex == 2
                                  ? AppColors.primaryMid
                                  : Colors.white))),
              SidebarDestination(
                  // isSelected: p.selectedIndex == 2 ? true : false,
                  icon: Icon(Icons.notifications_active,
                      color: p.selectedIndex == 3
                          ? AppColors.primaryMid
                          : Colors.white),
                  label: isPhone
                      ? const SizedBox.shrink()
                      : Text('Notifications',
                          style: TextStyle(
                              color: p.selectedIndex == 3
                                  ? AppColors.primaryMid
                                  : Colors.white))),
              SidebarDestination(
                  // isSelected: p.selectedIndex == 2 ? true : false,
                  icon: Icon(Icons.category_outlined,
                      color: p.selectedIndex == 4
                          ? AppColors.primaryMid
                          : Colors.white),
                  label: isPhone
                      ? const SizedBox.shrink()
                      : Text('Business Categories',
                          style: TextStyle(
                              color: p.selectedIndex == 4
                                  ? AppColors.primaryMid
                                  : Colors.white))),
              SidebarDestination(
                  // isSelected: p.selectedIndex == 2 ? true : false,
                  icon: Icon(Icons.interests,
                      color: p.selectedIndex == 5
                          ? AppColors.primaryMid
                          : Colors.white),
                  label: isPhone
                      ? const SizedBox.shrink()
                      : Text('Interests',
                          style: TextStyle(
                              color: p.selectedIndex == 5
                                  ? AppColors.primaryMid
                                  : Colors.white))),
              SidebarDestination(
                  // isSelected: p.selectedIndex == 2 ? true : false,
                  icon: Icon(Icons.translate,
                      color: p.selectedIndex == 6
                          ? AppColors.primaryMid
                          : Colors.white),
                  label: isPhone
                      ? const SizedBox.shrink()
                      : Text('Language',
                          style: TextStyle(
                              color: p.selectedIndex == 6
                                  ? AppColors.primaryMid
                                  : Colors.white))),
              SidebarDestination(
                  // isSelected: p.selectedIndex == 2 ? true : false,
                  icon: Icon(Icons.batch_prediction_outlined,
                      color: p.selectedIndex == 7
                          ? AppColors.primaryMid
                          : Colors.white),
                  label: isPhone
                      ? const SizedBox.shrink()
                      : Text('Goals',
                          style: TextStyle(
                              color: p.selectedIndex == 7
                                  ? AppColors.primaryMid
                                  : Colors.white))),
              SidebarDestination(
                  // isSelected: p.selectedIndex == 2 ? true : false,
                  icon: Icon(Icons.format_quote,
                      color: p.selectedIndex == 8
                          ? AppColors.primaryMid
                          : Colors.white),
                  label: isPhone
                      ? const SizedBox.shrink()
                      : Text('FAQs',
                          style: TextStyle(
                              color: p.selectedIndex == 8
                                  ? AppColors.primaryMid
                                  : Colors.white))),
              SidebarDestination(
                  // isSelected: p.selectedIndex == 2 ? true : false,
                  icon: Icon(Icons.person_4,
                      color: p.selectedIndex == 9
                          ? AppColors.primaryMid
                          : Colors.white),
                  label: isPhone
                      ? const SizedBox.shrink()
                      : Text('Profile',
                          style: TextStyle(
                              color: p.selectedIndex == 9
                                  ? AppColors.primaryMid
                                  : Colors.white))),
              SidebarDestination(
                  onTap: () async {
                    await ref.read(authVm).logOut(context);
                  },
                  // isSelected: p.selectedIndex == 2 ? true : false,
                  icon: Icon(Icons.logout,
                      color: p.selectedIndex == 10
                          ? AppColors.primaryMid
                          : Colors.orange),
                  label: isPhone
                      ? const SizedBox.shrink()
                      : Text('Logout',
                          style: TextStyle(
                              color: p.selectedIndex == 10
                                  ? AppColors.primaryMid
                                  : Colors.orange))),
            ]),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.82,
            child: CupertinoTabTransitionBuilder(
                duration: const Duration(milliseconds: 700),
                child: _pages.elementAt(p.selectedIndex)))
      ]));
    });
  }
}
