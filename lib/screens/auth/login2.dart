import 'package:admin_panel/const/appColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(color: AppColors.bgCard),
      Center(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  color: AppColors.bgField,
                  constraints: const BoxConstraints(maxWidth: 400),
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
                                      height: 11.h, width: 11.h))),
                          Expanded(child: Container())
                        ]),
                        const SizedBox(height: 30),
                        Row(children: [
                          Text("Login",
                              style: GoogleFonts.quicksand(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ]),
                        const SizedBox(height: 10),
                        Row(children: [
                          customText(
                              text: "Welcome back to the admin panel.",
                              color: Colors.black)
                        ]),
                        const SizedBox(height: 15),
                        TextField(
                            controller: email,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: "Email",
                                hintStyle: const TextStyle(color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)))),
                        const SizedBox(height: 15),
                        TextField(
                            obscureText: true,
                            controller: password,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: "Password",
                                hintStyle: const TextStyle(color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)))),
                        const SizedBox(height: 15),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Spacer(),
                              InkWell(
                                // onTap: () async {
                                //   if (email.text.isEmail) {
                                //     EasyLoading.show();
                                //     String response =
                                //         await Get.find<AuthServices>()
                                //             .forgetPassword(email.text);
                                //     EasyLoading.dismiss();
                                //     if (response == "") {
                                //       ElegantNotification.success(
                                //               iconSize: 30,
                                //               width: 600,
                                //               height: 100,
                                //               displayCloseButton: true,
                                //               description: Text(
                                //                   "Check your Email to Reset Email",
                                //                   style: GoogleFonts.quicksand(
                                //                       letterSpacing: 2,
                                //                       wordSpacing: 2,
                                //                       textStyle: TextStyle(
                                //                           fontSize: 20,
                                //                           color: Colors.black,
                                //                           fontWeight: FontWeight
                                //                               .w500))))
                                //           .show(context);
                                //     } else {
                                //       ElegantNotification.error(
                                //               iconSize: 30,
                                //               width: 600,
                                //               height: 100,
                                //               displayCloseButton: true,
                                //               description: Text(response,
                                //                   style: GoogleFonts.quicksand(
                                //                       letterSpacing: 2,
                                //                       wordSpacing: 2,
                                //                       textStyle: TextStyle(
                                //                           fontSize: 20,
                                //                           color: Colors.black,
                                //                           fontWeight: FontWeight
                                //                               .w500))))
                                //           .show(context);
                                //     }
                                //   } else {
                                //     ElegantNotification.info(
                                //             iconSize: 30,
                                //             width: 600,
                                //             height: 100,
                                //             displayCloseButton: true,
                                //             description: Text(
                                //                 "Enter Valid Email",
                                //                 style: GoogleFonts.quicksand(
                                //                     letterSpacing: 2,
                                //                     wordSpacing: 2,
                                //                     textStyle: TextStyle(
                                //                         fontSize: 20,
                                //                         color: Colors.black,
                                //                         fontWeight:
                                //                             FontWeight.w500))))
                                //         .show(context);
                                //   }
                                // },
                                child: customText(
                                    text: "Forgot password?",
                                    color: AppColors.gold),
                              )
                            ]),
                        const SizedBox(height: 15),
                        InkWell(
                            onTap: () async {
                              // if (email.text.isEmail) {
                              //   if (password.text.length > 6) {
                              //     if (email.text.toLowerCase() ==
                              //         "team@meetworth.com") {
                              //       EasyLoading.show();
                              //       String response =
                              //           await Get.find<AuthServices>()
                              //               .emailSignIn(
                              //                   email.text, password.text);
                              //       EasyLoading.dismiss();
                              //       if (response == "") {
                              //         Get.to(HomeScreen());
                              //       } else {
                              //         ElegantNotification.error(
                              //                 iconSize: 30,
                              //                 width: 600,
                              //                 height: 100,
                              //                 displayCloseButton: true,
                              //                 description: Text(response,
                              //                     style: GoogleFonts.quicksand(
                              //                         letterSpacing: 2,
                              //                         wordSpacing: 2,
                              //                         textStyle: TextStyle(
                              //                             fontSize: 20,
                              //                             color: Colors.black,
                              //                             fontWeight: FontWeight
                              //                                 .w500))))
                              //             .show(context);
                              //       }
                              //     } else {
                              //       ElegantNotification.info(
                              //               iconSize: 30,
                              //               width: 600,
                              //               height: 100,
                              //               displayCloseButton: true,
                              //               description: Text(
                              //                   "Not an Admin Email",
                              //                   style: GoogleFonts.quicksand(
                              //                       letterSpacing: 2,
                              //                       wordSpacing: 2,
                              //                       textStyle: TextStyle(
                              //                           fontSize: 20,
                              //                           color: Colors.black,
                              //                           fontWeight:
                              //                               FontWeight.w500))))
                              //           .show(context);
                              //     }
                              //   } else {
                              //     ElegantNotification.info(
                              //             iconSize: 30,
                              //             width: 600,
                              //             height: 100,
                              //             displayCloseButton: true,
                              //             description: Text(
                              //                 "Enter Valid Password",
                              //                 style: GoogleFonts.quicksand(
                              //                     letterSpacing: 2,
                              //                     wordSpacing: 2,
                              //                     textStyle: TextStyle(
                              //                         fontSize: 20,
                              //                         color: Colors.black,
                              //                         fontWeight:
                              //                             FontWeight.w500))))
                              //         .show(context);
                              //   }
                              // } else {
                              //   ElegantNotification.info(
                              //           iconSize: 30,
                              //           width: 600,
                              //           height: 100,
                              //           displayCloseButton: true,
                              //           description: Text("Enter Valid Email",
                              //               style: GoogleFonts.quicksand(
                              //                   letterSpacing: 2,
                              //                   wordSpacing: 2,
                              //                   textStyle: TextStyle(
                              //                       fontSize: 20,
                              //                       color: Colors.black,
                              //                       fontWeight:
                              //                           FontWeight.w500))))
                              //       .show(context);
                              // }
                            },
                            child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.pieChartColor2,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    alignment: Alignment.center,
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: customText(
                                      text: "Login",
                                      color: Colors.black,
                                    )))),
                        const SizedBox(height: 15)
                      ]))))
    ]));
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
