import 'package:auto/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String? font1 = GoogleFonts.poppins().fontFamily;

var text1style = GoogleFonts.poppins(
  fontSize: 40,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

text2style({Color color = lightGreen, FontWeight weight = FontWeight.w500}) =>
    GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: weight,
      color: color,
    );

var text3style = GoogleFonts.poppins(
  fontSize: 25,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

var text4style = GoogleFonts.poppins(
  fontSize: 23,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

var text5style = GoogleFonts.poppins(
  fontSize: 30,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

navTextStyle({Color color = Colors.black}) => GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: color,
    );
