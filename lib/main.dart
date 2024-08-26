import 'package:cwsdo/views/food_assistance.dart';
import 'package:cwsdo/views/medical_assistance.dart';
import 'package:cwsdo/views/request_releif.dart';
import 'package:cwsdo/views/login.dart';
import 'package:cwsdo/widget/admin/addBeneficiary.dart';
import 'package:cwsdo/widget/admin/reliefRequest.dart';
import 'package:cwsdo/widget/admin/totaltally.dart';
// import 'package:cwsdo/widget/navigation_bar/footer.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_test/pages/home_page.dart';
import 'package:cwsdo/views/home_page.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        '/requestrelief': (context) => const RequestRelief(),
        // '/sidebar': (context) => const Sidebar(),
        '/login': (context) => const LoginScreen(),
        '/reliefrequest': (context) => const ReliefrequestMain(),
        '/addbeneficiary': (context) => const AddBeneficiaryMain(),
        '/totaltally': (context) => const TotalTallyMain(),
        // '/try': (context) => NumberInputWidget(),
      },
      // home: const HomePage(),
    );
  }
}
