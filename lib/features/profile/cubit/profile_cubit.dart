import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/features/profile/state/profile_state.dart';


class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading());

  void loadProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));

    emit(
      ProfileLoaded(
        name: "Praveen Kumar",
        role: "Senior Software Engineer",
        empId: "EMP12345",
        department: "IT Department",
        joiningDate: "10 April 2020",
        managerName: "Anirudh Joshi",
        managerRole: "IT Manager",
      ),
    );
  }

  void logout() {
    // clear token / session
  }
}
