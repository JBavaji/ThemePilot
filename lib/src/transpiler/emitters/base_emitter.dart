import '../model/token_bundle.dart';

/// Represents a compiled platform code artifact.
class GeneratedArtifact {
  final String targetPlatform; // e.g. "flutter", "tailwind", "swiftui", "compose"
  final String relativeFilePath; // e.g. "packages/theme/lib/src/theme_data.dart"
  final String fileContent;
  final int lineCount;

  const GeneratedArtifact({
    required this.targetPlatform,
    required this.relativeFilePath,
    required this.fileContent,
    required this.lineCount,
  });
}

/// Abstract contract for all platform code emitters.
abstract interface class PlatformEmitter {
  String get platformId;
  String get targetFilePath;
  GeneratedArtifact emit(TokenBundle bundle);
}
