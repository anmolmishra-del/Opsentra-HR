abstract class ProfileState {
  const ProfileState();
}

// Initial / Loading
class ProfileLoading extends ProfileState {}

// Saving in progress
class ProfileSaving extends ProfileState {}

// Saved successfully
class ProfileSaved extends ProfileState {}

// Loaded data
class ProfileLoaded extends ProfileState {
  final String name;
  final String role;
  final String empId;
  final String department;
  final String joiningDate;
  final String managerName;
  final String managerRole;

  const ProfileLoaded({
    required this.name,
    required this.role,
    required this.empId,
    required this.department,
    required this.joiningDate,
    required this.managerName,
    required this.managerRole,
  });
}

// Error state
class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
}
