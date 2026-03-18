import 'package:hive/hive.dart';

part 'profile_hive_model.g.dart'; // MUST match this filename

@HiveType(typeId: 0)
class ProfileHiveModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String role;

  @HiveField(2)
  String empId;

  @HiveField(3)
  String department;

  @HiveField(4)
  String joiningDate;

  @HiveField(5)
  String managerName;

  @HiveField(6)
  String managerRole;

  ProfileHiveModel({
    required this.name,
    required this.role,
    required this.empId,
    required this.department,
    required this.joiningDate,
    required this.managerName,
    required this.managerRole,
  });
}
