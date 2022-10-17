import 'package:hive_flutter/hive_flutter.dart';
part 'challenge_model.g.dart';
@HiveType(typeId: 0)
class Challenge extends HiveObject {
  @HiveField(0)
  final String finishingDate;
  @HiveField(1)
  final int challengeDays;

  Challenge({
    required this.finishingDate,
    required this.challengeDays,
  });
}
