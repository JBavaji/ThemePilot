# Architecture Decision Record (ADR)
## ADR-002: Deterministic AST Code Generation over Reflection or String Templates

| Metadata | Value |
| :--- | :--- |
| **Status** | `Accepted` |
| **Date** | October 2026 |
| **Decision Makers** | Senior Software & AI-SDLC Architect |
| **Consulted** | Multi-Platform Core Engineering Team |

---

## Context and Problem Statement

ThemePilot compiles intermediate design tokens into four distinct programming languages: Dart (Flutter), JavaScript/CSS (Tailwind), Swift (SwiftUI), and Kotlin (Compose).

Typical code generation tools rely on either:
1. Brittle regex string interpolation (`"Color(" + hex + ")"`), which leads to indentation corruption, unescaped syntax errors, and unpredictable formatting.
2. Runtime reflection / dynamic interpreters, which add heavy dependencies, prevent ahead-of-time (AOT) compilation, and degrade performance.

How should ThemePilot generate target codebases deterministically and safely?

---

## Decision Drivers

* **Performance:** Must execute and emit all 4 targets in $<850\text{ms}$.
* **Zero Dependencies:** Emitted code should not require custom ThemePilot runtime libraries in client codebases.
* **Format & Lint Cleanliness:** Emitted code must pass official language linters (`dart analyze`, `swiftlint`, `ktlint`, `eslint`) out of the box.
* **Deterministic Output:** Given the exact same DTCG tokens, the output must be byte-for-byte identical across runs.

---

## Decision Outcome

**Chosen Option:** **Deterministic Typed AST Code Generation**.

Each platform target has a dedicated emitter class (e.g., `FlutterM3Emitter`, `ComposeM3Emitter`) with explicit token mapping rules and standard syntax formatting.

### Positive Consequences
* **Sub-Millisecond Emission:** AST-to-code transforms run entirely in-memory in microseconds per file, easily staying within the $<850\text{ms}$ overall budget.
* **Zero External Dependencies:** Consumer apps drop the emitted files directly into their projects; no ThemePilot runtime SDK is required.
* **Testability:** Emitters can be tested via automated golden-file snapshot testing.

### Negative Consequences / Trade-Offs
* Adding a new platform emitter requires engineering a dedicated language syntax emitter rather than just supplying a template string.
