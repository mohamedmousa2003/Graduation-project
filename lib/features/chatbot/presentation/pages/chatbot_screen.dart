
import 'dart:io';

import 'package:final_project_bfcai/core/constant/app_text.dart';
import 'package:final_project_bfcai/core/extensions/context_extention.dart';
import 'package:final_project_bfcai/widget/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constant/icons_assets.dart';
import '../../../../core/helper/observer.dart';
import '../../../../core/providers/animation_provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/const.dart';

// class ChatbotScreen extends StatefulWidget {
//   static const String routeName= "chat";
//   const ChatbotScreen({super.key});
//
//   @override
//   State<ChatbotScreen> createState() => _ChatbotScreenState();
// }
//
// class _ChatbotScreenState extends State<ChatbotScreen> with TickerProviderStateMixin, RouteAware {
//   late AnimationManager _animationManager;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationManager = AnimationManager();
//     _animationManager.initialize(this, const Duration(milliseconds: 600));
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // نربط الشاشة دي مع RouteObserver
//     AppNavigatorObserver.instance.subscribe(this, ModalRoute.of(context)!);
//   }
//
//   @override
//   void dispose() {
//     // نلغي الاشتراك
//     AppNavigatorObserver.instance.unsubscribe(this);
//     _animationManager.dispose();
//     super.dispose();
//   }
//
//   @override
//   void didPopNext() {
//     // يتم استدعاؤه لما ترجع للشاشة دي
//     _animationManager.restartAnimation();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.backgroundColor,
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Gap(20.h),
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: GestureDetector(
//                       onTap: () {
//                         context.pop();
//                       },
//                       child: Icon(
//                         Icons.arrow_back,
//                         color: AppColor.primary,
//                         size: 30,
//                       ),
//                     ),
//                   ),
//                   SlideTransition(
//                     position: _animationManager.sliderAnimationTop,
//                     child: Logo(
//                       height: 80.h,
//                       colorBorder: AppColor.primary,
//                       width: 80.w,
//                       imageSize: 60,
//                     ),
//                   ),
//                 ],
//               ),
//
//               Gap(8.h),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

/////////////////////////////////

class ChatbotScreen extends StatefulWidget {
  static const String routeName = "chat";
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  File? file;
  List message = [];
  TextEditingController textEditingController = TextEditingController();

  String keyapi = "AIzaSyDVw5MZ09RS0QHCuDVLIz4ofVgszgnrTp0";

  @override
  void initState() {
    Gemini.init(apiKey: keyapi);
    super.initState();
  }

  openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        file = File(photo.path);
      });
    }
  }

  add() {
    if (file != null) {
      if (textEditingController.text.isNotEmpty) {
        setState(() {
          message.add({
            "text": textEditingController.text,
            "sender": true,
            "image": file,
            "hasImage": true,
          });
        });

        Gemini gemini = Gemini.instance;
        gemini.textAndImage(
          text: textEditingController.text,
          images: [file!.readAsBytesSync()],
        ).then((value) {
          setState(() {
            message.add({
              "text": value?.output ?? "لا يوجد رد",
              "sender": false,
              "image": null,
              "hasImage": false,
            });
          });
        });

        setState(() {
          file = null;
        });
      }
    } else {
      if (textEditingController.text.isNotEmpty) {
        setState(() {
          message.add({
            "text": textEditingController.text,
            "sender": true,
            "image": null,
            "hasImage": false,
          });
        });

        Gemini gemini = Gemini.instance;
        gemini.text(textEditingController.text).then((value) {
          setState(() {
            message.add({
              "text": value?.output ?? "لا يوجد رد",
              "sender": false,
              "image": null,
              "hasImage": false,
            });
          });
        });
      }
    }

    setState(() {
      textEditingController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColor.primary, size: 30),
        title: Shimmer.fromColors(
          baseColor: Colors.blue,
          highlightColor: AppColor.red,
          child:  Text(
            logo,
            style: AppTextStyle.size24,
          ),
        ),
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: Column(
        children: [
          Gap(20.h),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                itemBuilder: (context, index) => Message(
                  sender: message[index]["sender"],
                  text: message[index]["text"],
                  hasImage: message[index]["hasImage"],
                  image: message[index]["image"],
                ),
                itemCount: message.length,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Row(
              children: [
                const SizedBox(width: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.70,
                  height: 40,
                  child: TextFormField(
                    controller: textEditingController,
                    cursorColor: Colors.transparent,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      contentPadding: const EdgeInsets.all(8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColor.primary,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    style:AppTextStyle.size18,
                  ),
                ),
                Gap(8.w),
                GestureDetector(
                  onTap: () => add(),
                  child: const Icon(
                    Icons.send,
                    color: AppColor.primary,
                    size: 38,
                  ),
                ),
                Gap(5.w),
                GestureDetector(
                  onTap: () => openGallery(),
                  child: const Icon(
                    Icons.add_photo_alternate,
                    color: AppColor.primary,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          Gap(8.h),
        ],
      ),
    );
  }
}

class Message extends StatelessWidget {
  final bool sender;
  final bool hasImage;
  final String text;
  final File? image;

  const Message({
    super.key,
    required this.sender,
    required this.text,
    required this.hasImage,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: sender ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          width: 300,
          child: Column(
            crossAxisAlignment:
            sender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (sender && hasImage)
                Container(
                  height: 200.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                    image: image != null
                        ? DecorationImage(
                      image: FileImage(image!),
                      fit: BoxFit.fill,
                    )
                        : null,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              Gap(8.h),
              Container(
                constraints: BoxConstraints(maxWidth: sender ? 250 : 400),
                decoration: BoxDecoration(
                  color: sender
                      ?  AppColor.lightGray
                      : AppColor.primary,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                padding:  EdgeInsets.all(8.0.r),
                child: Text(
                  text,
                  textAlign: TextAlign.start,
                  style: AppTextStyle.size18.copyWith(
                    color: AppColor.white
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
