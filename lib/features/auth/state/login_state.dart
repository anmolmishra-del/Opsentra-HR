class LoginState {
  final bool isLoading;
  final bool isPasswordVisible;
  final String? errorMessage;

  const LoginState({
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isPasswordVisible,
    String? errorMessage,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      errorMessage: errorMessage,
    );
  }
}
