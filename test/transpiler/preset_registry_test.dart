import 'dart:io';
import '../../lib/src/transpiler/model/token_bundle.dart';
import '../../lib/src/transpiler/parser/preset_registry.dart';

void main() {
  stdout.writeln('======================================================');
  stdout.writeln(' ThemePilot Transpiler Test: Preset Registry & Models');
  stdout.writeln('======================================================\n');

  int totalTests = 0;
  int passedTests = 0;

  void test(String description, void Function() body) {
    totalTests++;
    try {
      body();
      stdout.writeln('  ✅ Pass: $description');
      passedTests++;
    } catch (e) {
      stderr.writeln('  ❌ Fail: $description ($e)');
    }
  }

  void expect(bool condition, String message) {
    if (!condition) throw Exception(message);
  }

  test('PresetRegistry contains exactly 4 curated presets', () {
    expect(PresetRegistry.all.length == 4, 'Expected 4 presets, got ${PresetRegistry.all.length}');
  });

  test('All presets have non-empty IDs, names, and archetypes', () {
    for (final preset in PresetRegistry.all) {
      expect(preset.id.isNotEmpty, 'Preset ${preset.name} has empty id');
      expect(preset.name.isNotEmpty, 'Preset ${preset.id} has empty name');
      expect(preset.archetype.isNotEmpty, 'Preset ${preset.name} has empty archetype');
    }
  });

  test('Preset colors contain valid 7-character hex strings starting with #', () {
    final hexRegex = RegExp(r'^#[0-9A-Fa-f]{6}$');
    for (final p in PresetRegistry.all) {
      final c = p.colors;
      expect(hexRegex.hasMatch(c.scaffold), '${p.name}: invalid scaffold hex ${c.scaffold}');
      expect(hexRegex.hasMatch(c.surface), '${p.name}: invalid surface hex ${c.surface}');
      expect(hexRegex.hasMatch(c.primary), '${p.name}: invalid primary hex ${c.primary}');
      expect(hexRegex.hasMatch(c.secondary), '${p.name}: invalid secondary hex ${c.secondary}');
      expect(hexRegex.hasMatch(c.success), '${p.name}: invalid success hex ${c.success}');
    }
  });

  test('ColorTokens.hexToInt produces correct 0xAARRGGBB integers', () {
    final val = ColorTokens.hexToInt('#38BDF8');
    expect(val == 0xFF38BDF8, 'Expected 0xFF38BDF8, got $val');

    final white = ColorTokens.hexToInt('#FFFFFF');
    expect(white == 0xFFFFFFFF, 'Expected 0xFFFFFFFF, got $white');
  });

  test('ColorTokens.hexToRgbRatios produces valid 0.0-1.0 float ratios', () {
    final ratios = ColorTokens.hexToRgbRatios('#38BDF8');
    expect(ratios.r >= 0.0 && ratios.r <= 1.0, 'Red ratio out of range');
    expect(ratios.g >= 0.0 && ratios.g <= 1.0, 'Green ratio out of range');
    expect(ratios.b >= 0.0 && ratios.b <= 1.0, 'Blue ratio out of range');
  });

  test('All presets adhere to the 8dp mathematical grid for spacing', () {
    for (final p in PresetRegistry.all) {
      expect(p.spacing.gridBase == 8.0, '${p.name}: gridBase is not 8.0');
      expect(p.spacing.sm == 8.0, '${p.name}: sm is not 8.0');
      expect(p.spacing.md == 16.0, '${p.name}: md is not 16.0');
      expect(p.spacing.lg == 24.0, '${p.name}: lg is not 24.0');
      expect(p.spacing.xl == 32.0, '${p.name}: xl is not 32.0');
    }
  });

  test('PresetRegistry.findById resolves correctly with fallback', () {
    final vf = PresetRegistry.findById('vertical_feed');
    expect(vf.name == '⚡ Vertical Feed', 'Failed to resolve vertical_feed');

    final fallback = PresetRegistry.findById('unknown_id');
    expect(fallback.id == 'enterprise_obsidian', 'Fallback failed');
  });

  stdout.writeln('\n------------------------------------------------------');
  stdout.writeln(' Tests Executed: $totalTests | Passed: $passedTests');
  if (totalTests == passedTests) {
    stdout.writeln(' Status        : ✅ ALL TESTS PASSED');
    stdout.writeln('======================================================\n');
    exit(0);
  } else {
    stdout.writeln(' Status        : ❌ SOME TESTS FAILED');
    stdout.writeln('======================================================\n');
    exit(1);
  }
}
