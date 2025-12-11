import 'dart:convert';
import 'package:http/http.dart' as http;

import '../features/auth/logic/sign_up_response.dart';
import '../features/home/classical_place/data/models/classical_place.dart';
import '../features/home/tourist_place/data/models/tourist_place.dart';
import '../features/hotels/hotel/data/models/hotel_model.dart';
import '../features/search/search/data/models/SearchPlace.dart';
import '../features/trip/logic/TripPlan.dart';
import 'ClassicalPlace.dart';
import 'HotelsModel.dart';
import 'RequestSignUpModel.dart';
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

  static Future<List<HotelModel>> getHotels() async {
    final url = Uri.parse('http://hotelstourism.runasp.net/api/Hotels/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => HotelModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load hotels');
    }
  }

}

Future<TripPlan> getTripPlan(RequestPlanTrip parposer) async {
  final response = await http.post(
    Uri.parse('http://tourism1.runasp.net/plan_trip'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(parposer.toJson()),
  );
  if (response.statusCode == 200) {
    print(response.body);
    return TripPlan.fromJson(jsonDecode(response.body
    ));
  } else {
    throw Exception('Failed to get trip plan');
  }
}

Future<SignUpResponse> signUpUser(RequestSignUpModel requestModle) async {
  try {
    final response = await http.post(
      Uri.parse('http://identityhost.runasp.net/api/Auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestModle.toJson()),
    );
    return SignUpResponse.fromJson(jsonDecode(response.body));
  } on Exception catch (e) {
    throw Exception(e.toString());
  }
}

Future<SignUpResponse> signInUser(SignInModelRequest signInUser) async {
  try {
    final response = await http.post(
      Uri.parse('http://identityhost.runasp.net/api/Auth/signin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(signInUser.toJson()),
    );
    return SignUpResponse.fromJson(jsonDecode(response.body));
  } on Exception catch (e) {
    throw Exception(e.toString());
  }
}