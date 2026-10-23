import 'dart:io';
import '../../lib/src/transpiler/parser/preset_registry.dart';
import '../../lib/src/transpiler/emitters/flutter_emitter.dart';
import '../../lib/src/transpiler/emitters/tailwind_emitter.dart';
import '../../lib/src/transpiler/emitters/swiftui_emitter.dart';
import '../../lib/src/transpiler/emitters/compose_emitter.dart';

void main() {
  stdout.writeln('======================================================');
  stdout.writeln(' ThemePilot Transpiler Test: Multi-Platform Emitters');
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

  final preset = PresetRegistry.enterpriseObsidian;
  final flutterEmitter = FlutterM3Emitter();
  final tailwindEmitter = TailwindEmitter();
  final swiftUIEmitter = SwiftUIEmitter();
  final composeEmitter = ComposeM3Emitter();

  // Test 1: Flutter Emitter
  test('FlutterM3Emitter generates valid Material 3 Dart code', () {
    final artifact = flutterEmitter.emit(preset);
    expect(artifact.targetPlatform == 'flutter', 'Invalid target platform');
    expect(artifact.relativeFilePath == 'packages/theme/lib/src/theme_data.dart', 'Invalid file path');
    expect(artifact.fileContent.contains('abstract final class ThemePilotTokens'), 'Missing token class');
    expect(artifact.fileContent.contains('0xFF38BDF8'), 'Missing primary hex color (0xFF38BDF8)');
    expect(artifact.fileContent.contains('0xFF070E17'), 'Missing scaffold hex color (0xFF070E17)');
    expect(artifact.lineCount > 20, 'Artifact line count too short');
  });

  // Test 2: Tailwind Emitter
  test('TailwindEmitter generates valid tailwind.config.js code', () {
    final artifact = tailwindEmitter.emit(preset);
    expect(artifact.targetPlatform == 'tailwind', 'Invalid target platform');
    expect(artifact.relativeFilePath == 'tailwind.config.js', 'Invalid file path');
    expect(artifact.fileContent.contains('module.exports = {'), 'Missing module.exports');
    expect(artifact.fileContent.contains("'#38BDF8'"), 'Missing primary accent color (#38BDF8)');
    expect(artifact.fileContent.contains("'#070E17'"), 'Missing scaffold color (#070E17)');
    expect(artifact.lineCount > 20, 'Artifact line count too short');
  });

  // Test 3: SwiftUI Emitter
  test('SwiftUIEmitter generates valid iOS 17+ SwiftUI code', () {
    final artifact = swiftUIEmitter.emit(preset);
    expect(artifact.targetPlatform == 'swiftui', 'Invalid target platform');
    expect(artifact.relativeFilePath == 'Sources/Theme/ThemePilotTokens.swift', 'Invalid file path');
    expect(artifact.fileContent.contains('import SwiftUI'), 'Missing import SwiftUI');
    expect(artifact.fileContent.contains('public enum ThemePilotTokens'), 'Missing token enum');
    expect(artifact.fileContent.contains('Color(red:'), 'Missing normalized RGB Color definition');
    expect(artifact.lineCount > 15, 'Artifact line count too short');
  });

  // Test 4: Jetpack Compose Emitter
  test('ComposeM3Emitter generates valid Android Jetpack Compose code', () {
    final artifact = composeEmitter.emit(preset);
    expect(artifact.targetPlatform == 'compose', 'Invalid target platform');
    expect(artifact.relativeFilePath == 'com/themepilot/theme/Theme.kt', 'Invalid file path');
    expect(artifact.fileContent.contains('package com.themepilot.theme'), 'Missing package declaration');
    expect(artifact.fileContent.contains('val ThemePilotDarkColorScheme = darkColorScheme('), 'Missing darkColorScheme');
    expect(artifact.fileContent.contains('0xFF38BDF8'), 'Missing primary hex color (0xFF38BDF8)');
    expect(artifact.lineCount > 20, 'Artifact line count too short');
  });

  // Test 5: Cross-platform parity across all 4 presets
  test('All 4 emitters compile across all 4 presets without errors', () {
    for (final p in PresetRegistry.all) {
      final f = flutterEmitter.emit(p);
      final t = tailwindEmitter.emit(p);
      final s = swiftUIEmitter.emit(p);
      final c = composeEmitter.emit(p);

      expect(f.fileContent.isNotEmpty, '${p.name}: Flutter output empty');
      expect(t.fileContent.isNotEmpty, '${p.name}: Tailwind output empty');
      expect(s.fileContent.isNotEmpty, '${p.name}: SwiftUI output empty');
      expect(c.fileContent.isNotEmpty, '${p.name}: Compose output empty');
    }
  });

  stdout.writeln('\n------------------------------------------------------');
  stdout.writeln(' Tests Executed: $totalTests | Passed: $passedTests');
  if (totalTests == passedTests) {
    stdout.writeln(' Status        : ✅ ALL EMITTER TESTS PASSED');
    stdout.writeln('======================================================\n');
    exit(0);
  } else {
    stdout.writeln(' Status        : ❌ SOME EMITTER TESTS FAILED');
    stdout.writeln('======================================================\n');
    exit(1);
  }
}
