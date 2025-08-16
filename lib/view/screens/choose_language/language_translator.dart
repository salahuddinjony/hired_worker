import 'package:get/get_navigation/src/root/internacionalization.dart';

import 'english.dart';
import 'chinese.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    "en_US": english,
    "zh_CN": chinese,
  };
}
