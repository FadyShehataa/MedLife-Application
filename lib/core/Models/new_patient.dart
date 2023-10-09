import 'package:hive/hive.dart';

part 'new_patient.g.dart';

@HiveType(typeId: 1)
class NewPatient extends HiveObject {
  NewPatient({this.name, this.id, this.imageURL, this.phoneNumber, this.address, this.token});
  @HiveField(0)
  String? name = '';

  @HiveField(1)
  String? id = '';

  @HiveField(2)
  String? imageURL = '';

  @HiveField(3)
  String? phoneNumber = '';

  @HiveField(4)
  String? address = '';

  @HiveField(5)
  String? token = '';
}
