import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/view/components/extension/extension.dart';
import 'package:servana/view/screens/customer_part/order/model/customer_order_model.dart';
import 'package:servana/view/screens/customer_part/order/request_history_service_details_page/view_image_gallery/widgets/design_files_gallery.dart';

class BookingStatusCard extends StatelessWidget {
  final BookingDateAndStatus booking;
  const BookingStatusCard({super.key, required this.booking});

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'in_complete':
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String status = booking.status ?? '';
    final Color color = _statusColor(status);
    final String formattedDate =
        DateTime.tryParse(booking.date ?? '')?.formatDate() ?? '';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: color.withValues(alpha: .2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      status.toLowerCase() == 'completed'
                          ? Icons.check_circle
                          : Icons.hourglass_bottom,
                      color: color,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      status.isNotEmpty
                          ? status.replaceAll('_', ' ').safeCap()
                          : 'Unknown',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: color,
                      ),
                    ),
                  ],
                ),
                if (formattedDate.isNotEmpty)
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),

            // ✅ Use DesignFilesGallery for images
            if (booking.image.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Images:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 100.w,
                    height: 100.h,
                    child: DesignFilesGallery(
                      designFiles:
                          booking.image.map((e) {
                            if (e is String) return e;
                            return e.url ?? ''; // adjust field name
                          }).toList(),
                      height: 100.h,
                      width: double.infinity,
                    ),
                  ),

                  const SizedBox(height: 8),
                ],
              ),

            // Materials
            if (booking.materials.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Materials:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ...booking.materials.map((m) {
                    final name = m.name ?? '';
                    final count = m.count ?? 0;
                    final price = m.price ?? 0;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$name - $count × \$$price',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '\$${count * price}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 6),
                ],
              ),

            // Amount
            if (booking.amount != null && booking.amount! > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Amount:',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '\$${booking.amount}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
