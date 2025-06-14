class TripPlan {
  final String arrivalAirport;
  final String bestTimeToVisit;
  final String suggestedMonth;
  final List<DayPlan> tripPlan;
  final int totalCost;

  TripPlan({
    required this.arrivalAirport,
    required this.bestTimeToVisit,
    required this.suggestedMonth,
    required this.tripPlan,
    required this.totalCost,
  });

  factory TripPlan.fromJson(Map<String, dynamic> json) {
    return TripPlan(
      arrivalAirport: json['arrivalAirport'] ?? '',
      bestTimeToVisit: json['bestTimeToVisit'] ?? '',
      suggestedMonth: json['suggestedMonth'] ?? '',
      totalCost: json['totalCost'] ?? 0,
      tripPlan:
      (json['tripPlan'] as List<dynamic>?)
          ?.map((x) => DayPlan.fromJson(x))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'arrivalAirport': arrivalAirport,
    'bestTimeToVisit': bestTimeToVisit,
    'suggestedMonth': suggestedMonth,
    'tripPlan': tripPlan.map((x) => x.toJson()).toList(),
    'totalCost': totalCost,
  };
}

class DayPlan {
  final String day;
  final List<Place> places;

  DayPlan({required this.day, required this.places});

  factory DayPlan.fromJson(Map<String, dynamic> json) {
    return DayPlan(
      day: json['day'] ?? '',
      places:
      (json['places'] as List<dynamic>?)
          ?.map((x) => Place.fromJson(x))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'day': day,
    'places': places.map((x) => x.toJson()).toList(),
  };
}

class Place {
  final String name;
  final String type;
  final int cost;
  final int rating;
  final double latitude;
  final double longitude;
  final String description;
  final String address;
  final String openingHours;
  final String bestTimeToVisit;
  final String image;
  final String recommendedActivities;
  final String visitDuration;

  Place({
    required this.name,
    required this.type,
    required this.cost,
    required this.rating,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.address,
    required this.openingHours,
    required this.bestTimeToVisit,
    required this.image,
    required this.recommendedActivities,
    required this.visitDuration,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      cost: json['cost'] ?? 0,
      rating: json['rating'] ?? 0,
      latitude:
      (json['latitude'] != null)
          ? double.tryParse(json['latitude'].toString()) ?? 0.0
          : 0.0,
      longitude:
      (json['longitude'] != null)
          ? double.tryParse(json['longitude'].toString()) ?? 0.0
          : 0.0,
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      openingHours: json['openingHours'] ?? '',
      bestTimeToVisit: json['bestTimeToVisit'] ?? '',
      image: json['image'] ?? '',
      recommendedActivities: json['recommendedActivities'] ?? '',
      visitDuration: json['visitDuration'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'type': type,
    'cost': cost,
    'rating': rating,
    'latitude': latitude,
    'longitude': longitude,
    'description': description,
    'address': address,
    'openingHours': openingHours,
    'bestTimeToVisit': bestTimeToVisit,
    'image': image,
    'recommendedActivities': recommendedActivities,
    'visitDuration': visitDuration,
  };
}

class RequestPlanTrip {
  final int days;
  final double budget;
  RequestPlanTrip(this.days, this.budget);
  Map<String, dynamic> toJson() {
    return {"days": days, "budget": budget};
  }
}