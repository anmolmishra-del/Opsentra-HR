import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/features/onboarding/state/onboarding_state.dart';


class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState(0));

  void setPage(int index) => emit(OnboardingState(index));

  void nextPage() {
    if (state.pageIndex < 2) {
      emit(OnboardingState(state.pageIndex + 1));
    }
  }

  void skip() => emit(const OnboardingState(2));
}
