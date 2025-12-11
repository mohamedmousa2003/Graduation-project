// HotelCard Widget with full design and link launch
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_text_style.dart';
import '../../../model/HotelsModel.dart';
import '../hotel/data/models/hotel_model.dart';


class HotelCard extends StatelessWidget {
  final HotelModel hotel;

  const HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 320.w,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // اسم الفندق
              Text(hotel.name,
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
        
              SizedBox(height: 8.h),
        
              // معلومات أساسية
              Text(hotel.essentialInfo,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600])),
        
              SizedBox(height: 8.h),
        
              // التقييم وعدد المراجعات
              Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 20),
                  SizedBox(width: 4),
                  Text('${hotel.overallRating}',
                      style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Text('(${hotel.reviews} reviews)',
                      style: TextStyle(
                        color: AppColor.gray,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold)),
                ],
              ),

              Gap(8.h),
        
              // أوقات الدخول والخروج
              Text('🕒 Check-in: ${hotel.checkIn} \n🕒 Check-out: ${hotel.checkOut}',
                  style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold)),
        
              Gap(8.h),
        
              // السعر
              Text('💰 Price: ${hotel.lowestRate}',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),

              Gap(8.h),
        
              // الأماكن القريبة
              if (hotel.nearbyPlaces.isNotEmpty) ...[
                Text('📍 Nearby Places:',
                    style: AppTextStyle.size18.copyWith(
                      fontWeight: FontWeight.bold,
                    ),),
                SizedBox(height: 4),
                Text(hotel.nearbyPlaces, style: TextStyle(fontSize: 15.sp)),
              ],

              Gap(10.h),
              Gap(10.h),

              // المميزات
              if (hotel.amenities.isNotEmpty) ...[
                Text('✅ Amenities:',
                  style: AppTextStyle.size18.copyWith(
                    fontWeight: FontWeight.bold,
        
                  ),),
                Gap(8.h),
                Wrap(
                  spacing: 4,
                  children: hotel.amenities
                      .take(hotel.amenities.length) // عرض أول 6 فقط للتنظيم
                      .map((a) => Chip(label: Text(a, style: TextStyle(fontSize: 15.sp))))
                      .toList(),
                ),
              ],

              Gap(12.h),
        
              if (hotel.excludedAmenities.isNotEmpty) ...[
                Text('❌ Not Available:',
                  style: AppTextStyle.size18.copyWith(
                      fontWeight: FontWeight.bold,
        
                  ),),
                Gap(8.h),
                Wrap(
                  spacing: 4,
                  children: hotel.excludedAmenities
                      .take(hotel.excludedAmenities.length) // عرض أول 4 فقط
                      .map((a) => Chip(
                    label: Text(a, style: TextStyle(fontSize: 15.sp)),
                    backgroundColor: Colors.red[50],
                  ))
                      .toList(),
                ),
              ],
        
              SizedBox(height: 12.h),
        
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
            onPressed: () async {
              final Uri _url = Uri.parse(hotel.link);
              if (!await launchUrl(
                _url,
                mode: LaunchMode.externalApplication,
              )) {
                throw Exception('Could not launch $_url');
              }

            else {
            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not launch link')),
            );
            }
            },
            icon: const Icon(Icons.open_in_new,size: 22,),
                  label: Text(
                    'View Booking',
                    style: AppTextStyle.size18.copyWith(
                        fontWeight: FontWeight.bold,
                      color: AppColor.white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
        
        
            ],
          ),
        ),
      ),
    );
  }
}
