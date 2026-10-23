# Technical Specification Finalization Document
## ThemePilot: Core Engine & Multi-Platform Architecture

| Document Metadata | Value |
| :--- | :--- |
| **Document Version** | `1.0.0` |
| **Status** | `Phase 1 Completion / Ready for Phase 2` |
| **Product Name** | ThemePilot |
| **Author** | Senior Software & AI-SDLC Architect |
| **Governing Specifications** | [`BRD`](brd/BRD_THEMEPILOT_V1.md) • [`ARD`](ard/ARD_THEMEPILOT_V1.md) • [`PRD`](prd/PRD_THEMEPILOT_V1.md) • [`tokens.yaml`](../specs/tokens/tokens.yaml) |
| **Last Updated** | October 2026 |

---

## 1. Executive Summary & Purpose

This document finalizes the technical decisions, code contracts, repository architecture, and public APIs for **ThemePilot** following the completion of Phase 1 (Documentation, BRD, ARD, PRD, and Token Specification).

It locks in the contract between:
1. **The Ingestion & Intermediate Representation (IR) Layer**
2. **The Multi-Platform AST Emitters (Flutter, Tailwind, SwiftUI, Compose)**
3. **The AST Validation Gates & Linters**
4. **The Presentation Layer (Flutter Web Workbench)**

---

## 2. Repository & Package Structure

ThemePilot adopts a clean architectural separation between the **pure Dart transpiler engine** and the **Flutter Web user interface**:

```
ThemePilot/
├── docs/                                  # Phase 1 Documentation Suite
│   ├── brd/BRD_THEMEPILOT_V1.md          # Business Requirements
│   ├── ard/                              # Architecture Requirements & ADRs
│   │   ├── ARD_THEMEPILOT_V1.md
│   │   └── adr/
│   │       ├── 001_w3c_dtcg_ir.md
│   │       └── 002_deterministic_ast_generation.md
│   ├── prd/PRD_THEMEPILOT_V1.md          # Product Requirements & UX Contract
│   └── TECH_SPEC_FINALIZATION.md         # This Technical Finalization Document
│
├── specs/                                 # Design System as Code (DSaC) Spec Tree
│   └── tokens/
│       └── tokens.yaml                   # W3C DTCG Canonical Token Source
│
├── tools/                                 # Deterministic AST Validation Tools
│   ├── compile_tokens.dart               # Ingests tokens.yaml -> Emits Flutter theme
│   ├── audit_tokens.dart                 # AST Scanner enforcing 0% design drift
│   └── validate_specs.dart               # Validates spec tree integrity
│
├── lib/                                   # Application & Engine Source
│   ├── main.dart                          # Flutter Web CanvasKit/WASM Entrypoint
│   └── src/
│       ├── core/                          # Design system tokens and shared theme
│       │   └── theme/
│       │       ├── app_colors.dart        # Compiled type-safe color constants
│       │       ├── app_spacing.dart       # Compiled 8dp grid spacing constants
│       │       ├── app_radius.dart        # Compiled corner radius constants
│       │       └── app_theme.dart         # Material 3 ThemeData definition
│       │
│       ├── transpiler/                    # Pure Dart Multi-Platform Engine (Zero Flutter UI)
│       │   ├── model/                     # Strongly-typed DTCG Token Bundle models
│       │   │   ├── token_bundle.dart
│       │   │   ├── color_token.dart
│       │   │   ├── spacing_token.dart
│       │   │   └── typography_token.dart
│       │   ├── parser/                    # Ingestion Parsers
│       │   │   ├── dtcg_yaml_parser.dart  # Parses W3C tokens.yaml
│       │   │   └── preset_registry.dart   # The 4 curated presets in memory
│       │   ├── emitters/                  # Pure AST Emitters
│       │   │   ├── base_emitter.dart      # PlatformEmitter interface
│       │   │   ├── flutter_emitter.dart   # Emits Flutter ThemeData & Extensions
│       │   │   ├── tailwind_emitter.dart  # Emits tailwind.config.js & theme.css
│       │   │   ├── swiftui_emitter.dart   # Emits SwiftUI Color + Theme structs
│       │   │   └── compose_emitter.dart   # Emits Jetpack Compose ColorScheme
│       │   └── themepilot_engine.dart     # Transpiler Orchestrator
│       │
│       └── features/                      # Presentation Layer (Flutter Web)
│           ├── ingestion/                 # Step 1: Omni-Bar, Presets, Engine Matrix
│           ├── workbench/                 # Step 2: Chassis Simulator & Quad Inspector
│           └── export/                    # In-Browser ZIP Archive Packager
│
├── test/
│   ├── transpiler/                        # Unit tests for parser and all 4 emitters
│   │   ├── flutter_emitter_test.dart
│   │   ├── tailwind_emitter_test.dart
│   │   ├── swiftui_emitter_test.dart
│   │   └── compose_emitter_test.dart
│   └── goldens/                           # Verified golden outputs for the 4 presets
│
└── index.html                             # Standalone interactive preview
```

---

## 3. Core Engine Public API Interface Contracts

### 3.1 `ThemePilotEngine` Orchestrator
```dart
abstract interface class ThemePilotEngine {
  /// Compiles a DTCG token bundle into all 4 platform outputs in <850ms.
  QuadCompilationResult transpile(TokenBundle bundle);

  /// Helper to transpile directly from raw YAML or JSON string.
  QuadCompilationResult transpileFromYaml(String yamlContent);
}

class QuadCompilationResult {
  final GeneratedArtifact flutter;
  final GeneratedArtifact tailwind;
  final GeneratedArtifact swiftUI;
  final GeneratedArtifact compose;
  final Duration compilationDuration;
  final bool isZeroDriftVerified;

  const QuadCompilationResult({
    required this.flutter,
    required this.tailwind,
    required this.swiftUI,
    required this.compose,
    required this.compilationDuration,
    required this.isZeroDriftVerified,
  });
}

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
```

### 3.2 Platform Emitter Interface
Every emitter conforms to a clean, deterministic contract:
```dart
abstract interface class PlatformEmitter {
  String get platformId; // "flutter", "tailwind", "swiftui", "compose"
  String get targetFilePath;
  GeneratedArtifact emit(TokenBundle bundle);
}
```

---

## 4. Phase 1 Checklist & Sign-Off Gate

All Phase 1 documentation and design requirements are verified:

- [x] **BRD Created & Verified:** [`docs/brd/BRD_THEMEPILOT_V1.md`](brd/BRD_THEMEPILOT_V1.md)
- [x] **ARD Created & Verified:** [`docs/ard/ARD_THEMEPILOT_V1.md`](ard/ARD_THEMEPILOT_V1.md)
- [x] **ADR-001 (W3C DTCG IR) Accepted:** [`docs/ard/adr/001_w3c_dtcg_ir.md`](ard/adr/001_w3c_dtcg_ir.md)
- [x] **ADR-002 (Deterministic AST) Accepted:** [`docs/ard/adr/002_deterministic_ast_generation.md`](ard/adr/002_deterministic_ast_generation.md)
- [x] **PRD Created & Verified:** [`docs/prd/PRD_THEMEPILOT_V1.md`](prd/PRD_THEMEPILOT_V1.md)
- [x] **Design Tokens Initialized:** [`specs/tokens/tokens.yaml`](../specs/tokens/tokens.yaml)
- [x] **Visual Design System Documented:** [`DESIGN.md`](../DESIGN.md)

---

## 5. Transition to Phase 2 (Core Engine & Tooling)

With Phase 1 complete and finalized, the implementation will systematically proceed into **Phase 2**, broken down into the following bite-sized, reviewable milestones:

1. **Step 2.1:** Harmonize CLI Tools (`compile_tokens.dart`, `audit_tokens.dart`, `validate_specs.dart`) with ThemePilot's `specs/tokens/tokens.yaml`.
2. **Step 2.2:** Build the Strongly-Typed Token Model & W3C DTCG YAML Parser.
3. **Step 2.3:** Implement the 4 Platform Emitters with Unit & Golden Tests (Flutter, Tailwind, SwiftUI, Compose).
4. **Step 2.4:** Build the Transpiler Engine Orchestrator and verify $<850\text{ms}$ latency SLO.
