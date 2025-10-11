import 'package:flutter/material.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';

class ChatHeader extends StatelessWidget implements PreferredSizeWidget {
  final String receiverName;
  final String receiverImage;
  final VoidCallback onBack;
  final VoidCallback? onMore;
  final String id;
  final bool isCustomer;

  const ChatHeader({
    super.key,
    required this.receiverName,
    required this.receiverImage,
    required this.onBack,
    this.onMore, 
    required this.id, required this.isCustomer,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Stack(
                children: [
                  ClipOval(
                    child: CustomNetworkImage(
                        imageUrl: receiverImage, height: 48, width: 48),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    receiverName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Active now',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            // clearer "Make Offer" action for users
           if(isCustomer) TextButton.icon(
              onPressed: onMore,
              icon: const Icon(Icons.local_offer, color: AppColors.primary, size: 20),
              label: const Text(
                'Make Offer',
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                backgroundColor: Colors.grey.shade100,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            )else Icon( Icons.more_vert, color: Colors.grey.shade600),
            // Text(id
            //   , style: const TextStyle(fontSize: 12, color: Colors.grey),)
          ],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: onBack,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}