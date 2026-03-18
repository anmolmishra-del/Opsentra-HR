// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:opsentra_hr/Core/local/hive_service.dart';
// import 'package:opsentra_hr/Core/network/connectivity_service.dart';
// import 'package:opsentra_hr/features/profile/profile.service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:opsentra_hr/features/profile/state/profile_state.dart';

// class ProfileCubit extends Cubit<ProfileState> {
//   final ConnectivityService connectivityService;
//   final HiveService hiveService;
//   final ProfileService profileService;

//   ProfileCubit(this.connectivityService, this.hiveService, this.profileService)
//     : super(ProfileLoading());

//   void loadProfile() async {
//     await Future.delayed(const Duration(milliseconds: 500));

//     emit(
//       ProfileLoaded(
//         name: "Praveen Kumar",
//         role: "Senior Software Engineer",
//         empId: "EMP12345",
//         department: "IT Department",
//         joiningDate: "10 April 2020",
//         managerName: "Anirudh Joshi",
//         managerRole: "IT Manager",
//       ),
//     );
//   }

//   Future<void> saveProfile(Map<String, dynamic> data) async {
//     emit(ProfileSaving());

//     if (await connectivityService.hasInternet()) {
//       await profileService.sendProfileToApi(data);
//     } else {
//       await hiveService.saveOffline(data);
//     }

//     emit(ProfileSaved());
//   }

//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:opsentra_hr/Core/models/profile_hive_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:opsentra_hr/Core/local/hive_service.dart';
import 'package:opsentra_hr/Core/network/connectivity_service.dart';
import 'package:opsentra_hr/features/profile/profile.service.dart';
import 'package:opsentra_hr/features/profile/state/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ConnectivityService connectivityService;
  final HiveService hiveService;
  final ProfileService profileService;

  ProfileCubit(
      this.connectivityService, this.hiveService, this.profileService)
      : super(ProfileLoading());

  /// 🔹 Default profile (first app open)
  final ProfileModel defaultProfile = ProfileModel(
    name: "Shankar Ankepaka",
    role: "Flutter Developer",
    empId: "EMP1023",
    department: "Engineering",
    joiningDate: "01-Jan-2024",
    managerName: "Ramesh Kumar",
    managerRole: "Tech Lead",
  );

  /// 🔹 Load profile (Hive first, fallback to default)
  Future<void> loadProfile() async {
    emit(ProfileLoading());

    final box = Hive.box<ProfileModel>('profileBox');
    ProfileModel? profile = box.get('profile');

    if (profile == null) {
      // First time app open → save default
      await box.put('profile', defaultProfile);
      profile = defaultProfile;
    }

    emit(
      ProfileLoaded(
        name: profile.name,
        role: profile.role,
        empId: profile.empId,
        department: profile.department,
        joiningDate: profile.joiningDate,
        managerName: profile.managerName,
        managerRole: profile.managerRole,
      ),
    );
  }

  /// 🔹 Save / Update profile locally and optionally online
  Future<void> saveProfile(ProfileModel updatedProfile) async {
    emit(ProfileSaving());

    final box = Hive.box<ProfileModel>('profileBox');
    await box.put('profile', updatedProfile);

    // Optional: send to API if online
    if (await connectivityService.hasInternet()) {
      await profileService.sendProfileToApi({
        "name": updatedProfile.name,
        "role": updatedProfile.role,
        "empId": updatedProfile.empId,
        "department": updatedProfile.department,
        "joiningDate": updatedProfile.joiningDate,
        "managerName": updatedProfile.managerName,
        "managerRole": updatedProfile.managerRole,
      });
    } else {
      // Optional: save offline backup via your HiveService
      await hiveService.saveOffline({
        "name": updatedProfile.name,
        "role": updatedProfile.role,
        "empId": updatedProfile.empId,
        "department": updatedProfile.department,
        "joiningDate": updatedProfile.joiningDate,
        "managerName": updatedProfile.managerName,
        "managerRole": updatedProfile.managerRole,
      });
    }

    emit(
      ProfileLoaded(
        name: updatedProfile.name,
        role: updatedProfile.role,
        empId: updatedProfile.empId,
        department: updatedProfile.department,
        joiningDate: updatedProfile.joiningDate,
        managerName: updatedProfile.managerName,
        managerRole: updatedProfile.managerRole,
      ),
    );
  }

  /// 🔹 Logout → clear Hive and SharedPreferences
  Future<void> logout() async {
    final box = Hive.box<ProfileModel>('profileBox');
    await box.clear();

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    emit(ProfileLoading());
  }
}
