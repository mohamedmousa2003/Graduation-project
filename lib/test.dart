// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class MyGoogleLink extends StatelessWidget {
//   static String routName = "google";
//   final String text;
//
//   MyGoogleLink({super.key, required this.text});
//
//   Future<void> _launchUrl() async {
//     // استخدام Uri.https لضمان تكويد النص بطريقة صحيحة
//     final Uri url = Uri.https(
//       'en.wikipedia.org',
//       '/wiki/${text.replaceAll(' ', '_')}',
//     );
//
//     if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//       throw 'Could not launch $url';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: const Text(
//         "Item Details",
//         style: TextStyle(
//           color: Colors.blue,
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       onTap: _launchUrl,
//       trailing: const Icon(Icons.arrow_right, color: Colors.blue, size: 30),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyGoogleLink extends StatelessWidget {
  static String routName = "google";
  final String text;

  MyGoogleLink({super.key, required this.text});

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(
        'https://www.google.com/search?q=${Uri.encodeComponent(text)}');

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Search for: $text",
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: _launchUrl,
      trailing: const Icon(Icons.search, color: Colors.blue, size: 30),
    );
  }
}




class MyGoogleMapLink extends StatelessWidget {
  static String routName = "google_map";
  final String text;

  const MyGoogleMapLink({super.key, required this.text});

  Future<void> _launchMap() async {
    final Uri mapUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(text)}',
    );

    if (!await launchUrl(mapUrl, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $mapUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Open Map $text",
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: _launchMap,
      trailing: const Icon(Icons.map, color: Colors.blue, size: 30),
    );
  }
}
