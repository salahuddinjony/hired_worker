import 'package:get/get.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/utils/app_strings/app_strings.dart';

class HomeController extends GetxController {

  @override
  void onInit() {
    getCategory();
    super.onInit();
  }

  Rx<RxStatus> getCategoryStatus = Rx<RxStatus>(RxStatus.loading());

  //======= get Category =======//
  Future<void> getCategory() async {
    getCategoryStatus.value = RxStatus.loading();
    try {
      final response = await ApiClient.getData(ApiUrl.categories);

      getCategoryStatus.value = RxStatus.success();
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        
        showCustomSnackBar(
          response.body['message'] ?? "Login successful",
          isError: false,
        );
      } else {
        showCustomSnackBar(
          response.body['message'] ?? "Login Failed",
          isError: false,
        );
      }
    } catch (e) {
      getCategoryStatus.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }
}
