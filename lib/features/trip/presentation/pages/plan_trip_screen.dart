// import 'package:final_project_bfcai/core/utils/app_text_style.dart';
// import 'package:flutter/material.dart';
// import '../../../../core/utils/app_colors.dart';
// import '../../logic/TripPlan.dart';
//
// class PlanTripScreen extends StatelessWidget {
//   static const String routeName= "planTrip";
//   const PlanTripScreen({super.key, required this.tripPlan});
//   final TripPlan tripPlan;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Trip Plan")),
//       body:
//            ListView(
//             padding: const EdgeInsets.all(16),
//             children: [
//               _buildTripInfo(tripPlan),
//               const SizedBox(height: 10),
//               ...tripPlan.tripPlan.map((day) => ExpansionTile(
//                 title: Padding(
//                   padding: const EdgeInsets.only(top: 30.0),
//                   child: Text(day.day, style: AppTextStyle.size18.copyWith(
//                       color: AppColor.primary)),
//                 ),
//                 children: day.places.map((place) => _buildPlaceTile(place)).toList(),
//               )),
//             ],
//
//     ));
//   }
//
//   Widget _buildTripInfo(TripPlan trip) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       color: AppColor.backgroundColor,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _infoRow("✈️ Arrival Airport", trip.arrivalAirport),
//             _infoRow("📅 Best Time to Visit", trip.bestTimeToVisit),
//             _infoRow("🗓️ Suggested Month", trip.suggestedMonth),
//             _infoRow("💰 Total Cost", "${trip.totalCost} EGP"),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _infoRow(String title, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 8,),
//         Text(
//             title,
//             style: AppTextStyle.size18.copyWith(
//               color: AppColor.white
//             )),
//         SizedBox(height: 4,),
//         Text(value,style: AppTextStyle.size14.copyWith(
//             color: AppColor.white
//         )),
//         Divider(color: AppColor.gray,),
//         SizedBox(height: 8,),
//       ],
//     );
//   }
//
//   Widget _buildPlaceTile(Place place) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//       child: ListTile(
//         leading: ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Image.network(
//             place.image,
//             width: 60,
//             height: 60,
//             fit: BoxFit.cover,
//             errorBuilder: (context, _, __) =>
//                 Icon(Icons.image_not_supported,color: AppColor.primary,),
//           ),
//         ),
//         title: Text(place.name, style: const TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(place.address),
//             Text("🕔 ${place.bestTimeToVisit}"),
//             Text("🕔 ${place.openingHours}"),
//             Text("⭐ ${place.rating} | 💵 ${place.cost} EGP"),
//             Text("⭐ ${place.name} | 💵 ${place.cost} EGP"),
//
//           ],
//         ),
//         onTap: () {
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (_) => PlaceDetailsScreen(place: place),
//           //   ),
//           // );
//         },
//       ),
//     );
//   }}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../test.dart';
import '../../logic/TripPlan.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final Place place;

  const PlaceDetailsScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
          scrolledUnderElevation: 0,
          elevation: 0,
          title: Text(place.name,style: AppTextStyle.size21)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    place.image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 100),
                  ),
                ),
                Gap(16.h),
            
                Text(place.name, style: AppTextStyle.size21.copyWith(fontWeight: FontWeight.bold)),
                Gap(8.h),
            
                Text("📍 Address: ${place.address}", style: AppTextStyle.size16),
                Gap(8.h),
            
                Text("🏷️ Type: ${place.type}", style: AppTextStyle.size16),
                Gap(8.h),
                Text("💰 Cost: ${place.cost} EGP", style: AppTextStyle.size16),
                Gap(8.h),
                Text("⭐ Rating: ${place.rating}", style: AppTextStyle.size16),
                Gap(8.h),
            
                Text("📌 Coordinates:", style: AppTextStyle.size18.copyWith(fontWeight: FontWeight.bold)),
                Gap(4.h),
                Text("Latitude: ${place.latitude}", style: AppTextStyle.size14),
                Gap(4.h),
                Text("Longitude: ${place.longitude}", style: AppTextStyle.size14),
                Gap(10.h),
            
                Text("🕐 Opening Hours: ${place.openingHours}", style: AppTextStyle.size18),
                Gap(4.h),
                Text("🕔 Best Time to Visit: ${place.bestTimeToVisit}", style: AppTextStyle.size18),
                Gap(4.h),
                Text("⏳ Visit Duration: ${place.visitDuration}", style: AppTextStyle.size18.copyWith(fontWeight: FontWeight.bold)),
                Gap(10.h),
            
                Text("🎯 Recommended Activities:", style: AppTextStyle.size18.copyWith(fontWeight: FontWeight.bold)),
                Text(place.recommendedActivities, style: AppTextStyle.size16),
                Gap(10.h),
            
                Text("📝 Description:", style: AppTextStyle.size18.copyWith(fontWeight: FontWeight.bold)),
                Text(place.description, style: AppTextStyle.size16),
                Gap(16.h),
                MyGoogleMapLink(text: place.name?? "",),
                const SizedBox(height: 8),
                MyGoogleLink(text: place.name?? "",),
              ],
            ),
          )

      ),
    );
  }
}

class PlanTripScreen extends StatelessWidget {
  static const String routeName = "planTrip";

  const PlanTripScreen({super.key, required this.tripPlan});
  final TripPlan tripPlan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(title: const Text("Your Trip Plan")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTripInfo(tripPlan),
            const SizedBox(height: 20),
            ...tripPlan.tripPlan.map(
                  (day) => Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(bottom: 16),
                child: ExpansionTile(
                  title: Text(
                    day.day,
                    style: AppTextStyle.size18.copyWith(
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: day.places
                      .map((place) => _buildPlaceTile(context, place))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripInfo(TripPlan trip) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow("✈️ Arrival Airport", trip.arrivalAirport),
          _infoRow("📅 Best Time to Visit", trip.bestTimeToVisit),
          _infoRow("🗓️ Suggested Month", trip.suggestedMonth),
          _infoRow("💰 Total Cost", "${trip.totalCost} EGP"),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style: AppTextStyle.size14.copyWith(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text(value,
                style: AppTextStyle.size14.copyWith(color: Colors.grey[700])),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceTile(BuildContext context, Place place) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          place.image,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
          const Icon(Icons.image_not_supported_outlined),
        ),
      ),
      title: Text(place.name, style: AppTextStyle.size16),
      subtitle: Text(place.address, style: TextStyle(color: Colors.grey[600])),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16,color: AppColor.primary,),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlaceDetailsScreen(place: place),
          ),
        );
      },
    );
  }
}
