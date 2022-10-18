
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer/Config/size.dart';
import 'package:timer/Utils/Helpers/color_generator.dart';

class ChallengeItem extends StatelessWidget {
  final int index;
  final int challengeDays;
  final String date;

  const ChallengeItem(
      {Key? key,
      required this.index,
      required this.challengeDays,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 1.2),
      // This function is used to generate random colors from a map of colors
      color: ColorGenerator().generateColor(index),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.heightMultiplier * 2,
          horizontal: SizeConfig.widthMultiplier * 1.4,
        ),
        child: Row(
          children: [
            Icon(
              Icons.star_rate,
              color: Colors.amberAccent,
              size: SizeConfig.textMultiplier * 7,
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                      text: 'You won a ',
                      style: GoogleFonts.poppins(
                        fontSize: SizeConfig.textMultiplier * 1.8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: '$challengeDays days ',
                          style: GoogleFonts.poppins(
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            fontWeight: FontWeight.bold,
                            color: Colors.amberAccent,
                          ),
                        ),
                        TextSpan(
                          text: 'Challenge',
                          style: GoogleFonts.poppins(
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                Text.rich(
                  TextSpan(
                    text: 'You finished on  ',
                    style: GoogleFonts.poppins(
                      fontSize: SizeConfig.textMultiplier * 1.5,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade100,
                    ),
                    children: [
                      TextSpan(
                        text: date.substring(0, 10),
                        style: GoogleFonts.poppins(
                          fontSize: SizeConfig.textMultiplier * 1.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
