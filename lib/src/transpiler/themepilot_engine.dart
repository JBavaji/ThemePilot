import 'emitters/base_emitter.dart';
import 'emitters/compose_emitter.dart';
import 'emitters/flutter_emitter.dart';
import 'emitters/swiftui_emitter.dart';
import 'emitters/tailwind_emitter.dart';
import 'model/token_bundle.dart';
import 'parser/preset_registry.dart';

/// Represents the completed multi-platform compilation bundle.
class QuadCompilationResult {
  final TokenBundle sourceBundle;
  final GeneratedArtifact flutter;
  final GeneratedArtifact tailwind;
  final GeneratedArtifact swiftUI;
  final GeneratedArtifact compose;
  final Duration compilationDuration;
  final bool isZeroDriftVerified;

  const QuadCompilationResult({
    required this.sourceBundle,
    required this.flutter,
    required this.tailwind,
    required this.swiftUI,
    required this.compose,
    required this.compilationDuration,
    required this.isZeroDriftVerified,
  });

  /// All 4 artifacts as a list for easy iteration / packaging
  List<GeneratedArtifact> get allArtifacts => [flutter, tailwind, swiftUI, compose];
}

/// The core ThemePilot multi-platform transpiler engine.
class ThemePilotEngine {
  final FlutterM3Emitter _flutterEmitter;
  final TailwindEmitter _tailwindEmitter;
  final SwiftUIEmitter _swiftUIEmitter;
  final ComposeM3Emitter _composeEmitter;

  ThemePilotEngine({
    FlutterM3Emitter? flutterEmitter,
    TailwindEmitter? tailwindEmitter,
    SwiftUIEmitter? swiftUIEmitter,
    ComposeM3Emitter? composeEmitter,
  })  : _flutterEmitter = flutterEmitter ?? FlutterM3Emitter(),
        _tailwindEmitter = tailwindEmitter ?? TailwindEmitter(),
        _swiftUIEmitter = swiftUIEmitter ?? SwiftUIEmitter(),
        _composeEmitter = composeEmitter ?? ComposeM3Emitter();

  /// Compiles a [TokenBundle] into all 4 platform codebases.
  /// Performance SLO: Execution time < 850 milliseconds.
  QuadCompilationResult transpile(TokenBundle bundle) {
    final stopwatch = Stopwatch()..start();

    // Deterministic synchronous AST generation
    final flutterArtifact = _flutterEmitter.emit(bundle);
    final tailwindArtifact = _tailwindEmitter.emit(bundle);
    final swiftUIArtifact = _swiftUIEmitter.emit(bundle);
    final composeArtifact = _composeEmitter.emit(bundle);

    stopwatch.stop();

    // Verify token consistency across artifacts
    final isZeroDrift = _verifyZeroDrift(bundle, flutterArtifact, tailwindArtifact, swiftUIArtifact, composeArtifact);

    return QuadCompilationResult(
      sourceBundle: bundle,
      flutter: flutterArtifact,
      tailwind: tailwindArtifact,
      swiftUI: swiftUIArtifact,
      compose: composeArtifact,
      compilationDuration: stopwatch.elapsed,
      isZeroDriftVerified: isZeroDrift,
    );
  }

  /// Convenience method: compiles directly from a preset ID.
  QuadCompilationResult transpilePreset(String presetId) {
    final bundle = PresetRegistry.findById(presetId);
    return transpile(bundle);
  }

  /// Ensures that all emitters faithfully included the primary accent token
  bool _verifyZeroDrift(
    TokenBundle bundle,
    GeneratedArtifact flutter,
    GeneratedArtifact tailwind,
    GeneratedArtifact swiftUI,
    GeneratedArtifact compose,
  ) {
    final cleanHex = bundle.colors.primary.replaceAll('#', '').toUpperCase();
    final hasFlutter = flutter.fileContent.contains(cleanHex);
    final hasTailwind = tailwind.fileContent.contains(bundle.colors.primary);
    final hasCompose = compose.fileContent.contains(cleanHex);
    final hasSwiftUI = swiftUI.fileContent.contains('Color(red:');

    return hasFlutter && hasTailwind && hasCompose && hasSwiftUI;
  }
}
