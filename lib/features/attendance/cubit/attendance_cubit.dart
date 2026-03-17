import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/features/attendance/state/attendance_state.dart';


class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());

  void loadAttendance() async {
    emit(AttendanceLoading());

   
    await Future.delayed(const Duration(seconds: 10));

    emit(
      AttendanceLoaded(
        checkedIn: true,
        checkInTime: "09:15 AM",
        history: [
          {"date": "25 Dec", "status": "Present"},
          {"date": "24 Dec", "status": "Present"},
          {"date": "23 Dec", "status": "Holiday"},
        ],
      ),
    );
  }

  void toggleCheckIn() {
    if (state is AttendanceLoaded) {
      final current = state as AttendanceLoaded;
      emit(
        AttendanceLoaded(
          checkedIn: !current.checkedIn,
          checkInTime: current.checkedIn ? "--:--" : "09:30 AM",
          history: current.history,
        ),
      );
    }
  }
}
