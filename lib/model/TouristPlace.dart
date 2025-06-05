/// name : "Mini Egypt Park"
/// address : "Makadi Bay, Hurghada 84511 Egypt"
/// type : "Landmark"
/// rating : 4.5
/// description : "Miniegyptpark is a miniature for all egypt it has more than 50 makets with scale 1:25 for the most famous palces of egypt.Its an open air museum which can help the guests to have an idea about all egypt in one place."
/// imageUrl : "https://media-cdn.tripadvisor.com/media/photo-o/11/67/ba/8d/mini-egypt-park.jpg"
/// cost : 1000

class TouristPlace {
  TouristPlace({
      this.name, 
      this.address, 
      this.type, 
      this.rating, 
      this.description, 
      this.imageUrl, 
      this.cost,});

  TouristPlace.fromJson(dynamic json) {
    name = json['name'];
    address = json['address'];
    type = json['type'];
    rating = (json['rating'] as num?)?.toDouble();
    description = json['description'];
    imageUrl = json['imageUrl'];
    cost = json['cost'];
  }
  String? name;
  String? address;
  String? type;
  double? rating;
  String? description;
  String? imageUrl;
  int? cost;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['address'] = address;
    map['type'] = type;
    map['rating'] = rating;
    map['description'] = description;
    map['imageUrl'] = imageUrl;
    map['cost'] = cost;
    return map;
  }

}