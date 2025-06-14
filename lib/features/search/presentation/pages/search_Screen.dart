import 'package:final_project_bfcai/core/extensions/context_extention.dart';
import 'package:final_project_bfcai/core/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/constant/icons_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../model/SearchPlace.dart';
import '../../../../model/api_manager.dart';
import '../../../../widget/custom_dialog.dart';
import '../../../../widget/empty.dart';

class ClassicalPlacesScreen extends StatefulWidget {
  static const String routeName = "search";
  const ClassicalPlacesScreen({super.key});

  @override
  State<ClassicalPlacesScreen> createState() => _ClassicalPlacesScreenState();
}

class _ClassicalPlacesScreenState extends State<ClassicalPlacesScreen> {
  String? selectedProvince;
  Future<SearchPlace>? _futurePlace;

  void _search() {
    if (selectedProvince == null || selectedProvince!.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: AppColor.white,
          title:  Text(warning,style: AppTextStyle.size24.copyWith(fontWeight: FontWeight.bold),),
          content: Text(writeResult,style: AppTextStyle.size18.copyWith(
              fontWeight: FontWeight.bold,color: AppColor.gray
          ),),
          actions: [
            SizedBox(
              width: 50.w,
              height: 40.h,
              child: MaterialButtonWidget(
                colorBackground: AppColor.lightGray,
                radius: 20,
                onPressed: () {
                context.pop();
              }, title: Text(ok),
              ),
            )

          ],
        ),
      );
    } else {
      setState(() {
        _futurePlace = ApiManager.searchPlace(selectedProvince!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Gap(20.h),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: enterGovernorateName,
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColor.lightGray, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) => selectedProvince = value,
                  ),
                ),
                Gap(12.h),
                Expanded(
                  child: MaterialButtonWidget(
                    colorBackground: AppColor.lightGray,
                    onPressed: _search,
                    title: const Icon(Icons.search, color: AppColor.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<SearchPlace>(
                future: _futurePlace,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: EmptyStateWidget(
                        imagePath: IconsSvg.search,
                        imageWidth: 50,
                        imageHeight: 50,
                        title: noInternetConnection,
                        description: checkYourConnection,
                      ),
                    );
                  } else if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data!.touristSpots == null ||
                      snapshot.data!.touristSpots!.isEmpty) {
                    return const Center(
                      child: EmptyStateWidget(
                        imagePath: IconsSvg.search,
                        imageWidth: 50,
                        imageHeight: 50,
                        title: noResult,
                        description: noPlace,
                      ),
                    );
                  }

                  final places = snapshot.data!.touristSpots!;
                  return ListView.builder(
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      final place = places[index];
                      return ListTile(
                        title: Text(
                          place.name ?? "No name",
                          style: AppTextStyle.size18.copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          place.address ?? "No address",
                          style: AppTextStyle.size14.copyWith(color: AppColor.gray),
                        ),
                        leading: place.image != null
                            ? SizedBox(
                          width: mediaQuery.width * 0.2,
                          height: double.infinity,
                          child: Image.network(
                            place.image!,
                            fit: BoxFit.cover,
                          ),
                        )
                            : null,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
