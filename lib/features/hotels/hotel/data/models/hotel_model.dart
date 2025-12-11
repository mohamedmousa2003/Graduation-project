class HotelModel {
  final String type;
  final String name;
  final String link;
  final double latitude;
  final double longitude;
  final String checkIn;
  final String checkOut;
  final double overallRating;
  final double locationRating;
  final int reviews;
  final List<String> amenities;
  final List<String> excludedAmenities;
  final String essentialInfo;
  final String nearbyPlaces;
  final String ratingsBreakdown;
  final String reviewsBreakdown;
  final String lowestRate;
  final String beforeTaxes;
  final String totalLowest;
  final String totalBeforeTaxes;

  HotelModel({
    required this.type,
    required this.name,
    required this.link,
    required this.latitude,
    required this.longitude,
    required this.checkIn,
    required this.checkOut,
    required this.overallRating,
    required this.locationRating,
    required this.reviews,
    required this.amenities,
    required this.excludedAmenities,
    required this.essentialInfo,
    required this.nearbyPlaces,
    required this.ratingsBreakdown,
    required this.reviewsBreakdown,
    required this.lowestRate,
    required this.beforeTaxes,
    required this.totalLowest,
    required this.totalBeforeTaxes,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      link: json['link'] ?? '',
      latitude: (json['location']['latitude'] as num).toDouble(),
      longitude: (json['location']['longitude'] as num).toDouble(),
      checkIn: json['checkIn'] ?? '',
      checkOut: json['checkOut'] ?? '',
      overallRating: (json['ratings']['overall'] as num).toDouble(),
      locationRating: (json['ratings']['locationRating'] as num).toDouble(),
      reviews: json['reviews'] ?? 0,
      amenities: List<String>.from(json['amenities'] ?? []),
      excludedAmenities: List<String>.from(json['excludedAmenities'] ?? []),
      essentialInfo: json['essentialInfo'] ?? '',
      nearbyPlaces: json['nearbyPlaces'] ?? '',
      ratingsBreakdown: json['ratingsBreakdown'] ?? '',
      reviewsBreakdown: json['reviewsBreakdown'] ?? '',
      lowestRate: json['pricing']['lowestRate'] ?? '',
      beforeTaxes: json['pricing']['beforeTaxes'] ?? '',
      totalLowest: json['pricing']['totalLowest'] ?? '',
      totalBeforeTaxes: json['pricing']['totalBeforeTaxes'] ?? '',
    );
  }
}