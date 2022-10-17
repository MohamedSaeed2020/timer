import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer/Config/size.dart';
import 'package:timer/Constants/colors.dart';

class MyAwesomeDialog {
  static AwesomeDialog buildAwesomeDialog(
      BuildContext context, int challengeDays) {
    return AwesomeDialog(
        dialogType: DialogType.success,
        animType: AnimType.topSlide,
        btnOkOnPress: () {},
        context: context,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          // ignore: sort_child_properties_last
          child: Text(
              textAlign: TextAlign.left,
              'Congratulations Bro/Sis, You have finished your $challengeDays days challenge.',
              style: GoogleFonts.poppins(
                fontSize: SizeConfig.textMultiplier * 2,
                fontWeight: FontWeight.bold,
                color: MyColors.grey,
                height: 2,
              )),
        ))
      ..show();
  }
}
