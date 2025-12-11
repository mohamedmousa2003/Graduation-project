class ClassicalPlace {
  ClassicalPlace({
    this.name,
    this.address,
    this.type,
    this.rating,
    this.description,
    this.imageUrl,
    this.cost,});

  ClassicalPlace.fromJson(dynamic json) {
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