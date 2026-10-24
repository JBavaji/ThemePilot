import 'dart:io';
import '../../lib/src/transpiler/parser/preset_registry.dart';
import '../../lib/src/transpiler/themepilot_engine.dart';

void main() {
  stdout.writeln('======================================================');
  stdout.writeln(' ThemePilot Transpiler Test: Engine & SLO Benchmark');
  stdout.writeln('======================================================\n');

  final engine = ThemePilotEngine();
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

  // Test 1: Transpile each preset and verify result
  for (final preset in PresetRegistry.all) {
    test('Engine compiles preset "${preset.name}" into Quad result', () {
      final result = engine.transpile(preset);
      expect(result.allArtifacts.length == 4, 'Expected 4 artifacts');
      expect(result.flutter.fileContent.isNotEmpty, 'Flutter output empty');
      expect(result.tailwind.fileContent.isNotEmpty, 'Tailwind output empty');
      expect(result.swiftUI.fileContent.isNotEmpty, 'SwiftUI output empty');
      expect(result.compose.fileContent.isNotEmpty, 'Compose output empty');
      expect(result.isZeroDriftVerified, 'Zero drift check failed for ${preset.name}');
    });
  }

  // Test 2: Verify Latency SLO (<850ms)
  test('Compilation latency complies with <850ms SLO', () {
    final result = engine.transpilePreset('enterprise_obsidian');
    final durationMs = result.compilationDuration.inMicroseconds / 1000.0;
    stdout.writeln('     ⚡ Benchmark Latency: ${durationMs.toStringAsFixed(3)} ms (Budget: 850 ms)');
    expect(result.compilationDuration.inMilliseconds < 850, 'Latency exceeded 850ms SLO: ${durationMs}ms');
  });

  // Test 3: Batch 100 iterations throughput test
  test('Batch 100 compilations throughput test', () {
    final stopwatch = Stopwatch()..start();
    for (int i = 0; i < 100; i++) {
      engine.transpilePreset('vertical_feed');
    }
    stopwatch.stop();
    final totalMs = stopwatch.elapsedMilliseconds;
    final avgMs = totalMs / 100.0;
    stdout.writeln('     🚀 100 Compilations completed in ${totalMs} ms (Average: ${avgMs.toStringAsFixed(3)} ms/run)');
    expect(avgMs < 50.0, 'Average compilation took too long: ${avgMs}ms');
  });

  stdout.writeln('\n------------------------------------------------------');
  stdout.writeln(' Tests Executed: $totalTests | Passed: $passedTests');
  if (totalTests == passedTests) {
    stdout.writeln(' Status        : ✅ ALL ENGINE & SLO TESTS PASSED');
    stdout.writeln('======================================================\n');
    exit(0);
  } else {
    stdout.writeln(' Status        : ❌ SOME TESTS FAILED');
    stdout.writeln('======================================================\n');
    exit(1);
  }
}
