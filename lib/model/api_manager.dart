import 'dart:convert';
import 'package:http/http.dart' as http;

import 'ClassicalPlace.dart';
import 'SearchPlace.dart';
import 'TouristPlace.dart';
import 'api_constants.dart';

class ApiManager {

  static Future<List<TouristPlace>> getTourist() async {

    Uri url = Uri.http(
      ApiConstants.baseUrlClassical,
      ApiConstants.endPointTourist,
    );


    try {

      final response = await http.get(url);
        final jsonData = jsonDecode(response.body) as List;

        // تحويل كل عنصر إلى TouristPlace
        return jsonData.map((item) => TouristPlace.fromJson(item)).toList();

    } catch (e) {
      throw Exception("حدث خطأ أثناء الاتصال بالسيرفر: $e");
    }
  }

  static Future<List<ClassicalPlace>> getClassical() async {


    Uri url = Uri.http(
      ApiConstants.baseUrlClassical,
      ApiConstants.endPointClassical,
    );


    try {

      final response = await http.get(url);

      final jsonData = jsonDecode(response.body) as List;
      // تحويل كل عنصر إلى ClassicalPlace
      return jsonData.map((item) => ClassicalPlace.fromJson(item)).toList();

    } catch (e) {
      throw Exception("حدث خطأ أثناء الاتصال بالسيرفر: $e");
    }
  }



  static Future<SearchPlace> searchPlace(String province) async {
    Uri url = Uri.http(
      ApiConstants.baseUrlSearch,
      ApiConstants.endPointSearch,
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'province': province}),
      );

      print("Response: ${response.body}");
        final jsonData = jsonDecode(response.body);
        return SearchPlace.fromJson(jsonData);

    } catch (e) {
      throw Exception("حدث خطأ أثناء الاتصال بالسيرفر: $e");
    }
  }


}


// class ApiManager {
//
//   // http://classical.runasp.net/api/Landmarks/tourist
//
//   // function to get data
//   static Future<TouristPlace> getClassical() async{
//     Uri url =Uri.http(
//       ApiConstants.baseUrlClassical,
//       ApiConstants.endPoint,
//     );
//     try{
//       var response = await http.get(url);
//       var responseBody =response.body; // now datatype String i am not using String
//       // response came (json )
//
//       //convert String to json
//       var json=jsonDecode(responseBody);
//       // //convert json to object
//       return TouristPlace.fromJson(json); // object from tourists
//       // Tourists.fromJson(jsonDecode(response.body));
//     }
//     catch(error){
//       //throw error
//       throw "Error" ;
//     }
//
//
//   }
//
// }