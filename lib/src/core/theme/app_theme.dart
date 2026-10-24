// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from specs/tokens/tokens.yaml via tools/compile_tokens.dart

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_radius.dart';

/// Custom Theme Extension for ThemePilot-specific tokens
@immutable
class ThemePilotCustomTokens extends ThemeExtension<ThemePilotCustomTokens> {
  final Color? statusPass;
  final Color? statusPassContainer;
  final Color? brandViolet;
  final Color? steelFacet;

  const ThemePilotCustomTokens({
    this.statusPass,
    this.statusPassContainer,
    this.brandViolet,
    this.steelFacet,
  });

  @override
  ThemePilotCustomTokens copyWith({
    Color? statusPass,
    Color? statusPassContainer,
    Color? brandViolet,
    Color? steelFacet,
  }) {
    return ThemePilotCustomTokens(
      statusPass: statusPass ?? this.statusPass,
      statusPassContainer: statusPassContainer ?? this.statusPassContainer,
      brandViolet: brandViolet ?? this.brandViolet,
      steelFacet: steelFacet ?? this.steelFacet,
    );
  }

  @override
  ThemePilotCustomTokens lerp(ThemeExtension<ThemePilotCustomTokens>? other, double t) {
    if (other is! ThemePilotCustomTokens) return this;
    return ThemePilotCustomTokens(
      statusPass: Color.lerp(statusPass, other.statusPass, t),
      statusPassContainer: Color.lerp(statusPassContainer, other.statusPassContainer, t),
      brandViolet: Color.lerp(brandViolet, other.brandViolet, t),
      steelFacet: Color.lerp(steelFacet, other.steelFacet, t),
    );
  }
}

/// Official ThemePilot Material 3 ThemeData Provider
abstract final class AppTheme {
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.electricAeroBlue,
      onPrimary: AppColors.textOnAccent,
      primaryContainer: AppColors.surfaceContainerHigh,
      onPrimaryContainer: AppColors.electricAeroBlue,
      secondary: AppColors.irisViolet,
      onSecondary: AppColors.textPrimary,
      surface: AppColors.surfaceSlate,
      onSurface: AppColors.textPrimary,
      surfaceContainer: AppColors.surfaceSlate,
      surfaceContainerHigh: AppColors.surfaceContainerHigh,
      surfaceContainerHighest: AppColors.structuralSteelFacet,
      outline: AppColors.structuralSteelFacet,
      outlineVariant: AppColors.surfaceContainerHigh,
      error: const Color(0xFFEF4444),
      onError: Colors.white,
      errorContainer: const Color(0xFF3B0B0B),
      onErrorContainer: const Color(0xFFEF4444),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.scaffoldObsidian,
      cardTheme: CardTheme(
        color: AppColors.surfaceSlate,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: const BorderSide(color: AppColors.surfaceContainerHigh),
        ),
      ),
      extensions: const [
        ThemePilotCustomTokens(
          statusPass: AppColors.successEmerald,
          statusPassContainer: AppColors.emeraldContainer,
          brandViolet: AppColors.irisViolet,
          steelFacet: AppColors.structuralSteelFacet,
        ),
      ],
    );
  }
}
