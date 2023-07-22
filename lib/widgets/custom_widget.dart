import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

fontStyle(double? size, [Color? clr, FontWeight? fw]) {
  return GoogleFonts.openSans(
    fontSize: size,
    color: clr,
    fontWeight: fw,
  );
}

const Color textClrDark = Color(0xFF0F0E0E);
const Color textClrLight = Color(0xFFD8D8D8);
const Color textClrELight = Color(0xFFF0F0F0);
const Color textClrDLight = Color(0xFF595260);

const Color buttonClr = Color(0xFFEC6062);

const Color bgClr = Color(0xFFEFFFFD);
