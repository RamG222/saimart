import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets_and_screens/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());
}

//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: EasySplashScreen(
          logoWidth: 300,
          logo: Image.asset('assets/splash.png'),
          navigator: const Homepage(),
          durationInSeconds: 2,
          loadingText: const Text(
            "Loading",
            style: TextStyle(color: Colors.blueGrey),
          ),
          loaderColor: Colors.blue,
          showLoader: true,
        ),
      ),
    );
  }
}
