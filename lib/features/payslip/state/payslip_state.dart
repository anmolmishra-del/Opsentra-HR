abstract class PayslipState {}

class PayslipLoading extends PayslipState {}

class PayslipLoaded extends PayslipState {
  final String selectedYear;
  final String selectedMonth;

  final List<String> availableYears;
  final List<String> availableMonths;

  final String netPay;
  final List<Map<String, String>> earnings;
  final List<Map<String, String>> deductions;

  PayslipLoaded({
    required this.selectedYear,
    required this.selectedMonth,
    required this.availableYears,
    required this.availableMonths,
    required this.netPay,
    required this.earnings,
    required this.deductions,
  });
}

class PayslipError extends PayslipState {
  final String message;
  PayslipError(this.message);
}
