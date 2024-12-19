import 'package:cwsdo/views/food_assistance.dart';
import 'package:cwsdo/views/forgotPasswordScreen.dart';
import 'package:cwsdo/views/medical_assistance.dart';
import 'package:cwsdo/views/request_releif.dart';
import 'package:cwsdo/views/login.dart';
import 'package:cwsdo/widget/admin/addBeneficiary.dart';
import 'package:cwsdo/widget/admin/assisranceRequest.dart';
import 'package:cwsdo/widget/admin/carousel.dart';
import 'package:cwsdo/widget/admin/dashboard.dart';
import 'package:cwsdo/widget/admin/dashboard/completed.dart';
import 'package:cwsdo/widget/admin/dashboard/listbns.dart';
import 'package:cwsdo/widget/admin/dashboard/ongoing.dart';
import 'package:cwsdo/widget/admin/dashboard/requestlist.dart';
import 'package:cwsdo/widget/admin/dashboard/resident.dart';
import 'package:cwsdo/widget/admin/dashboard/totalBeneficiarylist.dart';
import 'package:cwsdo/widget/admin/dashboard/totalCompleted.dart';
import 'package:cwsdo/widget/admin/dashboard/totalFoodAssistancelist.dart';
import 'package:cwsdo/widget/admin/dashboard/totalMedicalAssistance.dart';
import 'package:cwsdo/widget/admin/reliefRequest';
import 'package:cwsdo/widget/admin/totaltally.dart';
import 'package:cwsdo/widget/notFound.dart';
import "package:cwsdo/views/admin/usersetting.dart";
// import 'package:cwsdo/widget/splashPage.dart';
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
      // settings: settings,
      onGenerateRoute: _onGenerateRoute,

      // routes: {
      //   '/': (context) => HomePage(),
      //   '/foodassistance': (context) => const Foodassistance(),
      //   '/medicalassistance': (context) => const MedicalAssistance(),
      //   '/requestrelief': (context) => const RequestRelief(),
      //   // '/sidebar': (context) => const Sidebar(),
      //   '/login': (context) => const LoginScreen(),

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

    // print(isAuthenticated);
    // print(settings.name);

    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(builder: (context) => SplashPage());
      // -----------------------USER ROUTE----------------------------------
      case '/':
        return _authGuard(isAuthenticated, const HomePage(), settings);
      case '/foodassistance':
        return _authGuard(isAuthenticated, const Foodassistance(), settings);
      case '/medicalassistance':
        return _authGuard(isAuthenticated, const MedicalAssistance(), settings);
      case '/requestrelief':
        return _authGuard(isAuthenticated, const RequestRelief(), settings);
      case '/login':
        return _authGuard(isAuthenticated, const LoginScreen(), settings);
      case '/forgotpassword':
        return _authGuard(
            isAuthenticated, const ForgotPasswordScreen(), settings);

      // -------------------------ADMIN ROUTE--------------------

      case '/reliefrequest':
        return _authGuardAdmin(
            isAuthenticated, const ReliefrequestMain(), settings);
      case '/ongoingassistance':
        return _authGuardAdmin(
            isAuthenticated, const TotalOngoingMain(), settings);
      case '/completedassitance':
        return _authGuardAdmin(isAuthenticated, const Completed(), settings);
      case '/listrequest':
        return _authGuardAdmin(isAuthenticated, const RequestList(), settings);
      case '/resident':
        return _authGuardAdmin(isAuthenticated, const Resident(), settings);
      case '/listbns':
        return _authGuardAdmin(isAuthenticated, const Listbns(), settings);
      case '/foodassistancelist':
        return _authGuardAdmin(
            isAuthenticated, const TotalFoodAssistanceMain(), settings);
      // case '/completedassitance':
      //   return _authGuardAdmin(
      //       isAuthenticated, const TotalCompletedMain(), settings);
      case '/medicalassistancelist':
        return _authGuardAdmin(
            isAuthenticated, const TotalMedicalAssistanceMain(), settings);
      case '/beneficiarylist':
        return _authGuardAdmin(
            isAuthenticated, const TotalBeneficiaryMain(), settings);
      case '/reqeustlist':
        return _authGuardAdmin(
            isAuthenticated, const TotalBeneficiaryMain(), settings);
      case '/carousel':
        return _authGuardAdmin(isAuthenticated, const CarouselMain(), settings);

      case '/addbeneficiary':
        return _authGuardAdmin(
            isAuthenticated, const AddBeneficiaryMain(), settings);
      case '/assistancerequest':
        return _authGuardAdmin(
            isAuthenticated, const AssistanceRequest(), settings);
      case '/totaltally':
        return _authGuardAdmin(
            isAuthenticated, const TotalTallyMain(), settings);
      case '/dashboard':
        return _authGuardAdmin(
            isAuthenticated, const DashboardMain(), settings);
      case '/usersetting':
        return _authGuardAdmin(isAuthenticated, const UserSetting(), settings);

      default:
        return MaterialPageRoute(builder: (context) => NotFoundPage());
    }
  }

  Route<dynamic> _authGuardAdmin(bool isAuthenticated, Widget page, settings) {
    return isAuthenticated
        ? MaterialPageRoute(settings: settings, builder: (context) => page)
        : MaterialPageRoute(
            settings: const RouteSettings(name: "/login"),
            builder: (context) => const LoginScreen());
  }

  Route<dynamic> _authGuard(bool isAuthenticated, Widget page, settings) {
    return isAuthenticated
        ? MaterialPageRoute(
            settings: const RouteSettings(name: "/dashboard"),
            builder: (context) => const DashboardMain())
        : MaterialPageRoute(settings: settings, builder: (context) => page);
  }
}
