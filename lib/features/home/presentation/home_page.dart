import 'package:flutter/material.dart';
import 'package:opsentra_hr/Core/constants/app_assets.dart';
import 'package:opsentra_hr/Core/constants/app_colors.dart';
import 'package:confetti/confetti.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:opsentra_hr/features/home/state/home_state.dart';

import 'package:opsentra_hr/l10n/app_localizations.dart';
import '../cubit/home_cubit.dart';

import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.isBirthday) {
          //  _showConfettiOverlay(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Stack(
          children: [
            _buildMainContent(context),

            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (!state.isBirthday) return const SizedBox.shrink();

                return Stack(
                  children: [
                    Positioned(
                      top: 100,
                      left: 16,
                      right: 16,
                      child: _BirthdayBanner(name: state.userName),
                    ),

                    Lottie.asset(
                      'assets/wish.json',
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      repeat: false,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showConfettiOverlay(BuildContext context) {
    final controller = ConfettiController(duration: const Duration(seconds: 4));

    final overlay = OverlayEntry(
      builder: (_) => Positioned.fill(
        child: IgnorePointer(
          child: ConfettiWidget(
            confettiController: controller,
            blastDirectionality: BlastDirectionality.explosive,
            emissionFrequency: 0.08,
            numberOfParticles: 100,
            gravity: 0.15,
            maxBlastForce: 30,
            minBlastForce: 10,
            colors: const [
              Colors.pink,
              Colors.blue,
              Colors.orange,
              Colors.green,
              Colors.purple,
            ],
          ),
        ),
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(overlay);
    controller.play();

    Future.delayed(const Duration(seconds: 4), () {
      controller.dispose();
      overlay.remove();
    });
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 50, 16, 24),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gradientStart, AppColors.primaryDark],
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Good Morning, Praveen 👋",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
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

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    _InfoCard(
                      title: AppLocalizations.of(context)!.todaysAttendance,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Divider(),
                          SizedBox(height: 6),
                          Text("Check-In : 09:15 AM"),
                          SizedBox(height: 4),
                          Text("Check-Out : ---"),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    _LeaveCard(
                      title: "Leave Balance",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Divider(),
                          SizedBox(height: 8),
                          Text(
                            "8 CL | 4 SL | 12 PL",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    _InfoCard(
                      title: "Announcements",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Divider(),
                          SizedBox(height: 6),
                          _BulletText("Meeting at 3 PM"),
                          SizedBox(height: 4),
                          _BulletText("New Policy Update"),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 6),
                    ],
                  ),
                  child: Row(
                    children: const [
                      Expanded(
                        child: _MiniItem(
                          icon: Icons.check_circle_outline,
                          title: "To-Do Tasks",
                          value: "5 Pending",
                        ),
                      ),
                      SizedBox(height: 40, child: VerticalDivider()),
                      Expanded(
                        child: _MiniItem(
                          icon: Icons.approval_outlined,
                          title: "Approvals",
                          value: "2 Requests",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BirthdayBanner extends StatelessWidget {
  final String name;
  const _BirthdayBanner({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.pink, Colors.deepPurple],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: Row(
        children: [
          const Icon(Icons.cake, color: Colors.white, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "🎉 Happy Birthday $name!\nHave a wonderful year ahead 🎂",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _InfoCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textMedium,
              ),
            ),
            const SizedBox(height: 6),
            child,
          ],
        ),
      ),
    );
  }
}

class _LeaveCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _LeaveCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.leaveBalanceBackground),
            fit: BoxFit.cover,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textMedium,
              ),
            ),
            const SizedBox(height: 6),
            child,
          ],
        ),
      ),
    );
  }
}

class _MiniItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _MiniItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(value, style: TextStyle(color: AppColors.textMedium)),
          ],
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  final String text;

  const _BulletText(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.circle, size: 6, color: AppColors.primary),
        const SizedBox(width: 6),
        Expanded(child: Text(text)),
      ],
    );
  }
}
