import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meetworth_admin/const/appColors.dart';
import 'package:meetworth_admin/const/appImages.dart';
import 'package:meetworth_admin/screens/catg.dart';
import 'package:meetworth_admin/screens/profile.dart';
import 'package:meetworth_admin/screens/verifications.dart';
import 'package:cupertino_sidebar/cupertino_sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/faq.dart';
import '../screens/goals.dart';
import '../screens/interest.dart';
import '../screens/lang.dart';
import '../screens/notifications.dart';
import '../screens/users.dart';
import '../screens/homePage.dart';
import '../vm/authVm.dart';

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
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Row(children: [
      CupertinoSidebar(
          maxWidth: MediaQuery.of(context).size.width * 0.18,
          backgroundColor: AppColors.bgCard,
          // selectedIndex: _selectedIndex,
          onDestinationSelected: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          ////////////////////////////
          navigationBar: SidebarNavigationBar(
            title: Center(
              child: Transform.translate(
                offset: const Offset(0, -20),
                child: Image.asset(
                    width: MediaQuery.of(context).size.width * 0.14,
                    AppImages.logoText),
              ),
            ),
          ),
          children: [
            SidebarDestination(
                // isSelected: _selectedIndex == 0 ? true : false,
                icon: Icon(CupertinoIcons.home,
                    color: _selectedIndex == 0
                        ? AppColors.primaryMid
                        : _selectedIndex == 0
                            ? AppColors.primaryMid
                            : Colors.white),
                label: Text(
                  'Home',
                  style: TextStyle(
                      color: _selectedIndex == 0
                          ? AppColors.primaryMid
                          : Colors.white),
                )),
            SidebarDestination(
                // isSelected: _selectedIndex == 1 ? true : false,
                icon: Icon(
                  CupertinoIcons.person,
                  color:
                      _selectedIndex == 1 ? AppColors.primaryMid : Colors.white,
                ),
                label: Text(
                  'Users',
                  style: TextStyle(
                      color: _selectedIndex == 1
                          ? AppColors.primaryMid
                          : Colors.white),
                )),
            SidebarDestination(
                // isSelected: _selectedIndex == 2 ? true : false,
                icon: Icon(Icons.verified,
                    color: _selectedIndex == 2
                        ? AppColors.primaryMid
                        : Colors.white),
                label: Text('Verifications',
                    style: TextStyle(
                        color: _selectedIndex == 2
                            ? AppColors.primaryMid
                            : Colors.white))),
            SidebarDestination(
                // isSelected: _selectedIndex == 2 ? true : false,
                icon: Icon(Icons.notifications_active,
                    color: _selectedIndex == 3
                        ? AppColors.primaryMid
                        : Colors.white),
                label: Text('Notifications',
                    style: TextStyle(
                        color: _selectedIndex == 3
                            ? AppColors.primaryMid
                            : Colors.white))),
            SidebarDestination(
                // isSelected: _selectedIndex == 2 ? true : false,
                icon: Icon(Icons.category_outlined,
                    color: _selectedIndex == 4
                        ? AppColors.primaryMid
                        : Colors.white),
                label: Text('Business Categories',
                    style: TextStyle(
                        color: _selectedIndex == 4
                            ? AppColors.primaryMid
                            : Colors.white))),
            SidebarDestination(
                // isSelected: _selectedIndex == 2 ? true : false,
                icon: Icon(Icons.interests,
                    color: _selectedIndex == 5
                        ? AppColors.primaryMid
                        : Colors.white),
                label: Text('Interests',
                    style: TextStyle(
                        color: _selectedIndex == 5
                            ? AppColors.primaryMid
                            : Colors.white))),
            SidebarDestination(
                // isSelected: _selectedIndex == 2 ? true : false,
                icon: Icon(Icons.translate,
                    color: _selectedIndex == 6
                        ? AppColors.primaryMid
                        : Colors.white),
                label: Text('Language',
                    style: TextStyle(
                        color: _selectedIndex == 6
                            ? AppColors.primaryMid
                            : Colors.white))),
            SidebarDestination(
                // isSelected: _selectedIndex == 2 ? true : false,
                icon: Icon(Icons.batch_prediction_outlined,
                    color: _selectedIndex == 7
                        ? AppColors.primaryMid
                        : Colors.white),
                label: Text('Goals',
                    style: TextStyle(
                        color: _selectedIndex == 7
                            ? AppColors.primaryMid
                            : Colors.white))),
            SidebarDestination(
                // isSelected: _selectedIndex == 2 ? true : false,
                icon: Icon(Icons.format_quote,
                    color: _selectedIndex == 8
                        ? AppColors.primaryMid
                        : Colors.white),
                label: Text('FAQs',
                    style: TextStyle(
                        color: _selectedIndex == 8
                            ? AppColors.primaryMid
                            : Colors.white))),
            SidebarDestination(
                // isSelected: _selectedIndex == 2 ? true : false,
                icon: Icon(Icons.person_4,
                    color: _selectedIndex == 9
                        ? AppColors.primaryMid
                        : Colors.white),
                label: Text('Profile',
                    style: TextStyle(
                        color: _selectedIndex == 9
                            ? AppColors.primaryMid
                            : Colors.white))),
            SidebarDestination(
                onTap: () {
                  ref.read(authVm).logOut(context);
                },
                // isSelected: _selectedIndex == 2 ? true : false,
                icon: Icon(Icons.logout,
                    color: _selectedIndex == 10
                        ? AppColors.primaryMid
                        : Colors.orange),
                label: Text('Logout',
                    style: TextStyle(
                        color: _selectedIndex == 10
                            ? AppColors.primaryMid
                            : Colors.orange))),
          ]),
      SizedBox(
          width: MediaQuery.of(context).size.width * 0.82,
          child: CupertinoTabTransitionBuilder(
              duration: const Duration(milliseconds: 700),
              child: _pages.elementAt(_selectedIndex)))
    ]));
  }
}
