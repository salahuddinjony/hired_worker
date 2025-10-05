import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';

class LanguageController extends GetxController {
  @override
  void onInit() {
    _loadLanguagePreference();
    super.onInit();
  }
    //========= language ===============
  var isChinese = false.obs;

 
  void toggleLanguage(bool value) async {
    isChinese.value = value;
     await SharePrefsHelper.setBool('isChinese', value);
    final newLocale = value ? Locale('zh', 'CN') : Locale('en', 'US');
    Get.updateLocale(newLocale);
  }
  

  void _loadLanguagePreference() async {
     isChinese.value = await SharePrefsHelper.getBool('isChinese') ?? false;
    final savedLocale =
        isChinese.value ? Locale('zh', 'CN') : Locale('en', 'US');
    Get.updateLocale(savedLocale);
  }

}