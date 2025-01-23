import 'dart:async';

import 'package:admin_panel_design/screens/homePage.dart';
import 'package:admin_panel_design/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'const/appcolors.dart';
import 'const/appimages.dart';

void main() async {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MeetWorth',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            scaffoldBackgroundColor: AppColors.bgColor,
            useMaterial3: true,
            primaryIconTheme: IconThemeData(color: AppColors.primaryMid),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: AppColors.primaryMid,
              selectionColor: AppColors.primary,
            ),
            textTheme: TextTheme(
              headlineSmall: TextStyle(color: AppColors.textLight),
              headlineLarge: TextStyle(color: AppColors.textLight),
              headlineMedium: TextStyle(color: AppColors.textLight),
              titleSmall: TextStyle(color: AppColors.textLight),
              titleLarge: TextStyle(color: AppColors.textLight),
              titleMedium: TextStyle(color: AppColors.textLight),
              bodyLarge: TextStyle(color: AppColors.textLight),
              bodyMedium: TextStyle(color: AppColors.textLight),
              bodySmall: TextStyle(color: AppColors.textLight),
              labelLarge: TextStyle(color: AppColors.textLight),
              labelMedium: TextStyle(color: AppColors.textLight),
              labelSmall: TextStyle(color: AppColors.textLight),
              displayLarge: TextStyle(color: AppColors.textLight),
              displayMedium: TextStyle(color: AppColors.textLight),
              displaySmall: TextStyle(color: AppColors.textLight),
            ),
            iconTheme: IconThemeData(color: AppColors.iconLight),
            appBarTheme: AppBarTheme(
                centerTitle: true,
                titleTextStyle: TextStyle(color: AppColors.primaryMid))),
        home: const SidebarWidget(),
        builder: EasyLoading.init());
  }
}

/////////////////

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.wanderingCubes
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColors.primaryDark
    ..backgroundColor = AppColors.sideBarBgColor
    ..indicatorColor = AppColors.primary
    ..textColor = AppColors.primary
    ..maskColor = AppColors.transparenCardBlack
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}
/////////////////

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    onlineSpan();
  }

  onlineSpan() async {
    try {
      Timer(const Duration(seconds: 3), () async {
        Navigator.of(context).pushReplacement(PageRouteBuilder(
            transitionDuration: const Duration(seconds: 3),
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomePage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child)));
      });
    } catch (e) {
      debugPrint("💥 UsergetData on splash Error:$e");
      Timer(const Duration(seconds: 3), () async {
        Navigator.of(context).pushReplacement(PageRouteBuilder(
            transitionDuration: const Duration(seconds: 3),
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomePage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(color: AppColors.primary[50]),
        child: Scaffold(
            backgroundColor: AppColors.primary[50],
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8 / 1,
                          child: Image.asset(
                            AppImages.logodark,
                            // color: AppColor.primary.withOpacity(0.1),
                          )).animate().scale()),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Text('Meetworth V2',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary[400],
                                  shadows: [
                                BoxShadow(
                                    color: AppColors.primary[200]!,
                                    offset: const Offset(1, 1),
                                    blurRadius: 2)
                              ]))
                      .animate(
                          delay: 500.ms,
                          onPlay: (controller) => controller.repeat())
                      .shakeX()
                      .shimmer(
                          duration: const Duration(seconds: 2),
                          delay: const Duration(milliseconds: 1000))
                      .shimmer(
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInOut),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: const LinearProgressIndicator(minHeight: 1)
                          .animate(
                              delay: 500.ms,
                              onPlay: (controller) => controller.repeat())
                          .shakeX()
                          .shimmer(
                              duration: const Duration(seconds: 2),
                              delay: const Duration(milliseconds: 1000))
                          .shimmer(
                              duration: const Duration(seconds: 2),
                              curve: Curves.easeInOut)),
                ])));
  }
}
