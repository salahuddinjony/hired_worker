import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_strings/app_strings.dart';
import 'package:servana/view/components/custom_nav_bar/customer_navbar.dart';
import 'package:servana/view/components/custom_nav_bar/navbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/components/message_card/message_card.dart';
import 'package:servana/view/screens/message/chat/inbox_screen/controller/conversation_controller.dart';
import 'package:servana/view/screens/message/chat/inbox_screen/widgets/empty_conversations.dart';
import 'package:servana/view/screens/message/chat/inbox_screen/widgets/inbox_loader.dart';

class InboxScreen extends StatelessWidget {
  final bool isCustomer;
  InboxScreen({super.key, this.isCustomer = false});

  String _formatMessageTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays == 0) {
     
      return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    } else if (difference.inDays == 1) {
      
      return "Yesterday";
    } else if (difference.inDays < 7) {
    
      const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
      return days[dateTime.weekday - 1];
    } else {
    
      return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    }
  }

  final controller = Get.find<ConversationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      // custom bottom nav bar
      bottomNavigationBar: Obx(() {
        return controller.thisRole.value
            ? const CustomerNavbar(currentIndex: 2)
            : const Navbar(currentIndex: 2);
      }),
      appBar: AppBar(title: Text(AppStrings.chatList)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'All Conversations'.tr,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primary,
                backgroundColor: AppColors.white,
                onRefresh: () async {
                  await controller.loadConversations();
                },
                child: Obx(() {
                  // Create a copy of the list to avoid modifying the reactive list during build
                  final conversations = List.from(controller.conversationList);
                  conversations.sort((a, b) {
                    final aTime = controller.parseDate(a.updatedAt) ??
                        DateTime.fromMillisecondsSinceEpoch(0);
                    final bTime = controller.parseDate(b.updatedAt) ??
                        DateTime.fromMillisecondsSinceEpoch(0);
                    return bTime.compareTo(aTime);
                  });

                  if (controller.isLoading.value) {
                    return InboxLoader();
                  }

                  if (conversations.isEmpty) {
                    return EmptyConversations(controller: controller);
                  }
                  return ListView.builder(
                    // controller: controller.scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      final convo = conversations[index];
                      final hasParticipants = convo.participants.isNotEmpty;
                      final participant = hasParticipants ? convo.participants.first : null;

                      final image =
                          participant?.img ??
                          AppConstants.profileImage;
                      final receiverName =
                          participant?.fullName ?? 'Unknown';
                      final recieverId = participant?.id ?? '';
                      final messageText = convo.lastMessage?.toString() ?? '';
                      final parsedDateTime = controller.parseDate(convo.lastMessageTime);
                      final lastdateTime = parsedDateTime != null 
                          ? _formatMessageTime(parsedDateTime)
                          : null;

                      return Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: MessageCard(
                          imageUrl: image,
                          senderName: receiverName,
                          message: messageText,
                          lastMessageTime: lastdateTime,
                          onTap: () async {
                            final String loggedUserId =
                                await SharePrefsHelper.getString(
                                  AppConstants.userId,
                                );
                            final String loggedUserRole =
                                await SharePrefsHelper.getString(
                                  AppConstants.role,
                                );
                            debugPrint(
                              'Tapped conversation ID: ${convo.id}\nSender ID: $recieverId',
                            );
                            Get.toNamed(
                              AppRoutes.chatScreen,
                              arguments: {
                                'receiverName': receiverName,
                                'receiverImage': image,
                                'conversationId': convo.id,
                                'userId': loggedUserId,
                                'receiverId': recieverId,
                                'userRole': loggedUserRole,
                                'isCustomer': isCustomer,
                              },
                            );
                            // refresh conversations to pick up lastMessage updates
                            try {
                              await controller.loadConversations();
                            } catch (_) {
                              controller.conversationList.refresh();
                            }
                          },
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
