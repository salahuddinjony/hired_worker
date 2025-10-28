import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/view/screens/message/chat/inbox_screen/controller/mixin_conversation.dart';

class ConversationController extends GetxController with MixinChatConversation {
  final isLoading = false.obs;
  final RxBool thisRole = true.obs;

  @override
  void onInit() async {
    super.onInit();
    loadConversations();

    await getRole();
    final String roles = await SharePrefsHelper.getString(AppConstants.role);
    debugPrint("User Role================>> $roles");
    debugPrint("User Role bool================>> ${thisRole.value}");
  }

  Future<void> getRole() async {
    final String role = await SharePrefsHelper.getString(AppConstants.role);
    thisRole.value = role == "customer" ? true : false;
  }

  DateTime? parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        final ms = int.tryParse(value);
        if (ms != null) return DateTime.fromMillisecondsSinceEpoch(ms);
      }
    }
    return null;
  }

  Future<void> loadConversations() async {
    isLoading.value = true;
    try {
      await fetchConversationsList();
    } catch (e) {
      debugPrint('Error loading conversations: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
