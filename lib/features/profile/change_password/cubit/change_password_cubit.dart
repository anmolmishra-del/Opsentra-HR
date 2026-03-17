import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/features/profile/change_password/state/change_passord_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    // 1️⃣ Check if new password matches confirm
    if (newPassword != confirmPassword) {
      emit(ChangePasswordError('Passwords do not match'));
      return;
    }

    // 2️⃣ Start loading
    emit(ChangePasswordLoading());

    try {
      // 3️⃣ Call API or Odoo RPC here
      await Future.delayed(const Duration(seconds: 2)); // simulate API

      // 4️⃣ Success
      emit(ChangePasswordSuccess());
    } catch (e) {
      // 5️⃣ Error
      emit(ChangePasswordError('Failed to change password'));
    }
  }
}
