import 'package:flutter/cupertino.dart';

class AppColorPrimitive {
  static const Color primary = Color(0xFF826EE8);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFE6E2FA);
  static const Color onPrimaryContainer = Color(0xFF6858BA);
  static const Color error = Color(0xFF826EE8);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFD8D8);
  static const Color onErrorContainer = Color(0xFFCC2F2F);
  static const Color surface = Color(0xFFFAFAFA);
  static const Color surfaceBright = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF2D2D2D);
  static const Color onSurfaceVariant = Color(0xFF767678);
  static const Color onSurfaceError = Color(0xFFFF3B3B);
  static const Color shadowNeutral = Color(0xFF000000);
  static const Color shadowPrimary = Color(0xFF826EE8);
}

class AppGradient {
  static const LinearGradient primary = LinearGradient(colors: [Color(0xFF9B8BED), Color(0xFF6858BA)], begin: Alignment.topRight, end: Alignment.bottomLeft);
}

class AppColor {
  static const AppTextColor text = AppTextColor();
  static const AppIconColor icon = AppIconColor();
  static const AppSurfaceColor surface = AppSurfaceColor();
}

class AppTextColor {
  const AppTextColor();

  final Color main = AppColorPrimitive.onSurface;
  final Color description = AppColorPrimitive.onSurfaceVariant;

  final Color error = AppColorPrimitive.onSurfaceError;

  final Color filledButton = AppColorPrimitive.onPrimary;
  final Color tonalButton = AppColorPrimitive.onPrimaryContainer;
}

class AppIconColor {
  const AppIconColor();

  final Color main = AppColorPrimitive.onSurface;
  final Color loading = AppColorPrimitive.primary;

  final Color filledButton = AppColorPrimitive.onPrimary;
  final Color dismissal = AppColorPrimitive.onErrorContainer;

  final Color toggle = AppColorPrimitive.primary;
}

class AppSurfaceColor {
  const AppSurfaceColor();

  final Color page = AppColorPrimitive.surface;
  final Color card = AppColorPrimitive.surfaceBright;
  final Color dismissal = AppColorPrimitive.errorContainer;

  final Color elevatedButton = AppColorPrimitive.surfaceBright;
  final Color tonalButton = AppColorPrimitive.primaryContainer;

  final Color toggle = AppColorPrimitive.primaryContainer;
}
