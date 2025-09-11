// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/subscribe_screen/subscribe_screen.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/subscribe_screen/thanks_screen.dart';
import 'package:servana/view/screens/contractor_part/home/home_screen/recent_all_service_screen.dart';
import 'package:servana/view/screens/contractor_part/profile/map/google_map_screen.dart';
import 'package:servana/view/screens/message/chat_screen/chat_screen.dart';
import '../../view/screens/authentication/account_type_screen/account_type_screen.dart';
import '../../view/screens/authentication/account_type_screen/contractor_sign_up_screen/contractor_sign_up_screen.dart';
import '../../view/screens/authentication/forgot_password_screen/forgot_password_screen.dart';
import '../../view/screens/authentication/login_screen/login_screen.dart';
import '../../view/screens/authentication/reset_password_screen/reset_password_screen.dart';
import '../../view/screens/authentication/verifay_code_screen/verifay_code_screen.dart';
import '../../view/screens/contractor_part/complete_your_profile/add_material_screen.dart';
import '../../view/screens/contractor_part/complete_your_profile/category_seleted_screen.dart';
import '../../view/screens/contractor_part/complete_your_profile/certificate_screen.dart';
import '../../view/screens/contractor_part/complete_your_profile/charge_screen.dart';
import '../../view/screens/contractor_part/complete_your_profile/schedule_seleted_screen.dart';
import '../../view/screens/contractor_part/complete_your_profile/seleted_map_screen.dart';
import '../../view/screens/contractor_part/complete_your_profile/skills_add_screen.dart';
import '../../view/screens/contractor_part/complete_your_profile/subscribe_screen/payment_method_screen.dart';
import '../../view/screens/contractor_part/home/home_screen/home_screen.dart';
import '../../view/screens/contractor_part/home/on_going_screen/on_going_finish_screen/on_going_finish_screen.dart';
import '../../view/screens/contractor_part/home/on_going_screen/on_going_screen.dart';
import '../../view/screens/contractor_part/home/order_screen/order_screen.dart';
import '../../view/screens/message/message_list_screen/message_list_screen.dart';
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
import '../../view/screens/customer_part/customer_search_result_screen/customer_search_result_screen.dart';
import '../../view/screens/customer_part/home/customar_materials_screen/customar_materials_screen.dart';
import '../../view/screens/customer_part/home/customar_qa_screen/customar_qa_screen.dart';
import '../../view/screens/customer_part/home/customar_service_details_screen/customar_service_contractor_details_screen.dart';
import '../../view/screens/customer_part/home/customar_service_details_screen/customar_service_details_screen.dart';
import '../../view/screens/customer_part/home/customer_all_contractor_view_screen/customer_all_contractor_view_screen.dart';
import '../../view/screens/customer_part/home/customer_category_screen/customer_category_screen.dart';
import '../../view/screens/customer_part/home/customer_confirmations_screen/customer_confirmations_screen.dart';
import '../../view/screens/customer_part/home/customer_contractor_profile_view_screen/customer_contractor_profile_view_screen.dart';
import '../../view/screens/customer_part/home/customer_home_screen/customer_home_screen.dart';
import '../../view/screens/customer_part/home/customer_par_sub_category_item/customer_par_sub_category_item.dart';
import '../../view/screens/customer_part/home/customer_services_contractor_screen/customer_services_contractor_screen.dart';
import '../../view/screens/customer_part/home/customer_sub_category_screen/customer_sub_category_screen.dart';
import '../../view/screens/customer_part/home/customer_successfully_paid_screen/customer_successfully_paid_screen.dart';
import '../../view/screens/customer_part/order/customer_request_history_screen/customer_request_history_screen.dart';
import '../../view/screens/customer_part/order/request_history_service_details_page/request_history_service_details_page.dart';
import '../../view/screens/customer_part/profile/about_us_screen/about_us_screen.dart';
import '../../view/screens/customer_part/profile/customer_help_support_screen/customer_help_support_screen.dart';
import '../../view/screens/customer_part/profile/customer_notification_screen/customer_notification_screen.dart';
import '../../view/screens/customer_part/profile/customer_refer_friend_screen/customer_refer_friend_screen.dart';
import '../../view/screens/customer_part/profile/edit_customer_profile_screen/edit_customer_profile_screen.dart';
import '../../view/screens/customer_part/profile/privacy_policy_screen/privacy_policy_screen.dart';
import '../../view/screens/customer_part/profile/terms_conditions_screen/terms_conditions_screen.dart';
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
  static const String subscribeScreen = "/SubscribeScreen";
  static const String paymentMethodScreen = "/PaymentMethodScreen";
  static const String thanksScreen = "/ThanksScreen";
  static const String seletedMapScreen = "/SeletedMapScreen";
  static const String scheduleSeletedScreen = "/ScheduleSeletedScreen";
  static const String categorySeletedScreen = "/CategorySeletedScreen";
  static const String certificateScreen = "/CertificateScreen";
  static const String skillsAddScreen = "/SkillsAddScreen";
  static const String homeScreen = "/HomeScreen";
  static const String orderScreen = "/OrderScreen";
  static const String messageListScreen = "/MessageListScreen";
  static const String chatScreen = "/ChatScreen";
  static const String profileScreen = "/ProfileScreen";
  static const String editProfileScreen = "/EditProfileScreen";
  static const String helpSupportScreen = "/HelpSupportScreen";
  static const String materialsScreen = "/MaterialsScreen";
  static const String addMaterialsScreen = "/AddMaterialsScreen";
  static const String notificationScreen = "/NotificationScreen";
  static const String scheduleScreen = "/ScheduleScreen";
  static const String eranScreen = "/EranScreen";
  static const String onGoingScreen = "/OnGoingScreen";
  static const String onGoingFinishScreen = "/OnGoingFinishScreen";
  static const String chargeScreen = "/ChargeScreen";


  ///===========================Customer==========================
  static const String customerHomeScreen = "/CustomerHomeScreen";
  static const String customerSubCategoryScreen = "/CustomerSubCategoryScreen";
  static const String customerServicesContractorScreen = "/CustomerServicesContractorScreen";
  static const String customerAllContractorViewScreen = "/CustomerAllContractorViewScreen";
  static const String customerContractorProfileViewScreen = "/CustomerContractorProfileViewScreen";
  static const String customerSuccessfullyPaidScreen = "/CustomerSuccessfullyPaidScreen";
  static const String customerConfirmationsScreen = "/CustomerConfirmationsScreen";
  static const String editCustomerProfileScreen = "/EditCustomerProfileScreen";
  static const String customerNotificationScreen = "/CustomerNotificationScreen";
  static const String customerHelpSupportScreen = "/CustomerHelpSupportScreen";
  static const String customerReferFriendScreen = "/CustomerReferFriendScreen";
  static const String customerMessaageListScreen = "/CustomerMessaageListScreen";
  static const String customerSearchResultScreen = "/CustomerSearchResultScreen";
  static const String customarServiceDetailsScreen = "/CustomarServiceDetailsScreen";
  static const String customarQaScreen = "/CustomarQaScreen";
  static const String customarMaterialsScreen = "/CustomarMaterialsScreen";
  static const String customerCategoryScreen = "/CustomerCategoryScreen";
  static const String customerRequestHistoryScreen = "/CustomerRequestHistoryScreen";
  static const String customerParSubCategoryItem = "/CustomerParSubCategoryItem";
  static const String customarServiceContractorDetailsScreen = "/CustomarServiceContractorDetailsScreen";
  static const String requestHistoryServiceDetailsPage = "/RequestHistoryServiceDetailsPage";
  static const String aboutUsScreen = "/AboutUsScreen";
  static const String privacyPolicyScreen = "/PrivacyPolicyScreen";
  static const String termsConditionsScreen = "/TermsConditionsScreen";
  static const String recentAllServiceScreen = "/RecentAllServiceScreen";

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
    GetPage(name: subscribeScreen, page: () => SubscribeScreen()),
    GetPage(name: paymentMethodScreen, page: () => PaymentMethodScreen()),
    GetPage(name: thanksScreen, page: () => ThanksScreen()),
    GetPage(name: seletedMapScreen, page: () => SeletedMapScreen()),
    GetPage(name: scheduleSeletedScreen, page: () => ScheduleSelectedScreen()),
    GetPage(name: categorySeletedScreen, page: () => CategorySelectedScreen()),
    GetPage(name: certificateScreen, page: () => CertificateScreen()),
    GetPage(name: skillsAddScreen, page: () => SkillsAddScreen()),
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: orderScreen, page: () => OrderScreen()),
    GetPage(name: messageListScreen, page: () => MessageListScreen()),
    GetPage(name: chatScreen, page: () => ChatScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: editProfileScreen, page: () => EditProfileScreen()),
    GetPage(name: helpSupportScreen, page: () => HelpSupportScreen()),
    GetPage(name: materialsScreen, page: () => MaterialsScreen()),
    GetPage(name: addMaterialsScreen, page: () => AddMaterialsScreen()),
    GetPage(name: notificationScreen, page: () => NotificationScreen()),
    GetPage(name: scheduleScreen, page: () => ScheduleScreen()),
    GetPage(name: eranScreen, page: () => EranScreen()),
    GetPage(name: onGoingScreen, page: () => OnGoingScreen()),
    GetPage(name: onGoingFinishScreen, page: () => OnGoingFinishScreen()),
    GetPage(name: chargeScreen, page: () => ChargeScreen()),

    ///===========================Customer==========================
    GetPage(name: customerHomeScreen, page: () => CustomerHomeScreen()),
    GetPage(name: customerSubCategoryScreen, page: () => CustomerSubCategoryScreen()),
    GetPage(name: customerServicesContractorScreen, page: () => CustomerServicesContractorScreen()),
    GetPage(name: customerAllContractorViewScreen, page: () => CustomerAllContractorViewScreen()),
    GetPage(name: customerContractorProfileViewScreen, page: () => CustomerContractorProfileViewScreen()),
    GetPage(name: customerSuccessfullyPaidScreen, page: () => CustomerSuccessfullyPaidScreen()),
    GetPage(name: customerConfirmationsScreen, page: () => CustomerConfirmationsScreen()),
    GetPage(name: editCustomerProfileScreen, page: () => EditCustomerProfileScreen()),
    GetPage(name: customerNotificationScreen, page: () => CustomerNotificationScreen()),
    GetPage(name: customerHelpSupportScreen, page: () => CustomerHelpSupportScreen()),
    GetPage(name: customerReferFriendScreen, page: () => CustomerReferFriendScreen()),
    GetPage(name: customerSearchResultScreen, page: () => CustomerSearchResultScreen()),
    GetPage(name: customarServiceDetailsScreen, page: () => CustomarServiceDetailsScreen()),
    GetPage(name: customarQaScreen, page: () => CustomarQaScreen()),
    GetPage(name: customarMaterialsScreen, page: () => CustomarMaterialsScreen()),
    GetPage(name: customerCategoryScreen, page: () => CustomerCategoryScreen()),
    GetPage(name: customerRequestHistoryScreen, page: () => CustomerRequestHistoryScreen()),
    GetPage(name: customerParSubCategoryItem, page: () => CustomerParSubCategoryItem()),
    GetPage(name: customarServiceContractorDetailsScreen, page: () => CustomarServiceContractorDetailsScreen()),
    GetPage(name: requestHistoryServiceDetailsPage, page: () => RequestHistoryServiceDetailsPage()),
    GetPage(name: aboutUsScreen, page: () => AboutUsScreen()),
    GetPage(name: privacyPolicyScreen, page: () => PrivacyPolicyScreen()),
    GetPage(name: termsConditionsScreen, page: () => TermsConditionsScreen()),
    GetPage(name: recentAllServiceScreen, page: () => RecentAllServiceScreen()),

  ];
}
