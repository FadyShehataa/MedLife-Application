class Location {
  num? lat;
  num? lng;

  Location({this.lat, this.lng});

  factory Location.fromJson(json) => Location(
        lat: json['lat'],
        lng: json['lng'],
      );

  Map<String, num?> toJson() => {
        'lat': lat,
        'lng': lng,
      };
}
