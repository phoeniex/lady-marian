import 'package:flutter/material.dart';
import 'package:marian/presentation/_shared/app_color.dart';

class AppShadow {
  static BoxShadow normalNeutral = BoxShadow(
    color: AppColorPrimitive.shadowNeutral.withOpacity(0.12),
    blurRadius: 8.0,
    spreadRadius: 0.0,
    offset: const Offset(0.0, 4.0),
  );

  static BoxShadow normalPrimary = BoxShadow(
    color: AppColorPrimitive.shadowPrimary.withOpacity(0.4),
    blurRadius: 8.0,
    spreadRadius: 0.0,
    offset: const Offset(0.0, 4.0),
  );
}