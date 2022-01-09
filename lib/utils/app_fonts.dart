import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

class AppFontsStyle {
  static String fontFamily = 'Euclid Circular A';
  static double textFontSize40 = 40.0;
  static double textFontSize48 = 48.0;
  static double textFontSize32 = 32.0;
  static double textFontSize24 = 24.0;
  static double textFontSize22 = 22.0;
  static double textFontSize20 = 20.0;
  static double textFontSize16 = 16.0;
  static double textFontSize18 = 18.0;
  static double textFontSize14 = 14.0;
  static double textFontSize13 = 13.0;
  static double textFontSize12 = 12.0;
  static double textFontSize10 = 10.0;
  static double textFontSize8 = 8.0;

  static Widget getAppTextView(text, {size, color, textAlign,maxLines}) {
    final displayText = text.toString().toLowerCase() == "null" ? "" : text;
    final textSize = size == null ? null : double.parse(size.toString());
    return Text(displayText,
        maxLines: maxLines,
        textAlign: textAlign ?? TextAlign.left,
        style: GoogleFonts.manrope(
            color: color ?? Pallet.colorBlue,
            fontSize: textSize ?? AppFontsStyle.textFontSize12,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            height: 1.5));
  }

  static Widget getAppTextViewBold(text, {size, color, textAlign, weight}) {
    final textSize = size == null ? null : double.parse(size.toString());
    return Text(text,
        textAlign: textAlign ?? TextAlign.left,
        style: GoogleFonts.manrope(
          color: color ?? Pallet.colorBlue,
          fontSize: textSize ?? AppFontsStyle.textFontSize16,
          fontWeight: weight ?? FontWeight.w600,
          fontStyle: FontStyle.normal,
        ));
  }
}
