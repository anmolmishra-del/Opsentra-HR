import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/Core/constants/app_assets.dart';
import 'package:opsentra_hr/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:opsentra_hr/features/onboarding/state/onboarding_state.dart';

import 'onboarding_page.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: Scaffold(
        body: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            return Stack(
              children: [
                PageView(
                  controller: _controller,
                  onPageChanged: (i) =>
                      context.read<OnboardingCubit>().setPage(i),
                  children: const [
                    OnboardingPage(
                      image: AppImage.onboard1,
                      title: 'Welcome to FTProTech HRMS',
                      description:
                          'Manage attendance, payroll, leaves, and communication in one app.',
                    ),
                    OnboardingPage(
                      image:AppImage.onboard2,
                      title: 'Attendance & Payroll Made Easy',
                      description:
                          'Check-in daily, track attendance, and view payslips instantly.',
                    ),
                    OnboardingPage(
                      image: AppImage.onboard3,
                      title: 'Team Chat & Updates',
                      description:
                          'Chat with your team and receive important announcements.',
                    ),
                  ],
                ),

              
                Positioned(
                  top: 50,
                  right: 20,
                  child: state.pageIndex < 2
                      ? TextButton(
                          onPressed: () {
                            _controller.jumpToPage(2);
                            context.read<OnboardingCubit>().skip();
                          },
                          child: const Text(
                            'Skip',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : const SizedBox(),
                ),

              
                Positioned(
                  bottom: 40,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                    
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: state.pageIndex == i ? 16 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF1F4ED8),
                          minimumSize:
                              const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          if (state.pageIndex == 2) {
                            Navigator.pushReplacementNamed(
                                context, '/login');
                          } else {
                            _controller.nextPage(
                              duration:
                                  const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            context.read<OnboardingCubit>().nextPage();
                          }
                        },
                        child: Text(
                          state.pageIndex == 2
                              ? 'Get Started'
                              : 'Next',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
