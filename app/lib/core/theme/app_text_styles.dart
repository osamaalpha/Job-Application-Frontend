import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const headline = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static const jobTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const jobSubtitle = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
}
