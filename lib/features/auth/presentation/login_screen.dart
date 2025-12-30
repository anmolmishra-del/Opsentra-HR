import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/Core/constants/app_assets.dart';
import 'package:opsentra_hr/Core/constants/app_colors.dart';
import 'package:opsentra_hr/Core/network/api_service.dart';
import 'package:opsentra_hr/features/auth/cubit/login_cubit.dart';
import 'package:opsentra_hr/features/auth/state/login_state.dart';
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(
        authApi: AuthApi(),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true, // ✅ FIX 1
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImage.backgroundImage),
              fit: BoxFit.fill,
            ),
            gradient: LinearGradient(
              colors: [
                AppColors.gradientStart,
                AppColors.gradientEnd,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (!state.isLoading && state.errorMessage == null) {
                  print("Login Success");
                }
              },
              builder: (context, state) {
                return SingleChildScrollView( // ✅ FIX 2
                  padding: EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20, // ✅ FIX 3
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),

                        const Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Login to continue",
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 40),

                        // Email
                        TextField(
                          controller: emailCtrl,
                          style: const TextStyle(color: Colors.white),
                          decoration: _inputDecoration(
                            hint: "Email / Employee ID",
                            icon: Icons.email_outlined,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password
                        TextField(
                          controller: passwordCtrl,
                          obscureText: !state.isPasswordVisible,
                          style: const TextStyle(color: Colors.white),
                          decoration: _inputDecoration(
                            hint: "Password",
                            icon: Icons.lock_outline,
                            suffix: IconButton(
                              icon: Icon(
                                state.isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white70,
                              ),
                              onPressed: () => context
                                  .read<LoginCubit>()
                                  .togglePassword(),
                            ),
                          ),
                        ),

                        if (state.errorMessage != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            state.errorMessage!,
                            style: const TextStyle(
                              color: Colors.redAccent,
                            ),
                          ),
                        ],

                        const SizedBox(height: 30),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: state.isLoading
                                ? null
                                : () {
                                    context.read<LoginCubit>().login(
                                          emailCtrl.text.trim(),
                                          passwordCtrl.text.trim(),
                                        );
                                  },
                            child: state.isLoading
                                ? const CircularProgressIndicator(
                                    color: AppColors.primary,
                                  )
                                : const Text("Login"),
                          ),
                        ),

                        const SizedBox(height: 20),

                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.white70),
      suffixIcon: suffix,
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white60),
      filled: true,
      fillColor: Colors.white.withOpacity(0.15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    );
  }
}
