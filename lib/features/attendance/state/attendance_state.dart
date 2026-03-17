abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final bool checkedIn;
  final String checkInTime;
  final List<Map<String, String>> history;

  AttendanceLoaded({
    required this.checkedIn,
    required this.checkInTime,
    required this.history,
  });
}

class AttendanceError extends AttendanceState {
  final String message;
  AttendanceError(this.message);
}
