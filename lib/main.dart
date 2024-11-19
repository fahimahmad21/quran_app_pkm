import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:quran_app_pkm/screens/onboarding_screen.dart';
import 'package:quran_app_pkm/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final appDocumentDirectory =
  await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  // Open the box
  final box = await Hive.openBox('appSettings');
  final showHome = box.get('showHome', defaultValue: false);

  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;

  const MyApp({
    super.key,
    required this.showHome,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran App',
      theme: ThemeData(
        primaryColor: const Color(0xff6D9886),
        scaffoldBackgroundColor: const Color(0xffF7F7F7),
      ),
      home: showHome ? const HomeScreen() : const OnboardingScreen(),
    );
  }
}