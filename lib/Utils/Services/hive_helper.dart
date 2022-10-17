import 'package:hive_flutter/hive_flutter.dart';
import 'package:timer/Data%20Layer/Models/challenge_model.dart';

class HiveHelper {
  static Box myPrimitiveBox = Hive.box('primitiveBox');
  static Box myChallengeBox = Hive.box('challengeBox');

  void savePrimitives(String key, dynamic value) {
    myPrimitiveBox.put(key, value);
  }

  void saveChallenge(Challenge challenge) {
    myChallengeBox.add(challenge);
  }
}
