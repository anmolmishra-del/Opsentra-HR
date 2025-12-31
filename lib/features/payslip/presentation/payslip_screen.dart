import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/Core/constants/app_colors.dart';
import 'package:opsentra_hr/Core/widgets/loading_widget.dart';
import 'package:opsentra_hr/features/payslip/state/payslip_state.dart';
import 'package:opsentra_hr/l10n/app_localizations.dart';
import '../cubit/payslip_cubit.dart';

class PayslipScreen extends StatelessWidget {
  const PayslipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Payslip",
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

          // 🔲 BODY
          Expanded(
            child: BlocBuilder<PayslipCubit, PayslipState>(
              builder: (context, state) {
                if (state is PayslipLoading) {
                  return const Center(child: AppLoadingWidget());
                }

                if (state is PayslipLoaded) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // ───── YEAR + MONTH + NET PAY ─────
                        _YearMonthNetPayCard(
                          selectedYear: state.selectedYear,
                          selectedMonth: state.selectedMonth,
                          years: state.availableYears,
                          months: state.availableMonths,
                          netPay: state.netPay,
                          onYearChanged: (year) {
                            context.read<PayslipCubit>().changeYear(year);
                          },
                          onMonthChanged: (month) {
                            context.read<PayslipCubit>().changeMonth(month);
                          },
                        ),

                        SizedBox(height: 12),

                        // ───── EARNINGS ─────
                        _WhiteCard(
                          title: AppLocalizations.of(context)!.earnings,
                          child: Column(
                            children: [
                              const Divider(),
                              const SizedBox(height: 6),
                              ...state.earnings.map(
                                (e) => _RowItem(
                                  title: e.keys.first,
                                  value: e.values.first,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 12),

                        // ───── DEDUCTIONS ─────
                        _WhiteCard(
                          title: AppLocalizations.of(context)!.deductions,
                          child: Column(
                            children: [
                              const Divider(),
                              const SizedBox(height: 6),
                              ...state.deductions.map(
                                (d) => _RowItem(
                                  title: d.keys.first,
                                  value: d.values.first,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ───── DOWNLOAD BUTTON ─────
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              // TODO: download payslip for selected year + month
                              // final s = state;
                              // downloadPayslip(s.selectedYear, s.selectedMonth);
                            },
                            icon: const Icon(
                              Icons.download,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Download Payslip",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                }

                if (state is PayslipError) {
                  return Center(child: Text(state.message));
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _YearMonthNetPayCard extends StatelessWidget {
  final String selectedYear;
  final String selectedMonth;
  final List<String> years;
  final List<String> months;
  final String netPay;
  final Function(String) onYearChanged;
  final Function(String) onMonthChanged;

  const _YearMonthNetPayCard({
    required this.selectedYear,
    required this.selectedMonth,
    required this.years,
    required this.months,
    required this.netPay,
    required this.onYearChanged,
    required this.onMonthChanged,
  });

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
          // 🔹 YEAR DROPDOWN
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedYear,
              isExpanded: true,
              items: years
                  .map(
                    (y) => DropdownMenuItem(
                      value: y,
                      child: Text(
                        y,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) onYearChanged(v);
              },
            ),
          ),

          const SizedBox(height: 8),

          // 🔹 MONTH DROPDOWN
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedMonth,
              isExpanded: true,
              items: months
                  .map(
                    (m) => DropdownMenuItem(
                      value: m,
                      child: Text(
                        m,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) onMonthChanged(v);
              },
            ),
          ),

          const Divider(),
          const SizedBox(height: 10),

          const Text(
            "Net Pay",
            style: TextStyle(fontSize: 13, color: AppColors.textMedium),
          ),
          const SizedBox(height: 6),

          Text(
            netPay,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _WhiteCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _WhiteCard({required this.title, required this.child});

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
    );
  }
}

class _RowItem extends StatelessWidget {
  final String title;
  final String value;

  const _RowItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, color: AppColors.textDark),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
