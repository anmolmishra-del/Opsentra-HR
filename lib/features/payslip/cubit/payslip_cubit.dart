import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/features/payslip/state/payslip_state.dart';


class PayslipCubit extends Cubit<PayslipState> {
  PayslipCubit() : super(PayslipLoading());

  // Mock data (replace with API)
  final Map<String, List<String>> _yearMonthMap = {
    "2025": ["January", "February", "March", "April"],
    "2024": ["September", "October", "November", "December"],
  };

  void loadPayslip({String? year, String? month}) async {
    emit(PayslipLoading());

    await Future.delayed(const Duration(milliseconds: 500));

    final selectedYear = year ?? _yearMonthMap.keys.first;
    final months = _yearMonthMap[selectedYear]!;
    final selectedMonth = month ?? months.first;

    emit(
      PayslipLoaded(
        selectedYear: selectedYear,
        selectedMonth: selectedMonth,
        availableYears: _yearMonthMap.keys.toList(),
        availableMonths: months,
        netPay: "₹ 50,000",
        earnings: [
          {"Basic": "₹ 25,000"},
          {"HRA": "₹ 15,000"},
          {"Other": "₹ 10,000"},
        ],
        deductions: [
          {"PF": "₹ 2,000"},
          {"Tax": "₹ 3,000"},
        ],
      ),
    );
  }

  void changeYear(String year) {
    loadPayslip(year: year);
  }

  void changeMonth(String month) {
    if (state is PayslipLoaded) {
      final current = state as PayslipLoaded;
      loadPayslip(year: current.selectedYear, month: month);
    }
  }
}
