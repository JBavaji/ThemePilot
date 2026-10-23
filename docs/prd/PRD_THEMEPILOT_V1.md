# Product Requirements Document (PRD)
## ThemePilot: User Experience & Functional Specification

| Document Metadata | Value |
| :--- | :--- |
| **Document Version** | `1.0.0` |
| **Status** | `Draft for Review` |
| **Product Name** | ThemePilot |
| **Target Delivery** | Web (Desktop/Tablet Chrome, Safari, Edge) |
| **Author** | Senior Software & AI-SDLC Architect |
| **Governing Documents** | [`BRD`](../brd/BRD_THEMEPILOT_V1.md) • [`ARD`](../ard/ARD_THEMEPILOT_V1.md) • [`DESIGN.md`](../../DESIGN.md) |
| **Last Updated** | October 2026 |

---

## 1. Product Experience Principles

ThemePilot enforces radical interface discipline to maximize developer velocity:

1. **Zero Cockpit Clutter:** No multi-level menus, redundant action buttons, or confusing configuration wizards. Exactly one obvious next step at every point.
2. **The 2-Step Mental Model:**
   - **Step 1:** Select or paste an input (Ideation & Ingestion).
   - **Step 2:** Inspect, test on the live chassis, and export the code (Implementation & Workbench).
3. **Instant Latency Feedback:** All state transitions and token compilation occur within $<850\text{ms}$ with smooth micro-interactions.

---

## 2. Step 1: Ideation & Ingestion Specification

Step 1 is the landing and ingestion viewport where developers introduce a design source into the transpiler.

```
┌────────────────────────────────────────────────────────────────────────┐
│                        THEMEPILOT HEADER & LOGO                        │
│               Universal Multi-Platform Theme Transpiler                │
├────────────────────────────────────────────────────────────────────────┤
│  [  Paste Google Stitch prototype or Figma URL...          ] [TRANSPILE]│
├────────────────────────────────────────────────────────────────────────┤
│  QUICK PRESETS:                                                        │
│  [⚡ Vertical Feed]  [🔮 Cyberpunk]  [📱 Fintech]  [🏢 Enterprise]      │
├────────────────────────────────────────────────────────────────────────┤
│  ENGINE TARGET MATRIX:                                                 │
│  ┌──────────────┬──────────────┬──────────────┬──────────────┐         │
│  │ Flutter M3   │ Tailwind CSS │ SwiftUI      │ Compose M3   │         │
│  │ AST v3.x     │ v3 & v4      │ iOS 17+      │ M3 Target    │         │
│  └──────────────┴──────────────┴──────────────┴──────────────┘         │
└────────────────────────────────────────────────────────────────────────┘
```

### 2.1 Omni-Input Bar
* **Placeholder Text:** `Paste Google Stitch prototype URL (e.g. stitch.dev/p/92841) or Figma token URL...`
* **Supported URL Patterns:**
  - Stitch Project URL: `https://stitch.dev/p/{projectId}` or `projects/{projectId}`
  - Figma File / Token URL: `https://www.figma.com/file/{fileId}/...` or `https://www.figma.com/design/{fileId}/...`
* **Validation & Error Handling:**
  - If empty or unrecognized: Highlight input border in subtle warning amber with assistive tooltip: *"Please enter a valid Stitch or Figma project URL, or select a preset below."*
* **Submission Trigger:** Enter keypress or clicking the primary **Transpile Theme →** button.

### 2.2 Curated Quick-Start Presets
Four instant-start cards enable zero-latency exploration without requiring external URLs:

| Preset Name | Brand Archetype | Core Colors | Typography | Shape Radii |
| :--- | :--- | :--- | :--- | :--- |
| **⚡ Vertical Feed** | Moody Cinematic Dark | Surface `#131313`, Neon Pink `#FF007A`, Cyan `#00DBE9` | Space Grotesk + Inter | Pill (`9999px`) |
| **🔮 Neon Cyberpunk** | High-Contrast Obsidian | Obsidian `#050811`, Violet `#A855F7`, Cyan `#06B6D4` | JetBrains Mono | Sharp / `4px` |
| **📱 Fintech Minimal** | Trust Corporate Dark | Midnight `#0A1128`, Cobalt `#0052FF`, Emerald `#10B981` | Inter Sans | Subtle (`12px`) |
| **🏢 Enterprise Obsidian** | Architectural Compiler | Obsidian `#070E17`, Aero `#38BDF8`, Iris `#818CF8` | Space Grotesk + Inter | Pill (`9999px`) |

### 2.3 Deterministic Engine Matrix
Below the presets, display an active telemetry matrix showing compiler readiness across all 4 targets:
* Target badges for Flutter M3, Tailwind CSS, SwiftUI, and Jetpack Compose.
* Zero-Drift AST verification checkmark (`DTCG W3C Certified`).

---

## 3. Step 2: Implementation & Live Workbench Specification

Once a URL is submitted or a preset is clicked, the application transitions into Step 2: the Live Workbench.

```
┌────────────────────────────────────────────────────────────────────────┐
│ [← Back to Ingestion]   ⚡ Vertical Feed (Stitch #92841)   [Download .ZIP]│
├──────────────────────────────────┬─────────────────────────────────────┤
│ LEFT PANE: LIVE CHASSIS SIMULATOR│ RIGHT PANE: TABBED CODE INSPECTOR   │
│                                  │                                     │
│ [ [📱 Mobile 390px] [💻 Desktop] ]│ [Flutter M3] [Tailwind] [iOS] [Android]
│                                  │                                     │
│ ┌──────────────────────────────┐ │ File: packages/theme/theme_data.dart│
│ │ 9:41              5G [|||]   │ │ Status: DTCG Zero-Drift Verified    │
│ │                              │ │                                     │
│ │ [ Feature Banner Card ]      │ │ 1 // Generated by ThemePilot        │
│ │                              │ │ 2 import 'package:flutter/...';     │
│ │ Palette Swatches:            │ │ 3 class ThemePilotTokens { ... }    │
│ │ [S1] [S2] [S3] [S4] [S5]     │ │                                     │
│ │                              │ │                                     │
│ │ [ Primary Gradient Stadium ] │ │ [ Copy Code ]                       │
│ └──────────────────────────────┘ │                                     │
└──────────────────────────────────┴─────────────────────────────────────┘
```

### 3.1 Single Source of Truth Top Navigation Bar
* **Left:** `← Back to Ingestion` button (returns smoothly to Step 1 with input state preserved).
* **Center:** Project Title & Source Badge (e.g., `⚡ Vertical Feed • Google Stitch #92841`).
* **Right:** Exactly **one primary action button**: `Download All (.ZIP)` (Electric Aero Blue to Iris Violet gradient pill button).

### 3.2 Dual-Pane Workspace Layout

#### A. Left Pane: Live Chassis Simulator
The left pane renders live components styled with the exact compiled tokens:
* **Viewport Mode Toggle:**
  - **Mobile Mode (Default):** Fixed `390px` width chassis simulating a modern smartphone.
  - **Desktop Canvas Mode:** `1200px` expanded responsive card layout simulating a web application dashboard.
* **Chassis Interactive Components:**
  1. *System Status Bar:* Native clock (`9:41`), cellular icon, and battery indicator.
  2. *Feature Hero Card:* Glassmorphic dark card (`#16283B`) with headline typography and subtle ambient shadow.
  3. *Semantic Palette Swatches:* Row of 5 interactive circular swatches (Scaffold, Surface, Primary Accent, Secondary Gradient, Status Emerald) with copyable hex values on tap/hover.
  4. *Stadium Call-to-Action (CTA):* Full pill button (`9999px`) rendered with primary gradient and high-contrast label.
  5. *Secondary Outline Button:* Glassmorphic container button with hover glow.

#### B. Right Pane: Tabbed Multi-Platform Code Inspector
The right pane provides full code transparency for all 4 targets:
* **Four Platform Tabs:**
  1. `Flutter (M3)`
  2. `Tailwind CSS`
  3. `SwiftUI (iOS 17+)`
  4. `Compose (Android)`
* **Tab Metadata Header:**
  - Exact target filepath (e.g., `packages/theme/lib/src/theme_data.dart`).
  - Zero-drift certification badge (`W3C DTCG • 0% Drift`).
  - Generated line count and size.
* **Code Editor / Viewer:**
  - Dark-mode syntax highlighting with line numbers using monospace font (`JetBrains Mono`).
  - Single primary **Copy Code** button positioned in the top-right of the viewer, providing a 2-second visual confirmation state: `✓ Copied!`.

---

## 4. Client-Side ZIP Export Specification

When the user clicks `Download All (.ZIP)`, a ZIP archive is constructed in-memory and triggered as a browser file download:

* **Filename Format:** `ThemePilot_<Preset_or_ProjectID>_Theme_Bundle.zip`
* **Internal Archive File Structure:**
```
ThemePilot_Theme_Bundle/
├── flutter/
│   └── theme_data.dart            # Flutter M3 ThemeData & ThemeExtension
├── web/
│   ├── tailwind.config.js         # Tailwind v3 & v4 configuration
│   └── theme.css                  # CSS Custom Properties (:root)
├── ios/
│   └── ThemePilotTokens.swift     # SwiftUI Color structs & extensions
├── android/
│   └── Theme.kt                   # Jetpack Compose darkColorScheme
├── tokens/
│   └── tokens.yaml                # W3C DTCG Intermediate Representation
└── README.md                      # Integration instructions for all 4 platforms
```

---

## 5. Functional Error Handling & Edge Cases

| Scenario | Behavior / Fallback |
| :--- | :--- |
| **Malformed or Unreachable URL** | Display inline error banner below omni-input: *"Could not resolve design URL. Falling back to default Enterprise preset."* Keeps the user unblocked. |
| **Missing Specific Token in Ingestion** | Normalizer applies intelligent semantic fallback (e.g., if `surfaceContainer` is missing, derives it by lightening `surface` by 6%). |
| **Browser Offline Mode** | Full UI, preset selection, live chassis preview, code tabs, and ZIP export continue functioning without interruption. |

---

## 6. Document Sign-Off & Next Steps

This PRD establishes the complete functional and UX contract for ThemePilot. Upon review, we will conclude Phase 1 with **Step 1.4: Technical Finalization & Token Schema Specification**.
