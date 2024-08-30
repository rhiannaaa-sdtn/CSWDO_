import 'package:cwsdo/views/food_assistance.dart';
import 'package:cwsdo/views/medical_assistance.dart';
import 'package:cwsdo/views/request_releif.dart';
import 'package:cwsdo/views/login.dart';
import 'package:cwsdo/widget/admin/addBeneficiary.dart';
import 'package:cwsdo/widget/admin/reliefRequest.dart';
import 'package:cwsdo/widget/admin/totaltally.dart';
import 'package:cwsdo/widget/notFound.dart';
import 'package:cwsdo/widget/splashPage.dart';
// import 'package:cwsdo/widget/navigation_bar/footer.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_test/pages/home_page.dart';
import 'package:cwsdo/views/home_page.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    final _auth = FirebaseAuth.instance;
    final bool auth;
    if (_auth.currentUser != null) {
      auth = true;
    } else {
      auth = false;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CWSDO',
      theme: ThemeData.light(),

      onGenerateRoute: _onGenerateRoute,

      // routes: {
      //   '/': (context) => auth ? HomePage() : ReliefrequestMain(),
      //   '/foodassistance': (context) =>
      //       auth ? const Foodassistance() : ReliefrequestMain(),
      //   '/medicalassistance': (context) =>
      //       auth ? const MedicalAssistance() : ReliefrequestMain(),
      //   '/requestrelief': (context) =>
      //       auth ? const RequestRelief() : ReliefrequestMain(),
      //   // '/sidebar': (context) => const Sidebar(),
      //   '/login': (context) => auth ? const LoginScreen() : ReliefrequestMain(),

      //   // ---------ADMIN---------

      //   '/reliefrequest': (context) => const ReliefrequestMain(),
      //   '/addbeneficiary': (context) => const AddBeneficiaryMain(),
      //   '/totaltally': (context) => const TotalTallyMain(),
      //   // '/try': (context) => NumberInputWidget(),
      // },
      // home: const HomePage(),
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    // Check authentication status
    final isAuthenticated = FirebaseAuth.instance.currentUser != null;

    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(builder: (context) => SplashPage());
      case '/':
        return _authGuard(isAuthenticated, const HomePage());
      case '/login':
        return _authGuard(isAuthenticated, const LoginScreen());
      case '/reliefrequest':
        return _authGuardAdmin(isAuthenticated, const ReliefrequestMain());
      default:
        return MaterialPageRoute(builder: (context) => NotFoundPage());
    }
  }

  Route<dynamic> _authGuardAdmin(bool isAuthenticated, Widget page) {
    return isAuthenticated
        ? MaterialPageRoute(builder: (context) => const LoginScreen())
        : MaterialPageRoute(builder: (context) => page);
  }

  Route<dynamic> _authGuard(bool isAuthenticated, Widget page) {
    return isAuthenticated
        ? MaterialPageRoute(builder: (context) => page)
        : MaterialPageRoute(builder: (context) => const ReliefrequestMain());
  }
}
