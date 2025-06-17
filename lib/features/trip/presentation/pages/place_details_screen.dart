// import 'package:flutter/material.dart';
//
// import '../../../../core/utils/app_text_style.dart';
// import '../../../../model/place.dart';
//
// class PlaceDetailsScreen extends StatelessWidget {
//   final Place place;
//
//   const PlaceDetailsScreen({super.key, required this.place});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(place.name ??"")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Image.network(
//                 place.image ??'',
//                 width: double.infinity,
//                 height: 220,
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) =>
//                 const Icon(Icons.image_not_supported, size: 100),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               place.name??'',
//               style: AppTextStyle.size20.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             _infoRow("📍 Address", place.address??''),
//             _infoRow("🕔 Opening Hours", place.??''),
//             _infoRow("📅 Best Time to Visit", place.bestTimeToVisit),
//             _infoRow("💰 Cost", "${place.cost} EGP"),
//             _infoRow("⭐ Rating", "${place.rating}/5"),
//             _infoRow("🗺️ Type", place.type??''),
//             _infoRow("📸 Activities", place.recommendedActivities),
//             _infoRow("⏱️ Visit Duration", place.visitDuration),
//             const SizedBox(height: 12),
//             Text(
//               "📝 Description",
//               style: AppTextStyle.size18.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 6),
//             Text(place.description, style: AppTextStyle.size14),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _infoRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("$title: ", style: AppTextStyle.size14.copyWith(fontWeight: FontWeight.bold)),
//           Expanded(child: Text(value, style: AppTextStyle.size14)),
//         ],
//       ),
//     );
//   }
// }
