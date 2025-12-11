class SearchPlace {
  SearchPlace({
    this.touristSpots,});

  SearchPlace.fromJson(dynamic json) {
    if (json['tourist_spots'] != null) {
      touristSpots = [];
      json['tourist_spots'].forEach((v) {
        touristSpots?.add(TouristSpots.fromJson(v));
      });
    }
  }
  List<TouristSpots>? touristSpots;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (touristSpots != null) {
      map['tourist_spots'] = touristSpots?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class TouristSpots {
  TouristSpots({
    this.city,
    this.name,
    this.address,
    this.image,});

  TouristSpots.fromJson(dynamic json) {
    city = json['city'];
    name = json['name'];
    address = json['address'];
    image = json['image'];
  }
  String? city;
  String? name;
  String? address;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = city;
    map['name'] = name;
    map['address'] = address;
    map['image'] = image;
    return map;
  }

}