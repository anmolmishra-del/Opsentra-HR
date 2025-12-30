import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:opsentra_hr/Core/constants/app_colors.dart';

class AppLoadingWidget extends StatelessWidget {
  final double size;

  const AppLoadingWidget({
    super.key,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.halfTriangleDot(
        color: AppColors.primary,
        size: size,
      ),
    );
  }
}
