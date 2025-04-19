import 'package:get/get.dart';

import '../../view/screens/contractor_part/home/order_screen/controller/order_controller.dart';
import '../../view/screens/contractor_part/profile/controller/profile_controller.dart';
import '../../view/screens/customer_part/profile/controller/customer_profile_controller.dart';
class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    ///==========================Default Custom Controller ==================
    Get.lazyPut(() => OrderController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => CustomerProfileController(), fenix: true);

  }
}
