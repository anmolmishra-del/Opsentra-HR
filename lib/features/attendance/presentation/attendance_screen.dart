import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/Core/constants/app_colors.dart';
import 'package:opsentra_hr/Core/widgets/loading_widget.dart';
import 'package:opsentra_hr/features/attendance/state/attendance_state.dart';
import 'package:opsentra_hr/l10n/app_localizations.dart';
import '../cubit/attendance_cubit.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.gradientStart, AppColors.primaryDark],
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Attendance",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.white,
                  child: Icon(Icons.person, color: AppColors.primary),
                ),
              ],
            ),
          ),

          Expanded(
            child: BlocBuilder<AttendanceCubit, AttendanceState>(
              builder: (context, state) {
                if (state is AttendanceLoading) {
                  return const Center(child: AppLoadingWidget());
                }

                if (state is AttendanceLoaded) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _WhiteCard(
                          title: AppLocalizations.of(context)!.todaysAttendance,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(),
                              const SizedBox(height: 8),
                              Text(
                                "${AppLocalizations.of(context)!.checkIn}: ${state.checkInTime}",
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${AppLocalizations.of(context)!.checkOut} : ---",
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                height: 44,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onPressed: () => context
                                      .read<AttendanceCubit>()
                                      .toggleCheckIn(),
                                  child: Text(
                                    state.checkedIn ? "Check Out" : "Check In",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        _WhiteCard(
                          title: AppLocalizations.of(
                            context,
                          )!.attendanceHistory,
                          child: Column(
                            children: [
                              const Divider(),
                              const SizedBox(height: 6),
                              ...state.history.map(
                                (item) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(item['date']!),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),

                                        decoration: BoxDecoration(
                                          color: item['status'] == "Present"
                                              ? AppColors.success
                                              : AppColors.info,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          item['status']!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: item['status'] == "Present"
                                                ? AppColors.white
                                                : AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ───── HOLIDAY / LEAVE CARD ─────
                        _WhiteCard(
                          title: AppLocalizations.of(context)!.holidays,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Divider(),
                              SizedBox(height: 8),
                              Text("• 26 Jan – Republic Day"),
                              SizedBox(height: 4),
                              Text("• 15 Aug – Independence Day"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ───── APPLY LEAVE BUTTON ─────
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              // TODO: Navigate to Apply Leave Screen
                              // Navigator.pushNamed(context, Routes.applyLeave);
                            },
                            child: const Text(
                              "Apply Leave",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _WhiteCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _WhiteCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textMedium,
            ),
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}
