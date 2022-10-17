import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:timer/Config/size.dart';
import 'package:timer/Constants/colors.dart';
import 'package:timer/Presentation/Views/challenge_item.dart';
import 'package:timer/Presentation/Views/myflat_button.dart';
import 'package:timer/Presentation/Views/mypopup_button.dart';
import 'package:timer/Presentation/Views/time_card.dart';
import 'package:timer/Providers/home_provider.dart';
import 'package:timer/Utils/Services/hive_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    log('initState');
    if (context.read<HomeProvider>().isRunning) {
      /*it will be called only once after Build widget done with rendering. Without it
      * you will get an error [setState() or markNeedsBuild() called during build.].
      * */
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<HomeProvider>().startTimer(context);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('HomeScreen build');

    return Consumer<HomeProvider>(builder: (context, provider, _) {
      return SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Container(
                color: const Color.fromARGB(255, 13, 116, 50),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                height: SizeConfig.heightMultiplier * 45,
                width: double.infinity,
                child: Column(
                  children: [
                    (!provider.isRunning)
                        ? const Align(
                            alignment: Alignment.centerRight,
                            child: MyPopUpButton(),
                          )
                        : const SizedBox.shrink(),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TimeCard(time: provider.days, title: "Days"),
                        TimeCard(time: provider.hours, title: "Hours"),
                        TimeCard(time: provider.minutes, title: "Minutes"),
                        TimeCard(time: provider.seconds, title: "Seconds"),
                      ],
                    ),
                    const Spacer(),
                    MyFlatButton(
                      title: provider.isRunning ? "Cancel" : "Start",
                      onPressed: () {
                        if (provider.isRunning) {
                          provider.cancelTimer();
                          HiveHelper().savePrimitives('isRunning', false);
                        } else {
                          provider.startTimer(context);
                          HiveHelper().savePrimitives('isRunning', true);
                          DateTime dateTime = DateTime.now();
                          HiveHelper().savePrimitives(
                              'challengeStartDate', dateTime.toString());
                        }
                      },
                      color: provider.isRunning
                          ? Colors.red
                          : const Color.fromARGB(255, 77, 132, 202),
                      maxsize: SizeConfig.widthMultiplier * 50,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 13, 116, 50),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            SizeConfig.textMultiplier * 4,
                          ),
                          topRight: Radius.circular(
                            SizeConfig.textMultiplier * 4,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.textMultiplier * 3,
                        vertical: SizeConfig.textMultiplier * 3.5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Challenges That You Won :',
                            style: GoogleFonts.poppins(
                              fontSize: SizeConfig.textMultiplier * 2.3,
                              fontWeight: FontWeight.bold,
                              color: MyColors.deepBlue,
                            ),
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 3),
                          Expanded(
                              child: provider.challenges.isEmpty
                                  ? Center(
                                      child: Lottie.asset(
                                        'assets/json/working-man.json',
                                        width: SizeConfig.widthMultiplier * 100,
                                        height:
                                            SizeConfig.widthMultiplier * 100,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  : ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: provider.challenges.length,
                                      itemBuilder: (context, index) {
                                        return ChallengeItem(
                                            index: index,
                                            challengeDays: provider
                                                .challenges[index]
                                                .challengeDays,
                                            date: provider.challenges[index]
                                                .finishingDate);
                                      },
                                    ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
