# ThemePilot — CLI Tools & AST Validation Gates

> **Directory:** `tools/`  
> **Governing Spec:** [`docs/TECH_SPEC_FINALIZATION.md`](../docs/TECH_SPEC_FINALIZATION.md)

This directory houses the deterministic CLI tools and AST validation gates that power the Spec-Driven Development (SDD) and Design System as Code (DSaC) pipeline in **ThemePilot**.

---

## 🛠️ Available Tools

### 1. [`compile_tokens.dart`](compile_tokens.dart)
* **Purpose:** Ingests [`specs/tokens/tokens.yaml`](../specs/tokens/tokens.yaml) and compiles production Flutter Material 3 classes into `lib/src/core/theme/`.
* **Usage:**
  ```bash
  dart run tools/compile_tokens.dart
  ```
* **Emitted Targets:**
  * `lib/src/core/theme/app_colors.dart`
  * `lib/src/core/theme/app_spacing.dart`
  * `lib/src/core/theme/app_radius.dart`
  * `lib/src/core/theme/app_theme.dart`

---

### 2. [`audit_tokens.dart`](audit_tokens.dart)
* **Purpose:** Abstract Syntax Tree (AST) scanner for `lib/`. Fails with exit code 1 if hardcoded colors (`Color(0x...)`), `Colors.<color>`, or non-grid padding values are introduced outside of the theme definition.
* **Usage:**
  ```bash
  dart run tools/audit_tokens.dart
  ```
* **CI Integration:** Executed on pull requests to enforce zero design drift.

---

### 3. [`validate_specs.dart`](validate_specs.dart)
* **Purpose:** Validates the Design System as Code specifications in `specs/`. Ensures:
  * Canonical `specs/tokens/tokens.yaml` exists and is formatted correctly.
  * Every component specification strictly implements the mandatory 8-section contract.
  * Every spec file adheres to the $< 200$ line modularity constraint.
* **Usage:**
  ```bash
  dart run tools/validate_specs.dart
  ```
