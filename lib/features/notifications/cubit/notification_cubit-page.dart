import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/features/notifications/state/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationState.initial()) {
    loadNotifications();
  }

  void loadNotifications() {
    final demoNotifications = List.generate(
      9,
      (index) => {
        'title': 'Notification ${index + 1}',
        'subtitle': 'This is demo notification ${index + 1}',
      },
    );

    emit(state.copyWith(notifications: demoNotifications));
  }

  void markAllAsRead() {
    final updated = state.notifications
        .map((n) => {...n, 'isRead': true})
        .toList();

    emit(state.copyWith(notifications: updated));
  }
}
