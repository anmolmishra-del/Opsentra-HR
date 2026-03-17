import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:opsentra_hr/Core/local/hive_service.dart';
import 'package:opsentra_hr/Core/network/connectivity_service.dart';
import 'package:opsentra_hr/features/profile/profile.service.dart';
import 'package:opsentra_hr/features/profile/profile_hive_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:opsentra_hr/features/profile/state/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ConnectivityService connectivityService;
  final HiveService hiveService;
  final ProfileService profileService;

  ProfileCubit(this.connectivityService, this.hiveService, this.profileService)
    : super(ProfileLoading());

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

  Future<void> saveStaticProfileToHive() async {
    emit(ProfileLoading());

    final profile = ProfileHiveModel(
      name: "Praveen Kumar",
      role: "Senior Software Engineer",
      empId: "EMP12345",
      department: "IT Department",
      joiningDate: "10 April 2020",
      managerName: "Anirudh Joshi",
      managerRole: "IT Manager",
    );

    // Save to Hive box
    final box = Hive.box<ProfileHiveModel>('profileBox');
    await box.put('profile', profile);

    // Emit state for UI
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

  // 2️⃣ Load profile from Hive
  Future<void> loadProfileFromHive() async {
    final box = Hive.box<ProfileHiveModel>('profileBox');
    final cached = box.get('profile');

    if (cached != null) {
      emit(
        ProfileLoaded(
          name: cached.name,
          role: cached.role,
          empId: cached.empId,
          department: cached.department,
          joiningDate: cached.joiningDate,
          managerName: cached.managerName,
          managerRole: cached.managerRole,
        ),
      );
    } else {
      emit(ProfileError("No offline profile found"));
    }
  }

  Future<void> saveProfile(Map<String, dynamic> data) async {
    emit(ProfileSaving());

    if (await connectivityService.hasInternet()) {
      await profileService.sendProfileToApi(data);
    } else {
      await hiveService.saveOffline(data);
    }

    emit(ProfileSaved());
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> saveProfileToHive(ProfileHiveModel profile) async {
    final box = Hive.box<ProfileHiveModel>('profileBox');
    await box.put('profile', profile); // single profile
  }
}
