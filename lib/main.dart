import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timer/Config/size.dart';
import 'package:timer/Data%20Layer/Models/challenge_model.dart';
import 'package:timer/Presentation/Screens/home_screen.dart';
import 'package:timer/Providers/home_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ChallengeAdapter());
  await Hive.openBox('primitiveBox');
  await Hive.openBox('challengeBox');

  // This line is used to make the app in fullscreen (without bar status).
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [
    SystemUiOverlay.bottom,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
          create: (_) => HomeProvider()..init(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig().init(constraints);
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'No Addiction',
          home: HomeScreen(),
        );
      },
    );
  }
}
