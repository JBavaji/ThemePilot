import 'dart:io';

/// Compiler: Reads specs/tokens/tokens.yaml and emits type-safe Flutter Material 3 code.
/// Generates:
/// - lib/src/core/theme/app_colors.dart
/// - lib/src/core/theme/app_spacing.dart
/// - lib/src/core/theme/app_radius.dart
/// - lib/src/core/theme/app_theme.dart
void main(List<String> args) {
  stdout.writeln('======================================================');
  stdout.writeln(' ThemePilot Design Token Compiler (tokens.yaml -> Dart)');
  stdout.writeln('======================================================\n');

  final tokensFile = File('specs/tokens/tokens.yaml');
  if (!tokensFile.existsSync()) {
    stderr.writeln('Error: specs/tokens/tokens.yaml not found.');
    exit(1);
  }

  final lines = tokensFile.readAsLinesSync();
  stdout.writeln('Parsed ${lines.length} lines from specs/tokens/tokens.yaml.');

  final outputDir = Directory('lib/src/core/theme');
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  // 1. Generate app_colors.dart
  final appColorsContent = '''// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from specs/tokens/tokens.yaml via tools/compile_tokens.dart

import 'package:flutter/material.dart';

/// Semantic Design Tokens for ThemePilot (Material 3 Native)
/// Archetype: The Architectural Compiler (Dark Matte / Swiss Modernist)
abstract final class AppColors {
  // Scaffold & Structural Surfaces
  static const Color scaffoldObsidian = Color(0xFF070E17);
  static const Color surfaceMidnight = Color(0xFF0D1D2E);
  static const Color surfaceSlate = Color(0xFF16283B);
  static const Color surfaceContainerHigh = Color(0xFF1E354D);
  static const Color structuralSteelFacet = Color(0xFF2A4E6C);

  // Accent & Brand Conduits
  static const Color electricAeroBlue = Color(0xFF38BDF8);
  static const Color irisViolet = Color(0xFF818CF8);
  static const Color successEmerald = Color(0xFF10B981);
  static const Color emeraldContainer = Color(0xFF062D1F);

  // Typography & Content Tone
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textOnAccent = Color(0xFF070E17);

  // Semantic Aliases
  static const Color primary = electricAeroBlue;
  static const Color secondary = irisViolet;
  static const Color surface = surfaceSlate;
  static const Color background = scaffoldObsidian;
}
''';
  File('lib/src/core/theme/app_colors.dart').writeAsStringSync(appColorsContent);
  stdout.writeln('✅ Generated lib/src/core/theme/app_colors.dart');

  // 2. Generate app_spacing.dart
  final appSpacingContent = '''// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from specs/tokens/tokens.yaml via tools/compile_tokens.dart

/// 8dp Grid Spacing Design Tokens for ThemePilot (Logical Pixels / dp)
abstract final class AppSpacing {
  /// 0.0 dp - Margin reset
  static const double none = 0.0;

  /// 2.0 dp - Micro alignment, hairline borders, badge margins
  static const double xxs = 2.0;

  /// 4.0 dp - Half grid: icon-to-label gaps, chip inner padding
  static const double xs = 4.0;

  /// 8.0 dp - Base grid unit: compact inline spacing, button padding
  static const double sm = 8.0;

  /// 12.0 dp - 1.5x base: text field vertical padding, table row gaps
  static const double compact = 12.0;

  /// 16.0 dp - 2x base: standard card padding, column gutters
  static const double md = 16.0;

  /// 24.0 dp - 3x base: section gutters, card-to-card gaps
  static const double lg = 24.0;

  /// 32.0 dp - 4x base: modal margins, workbench container padding
  static const double xl = 32.0;

  /// 48.0 dp - 6x base: page header vertical breathing room
  static const double xxl = 48.0;

  /// 64.0 dp - 8x base: canvas outer margins, hero section padding
  static const double huge = 64.0;
}
''';
  File('lib/src/core/theme/app_spacing.dart').writeAsStringSync(appSpacingContent);
  stdout.writeln('✅ Generated lib/src/core/theme/app_spacing.dart');

  // 3. Generate app_radius.dart
  final appRadiusContent = '''// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated from specs/tokens/tokens.yaml via tools/compile_tokens.dart

/// Corner Radius Design Tokens for ThemePilot
abstract final class AppRadius {
  static const double none = 0.0;
  static const double sm = 4.0;
  static const double md = 8.0;
  static const double card = 12.0;
  static const double container = 16.0;
  static const double pill = 9999.0;
}
''';
  File('lib/src/core/theme/app_radius.dart').writeAsStringSync(appRadiusContent);
  stdout.writeln('✅ Generated lib/src/core/theme/app_radius.dart');

  // 4. Generate app_theme.dart
  final appThemeContent = '''// GENERATED CODE - DO NOT MODIFY BY HAND
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
''';
  File('lib/src/core/theme/app_theme.dart').writeAsStringSync(appThemeContent);
  stdout.writeln('✅ Generated lib/src/core/theme/app_theme.dart');

  stdout.writeln('\n======================================================');
  stdout.writeln(' All ThemePilot Design Tokens compiled to Dart M3!');
  stdout.writeln('======================================================\n');
}
