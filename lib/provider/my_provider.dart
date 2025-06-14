import 'package:flutter/foundation.dart';
import '../model/ClassicalPlace.dart';
import '../model/TouristPlace.dart';


class FavoritesProvider with ChangeNotifier {
  final List<ClassicalPlace> _favorites = [];

  List<ClassicalPlace> get favorites => _favorites;

  bool isFavorite(ClassicalPlace place) {
    return _favorites.any((element) => element.name == place.name);
  }

  void toggleFavorite(ClassicalPlace place) {
    final isExist = isFavorite(place);
    if (isExist) {
      _favorites.removeWhere((element) => element.name == place.name);
    } else {
      _favorites.add(place);
    }
    notifyListeners();
  }
}

class FavoritesProvider2 with ChangeNotifier {
  final List<TouristPlace> _favorites = [];

  List<TouristPlace> get favorites => _favorites;

  bool isFavorite(TouristPlace place) {
    return _favorites.any((element) => element.name == place.name);
  }

  void toggleFavorite(TouristPlace place) {
    final isExist = isFavorite(place);
    if (isExist) {
      _favorites.removeWhere((element) => element.name == place.name);
    } else {
      _favorites.add(place);
    }
    notifyListeners();
  }
}

