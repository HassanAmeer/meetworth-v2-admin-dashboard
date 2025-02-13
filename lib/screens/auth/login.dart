import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meetworth_admin/const/appColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meetworth_admin/vm/authVm.dart';
import 'package:meetworth_admin/widgets/dotloader.dart';
import 'package:meetworth_admin/widgets/minicard.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    // syncFirstF();
  }

  // syncFirstF() {
  //   User? fbUser = FirebaseAuth.instance.currentUser;
  //   if (fbUser != null) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => const SidebarWidget()));
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var p = ref.watch(authVm);
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      var isPhone = constraints.maxWidth <= 424;
      var isTablet =
          (constraints.maxWidth >= 424 && constraints.maxWidth <= 1024);
      // var desktop = constraints.maxWidth >= 1024;

      return Stack(children: [
        Container(color: AppColors.bgColor),
        Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CardWidget(
                    // color: AppColors.bgField,
                    // constraints: const BoxConstraints(maxWidth: 400),
                    widthRatio: isPhone
                        ? 0.8
                        : isTablet
                            ? 0.6
                            : 0.3,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(children: [
                            const Spacer(),
                            Center(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset("assets/icons/logo.jpg",
                                        height: h * 0.11, width: h * 0.11))),
                            Expanded(child: Container())
                          ]),
                          const SizedBox(height: 30),
                          Row(children: [
                            Text("Login",
                                style: GoogleFonts.quicksand(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                          ]),
                          const SizedBox(height: 10),
                          Row(children: [
                            customText(
                                text: "Welcome back to the admin panel.",
                                color: Colors.white)
                          ]),
                          const SizedBox(height: 15),
                          TextField(
                              controller: email,
                              style: const TextStyle(color: Colors.grey),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Email",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          const SizedBox(height: 15),
                          TextField(
                              obscureText: true,
                              controller: password,
                              style: const TextStyle(color: Colors.grey),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Password",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          const SizedBox(height: 15),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Spacer(),
                                InkWell(
                                    onTap: () async {
                                      if (email.text.trim().isEmpty) {
                                        EasyLoading.showInfo(
                                            "Email is required");
                                      } else {
                                        if (email.text !=
                                            "team@meetworth.com") {
                                          EasyLoading.showError(
                                              "Invalid Email");
                                          return;
                                        }
                                        p.forgotPasswordF(
                                            email: email.text,
                                            loadingFor: "reset",
                                            showLoading: true);
                                      }
                                    },
                                    child: p.isLoading &&
                                            p.isLoadingFor == 'reset'
                                        ? const DotLoader(color: AppColors.gold)
                                        : customText(
                                            text: "Forgot password?",
                                            color: AppColors.gold)
                                    // .animate(
                                    //     onPlay: (controller) =>
                                    //         controller.repeat())
                                    // .shimmer(
                                    //     color: AppColors.primary,
                                    //     duration:
                                    //         const Duration(seconds: 7)),
                                    )
                              ]),
                          const SizedBox(height: 15),
                          InkWell(
                              onTap: () async {
                                if (email.text.trim().isEmpty) {
                                  EasyLoading.showInfo("Email is required");
                                } else if (password.text.trim().isEmpty) {
                                  EasyLoading.showInfo("Password is required");
                                } else {
                                  if (email.text != "team@meetworth.com") {
                                    EasyLoading.showError("Invalid Email");
                                    return;
                                  }
                                  p.loginF(
                                    context,
                                    email: email.text,
                                    password: password.text,
                                    showLoading: true,
                                    loadingFor: 'login',
                                  );
                                }
                              },
                              child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.gold,
                                          gradient: const LinearGradient(
                                              colors: [
                                                AppColors.textGold,
                                                AppColors.gold
                                              ]),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      alignment: Alignment.center,
                                      width: double.maxFinite,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: p.isLoading &&
                                              p.isLoadingFor == 'login'
                                          ? const DotLoader(color: Colors.black)
                                          : customText(
                                              text: "Login",
                                              color: Colors.black,
                                              weight: FontWeight.bold,
                                            )))),
                          // .animate(
                          //     onPlay: (controller) => controller.repeat())
                          // .shimmer(
                          //     // color: AppColors.gold,
                          //     duration: const Duration(seconds: 2)),
                          const SizedBox(height: 15)
                        ]))))
      ]);
    }));
  }
}

Widget customText(
    {String text = "",
    double? size,
    Color? color,
    FontWeight? weight,
    bool center = true}) {
  return Text(text,
      textAlign: center ? TextAlign.center : null,
      style: GoogleFonts.quicksand(
          textStyle: TextStyle(
              fontSize: size ?? 16,
              color: color ?? Colors.black,
              fontWeight: weight ?? FontWeight.normal)));
}
