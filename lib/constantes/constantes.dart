// ignore_for_file: constant_identifier_names, unused_element

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color unselectedCallBack = Color.fromARGB(255, 183, 214, 241);

const Color mainColor = Color(0xFF001F3F);
const Color liteTxt = Color(0xFFB9BCBE);

const Color blackText = Color(0xFF23272A);
const Color backGround = Color.fromARGB(255, 242, 245, 251);
const Color redColor = Color(0xFFD8192C);

//const Color backGround = Color(0xFFF7F9FF);
const Color greyBackGround = Color(0xFFAFB2B8);
const Color gradientGray = Color.fromARGB(255, 255, 255, 255);
const Color selectedIcon = Color(0xFF008AFF);
const Color headerColor = Color(0xFFA8A8A8);
const Color greyTxt = Color(0xFF7C7C7C);
const Color unselectedIcon = Color(0xFF7EA2B7);
const Color iconColor = Color(0xFF111111);
const Color pending = Color.fromARGB(255, 194, 166, 253);
const Color hardPending = Color(0XFF8952FF);
const Color desactivatedButton = Color(0XFF526EFF);
const Color headerGrey = Color(0xFF444444);
const Color greenColor = Color(0xFF16A34A);

TextStyle? simple =
    GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500);

Color getColor(String status) {
  switch (status) {
    case "Confirmed":
      return const Color(0xFF018D36);

    case "Pending":
      return const Color(0xFF6941C6);
    case "Cancelled":
      return const Color(0xFFD8192C);
    default:
      return const Color(0xFF6941C6);
  }
}

void showErrorSnackBar(
    BuildContext context, String message, Color color, Color backGround) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: false,
      margin: EdgeInsets.zero,
      elevation: 2,
      content: Text(
        message,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: backGround,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: color,
          width: 2,
        ),
      ),
    ),
  );
}
