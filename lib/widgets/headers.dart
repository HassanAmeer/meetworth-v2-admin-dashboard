import 'package:flutter/material.dart';

import '../const/appColors.dart';
import '../const/appImages.dart';

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
