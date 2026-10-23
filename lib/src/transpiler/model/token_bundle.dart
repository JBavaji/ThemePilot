/// Pure Dart W3C DTCG Token Domain Models for ThemePilot.
/// Zero Flutter UI dependencies - can run in standalone CLI or Web WASM runtimes.

enum ThemeModePreference { dark, light }

class TokenBundle {
  final String id;
  final String name;
  final String archetype;
  final ThemeModePreference mode;
  final ColorTokens colors;
  final SpacingTokens spacing;
  final RadiusTokens radii;
  final TypographyTokens typography;

  const TokenBundle({
    required this.id,
    required this.name,
    required this.archetype,
    this.mode = ThemeModePreference.dark,
    required this.colors,
    required this.spacing,
    required this.radii,
    required this.typography,
  });
}

class ColorTokens {
  final String scaffold;
  final String surface;
  final String surfaceDim;
  final String surfaceHigh;
  final String primary;
  final String secondary;
  final String success;
  final String textPrimary;
  final String textMuted;
  final String textOnAccent;

  const ColorTokens({
    required this.scaffold,
    required this.surface,
    required this.surfaceDim,
    required this.surfaceHigh,
    required this.primary,
    required this.secondary,
    required this.success,
    required this.textPrimary,
    required this.textMuted,
    required this.textOnAccent,
  });

  /// Helper to convert a #RRGGBB hex string to 0xAARRGGBB integer
  static int hexToInt(String hex) {
    final clean = hex.replaceAll('#', '');
    if (clean.length == 6) {
      return int.parse('FF$clean', radix: 16);
    } else if (clean.length == 8) {
      return int.parse(clean, radix: 16);
    }
    return 0xFF000000;
  }

  /// Helper to convert a #RRGGBB hex string to RGB percentages (0.0 to 1.0)
  static ({double r, double g, double b}) hexToRgbRatios(String hex) {
    final clean = hex.replaceAll('#', '');
    final r = int.parse(clean.substring(0, 2), radix: 16) / 255.0;
    final g = int.parse(clean.substring(2, 4), radix: 16) / 255.0;
    final b = int.parse(clean.substring(4, 6), radix: 16) / 255.0;
    return (
      r: double.parse(r.toStringAsFixed(2)),
      g: double.parse(g.toStringAsFixed(2)),
      b: double.parse(b.toStringAsFixed(2)),
    );
  }
}

class SpacingTokens {
  final double gridBase;
  final double none;
  final double xxs;
  final double xs;
  final double sm;
  final double compact;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double huge;

  const SpacingTokens({
    this.gridBase = 8.0,
    this.none = 0.0,
    this.xxs = 2.0,
    this.xs = 4.0,
    this.sm = 8.0,
    this.compact = 12.0,
    this.md = 16.0,
    this.lg = 24.0,
    this.xl = 32.0,
    this.xxl = 48.0,
    this.huge = 64.0,
  });
}

class RadiusTokens {
  final double none;
  final double sm;
  final double md;
  final double card;
  final double container;
  final double pill;

  const RadiusTokens({
    this.none = 0.0,
    this.sm = 4.0,
    this.md = 8.0,
    this.card = 12.0,
    this.container = 16.0,
    this.pill = 9999.0,
  });
}

class TypographyTokens {
  final String displayFont;
  final String bodyFont;
  final String codeFont;

  const TypographyTokens({
    required this.displayFont,
    required this.bodyFont,
    required this.codeFont,
  });
}
