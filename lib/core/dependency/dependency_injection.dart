import 'package:get/get.dart';
import 'package:servana/global/general_controller/general_controller.dart';
import 'package:servana/view/components/custom_Controller/custom_controller.dart';
import 'package:servana/view/screens/authentication/controller/auth_controller.dart';
import 'package:servana/view/screens/choose_language/controller/language_controller.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/add_material_controller.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/charge_controller.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/map_controller.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/sub_category_selection_controller.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/subscription_plan_controller.dart';
import 'package:servana/view/screens/contractor_part/home/controller/contractor_home_controller.dart';
import 'package:servana/view/screens/contractor_part/home/on_going_screen/controller/on_going_controller.dart';
import 'package:servana/view/screens/contractor_part/home/on_going_screen/controller/photo_upload_controller.dart';
import 'package:servana/view/screens/contractor_part/profile/controller/support_controller.dart';
import 'package:servana/view/screens/contractor_part/profile/schedule_screen/controller/schedule_controller.dart';
import 'package:servana/view/screens/customer_part/home/customar_qa_screen/booking_controller/contractor_booking_controller.dart';
import 'package:servana/view/screens/message/chat/inbox_screen/controller/conversation_controller.dart';
import 'package:servana/view/screens/message/controller/message_controller.dart';
import 'package:servana/view/screens/customer_part/home/controller/home_controller.dart';
import '../../view/screens/contractor_part/complete_your_profile/controller/category_selection_controller.dart';
import '../../view/screens/contractor_part/complete_your_profile/controller/certificate_upload_controller.dart';
import '../../view/screens/contractor_part/complete_your_profile/controller/schedule_selection_controller.dart';
import '../../view/screens/contractor_part/complete_your_profile/controller/skill_selection_controller.dart';
import '../../view/screens/contractor_part/home/controller/recent_all_service_controller.dart';
import '../../view/screens/contractor_part/home/order_screen/controller/order_controller.dart';
import '../../view/screens/contractor_part/profile/controller/profile_controller.dart';
import '../../view/screens/customer_part/order/controller/customer_order_controller.dart';
import '../../view/screens/customer_part/profile/controller/customer_profile_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    ///==========================Default Custom Controller ==================
    Get.put(LanguageController());
    Get.lazyPut(() => GeneralController(), fenix: true);
    Get.lazyPut(() => OrderController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => CustomerProfileController(), fenix: true);
    Get.lazyPut(() => CertificateUploadController(), fenix: true);
    Get.lazyPut(() => CustomerOrderController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ContractorHomeController(), fenix: true);
    Get.lazyPut(() => RecentAllServiceController(), fenix: true);
    Get.lazyPut(() => MapController(), fenix: true);
    Get.lazyPut(() => CustomController(), fenix: true);
    Get.lazyPut(() => ConversationController(), fenix: true);
    Get.lazyPut(() => ScheduleSelectionController(), fenix: true);
    Get.lazyPut(() => CategorySelectionController(), fenix: true);
    Get.lazyPut(() => SubCategorySelectionController(), fenix: true);
    Get.lazyPut(() => SkillSelectionController(), fenix: true);
    Get.lazyPut(() => MaterialController(), fenix: true);
    Get.lazyPut(() => ChargeController(), fenix: true);
    Get.lazyPut(() => SubscriptionPlanController(), fenix: true);
    Get.lazyPut(() => ScheduleController(), fenix: true);
    Get.lazyPut(() => SupportController(), fenix: true);
    Get.lazyPut(() => ContractorBookingController(), fenix: true);
    Get.lazyPut(() => CustomerOrderController(), fenix: true);
    Get.lazyPut(() => OnGoingController(), fenix: true);
    Get.lazyPut(() => PhotoUploadController(), fenix: true);
  }
}
