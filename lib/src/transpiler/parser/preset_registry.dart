import '../model/token_bundle.dart';

/// Preset Registry for ThemePilot: houses the 4 curated quick-start design archetypes.
abstract final class PresetRegistry {
  /// 1. ⚡ Vertical Feed (Moody Cinematic Dark)
  static const TokenBundle verticalFeed = TokenBundle(
    id: 'vertical_feed',
    name: '⚡ Vertical Feed',
    archetype: 'The Digital Projectionist (Moody Cinematic Dark)',
    mode: ThemeModePreference.dark,
    colors: ColorTokens(
      scaffold: '#131313',
      surface: '#1F1F1F',
      surfaceDim: '#171717',
      surfaceHigh: '#292929',
      primary: '#FF007A',
      secondary: '#00DBE9',
      success: '#10B981',
      textPrimary: '#FFFFFF',
      textMuted: '#A3A3A3',
      textOnAccent: '#FFFFFF',
    ),
    spacing: SpacingTokens(),
    radii: RadiusTokens(
      none: 0.0,
      sm: 4.0,
      md: 8.0,
      card: 16.0,
      container: 24.0,
      pill: 9999.0,
    ),
    typography: TypographyTokens(
      displayFont: 'Space Grotesk',
      bodyFont: 'Inter',
      codeFont: 'JetBrains Mono',
    ),
  );

  /// 2. 🔮 Neon Cyberpunk (High-Contrast Obsidian)
  static const TokenBundle neonCyberpunk = TokenBundle(
    id: 'neon_cyberpunk',
    name: '🔮 Neon Cyberpunk',
    archetype: 'High-Contrast Terminal Obsidian',
    mode: ThemeModePreference.dark,
    colors: ColorTokens(
      scaffold: '#050811',
      surface: '#0B132B',
      surfaceDim: '#080E20',
      surfaceHigh: '#1C2541',
      primary: '#A855F7',
      secondary: '#06B6D4',
      success: '#10B981',
      textPrimary: '#F8FAFC',
      textMuted: '#64748B',
      textOnAccent: '#050811',
    ),
    spacing: SpacingTokens(),
    radii: RadiusTokens(
      none: 0.0,
      sm: 2.0,
      md: 4.0,
      card: 6.0,
      container: 8.0,
      pill: 9999.0,
    ),
    typography: TypographyTokens(
      displayFont: 'JetBrains Mono',
      bodyFont: 'Inter',
      codeFont: 'JetBrains Mono',
    ),
  );

  /// 3. 📱 Fintech Minimal (Trust Corporate Dark)
  static const TokenBundle fintechMinimal = TokenBundle(
    id: 'fintech_minimal',
    name: '📱 Fintech Minimal',
    archetype: 'Institutional Trust Minimal',
    mode: ThemeModePreference.dark,
    colors: ColorTokens(
      scaffold: '#0A1128',
      surface: '#101F42',
      surfaceDim: '#0C1633',
      surfaceHigh: '#1C2F5E',
      primary: '#0052FF',
      secondary: '#10B981',
      success: '#10B981',
      textPrimary: '#FFFFFF',
      textMuted: '#8F9CAE',
      textOnAccent: '#FFFFFF',
    ),
    spacing: SpacingTokens(),
    radii: RadiusTokens(
      none: 0.0,
      sm: 4.0,
      md: 8.0,
      card: 12.0,
      container: 16.0,
      pill: 9999.0,
    ),
    typography: TypographyTokens(
      displayFont: 'Inter',
      bodyFont: 'Inter',
      codeFont: 'JetBrains Mono',
    ),
  );

  /// 4. 🏢 Enterprise Obsidian (The Architectural Compiler — ThemePilot Native)
  static const TokenBundle enterpriseObsidian = TokenBundle(
    id: 'enterprise_obsidian',
    name: '🏢 Enterprise Obsidian',
    archetype: 'The Architectural Compiler (Swiss Modernist)',
    mode: ThemeModePreference.dark,
    colors: ColorTokens(
      scaffold: '#070E17',
      surface: '#16283B',
      surfaceDim: '#0D1D2E',
      surfaceHigh: '#1E354D',
      primary: '#38BDF8',
      secondary: '#818CF8',
      success: '#10B981',
      textPrimary: '#FFFFFF',
      textMuted: '#94A3B8',
      textOnAccent: '#070E17',
    ),
    spacing: SpacingTokens(),
    radii: RadiusTokens(
      none: 0.0,
      sm: 4.0,
      md: 8.0,
      card: 12.0,
      container: 16.0,
      pill: 9999.0,
    ),
    typography: TypographyTokens(
      displayFont: 'Space Grotesk',
      bodyFont: 'Inter',
      codeFont: 'JetBrains Mono',
    ),
  );

  /// All 4 presets in a single immutable list
  static const List<TokenBundle> all = [
    verticalFeed,
    neonCyberpunk,
    fintechMinimal,
    enterpriseObsidian,
  ];

  /// Find preset by ID, falling back to Enterprise Obsidian
  static TokenBundle findById(String id) {
    return all.firstWhere(
      (p) => p.id == id,
      orElse: () => enterpriseObsidian,
    );
  }
}
