import 'dart:async';

import 'package:admin_panel/screens/homePage.dart';
import 'package:admin_panel/widgets/sidebar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'const/appcolors.dart';
import 'const/appimages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MeetWorth Admin',
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
            textTheme: const TextTheme(
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
            iconTheme: const IconThemeData(color: AppColors.iconLight),
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






// ******** remainings in db side
//  accountCreationLocation
//

// ******** remainings in app side
// totalShare in posts 
// appInfo
// loadtime


/////////////////////////////////////////////////////////////////
//
// clienstjobs@gmail.com
// A87WbTFgL3MVO3GFN5r0cxnpHmI3
//
////////



//------------  new variables --------------
/// splashTimes = [] ---> for seassion duration,Frequency of use, Retention rate, 
///  , and ---->  churn rate >> if user not available from last 7 days divided by actvive last days users
/// 
/// creationDate
///   
/// 
/// 



//////////////////
/// Connection made: 
/// when users tender request > how much accept 
///  

//////////////////
/// Session Duration: 
/// login time and logout time + on home page should get click time every time 
///  
/// 
//////////////////
/// Frequency of use: 
/// specific time period (daily, weekly, or monthly). 
/// 
//////////////////
/// Retention Rate: 
/// total clicks numbers / open app times number * 100
/// 
/// 
//////////////////
/// churn rate 
/// Users who don’t open the app within a specific time frame
/// or uninstall 
/// --> for this count users from last month how much active
/// 
/// 
/// 
/////////////////
// analytics logEvent
// FirebaseAnalytics.instance.logAppOpen
// userOnline
// userOffline
// paidMembership
//  .logLogin(loginMethod: "SignIn Google", 
// .logLogin(loginMethod: "SignUp Email"
//  .logLogin(loginMethod: "SignIn Phone Number"
// .logSignUp(signUpMethod: "SignUp Phone Number",
// .logLogin(loginMethod: "SignIn Email",
//  .logLogin(loginMethod: "SignIn Facebook", 
//  .logSignUp(signUpMethod: "SignUp Facebook",
//  .logLogin(loginMethod: "SignIn Apple"
//   .logSignUp(signUpMethod: "SignUp Apple"
//
//
//  ogEvent(name: "completeRegistration",
//   .logSignUp(signUpMethod: "Email",
//   .logEvent(name: "userOnline", 
//   .logEvent(name: "userOffline",
//
// .logEvent(name: "⁠⁠tutorialStart",
//  .logEvent(name: "⁠⁠skipTutorial", 
//    .logEvent(name: "⁠⁠completeTutorial", 
//
// .logEvent(name: "⁠getMatch",
//   .logEvent(name: "swipeCard",
/// / FirebaseAnalytics.instance.logEvent(name: "swipeCard", 
//
//   .logEvent(name: "openMembershipScreen"
//
//  FirebaseAnalytics.instance.logEvent(name: "getReferance",
//
// await FirebaseAnalytics.instance.logEvent(name: "getReferance",
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//
// 
//





//////////////////////////////
// class AppUsageTracker with WidgetsBindingObserver {
//   DateTime? _startTime;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//     WidgetsBinding.instance.addObserver(this);
//     _startTime = DateTime.now();
//   }

//   void stopTracking() {
//     WidgetsBinding.instance.removeObserver(this);
//     _logAppUsage();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused) {
//       // App went to the background
//       _logAppUsage();
//     } else if (state == AppLifecycleState.resumed) {
//       // App came back to the foreground
//       _startTime = DateTime.now();
//     }
//   }

//   void _logAppUsage() async {
//     if (_startTime != null) {
//       final endTime = DateTime.now();
//       final duration = endTime.difference(_startTime!);

//       // Get the user ID (you can use Firebase Auth to get the UID)
//       final userId = 'user123'; // Replace with actual user ID

//       // Update the total usage time in Firestore
//       final userRef = _firestore.collection('users').doc(userId);
//       final userDoc = await userRef.get();

//       int totalUsageTime = userDoc.exists ? userDoc['total_usage_time'] ?? 0 : 0;
//       totalUsageTime += duration.inSeconds;

//       await userRef.set({
//         'total_usage_time': totalUsageTime,
//         'last_updated': DateTime.now(),
//       }, SetOptions(merge: true));

//       _startTime = null;
//     }
//   }
// }

// in another page
  // final AppUsageTracker _appUsageTracker = AppUsageTracker();

  // @override
  // void initState() {
  //   super.initState();
  //   _appUsageTracker.startTracking();
  // }

  // @override
  // void dispose() {
  //   _appUsageTracker.stopTracking();
  //   super.dispose();
  // }




  ////////--------------
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
