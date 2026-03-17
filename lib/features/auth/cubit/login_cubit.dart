import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/Core/network/api_exceptions.dart';
import 'package:opsentra_hr/Core/network/api_service.dart';
import 'package:opsentra_hr/features/auth/state/login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  final AuthApi authApi;

  LoginCubit({required this.authApi}) : super(const LoginState());


  void togglePassword() {
    emit(state.copyWith(
      isPasswordVisible: !state.isPasswordVisible,
    ));
  }

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(state.copyWith(
        errorMessage: "Email and password are required",
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      await authApi.login(
        email: email,
        password: password,
      );

     
      emit(state.copyWith(isLoading: false));
    } on UnauthorizedException {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Invalid email or password",
      ));
    } on ApiException catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Something went wrong. Please try again.",
      ));
    }
  }
}
