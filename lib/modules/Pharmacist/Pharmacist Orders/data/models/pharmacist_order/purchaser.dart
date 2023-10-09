import 'location.dart';

class Purchaser {
  Location? location;
  String? address;
  String? id;
  String? name;
  String? phoneNumber;

  Purchaser({
    this.location,
    this.address,
    this.id,
    this.name,
    this.phoneNumber,
  });

  factory Purchaser.fromJson(Map<String, dynamic> json) => Purchaser(
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location']),
        address: json['address'] as String?,
        id: json['_id'] as String?,
        name: json['name'] as String?,
        phoneNumber: json['phoneNumber'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'location': location?.toJson(),
        'address': address,
        '_id': id,
        'name': name,
        'phoneNumber': phoneNumber,
      };
}
