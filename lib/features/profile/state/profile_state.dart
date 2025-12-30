abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String role;
  final String empId;
  final String department;
  final String joiningDate;
  final String managerName;
  final String managerRole;

  ProfileLoaded({
    required this.name,
    required this.role,
    required this.empId,
    required this.department,
    required this.joiningDate,
    required this.managerName,
    required this.managerRole,
  });
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
