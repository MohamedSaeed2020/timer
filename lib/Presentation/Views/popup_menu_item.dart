import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer/Config/size.dart';
import 'package:timer/Constants/colors.dart';

class PopupMenuItemWidget extends StatelessWidget {
  const PopupMenuItemWidget({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);
  final int value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          const Icon(Icons.arrow_forward_ios_outlined),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: SizeConfig.textMultiplier * 2,
              fontWeight: FontWeight.bold,
              color: MyColors.deepBlue,
            ),
          ),
        ],
      ),
    );
  }
}
