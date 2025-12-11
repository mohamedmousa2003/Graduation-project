import '../../data/models/tourist_place.dart';
abstract class TouristPlaceRepositories {

  Future<List<TouristPlace>> getTourist();

}