# Business Requirements Document (BRD)
## ThemePilot: Universal Multi-Platform Theme Transpiler

| Document Metadata | Value |
| :--- | :--- |
| **Document Version** | `1.0.0` |
| **Status** | `Draft for Review` |
| **Product Name** | ThemePilot |
| **Product Type** | Developer Tool & Design-to-Code Compiler |
| **Primary Domain** | Multi-Platform Design Systems (Flutter, Web, iOS, Android) |
| **Author** | Senior Software & AI-SDLC Architect |
| **Last Updated** | October 2026 |

---

## 1. Executive Summary

**ThemePilot** is a deterministic, AI-native multi-platform theme transpiler designed to eliminate the engineering and design friction of cross-platform design token management. 

By ingesting raw prototype inputs (Google Stitch prototype URLs, Figma design tokens, or industry-standard presets), ThemePilot normalizes design semantics into a **W3C Design Tokens Community Group (DTCG)** intermediate representation and emits production-ready, type-safe theme code across **all 4 major platforms simultaneously in under 850 milliseconds**:
1. **Flutter** (Material 3 `ThemeData` & `ThemeExtension`)
2. **Web / React** (Tailwind CSS v3 & v4 configuration + CSS Custom Properties)
3. **Apple iOS** (SwiftUI `Color` extensions & `Theme` structs)
4. **Android** (Jetpack Compose Material 3 `ColorScheme` composable)

ThemePilot replaces hours of error-prone manual translation, drift debugging, and redundant PRs with a clean, 2-step developer workflow and automated validation gates.

---

## 2. The Business Problem: The "Token Desynchronization Tax"

Modern product organizations operating across mobile, web, and desktop encounter a persistent, compounding operational tax: **Design Token Desynchronization**.

```
Figma / Stitch URL ──> Web Team     ──> tailwind.config.js (Manual Copy-Paste)
                    ──> Flutter Team ──> ThemeData.dart     (Manual Translation)
                    ──> iOS Team     ──> Color Structs      (Manual Edits)
                    ──> Android Team ──> ColorScheme.kt     (Manual Sync)
```

### 2.1 The Symptoms of Token Drift
* **Spatial Incoherence:** Mobile teams implement `16dp` padding while web developers use `14px` or `1.25rem` (20px), breaking cross-platform brand muscle memory.
* **Color Fragmentation:** Slight variations in hex values (`#38BDF8` vs `#3BB0E6`) proliferate across platforms, diluting brand identity.
* **Component Shape Divergence:** Border radiuses vary between sharp containers, gentle rounding, and full pills without unified rules.
* **"Vibe Coding Decay" in AI-Native Teams:** When generative AI coding assistants lack a rigid token compiler, each new session generates arbitrary styling values (`EdgeInsets.all(13)` or `#182A3E`), degrading UI quality within weeks.

### 2.2 Financial & Time Impact
* **Average Time per Design Update:** Engineering teams spend **12–20 developer hours** per multi-platform brand update manually translating hex codes, updating configs, opening 4 separate PRs, and resolving visual regressions.
* **Annual Waste:** For a mid-sized engineering team managing 4 platforms, design token maintenance consumes **$75,000 to $120,000 annually** in lost engineering velocity and redundant QA cycles.

---

## 3. Product Vision & Value Proposition

### 3.1 Core Value Proposition
> **"One design input. Four native production codebases. Zero manual translation. Under 850 milliseconds."**

* **Deterministic Single Source of Truth:** A unified W3C DTCG intermediate token model guarantees identical mathematical spacing, color hierarchy, and shape tokens across all platforms.
* **Radical Simplicity (The 2-Step Architecture):**
  - **Step 1 (Ideation & Ingestion):** Fast URL ingestion with curated presets and compiler status matrix.
  - **Step 2 (Implementation & Workbench):** Dual-pane responsive chassis preview (mobile/desktop) paired with tabbed native code inspection and 1-click **Download All (.ZIP)** export.
* **Developer-Grade Quality:** Emitted code contains zero runtime reflection, zero external vendor SDK dependencies, and adheres strictly to native idioms for each ecosystem.

---

## 4. Target Personas

### Persona 1: The Cross-Platform Lead Architect
* **Role:** Lead Engineer / Principal Architect managing Flutter, Web, iOS, and Android applications.
* **Pain Points:** Burdened by cross-platform PR reviews where colors, paddings, and font weights subtly mismatch. Frustrated by endless design-system sync meetings.
* **Success Criteria with ThemePilot:** Ingest a prototype URL, export verified native theme code, and drop it directly into all 4 platform packages without touching a single color constant.

### Persona 2: The Design Systems Engineer
* **Role:** Design Systems maintainer or frontend platform engineer.
* **Pain Points:** Struggles to keep Figma/Stitch design tokens synchronized with repository code. Lacks automated tooling to audit code against design specs.
* **Success Criteria with ThemePilot:** Automatic generation of W3C DTCG-compliant tokens, accompanied by AST audit tools that prevent hardcoded colors in production.

### Persona 3: The Rapid Prototyper / Founder
* **Role:** Solo builder or startup developer building fast with AI agents.
* **Pain Points:** AI agents generate fragmented styling and inconsistent themes across coding sessions ("Vibe Coding Decay").
* **Success Criteria with ThemePilot:** An instant, rock-solid token foundation that feeds AI coding prompts and eliminates manual CSS/Dart writing from day one.

---

## 5. Scope & Output Deliverables

### 5.1 In-Scope Deliverables (The Multi-Platform Quad)
ThemePilot deterministically emits native production code for the following four targets:

| Target Platform | Native Framework | Output Filepath | Primary Generated Artifacts |
| :--- | :--- | :--- | :--- |
| **1. Flutter** | Material 3 (Dart 3.x) | `packages/theme/lib/src/theme_data.dart` | `ThemePilotTokens`, `ThemeData.dark()`, `ThemeData.light()`, `ThemeExtension` classes |
| **2. Web** | Tailwind CSS (v3 & v4) | `tailwind.config.js` / `theme.css` | Extended color palette, border radiuses, spacing scale, CSS custom properties (`:root`) |
| **3. iOS** | Apple SwiftUI (iOS 17+) | `Sources/Theme/ThemePilotTokens.swift` | `ThemePilotTokens` enum, `Color` extensions, `Theme` environment values |
| **4. Android** | Jetpack Compose (M3) | `com/themepilot/theme/Theme.kt` | `darkColorScheme()`, `lightColorScheme()`, `Typography`, custom design token composition locals |

### 5.2 Out-of-Scope (V1)
* **Arbitrary Full-Page Layout Transpilation:** ThemePilot transpiles **design tokens, component themes, color schemes, and typographic scales**. It does *not* attempt to convert freeform HTML/CSS div layouts into nested Flutter widgets or SwiftUI views.
* **Two-Way Git Push / Cloud Synced Accounts:** ThemePilot V1 prioritizes instant, friction-free local execution and 1-click client-side `.ZIP` downloads over mandatory account logins or third-party OAuth setups.

---

## 6. Key Performance & Operational SLOs

| Metric | Target SLO | Measurement Method |
| :--- | :--- | :--- |
| **End-to-End Transpilation Latency** | $< 850\text{ ms}$ | Time from URL submission/preset selection to full Quad code generation. |
| **Cross-Platform Token Parity** | `100.0%` (0% drift) | Hex values, spatial grid factors (8dp), and corner radii match exactly across all 4 emitters. |
| **Client-Side Autonomy** | `100%` Offline Capable | Transpiler core and ZIP generator can run fully in-browser without server roundtrips. |
| **Code Idiom Adherence** | Zero reflection / Zero 3P lock-in | Emitted code uses standard platform APIs (Flutter `Material3`, SwiftUI `Color`, Compose `Material3`). |
| **Chassis Simulator Responsiveness** | `60 fps` at $\ge 1440\text{px}$ | Smooth viewport toggle between 390px mobile chassis and 1200px desktop canvas. |

---

## 7. Business Success Metrics (KPIs)

1. **Velocity Metric:** Reduce the time required to distribute a new design theme across 4 platforms from **16 engineering hours to under 2 minutes**.
2. **Quality Metric:** Achieve **0 reported visual regression bugs** related to color codes, radius definitions, or spacing divergence in consumer applications using ThemePilot output.
3. **Adoption Metric:** 100% of generated `.ZIP` archives compile cleanly in their respective native toolchains (`flutter analyze`, `swift build`, `./gradlew compileDebugKotlin`, `npx tailwindcss`).

---

## 8. Document Sign-Off & Next Steps

This BRD serves as the governing business contract for ThemePilot V1. Upon review and confirmation, the technical requirements will be formalized in **Step 1.2: Architecture Requirements Document (ARD)**.
