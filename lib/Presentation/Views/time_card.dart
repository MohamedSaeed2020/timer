import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:timer/Config/size.dart';

class TimeCard extends StatelessWidget {
  final String time;
  final String title;

  const TimeCard({Key? key, required this.time, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('TimeCard build');

    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: SizeConfig.textMultiplier * 5,
              ),
            ),
          ),
        ),
        SizedBox(height: SizeConfig.heightMultiplier * 1),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: SizeConfig.textMultiplier * 2,
          ),
        )
      ],
    );
  }
}
