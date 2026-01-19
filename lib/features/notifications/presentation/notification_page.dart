import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/features/notifications/cubit/notification_cubit-page.dart';
import 'package:opsentra_hr/features/notifications/state/notification_state.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state.notifications.isEmpty) {
            return const Center(child: Text('No notifications'));
          }

          return ListView.separated(
            itemCount: state.notifications.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final notification = state.notifications[index];

              return ListTile(
                leading: Icon(Icons.notifications),
                title: Text(notification['title']),
                subtitle: Text(notification['subtitle']),
              );
            },
          );
        },
      ),
    );
  }
}
