import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/Core/constants/app_colors.dart';
import 'package:opsentra_hr/features/language/cubit/language_cubit.dart';
import 'package:opsentra_hr/features/profile/state/profile_state.dart';
import 'package:opsentra_hr/l10n/app_localizations.dart';
import '../cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..loadProfile(),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Column(
          children: [
            // 🔵 HEADER
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
                children:  [
                  Text(
                    AppLocalizations.of(context)!.profile,
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

            Expanded(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ProfileLoaded) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // ───── USER CARD ─────
                          _WhiteCard(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 28,
                                      backgroundImage: NetworkImage(
                                        "https://i.pravatar.cc/150",
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          state.role,
                                          style: const TextStyle(
                                            color: AppColors.textMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Divider(height: 24),
                                _InfoLine(state.empId),
                                _InfoLine(state.department),
                                _InfoLine("Joining to: ${state.joiningDate}"),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // ───── REPORTING MANAGER ─────
                          _WhiteCard(
                            title: "Reporting Manager",
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    "https://i.pravatar.cc/100",
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.managerName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      state.managerRole,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // ───── SETTINGS ─────
                          _SettingTile(
                            icon: Icons.lock_outline,
                            title: AppLocalizations.of(context)!.changePassword,
                          ),
                          _SettingTile(
                            icon: Icons.notifications_none,
                            title: AppLocalizations.of(context)!.notifications,
                            trailing: const _Badge(count: 2),
                          ),
                          _SettingTile(
                            icon: Icons.language,
                            title: AppLocalizations.of(context)!.language,
                            subtitle:
                                context
                                        .read<LanguageCubit>()
                                        .state
                                        .locale
                                        .languageCode ==
                                    'en'
                                ? AppLocalizations.of(context)!.english
                                : AppLocalizations.of(context)!.hindi,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 12),
                                      Container(
                                        width: 40,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[400],
                                          borderRadius: BorderRadius.circular(
                                            2,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      ListTile(
                                        title: Text(
                                          AppLocalizations.of(context)!.english,
                                        ),
                                        onTap: () {
                                          context
                                              .read<LanguageCubit>()
                                              .changeLanguage(
                                                const Locale('en'),
                                              );
                                          Navigator.pop(context);
                                        },
                                        trailing:
                                            context
                                                    .read<LanguageCubit>()
                                                    .state
                                                    .locale
                                                    .languageCode ==
                                                'en'
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.green,
                                              )
                                            : null,
                                      ),
                                      ListTile(
                                        title: Text(
                                          AppLocalizations.of(context)!.hindi,
                                        ),
                                        onTap: () {
                                          context
                                              .read<LanguageCubit>()
                                              .changeLanguage(
                                                const Locale('hi'),
                                              );
                                          Navigator.pop(context);
                                        },
                                        trailing:
                                            context
                                                    .read<LanguageCubit>()
                                                    .state
                                                    .locale
                                                    .languageCode ==
                                                'hi'
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.green,
                                              )
                                            : null,
                                      ),
                                      const SizedBox(height: 70),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          _SettingTile(
                            icon: Icons.logout,
                            title: AppLocalizations.of(context)!.logout,
                            titleColor: Colors.red,
                            iconColor: Colors.red,
                            onTap: () => context.read<ProfileCubit>().logout(),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is ProfileError) {
                    return Center(child: Text(state.message));
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final String text;

  const _InfoLine(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(fontSize: 13, color: AppColors.textMedium),
        ),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Color? titleColor;
  final Color? iconColor;
  final VoidCallback? onTap;

  const _SettingTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.titleColor,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: ListTile(
          leading: Icon(icon, color: iconColor ?? AppColors.primary),
          title: Text(
            title,
            style: TextStyle(
              color: titleColor ?? AppColors.textDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: subtitle != null ? Text(subtitle!) : null,
          trailing: trailing ?? const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final int count;

  const _Badge({required this.count});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: Colors.red,
      child: Text(
        count.toString(),
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}

class _WhiteCard extends StatelessWidget {
  final String? title;
  final Widget child;

  const _WhiteCard({this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textMedium,
              ),
            ),
            const Divider(),
          ],
          child,
        ],
      ),
    );
  }
}
