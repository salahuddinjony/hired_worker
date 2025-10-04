// import 'package:flutter/material.dart';
// import '../model/contactor_details_model.dart';

// /// A reusable card widget that renders a single review.
// class ReviewCard extends StatelessWidget {
//   final Review review;
//   final double maxWidth;

//   const ReviewCard({Key? key, required this.review, this.maxWidth = double.infinity}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final customer = review.customerId;
//   final theme = Theme.of(context);

//     return ConstrainedBox(
//       constraints: BoxConstraints(maxWidth: maxWidth),
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildAvatar(customer, theme),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             customer?.fullName.isNotEmpty == true ? customer!.fullName : 'Anonymous',
//                             style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         _buildStars(review.stars, theme),
//                       ],
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       _formatDate(review.createdAt),
//                       style: theme.textTheme.bodySmall,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       review.description.isNotEmpty ? review.description : 'No comment provided.',
//                       style: theme.textTheme.bodyMedium,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAvatar(Customer? customer, ThemeData theme) {
//     final avatarRadius = 22.0;
//     if (customer == null || customer.img.isEmpty) {
//       return CircleAvatar(
//         radius: avatarRadius,
//         backgroundColor: theme.colorScheme.primary.withOpacity(0.12),
//         child: Icon(Icons.person, color: theme.colorScheme.primary, size: 22),
//       );
//     }

//     // Use NetworkImage but guard in case the URL is not valid.
//     return CircleAvatar(
//       radius: avatarRadius,
//       backgroundImage: NetworkImage(customer.img),
//       backgroundColor: Colors.transparent,
//     );
//   }

//   Widget _buildStars(int stars, ThemeData theme) {
//     final capped = stars.clamp(0, 5);
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(5, (i) {
//         final active = i < capped;
//         return Icon(
//           active ? Icons.star : Icons.star_border,
//           size: 16,
//           color: active ? Colors.amber.shade700 : theme.disabledColor,
//         );
//       }),
//     );
//   }

//   String _formatDate(String iso) {
//     if (iso.isEmpty) return '';
//     try {
//       final dt = DateTime.parse(iso);
//       return '${dt.day}/${dt.month}/${dt.year}';
//     } catch (_) {
//       // Fallback if it's not ISO
//       return iso.split('T').first;
//     }
//   }
// }
