import 'dart:async';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:timer/Data%20Layer/Models/challenge_model.dart';
import 'package:timer/Presentation/Views/awesome_dialog.dart';
import '../Utils/Services/hive_helper.dart';

class HomeProvider with ChangeNotifier {
  late bool isRunning;
  late List<Challenge> challenges;
  late Duration _countDownDuration;
  static int challengeDays = 2;
  Timer? _timer;
  String _days = challengeDays.toString().padLeft(2, '0');
  String _hours = "00";
  String _minutes = "00";
  String _seconds = "00";

  String get days => _days;

  String get hours => _hours;

  String get minutes => _minutes;

  String get seconds => _seconds;

  void init() {
    isRunning = HiveHelper.myPrimitiveBox.get('isRunning') ?? false;
    if (isRunning) {
      String savedDate =
          HiveHelper.myPrimitiveBox.get('challengeStartDate').toString();
      DateTime date = DateTime.parse(savedDate);

      // This is used so that the countdown keep working even if we closed the app.
      Duration remaining = date.difference(DateTime.now());
      _countDownDuration =
          Duration(days: challengeDays, seconds: remaining.inSeconds);
    } else {
      _countDownDuration = Duration(days: challengeDays);
    }

    challenges = HiveHelper.myChallengeBox.values.toList().cast<Challenge>();
  }

  void startTimer(BuildContext context) {
    log('startTimer');
    isRunning = true;
    _timer =
        Timer.periodic(const Duration(seconds: 1), (_) => countDown(context));
  }

  void countDown(BuildContext context) {
    log('countDown');

    final int seconds = _countDownDuration.inSeconds - 1;
    if (seconds < 0) {
      _timer!.cancel();
      isRunning = false;
      HiveHelper().savePrimitives('isRunning', false);
      _countDownDuration = Duration(days: challengeDays);
      _days = _countDownDuration.inDays.toString().padLeft(2, '0');
      Challenge challenge = Challenge(
        finishingDate: DateTime.now().toString(),
        challengeDays: challengeDays,
      );
      HiveHelper().saveChallenge(challenge);
      MyAwesomeDialog.buildAwesomeDialog(context, challengeDays);
    } else {
      _countDownDuration = Duration(seconds: seconds);
      // I used this method so the they can be written in two digits (02 instead of 2).
      _days = _countDownDuration.inDays.toString().padLeft(2, '0');
      _hours =
          _countDownDuration.inHours.remainder(24).toString().padLeft(2, '0');
      _minutes =
          _countDownDuration.inMinutes.remainder(60).toString().padLeft(2, '0');
      _seconds =
          _countDownDuration.inSeconds.remainder(60).toString().padLeft(2, '0');
    }

    notifyListeners();
  }

  void cancelTimer() {
    _timer!.cancel();
    _countDownDuration = Duration(days: challengeDays);
    _days = challengeDays.toString().padLeft(2, '0');
    _hours = "00";
    _minutes = "00";
    _seconds = "00";
    isRunning = false;
    notifyListeners();
  }

  void changeChallengeNoOfDays(int noOfDays) {
    challengeDays = noOfDays;
    _countDownDuration = Duration(days: challengeDays);
    _days = challengeDays.toString().padLeft(2, '0');
    notifyListeners();
  }
}
