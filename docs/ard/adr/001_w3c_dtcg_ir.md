# Architecture Decision Record (ADR)
## ADR-001: Adoption of W3C DTCG Format for Token Intermediate Representation (IR)

| Metadata | Value |
| :--- | :--- |
| **Status** | `Accepted` |
| **Date** | October 2026 |
| **Decision Makers** | Senior Software & AI-SDLC Architect |
| **Consulted** | Multi-Platform Core Engineering Team |

---

## Context and Problem Statement

ThemePilot must ingest design tokens from heterogeneous design tools (Google Stitch, Figma, custom design JSONs) and compile them into four distinct native programming environments (Flutter, Tailwind CSS, SwiftUI, Jetpack Compose). 

Directly translating each source format into each target format creates an $M \times N$ matrix complexity. Furthermore, proprietary design tool formats change frequently, which would force breaking changes onto code emitters.

How should ThemePilot model design tokens internally to guarantee maintainability, extensible emitters, and zero design drift?

---

## Decision Drivers

* **Neutrality:** The format must not be tied to Figma, Google, or Adobe proprietary schemas.
* **Industry Standardization:** High compatibility with emerging tooling and cross-industry consensus.
* **Type-Safety & Semantics:** Capable of explicitly declaring types (`color`, `dimension`, `fontFamily`, `fontWeight`, `shadow`).
* **AI-Readability:** Highly structured, human-readable, and machine-parsable format for LLM agents.

---

## Considered Options

1. **Option 1: Proprietary ThemePilot JSON/Dart Model**
2. **Option 2: Direct Translation (Figma/Stitch AST ➔ Target Code)**
3. **Option 3: W3C Design Tokens Community Group (DTCG) Standard**

---

## Decision Outcome

**Chosen Option:** **Option 3: W3C Design Tokens Community Group (DTCG) Standard**.

ThemePilot normalizes all design tokens into a DTCG-compliant schema using `$value` and `$type` declarations.

### Positive Consequences
* Reduces $M \times N$ translation complexity to $M + N$ (any new ingestion source maps to DTCG; any new target platform reads from DTCG).
* Future-proof compatibility with Figma's native W3C token export and Google Stitch design system representations.
* Clean separation of concerns: Ingestion adapters focus solely on normalizing to DTCG; Emitters focus solely on code generation.

### Negative Consequences / Trade-Offs
* Requires an initial normalization parsing step before code emission.
* W3C DTCG specification is still evolving, requiring ThemePilot to maintain a version-pinned core schema subset.
