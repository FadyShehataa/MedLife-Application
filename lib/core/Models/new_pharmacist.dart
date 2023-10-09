import 'package:hive/hive.dart';

part 'new_pharmacist.g.dart';

@HiveType(typeId: 2)
class NewPharmacist extends HiveObject {
  NewPharmacist(
      {this.name,
      this.id,
      this.email,
      this.pharmacyId,
      this.token,
      this.pharmacyName,
      this.pharmacyImage});
  @HiveField(0)
  String? name = '';

  @HiveField(1)
  String? id = '';

  @HiveField(3)
  String? email = '';

  @HiveField(4)
  String? pharmacyId = '';

  @HiveField(5)
  String? token = '';

  @HiveField(6)
  String? pharmacyName = '';

  @HiveField(7)
  String? pharmacyImage = '';

  @HiveField(8)
  double? lat = 0.0;

  @HiveField(9)
  double? lng = 0.0;
}
