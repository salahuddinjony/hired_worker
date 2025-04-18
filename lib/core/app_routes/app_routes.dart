// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import '../../view/screens/authentication/account_type_screen/account_type_screen.dart';
import '../../view/screens/authentication/account_type_screen/contractor_sign_up_screen/contractor_sign_up_screen.dart';
import '../../view/screens/authentication/forgot_password_screen/forgot_password_screen.dart';
import '../../view/screens/authentication/login_screen/login_screen.dart';
import '../../view/screens/authentication/reset_password_screen/reset_password_screen.dart';
import '../../view/screens/authentication/verifay_code_screen/verifay_code_screen.dart';
import '../../view/screens/contractor_part/home/home_screen/home_screen.dart';
import '../../view/screens/contractor_part/home/on_going_screen/on_going_finish_screen/on_going_finish_screen.dart';
import '../../view/screens/contractor_part/home/on_going_screen/on_going_screen.dart';
import '../../view/screens/contractor_part/home/order_screen/order_screen.dart';
import '../../view/screens/contractor_part/message/message_list_screen/message_list_screen.dart';
import '../../view/screens/contractor_part/onboarding_screen/onboarding_screen.dart';
import '../../view/screens/contractor_part/onboarding_screen/onboarding_screen_two.dart';
import '../../view/screens/contractor_part/profile/edit_profile_screen/edit_profile_screen.dart';
import '../../view/screens/contractor_part/profile/eran_screen/eran_screen.dart';
import '../../view/screens/contractor_part/profile/help_support_screen/help_support_screen.dart';
import '../../view/screens/contractor_part/profile/materials_screen/materials_screen.dart';
import '../../view/screens/contractor_part/profile/notification_screen/notification_screen.dart';
import '../../view/screens/contractor_part/profile/profile_screen/profile_screen.dart';
import '../../view/screens/contractor_part/profile/schedule_screen/schedule_screen.dart';
import '../../view/screens/contractor_part/splash_screen/splash_screen.dart';
import '../../view/screens/customer_part/home/customer_home_screen/customer_home_screen.dart';
import '../../view/screens/customer_part/home/customer_popular_services_screen/customer_popular_services_screen.dart';
import '../../view/screens/customer_part/home/customer_services_contractor_screen/customer_services_contractor_screen.dart';
class AppRoutes {
  ///===========================Authentication==========================
  static const String splashScreen = "/SplashScreen";
  static const String onboardingScreen = "/OnboardingScreen";
  static const String onboardingScreenTwo = "/OnboardingScreenTwo";
  static const String loginScreen = "/LoginScreen";
  static const String accountTypeScreen = "/AccountTypeScreen";
  static const String forgotPasswordScreen = "/ForgotPasswordScreen";
  static const String verifayCodeScreen = "/VerifayCodeScreen";
  static const String resetPasswordScreen = "/ResetPasswordScreen";
  static const String contractorSignUpScreen = "/ContractorSignUpScreen";
  static const String homeScreen = "/HomeScreen";
  static const String orderScreen = "/OrderScreen";
  static const String messageListScreen = "/MessageListScreen";
  static const String profileScreen = "/ProfileScreen";
  static const String editProfileScreen = "/EditProfileScreen";
  static const String helpSupportScreen = "/HelpSupportScreen";
  static const String materialsScreen = "/MaterialsScreen";
  static const String notificationScreen = "/NotificationScreen";
  static const String scheduleScreen = "/ScheduleScreen";
  static const String eranScreen = "/EranScreen";
  static const String onGoingScreen = "/OnGoingScreen";
  static const String onGoingFinishScreen = "/OnGoingFinishScreen";


  ///===========================Customer==========================
  static const String customerHomeScreen = "/CustomerHomeScreen";
  static const String customerPopularServicesScreen = "/CustomerPopularServicesScreen";
  static const String customerServicesContractorScreen = "/CustomerServicesContractorScreen";

  static List<GetPage> routes = [
    ///===========================Authentication==========================
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: onboardingScreenTwo, page: () => OnboardingScreenTwo()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: accountTypeScreen, page: () => AccountTypeScreen()),
    GetPage(name: forgotPasswordScreen, page: () => ForgotPasswordScreen()),
    GetPage(name: verifayCodeScreen, page: () => VerifayCodeScreen()),
    GetPage(name: resetPasswordScreen, page: () => ResetPasswordScreen()),
    GetPage(name: contractorSignUpScreen, page: () => ContractorSignUpScreen()),
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: orderScreen, page: () => OrderScreen()),
    GetPage(name: messageListScreen, page: () => MessageListScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: editProfileScreen, page: () => EditProfileScreen()),
    GetPage(name: helpSupportScreen, page: () => HelpSupportScreen()),
    GetPage(name: materialsScreen, page: () => MaterialsScreen()),
    GetPage(name: notificationScreen, page: () => NotificationScreen()),
    GetPage(name: scheduleScreen, page: () => ScheduleScreen()),
    GetPage(name: eranScreen, page: () => EranScreen()),
    GetPage(name: onGoingScreen, page: () => OnGoingScreen()),
    GetPage(name: onGoingFinishScreen, page: () => OnGoingFinishScreen()),

    ///===========================Customer==========================
    GetPage(name: customerHomeScreen, page: () => CustomerHomeScreen()),
    GetPage(name: customerPopularServicesScreen, page: () => CustomerPopularServicesScreen()),
    GetPage(name: customerServicesContractorScreen, page: () => CustomerServicesContractorScreen()),

  ];
}
