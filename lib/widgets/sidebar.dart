import 'package:admin_panel/const/appColors.dart';
import 'package:admin_panel/const/appImages.dart';
import 'package:admin_panel/screens/verifications.dart';
import 'package:cupertino_sidebar/cupertino_sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/users.dart';
import '../screens/homePage.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget({super.key});

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  // A list of pages to be displayed as the destination content.
  final _pages = [
    const HomePage(),
    const UsersPage(),
    const VerificatiosPage(),
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
          ]),
      SizedBox(
          width: MediaQuery.of(context).size.width * 0.82,
          child: CupertinoTabTransitionBuilder(
              duration: const Duration(milliseconds: 700),
              child: _pages.elementAt(_selectedIndex)))
    ]));
  }
}
