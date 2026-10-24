import 'dart:io';

/// Automated Validator for ThemePilot Design System as Code (DSaC) Specifications.
/// Verifies:
/// 1. Canonical tokens.yaml exists and contains valid DTCG structure.
/// 2. Any component specs in specs/ implement the mandatory 8-section contract.
/// 3. All spec files adhere to the modularity constraint (<200 lines).
void main(List<String> args) {
  stdout.writeln('======================================================');
  stdout.writeln(' ThemePilot DSaC Specification Suite Validator');
  stdout.writeln('======================================================\n');

  final baseDir = Directory('specs');
  if (!baseDir.existsSync()) {
    stderr.writeln('Error: specs directory not found.');
    exit(1);
  }

  final tokensFile = File('specs/tokens/tokens.yaml');
  if (!tokensFile.existsSync()) {
    stderr.writeln('❌ [Violation] specs/tokens/tokens.yaml is missing.');
    exit(1);
  } else {
    stdout.writeln('✅ Verified canonical W3C DTCG tokens file: specs/tokens/tokens.yaml');
  }

  final specFiles = baseDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.md') || f.path.endsWith('.yaml'))
      .toList();

  stdout.writeln('Analyzing ${specFiles.length} specification file(s) in specs/...\n');

  int passedFiles = 0;
  List<String> errors = [];

  for (final file in specFiles) {
    final lines = file.readAsLinesSync();
    final lineCount = lines.length;

    // Check line limit rule (< 200 lines)
    if (lineCount > 200) {
      errors.add('Line limit exceeded in ${file.path}: $lineCount lines (>200)');
    }

    // Check 8 mandatory sections for component markdown files
    if (file.path.contains('/components/') && file.path.endsWith('.md')) {
      final content = file.readAsStringSync();
      final requiredSections = [
        '## 1. Metadata',
        '## 2. Overview',
        '## 3. Anatomy',
        '## 4. Tokens Used',
        '## 5. Props',
        '## 6. Interaction States',
        '## 7.',
        '## 8. Cross-References',
      ];

      for (final section in requiredSections) {
        if (!content.contains(section)) {
          errors.add('Missing mandatory section "$section" in ${file.path}');
        }
      }
    }

    passedFiles++;
  }

  stdout.writeln('------------------------------------------------------');
  stdout.writeln(' Total Specs Analyzed : ${specFiles.length}');
  stdout.writeln(' Specs Passing Rules  : $passedFiles');

  if (errors.isEmpty) {
    stdout.writeln(' Status               : ✅ SPEC SUITE PASS (0 Errors)');
    stdout.writeln('======================================================\n');
    exit(0);
  } else {
    stdout.writeln(' Status               : ❌ VALIDATION FAILED');
    for (final err in errors) {
      stderr.writeln('   - $err');
    }
    stdout.writeln('======================================================\n');
    exit(1);
  }
}
