import 'dart:io';

/// AST & Token Auditor for ThemePilot.
/// Scans lib/ for:
/// 1. Hardcoded raw hex colors: `Color(0x...)` outside of theme declarations.
/// 2. Hardcoded arbitrary padding / margins: `EdgeInsets.all(17.5)`.
/// 3. Direct usage of `Colors.<color>` instead of Material 3 `Theme.of(context).colorScheme`.
/// Fails with exit code 1 if non-compliant usages are found.
void main(List<String> args) {
  stdout.writeln('======================================================');
  stdout.writeln(' ThemePilot Design System AST Token Auditor');
  stdout.writeln('======================================================\n');

  final libDir = Directory('lib');
  if (!libDir.existsSync()) {
    stdout.writeln('lib/ directory does not exist yet. Nothing to audit.');
    exit(0);
  }

  final dartFiles = libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .where((f) => !f.path.contains('/theme/')) // Allow definitions in theme folder
      .where((f) => !f.path.contains('/transpiler/emitters/')) // Allow emitter templates
      .toList();

  stdout.writeln('Auditing ${dartFiles.length} Dart files in lib/...\n');

  final rawColorRegex = RegExp(r'Color\(0x[0-9a-fA-F]+\)');
  final materialColorsRegex = RegExp(r'Colors\.(blue|red|green|amber|grey|black|white|purple)');
  final arbitraryPaddingRegex = RegExp(r'EdgeInsets\.(all|symmetric)\(\s*([0-9]+(?:\.[0-9]+)?)\s*\)');

  final allowedSpacings = {0, 2, 4, 8, 12, 16, 24, 32, 48, 64};

  int violations = 0;

  for (final file in dartFiles) {
    final lines = file.readAsLinesSync();
    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final lineNum = i + 1;

      // 1. Check raw Color(0x...)
      if (rawColorRegex.hasMatch(line)) {
        stderr.writeln('❌ [Violation] ${file.path}:$lineNum - Hardcoded raw color detected.');
        stderr.writeln('   Use AppColors or Theme.of(context).colorScheme instead.\n');
        violations++;
      }

      // 2. Check Colors.xxx
      if (materialColorsRegex.hasMatch(line)) {
        stderr.writeln('❌ [Violation] ${file.path}:$lineNum - Raw Material Colors palette used.');
        stderr.writeln('   Use Theme.of(context).colorScheme instead.\n');
        violations++;
      }

      // 3. Check arbitrary padding values
      final padMatch = arbitraryPaddingRegex.firstMatch(line);
      if (padMatch != null) {
        final val = double.tryParse(padMatch.group(2) ?? '');
        if (val != null && !allowedSpacings.contains(val.toInt())) {
          stderr.writeln('❌ [Violation] ${file.path}:$lineNum - Non-tokenized padding: $val dp.');
          stderr.writeln('   Use AppSpacing tokens (e.g. AppSpacing.md, AppSpacing.sm) instead.\n');
          violations++;
        }
      }
    }
  }

  stdout.writeln('------------------------------------------------------');
  if (violations == 0) {
    stdout.writeln(' Audit Status : ✅ 0 VIOLATIONS. CODE IS 100% TOKENIZED.');
    stdout.writeln('======================================================\n');
    exit(0);
  } else {
    stdout.writeln(' Audit Status : ❌ $violations VIOLATIONS FOUND. FAILING CI.');
    stdout.writeln('======================================================\n');
    exit(1);
  }
}
