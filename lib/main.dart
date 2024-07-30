import 'package:cwsdo/views/food_assistance.dart';
import 'package:cwsdo/views/medical_assistance.dart';
import 'package:cwsdo/widget/navigation_bar/footer.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_test/pages/home_page.dart';
import 'package:cwsdo/views/home_page.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CWSDO',
      theme: ThemeData.light(),
      routes: {
        '/': (context) => const HomePage(),
        '/foodassistance': (context) => const Foodassistance(),
        '/medicalassistance': (context) => const MedicalAssistance(),
      },
      // home: const HomePage(),
    );
  }
}
