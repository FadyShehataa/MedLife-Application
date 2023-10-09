import 'package:hive/hive.dart';

part 'app_mode.g.dart';

@HiveType(typeId: 0)
class AppMode extends HiveObject {
  AppMode({required this.userType});
  @HiveField(0)
  String userType = 'First_Time';

  // @HiveField(1)
  // int age;

}
