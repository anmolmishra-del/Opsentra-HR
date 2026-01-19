class NotificationState {
  final List<Map<String, dynamic>> notifications;

  const NotificationState({required this.notifications});

  factory NotificationState.initial() {
    return const NotificationState(notifications: []);
  }

  NotificationState copyWith({List<Map<String, dynamic>>? notifications}) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
    );
  }
}
