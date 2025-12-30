import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/Core/constants/app_colors.dart';
import 'package:opsentra_hr/features/attendance/cubit/attendance_cubit.dart';
import 'package:opsentra_hr/features/attendance/presentation/attendance_screen.dart';
import 'package:opsentra_hr/features/home/cubit/home_cubit.dart';
import 'package:opsentra_hr/features/home/presentation/home_page.dart';
import 'package:opsentra_hr/features/main/cubit/main_cubit.dart';
import 'package:opsentra_hr/features/main/state/main_state.dart';
import 'package:opsentra_hr/features/payslip/cubit/payslip_cubit.dart';
import 'package:opsentra_hr/features/payslip/presentation/payslip_screen.dart';
import 'package:opsentra_hr/features/profile/cubit/profile_cubit.dart';
import 'package:opsentra_hr/features/profile/presentation/profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainCubit()..onInit()),
        BlocProvider(
          create: (_) => HomeCubit()..loadHome(),
          child: const HomeScreen(),
        ),
         BlocProvider(
          create: (_) => AttendanceCubit()..loadAttendance(),
          child: const AttendanceScreen(),
        ),
         BlocProvider(
          create: (_) => PayslipCubit()..loadPayslip(),
          child: const PayslipScreen(),
        ),
         BlocProvider(
      create: (_) => ProfileCubit()..loadProfile(),
       child: const ProfileScreen())
      ],
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
            
              index: state.selectedIndex,
              children: _pages,
            ),
            bottomNavigationBar: BottomNavigationBar(

              backgroundColor: Colors.white,
              currentIndex: state.selectedIndex,
              onTap: (index) => context.read<MainCubit>().changeTab(index),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.access_time_rounded),
                  label: 'Attendance',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet_outlined),
                  label: 'Payroll',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Keep pages alive
  static final List<Widget> _pages = [
    HomeScreen(),
     AttendanceScreen(),
     Container(),
      PayslipScreen(),
  ProfileScreen(),
  ];
}
