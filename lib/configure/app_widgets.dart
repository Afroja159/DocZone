// ignore_for_file: use_build_context_synchronously

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'app_colors.dart';

class AppWidgets {

  ///for button
  button(BuildContext context,
      {text,
        press,
        height,
        width,
        top,
        left,
        right,
        bottom,
        color,
        radius,
        style}) {
    return Center(
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.only(
          top: top ?? 0,
          left: left ?? 0,
          right: right ?? 0,
          bottom: bottom ?? 0,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 5),
            ),
            backgroundColor: color ?? const Color(0xff0ce0ff),
          ),
          onPressed: press,
          child: Text(
            text,
            style: style ?? AppStyle.title1,
          ),
        ),
      ),
    );
  }

  ///for submit button
  submitButton(BuildContext context, {required text, required press}) {
    return MaterialButton(
      onPressed: press,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 11,
        padding: const EdgeInsets.only(top: 5, right: 14, bottom: 18),
        child: Material(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$text',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
      ),
    );
  }


  ///for input field
  inputField(BuildContext context,
      {controller,
        hintText,
        keyboardType,
        icon,
        autoFocus,
        autofillHints,
        obscureText,
        suffixIcon,
        readOnly,
        textCapitalizations,
        minLine,
        maxLine,
        height}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 15, left: 25, right: 25),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 1),
        height: height ?? 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.borderRadiusSize),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(1, 1),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.transparent,
              offset: Offset(-1, -1),
              blurRadius: 10,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(right: 10, bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(.35),
                            blurRadius: 2,
                            spreadRadius: 1.5,
                            offset: const Offset(0, 2.0))
                      ]),
                  child: icon,
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: keyboardType,
                    obscureText: obscureText ?? false,
                    autofillHints: [autofillHints],
                    readOnly: readOnly ?? false,
                    textInputAction: TextInputAction.done,
                    maxLines: maxLine ?? 1,
                    minLines: minLine ?? 1,
                    autofocus: autoFocus ?? false,
                    textCapitalization:
                    textCapitalizations ?? TextCapitalization.none,
                    style: const TextStyle(fontSize: 17, letterSpacing: 1),
                    decoration: InputDecoration(
                      hintText: hintText,
                      isCollapsed: true,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: suffixIcon,
                      contentPadding: const EdgeInsets.only(
                        top: 8,
                        bottom: 17,
                        left: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  ///for Icon Button
  iconButton(BuildContext context, {icon, press, size}) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(right: 10, bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.35),
              blurRadius: 2,
              spreadRadius: 1.5,
              offset: const Offset(0, 2.0),
            ),
          ],
        ),
        child: icon,
      ),
    );
  }


  /// Success Message
  successAlert(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconColor: Colors.transparent,
      content: Center(child: Lottie.asset('assets/jsons/success_msg.json')),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      useSafeArea: false,
      barrierColor: AppColors.primaryColor.withOpacity(0.2),
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  ///for success snack bar
  successSnackBar(BuildContext context, String exp) {
    return Get.snackbar(
      'Success',
      exp,
      icon: const Icon(Icons.check, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      borderRadius: 8,
      margin: const EdgeInsets.all(15),
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  ///for wrong snack bar
  wrongSnackBar(BuildContext context, String exp) {
    return Get.snackbar(
      'Something wrong',
      exp,
      icon: const Icon(Icons.error_outline, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      borderRadius: 8,
      margin: const EdgeInsets.all(15),
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.vertical,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  ///show loader dialog
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      content: Center(
        child: Lottie.asset(
          'assets/images/circular_progress.json',
          height: 60,
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}