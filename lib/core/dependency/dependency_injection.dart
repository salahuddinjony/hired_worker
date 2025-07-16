import 'package:get/get.dart';
import 'package:servana/global/general_controller/general_controller.dart';
import 'package:servana/view/components/custom_Controller/custom_controller.dart';
import 'package:servana/view/screens/authentication/controller/auth_controller.dart';
import 'package:servana/view/screens/choose_language/controller/language_controller.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/map_controller.dart';
import 'package:servana/view/screens/contractor_part/message/controller/message_controller.dart';
import 'package:servana/view/screens/customer_part/home/controller/home_controller.dart';
import '../../view/screens/contractor_part/complete_your_profile/controller/complete_profile_controller.dart';
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
    Get.lazyPut(() => CompleteProfileController(), fenix: true);
    Get.lazyPut(() => CustomerOrderController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => MapController(), fenix: true);
    Get.lazyPut(() => CustomController(), fenix: true);
    Get.lazyPut(() => MessageController(), fenix: true);
  }
}
