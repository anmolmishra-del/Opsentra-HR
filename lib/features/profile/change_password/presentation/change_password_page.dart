import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/Core/constants/app_colors.dart';
import 'package:opsentra_hr/features/profile/change_password/state/change_passord_state.dart';
import 'package:opsentra_hr/l10n/app_localizations.dart';
import '../cubit/change_password_cubit.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChangePasswordCubit(),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,

        // appBar: AppBar(
        //   backgroundColor: AppColors.offWhite,
        //   title: Text(
        //     AppLocalizations.of(context)?.changePassword ?? 'Change Password',
        //   ),
        // ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gradientStart, AppColors.primaryDark],
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.changePassword,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
              listener: (context, state) {
                if (state is ChangePasswordSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password updated successfully'),
                    ),
                  );
                  Navigator.pop(context);
                }
                if (state is ChangePasswordError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _passwordField(
                        controller: _oldController,
                        label: AppLocalizations.of(context)!.currentPassword,
                      ),
                      _passwordField(
                        controller: _newController,
                        label: AppLocalizations.of(context)!.newPassword,
                      ),
                      _passwordField(
                        controller: _confirmController,
                        label: AppLocalizations.of(context)!.confirmPassword,
                      ),
                      const SizedBox(height: 24),
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
                          onPressed: state is ChangePasswordLoading
                              ? null
                              : () {
                                  context
                                      .read<ChangePasswordCubit>()
                                      .changePassword(
                                        oldPassword: _oldController.text,
                                        newPassword: _newController.text,
                                        confirmPassword:
                                            _confirmController.text,
                                      );
                                },
                          child: state is ChangePasswordLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  AppLocalizations.of(context)!.updatePassword,
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          // boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.black54),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), // rounded corners
              borderSide: BorderSide(color: AppColors.black),
            ),
          ),
        ),
      ),
    );
  }
}
