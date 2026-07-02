<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wahab Dawakhana — Project Documentation</title>
    <style>
        :root {
            --primary: #00A896;
            --secondary: #028090;
            --bg-mist: #F4F7F6;
            --text-slate: #1E293B;
            --muted-text: #64748B;
            --border-color: #E2E8F0;
            --alert-coral: #EF4444;
            --code-bg: #0F172A;
            --code-text: #E2E8F0;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            line-height: 1.7;
            color: var(--text-slate);
            background-color: #FFFFFF;
            margin: 0;
            padding: 0;
        }

        header {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 4rem 2rem;
            text-align: center;
            position: relative;
        }

        header h1 {
            font-size: 2.75rem;
            margin: 0 0 1rem 0;
            font-weight: 800;
            letter-spacing: -0.025em;
        }

        header p {
            font-size: 1.25rem;
            margin: 0 max(2rem, 10%) 0 max(2rem, 10%);
            opacity: 0.9;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }

        .badge-container {
            margin-top: 1.5rem;
            display: flex;
            justify-content: center;
            gap: 0.75rem;
            flex-wrap: wrap;
        }

        .badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 0.35rem 0.75rem;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 600;
            backdrop-filter: blur(4px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 2rem;
        }

        nav.toc {
            background-color: var(--bg-mist);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 3rem;
        }

        nav.toc h2 {
            margin-top: 0;
            font-size: 1.25rem;
            color: var(--secondary);
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 0.5rem;
        }

        nav.toc ul {
            list-style: none;
            padding-left: 0;
            margin: 0;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 0.5rem 1.5rem;
        }

        nav.toc a {
            color: var(--text-slate);
            text-decoration: none;
            font-size: 0.95rem;
            transition: color 0.2s ease;
            display: inline-block;
        }

        nav.toc a:hover {
            color: var(--primary);
            text-decoration: underline;
        }

        section {
            margin-bottom: 4rem;
            scroll-margin-top: 2rem;
        }

        h2 {
            font-size: 1.85rem;
            color: var(--secondary);
            border-bottom: 2px solid var(--bg-mist);
            padding-bottom: 0.5rem;
            margin-top: 2.5rem;
            margin-bottom: 1.25rem;
            font-weight: 700;
            letter-spacing: -0.015em;
        }

        h3 {
            font-size: 1.35rem;
            color: var(--text-slate);
            margin-top: 2rem;
            margin-bottom: 0.75rem;
            font-weight: 600;
        }

        p {
            margin-top: 0;
            margin-bottom: 1.25rem;
            text-align: justify;
        }

        ul, ol {
            margin-top: 0;
            margin-bottom: 1.5rem;
            padding-left: 1.75rem;
        }

        li {
            margin-bottom: 0.5rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 1.5rem 0;
            font-size: 0.95rem;
        }

        th, td {
            text-align: left;
            padding: 0.75rem 1rem;
            border-bottom: 1px solid var(--border-color);
        }

        th {
            background-color: var(--bg-mist);
            color: var(--text-slate);
            font-weight: 600;
        }

        tr:hover {
            background-color: rgba(244, 247, 246, 0.5);
        }

        pre {
            background-color: var(--code-bg);
            color: var(--code-text);
            padding: 1.25rem;
            border-radius: 10px;
            overflow-x: auto;
            font-family: "Fira Code", Consolas, Monaco, "Andale Mono", "Ubuntu Mono", monospace;
            font-size: 0.9rem;
            margin: 1.5rem 0;
            border: 1px solid #1E293B;
        }

        code {
            font-family: "Fira Code", Consolas, Monaco, monospace;
            font-size: 0.9em;
            background-color: var(--bg-mist);
            padding: 0.2rem 0.4rem;
            border-radius: 4px;
            color: #D63384;
        }

        pre code {
            background-color: transparent;
            padding: 0;
            border-radius: 0;
            color: inherit;
        }

        blockquote {
            margin: 1.5rem 0;
            padding: 0.75rem 1.25rem;
            border-left: 4px solid var(--primary);
            background-color: var(--bg-mist);
            border-radius: 0 8px 8px 0;
            font-style: italic;
        }

        blockquote p {
            margin: 0;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin: 1.5rem 0;
        }

        .card {
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 1.5rem;
            background-color: #FFFFFF;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            border-color: var(--primary);
        }

        .card h4 {
            margin-top: 0;
            margin-bottom: 0.5rem;
            color: var(--secondary);
            font-size: 1.1rem;
        }

        .footer {
            text-align: center;
            padding: 3rem 2rem;
            background-color: var(--bg-mist);
            color: var(--muted-text);
            font-size: 0.9rem;
            border-top: 1px solid var(--border-color);
            margin-top: 5rem;
        }

        .latex-block {
            display: flex;
            justify-content: center;
            margin: 1.5rem 0;
            padding: 1rem;
            background-color: var(--bg-mist);
            border-radius: 8px;
            font-style: italic;
        }

        @media (max-width: 768px) {
            header h1 { font-size: 2rem; }
            nav.toc ul { grid-template-columns: 1fr; }
            .grid { grid-template-columns: 1fr; }
        }
    </style>
    <!-- Polyfill or library for math block styles inside vanilla elements -->
    <script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
    <script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
</head>
<body>

    <header>
        <h1>🏥 Wahab Dawakhana</h1>
        <p>A production-ready, lightning-fast, local-first multi-platform medical ledger system designed to transform physical paper health registers into a cross-device digital experience.</p>
        <div class="badge-container">
            <span class="badge">Flutter 3.x Natively Compatible</span>
            <span class="badge">Dart Null-Safety Strict</span>
            <span class="badge">Local NoSQL Hive Storage</span>
            <span class="badge">Cross-Platform (Mobile / Web / Desktop)</span>
        </div>
    </header>

    <div class="container">
        
        <nav class="toc">
            <h2>📋 Table of Contents</h2>
            <ul>
                <li><a href="#problem-statement">🧩 Problem Statement</a></li>
                <li><a href="#solution-overview">💡 Solution Overview</a></li>
                <li><a href="#key-features">✨ Key Features</a></li>
                <li><a href="#tech-stack">🛠️ Tech Stack Matrix</a></li>
                <li><a href="#system-architecture">🏗️ System Architecture</a></li>
                <li><a href="#data-serialization">🧬 Data Serialization Engines</a></li>
                <li><a href="#screen-by-screen">📱 Screen-by-Screen Breakdown</a></li>
                <li><a href="#firestore-data-model">🔥 Future-Proof Storage Schemas</a></li>
                <li><a href="#directory-structure">📁 Project Directory Structure</a></li>
                <li><a href="#prerequisites">✅ Prerequisites & Toolchains</a></li>
                <li><a href="#getting-started">🚀 Detailed Getting Started Steps</a></li>
                <li><a href="#google-drive-setup">🔑 Google Drive Auth Architecture</a></li>
                <li><a href="#building-apk">📦 Compilation & Deployment Guides</a></li>
                <li><a href="#known-limitations">⚠️ Known Limitations</a></li>
                <li><a href="#roadmap">🗺️ Production Roadmap</a></li>
                <li><a href="#contributors">👥 Engineering Contributors</a></li>
            </ul>
        </nav>

        <section id="problem-statement">
            <h2>🧩 Problem Statement</h2>
            <p>Traditional clinics and holistic medical practices (such as Eastern medicine "Dawakhanas" across South Asia) manage patient logs exclusively in oversized paper registers. This physical baseline poses critical functional liabilities:</p>
            <ul>
                <li><strong>High Physical Retrieval Latency:</strong> Searching for a patient's historical treatment card across months of daily entries takes a substantial amount of time per patient visit, causing operational bottlenecks during high-volume hours.</li>
                <li><strong>Vulnerability to Data Loss:</strong> Physical paper is vulnerable to degradation, water accidents, fire hazards, or complete structural misplacement with no backup copies.</li>
                <li><strong>No Form Validation & Inconsistencies:</strong> Manual records lack error checking, leading to missing crucial variables, unreadable entries, and incomplete follow-up timelines.</li>
                <li><strong>Platform Air-gapping:</strong> Paper registers lock clinical data to a single physical table. A doctor cannot safely refer to patient history while away from the desk without manually snapping photos or transporting delicate ledgers.</li>
            </ul>
        </section>

        <section id="solution-overview">
            <h2>💡 Solution Overview</h2>
            <p><strong>Wahab Dawakhana</strong> replaces paper ledgers with a responsive, multi-platform system tailored for quick medical data entry. It supports Mobile (Android/iOS), Web, and native Desktop operating systems (Windows, macOS, Linux) using a unified codebase. The design framework balances performance and reliability across three core pillars:</p>
            <div class="grid">
                <div class="card">
                    <h4>1. Local-First Offline Autonomy</h4>
                    <p>The app operates fully independent of network availability. By utilizing a zero-latency internal memory NoSQL cluster, data modifications read and write locally instantly, preserving the speed of physical entry fields.</p>
                </div>
                <div class="card">
                    <h4>2. Air-Gapped Medical Privacy</h4>
                    <p>Patient health details remain local on the machine. No background tracking or constant data reporting takes place, ensuring patients' biometric identity and medical variables remain confidential.</p>
                </div>
                <div class="card">
                    <h4>3. Fluid Relational Models</h4>
                    <p>The system uses a nested data model structure. A unique patient record can hold an unlimited number of sequential treatment instances. Each prescription instance natively handles a modular set of custom dynamic variables.</p>
                </div>
            </div>
        </section>

        <section id="key-features">
            <h2>✨ Key Features</h2>
            <h3>Core Data Registry</h3>
            <ul>
                <li><strong>Full Local Patient CRUD Operations:</strong> Instantly add new medical files, open profiles, edit existing address fields, or remove patient entries with cascading database updates.</li>
                <li><strong>Infinite Treatment Ledger Cards:</strong> Each patient file acts as a historical medical record where doctors can log infinite prescriptive cards containing formula identifiers, costs, quantities, and duration.</li>
                <li><strong>Automated Device Clock Timestamps:</strong> To enforce structural tracking and prevent human date-entry errors, the system auto-generates localized date and time configurations on entry creation. This variable is non-editable by operators.</li>
            </ul>

            <h3>Interface & Filtering Optimizations</h3>
            <ul>
                <li><strong>Dynamic Multi-Field Search Execution:</strong> A continuous evaluation search bar tracks layout text modifications, instantly isolating matches against patient name fields or specific municipalities in real time.</li>
                <li><strong>Compound Chronological Filtering Grid:</strong> An expandable drop-down header panel allows complex query evaluations. Doctors can refine lists by a specific calendar day, isolated year values, standalone target months, or combined parameters. Let's express this mathematically:</li>
            </ul>
            <div class="latex-block">
                $$\mathcal{P}_{\text{filtered}} = \{ p \in \mathcal{P} \mid (\text{Query} \subseteq p.\text{name} \lor \text{Query} \subseteq p.\text{city}) \land \text{MatchDate}(p.\text{created}, d, m, y) \}$$
            </div>

            <h3>Data Portability & Administrative Tools</h3>
            <ul>
                <li><strong>Dual-Strategy Data Export Pipeline:</strong> Write backups out into structured <code>.json</code> or <code>.txt</code> configurations via choice buttons: 
                    <ol>
                        <li><em>Override Strategy:</em> Replaces an existing master backup document cleanly with current records.</li>
                        <li><em>Incremental Counter Strategy:</em> Automatically calculates historical path allocations to prevent overwriting (e.g., <code>patientData1.json</code>, <code>patientData2.json</code>).</li>
                    </ol>
                </li>
                <li><strong>Cross-Platform Native Share Sheet Interfacing:</strong> Uses native system file bridges to import or export files directly to system clipboards, attached local drives, or cross-device file transfer nodes.</li>
                <li><strong>Manual Authenticated Cloud Backups:</strong> Incorporates a secure transmission mechanism that logs into a user's Google Drive via OAuth 2.0 to safely upload files to their personal cloud folder.</li>
            </ul>
        </section>

        <section id="tech-stack">
            <h2>🛠️ Tech Stack Matrix</h2>
            <h3>Mobile, Web & Desktop Frontend Execution</h3>
            <table>
                <thead>
                    <tr>
                        <th>Layer / Dependency</th>
                        <th>Target Version Block</th>
                        <th>Architectural Implementation Intent</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>Flutter SDK Framework</strong></td>
                        <td><code>^3.12.0</code> (Or Higher)</td>
                        <td>Compiles cross-platform rendering layouts from a single, unified source.</td>
                    </tr>
                    <tr>
                        <td><strong>Provider Engine</strong></td>
                        <td><code>^6.1.2</code></td>
                        <td>Handles reactive data flow and state management between data layers and views.</td>
                    </tr>
                    <tr>
                        <td><strong>Hive Flutter Wrapper</strong></td>
                        <td><code>^1.1.0</code></td>
                        <td>Fast, local NoSQL database engine that loads data into RAM for near-instant reads.</td>
                    </tr>
                    <tr>
                        <td><strong>Path Provider Utility</strong></td>
                        <td><code>^2.1.3</code></td>
                        <td>Queries native paths across diverse platforms safely (Android sandbox vs Desktop Documents).</td>
                    </tr>
                    <tr>
                        <td><strong>File Picker Core</strong></td>
                        <td><code>^8.0.0</code></td>
                        <td>Provides user interfaces to search, extract, and load backup JSON files into memory.</td>
                    </tr>
                    <tr>
                        <td><strong>Share Plus Library</strong></td>
                        <td><code>^7.2.1</code></td>
                        <td>Triggers native system share sheets on mobile interfaces to export files instantly.</td>
                    </tr>
                    <tr>
                        <td><strong>Intl Support Engine</strong></td>
                        <td><code>^0.19.0</code></td>
                        <td>Handles local calendar formatting logic, date manipulation, and data filters.</td>
                    </tr>
                </tbody>
            </table>

            <h3>Cloud Interface Infrastructure Components</h3>
            <table>
                <thead>
                    <tr>
                        <th>Library Dependency</th>
                        <th>Target Version Block</th>
                        <th>Architectural Implementation Intent</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>Google Sign In Engine</strong></td>
                        <td><code>^6.2.1</code></td>
                        <td>Authenticates user identities securely via OAuth 2.0 inside mobile and desktop layers.</td>
                    </tr>
                    <tr>
                        <td><strong>Google APIs (Drive v3)</strong></td>
                        <td><code>^13.2.0</code></td>
                        <td>Connects to cloud endpoints to stream backup data into Google Drive app directories.</td>
                    </tr>
                </tbody>
            </table>
        </section>

        <section id="system-architecture">
            <h2>🏗️ System Architecture</h2>
            <p>The solution utilizes clean architectural patterns to separate domain models, presentation views, and persistent cloud data service streams:</p>
            <pre>
┌───────────────────────────────────────────────────────────────────────────────┐
│                              PRESENTATION LAYER                               │
│                                                                               │
│   MainNavigationHub  ──►  PeoplePage (Rosters & Filter Pane Overlay Configurations)│
│                                │                                              │
│                                └──► PatientDetailPage (Prescription Viewports) │
│                                                                               │
│   Dialog Components: PatientFormDialog  │  MedicineCardFormDialog             │
└──────────────────────────────────────┬────────────────────────────────────────┘
                                       │ Inherited State Updates
┌──────────────────────────────────────▼────────────────────────────────────────┐
│                                 DOMAIN LAYER                                  │
│                                                                               │
│   • Multi-tier Search String Extraction Matching (Name / Municipal City)      │
│   • Chronological Temporal Set Extraction Filtering Matrix Evaluation         │
│   • Reactive State Mutation Triggers via ChangeNotifier notifyListeners()     │
└──────────────────────────────────────┬────────────────────────────────────────┘
                                       │ Persistent Storage Mapping
┌──────────────────────────────────────▼────────────────────────────────────────┐
│                                  DATA LAYER                                   │
│                                                                               │
│   DatabaseService   ◄──►   Hive Box Storage System Engine (RAM Persistent)    │
│   ExportService     ◄──►   Hardware I/O Streams (.json / .txt Local Paths)   │
│   GDriveService     ◄──►   Google APIs Drive Web Endpoint Gateway Connectors  │
└───────────────────────────────────────────────────────────────────────────────┘
            </pre>
        </section>

        <section id="data-serialization">
            <h2>🧬 Data Serialization Engines</h2>
            <p>Because Hive is configured as a flat key-value string datastore, the application relies on standard serialization patterns. It maps model trees into structured JSON strings without external script generation dependencies, ensuring optimal cross-platform runtime execution:</p>
            <pre><code>// Example of serialized nested Patient profile tracking data architecture block
[
  {
    "id": "1719912860122",
    "name": "Ahmed Khan",
    "city": "Lahore",
    "address": "123 Model Town",
    "createdDate": "2026-05-20T10:30:00.000Z",
    "medicineCards": [
      {
        "id": "1719912895441",
        "medicineName": "Paracetamol 500mg",
        "cost": "200",
        "quantity": "20 tablets",
        "duration": "5 days",
        "dateTime": "2026-05-24T10:30:00.000Z",
        "customFields": [
          { "key": "Avoid", "value": "Cold drinks" },
          { "key": "Visit", "value": "After 7 days" }
        ]
      }
    ]
  }
]</code></pre>
        </section>

        <section id="screen-by-screen">
            <h2>📱 Screen-by-Screen Breakdown</h2>
            <h3>1. Main Navigation Hub (<code>main_navigation_hub.dart</code>)</h3>
            <p>Serves as the structural home screen container. It uses a persistent bottom navigation shell to cache page states inside an <code>IndexedStack</code> widget. This prevents layout redraws and retains search queries when switching between tabs.</p>

            <h3>2. People Roster Interface (<code>people_page.dart</code>)</h3>
            <p>Renders the core search engine and list interface matching the exact layout shown in your <code>wd1.png</code> and <code>wd2.png</code> mockups:</p>
            <ul>
                <li><strong>Search Field Block:</strong> Tracks string changes natively, filtering active patient array objects via real-time sub-string indexing matches.</li>
                <li><strong>Contextual Filter Pane Overlay:</strong> Extends an options tray directly beneath the search bar on click. This panel supports conditional logic, letting users filter patient list visibility by single or compound parameters (e.g., Year only, Month only, or specific date matching).</li>
                <li><strong>Floating Action Input:</strong> A circular entry button that opens the patient initialization dialog globally.</li>
            </ul>

            <h3>3. Patient Medical File Ledger (<code>patient_detail_page.dart</code>)</h3>
            <p>A multi-card prescription feed matching <code>wd3.png</code>. It reads structural detail lookups via unique URL path index pointers:</p>
            <ul>
                <li><strong>Roster Timeline Header:</strong> Displays the patient name, city, and address parameters along with an administrative control utility tray.</li>
                <li><strong>Prescription Cards Roster:</strong> Displays structured cards highlighting exact medicine names, costs, quantities, durations, and auto-generated system timestamps.</li>
                <li><strong>Dynamic Fields Readout:</strong> Loops safely over custom note blocks, rendering them as clean text pairs under the main medication info.</li>
            </ul>

            <h3>4. Dynamic Note Form Engine (<code>medicine_card_form_dialog.dart</code>)</h3>
            <p>Manages the customized entries section. Clicking the add icon (<code>+</code>) adds a new key-value string model object into a local state collection, rendering an instant input row. Clicking the remove icon instantly drops the array element, providing full, customizable control before saving changes to disk.</p>

            <h3>5. Settings Control Center (<code>settings_page.dart</code>)</h3>
            <p>A complete data utility panel matching the design profiles shown in <code>wd4.png</code> and <code>wd5.png</code>:</p>
            <ul>
                <li><strong>Export Option Radio Targets:</strong> Houses selectable radio buttons to choose the local file-saving strategy (Override vs Multi-file Append).</li>
                <li><strong>Action Launch Triggers:</strong> Large touch target action buttons invoke file management utilities, displaying system snackbars on completion.</li>
                <li><strong>Live App Diagnostics:</strong> An informative read-only overview card that shows app parameters, version blocks, and the database's total active patient count.</li>
            </ul>
        </section>

        <section id="firestore-data-model">
            <h2>🔥 Future-Proof Storage Schemas</h2>
            <p>While the initial application runs locally using a fast NoSQL memory engine, the data structures use decoupled entities. This layout allows for seamless scalability if migrated to remote systems like Cloud Firestore in a future update:</p>
            <pre><code>// Strict relational model interface mapping for database migrations
class PatientEntity {
  final String documentId;          // Map Primary Identifier
  final String patientName;         // Query Target Name Variable 
  final String locationCity;        // Filtering Index Parameter
  final String streetAddress;       // Detailed demographic profile info
  final DateTime recordCreation;    // Baseline filter evaluation time token
  final List&lt;PrescriptionCard&gt; logs; // Sequential child ledger records
}</code></pre>
        </section>

        <section id="directory-structure">
            <h2>📁 Project Directory Structure</h2>
            <p>The code uses a clean, feature-first structural layout to simplify file navigation and feature separation:</p>
            <pre>
wahab_dawakhana/
├── android/               # Native Android build configurations
├── ios/                   # Native iOS build parameters
├── macos/                 # Native macOS compilation profiles
├── windows/               # Native Windows system configurations
├── linux/                 # Native Linux desktop packaging paths
├── web/                   # Web application deployment elements
├── pubspec.yaml           # App configuration and dependency registry
└── lib/
    ├── main.dart          # System app loader & Provider initialization
    ├── models/            # Strict JSON model data structural components
    │   ├── custom_field.dart
    │   ├── medicine_card.dart
    │   └── patient.dart
    ├── services/          # Infrastructure operations, cloud pathways, I/O engines
    │   ├── database_service.dart
    │   ├── export_service.dart
    │   └── google_drive_service.dart
    ├── utils/             # Color tokens, styles, and global themes
    │   └── app_theme.dart
    └── views/             # Graphical User Interface layout views
        ├── main_navigation_hub.dart
        ├── people/        # Patient listing & prescription log components
        │   ├── patient_detail_page.dart
        │   ├── people_page.dart
        │   └── widgets/   # Dialogue inputs, forms, and custom listing tiles
        │       ├── medicine_card_form_dialog.dart
        │       ├── medicine_treatment_card.dart
        │       ├── patient_form_dialog.dart
        │       └── patient_tile_card.dart
        └── settings/      # Configuration dashboards and system data diagnostics
            └── settings_page.dart
            </pre>
        </section>

        <section id="prerequisites">
            <h2>✅ Prerequisites & Toolchains</h2>
            <p>To run or modify the application locally, ensure your machine has the following tools installed:</p>
            <ul>
                <li><strong>Flutter SDK Toolchain:</strong> Version <code>3.12.0</code> or newer configured within system paths.</li>
                <li><strong>Dart Development Toolkit:</strong> Version <code>3.0.0</code> or higher with strict Sound Null Safety enforced.</li>
                <li><strong>Native Desktop Compilers:</strong> 
                    <ul>
                        <li>Visual Studio build tools with C++ Desktop options enabled (for native Windows execution configurations).</li>
                        <li>Xcode development tools environment installed (for native macOS application builds).</li>
                    </ul>
                </li>
                <li><strong>Target Device Integration:</strong> Android Studio tools, a running emulator instance, or a connected physical mobile device with USB Debugging enabled.</li>
            </ul>
        </section>

        <section id="getting-started">
            <h2>🚀 Detailed Getting Started Steps</h2>
            <p>Follow this step-by-step installation guide to build and run the development version of the application:</p>
            
            <h3>Step 1: Clone the Application Repository</h3>
            <pre><code>git clone https://github.com/your-repository/wahab_dawakhana.git
cd wahab_dawakhana</code></pre>

            <h3>Step 2: Fetch Specified Package Dependencies</h3>
            <p>Run the Flutter package manager to fetch the dependencies listed in your pubspec configuration:</p>
            <pre><code>flutter pub get</code></pre>

            <h3>Step 3: Analyze Code Health Metrics</h3>
            <p>Run static code analysis to verify that compilation paths, syntax elements, and imports are clean and error-free:</p>
            <pre><code>flutter analyze</code></pre>

            <h3>Step 4: Launch the Cross-Platform Native Target</h3>
            <p>Deploy the application locally to your target environment using the appropriate execution commands:</p>
            <pre><code># Deploy natively onto an active Android / iOS Mobile target environment
flutter run

# Compile and launch natively within the host Windows Desktop framework
flutter run -d windows

# Compile and run natively inside the host macOS Desktop window manager
flutter run -d macos

# Launch as a responsive, sandboxed Web Application inside your local browser
flutter run -d chrome</code></pre>
        </section>

        <section id="google-drive-setup">
            <h2>🔑 Google Drive Auth Architecture</h2>
            <p>The integrated Google Drive synchronization tool uses an app-private storage schema to protect patient data while syncing. It routes backups through a secure authentication flow:</p>
            <ol>
                <li><strong>OAuth Credential Generation:</strong> Access the Google Cloud Developer Console. Create an active project baseline container, enable the <em>Google Drive API (v3)</em>, and generate your platform client identifiers.</li>
                <li><strong>Authentication Token Request:</strong> When a user triggers a backup, the app calls <code>_googleSignIn.signIn()</code>, displaying a native authorization screen requesting permission for the <code>drive.file</code> scope.</li>
                <li><strong>Authenticated Pipeline Creation:</strong> The resulting authentication headers are injected into an isolated network client request wrapper (<code>GoogleDriveHttpClient</code>).</li>
                <li><strong>Streaming File Upload:</strong> The database converts records into a clean byte stream, uploading them directly to the user's remote cloud root directory via <code>driveApi.files.create()</code>.</li>
            </ol>
        </section>

        <section id="building-apk">
            <h2>📦 Compilation & Deployment Guides</h2>
            <p>Follow these compilation recipes to package release-ready binaries for production environments:</p>
            
            <h3>Production Android APK Compiling</h3>
            <p>Compiles optimized, shrink-wrapped native bytecode bundles for Android deployment:</p>
            <pre><code>flutter clean
flutter pub get
flutter build apk --release --split-per-abi</code></pre>
            <p>The resulting production APK files will be generated at the following path: <code>build/app/outputs/flutter-apk/app-release.apk</code>.</p>

            <h3>Production Windows Executable Packaging</h3>
            <p>Compiles and links native Win32 C++ target assemblies into a optimized application binary:</p>
            <pre><code>flutter build windows --release</code></pre>
            <p>The compiled asset bundles and executable binaries will be output cleanly to: <code>build/windows/runner/Release/</code>.</p>
        </section>

        <section id="known-limitations">
            <h2>⚠️ Known Limitations</h2>
            <ul>
                <li><strong>Plaintext Storage Baseline:</strong> The application relies on standard Hive local storage. For high-security clinical environments processing sensitive data, we recommend upgrading to encrypted Hive box keys.</li>
                <li><strong>Local Browser Sandbox Constraints:</strong> When running in a Web environment, file export utilities default to web download mechanisms rather than absolute custom disk paths due to standard browser sandboxing security rules.</li>
                <li><strong>Memory Constraints with Scale:</strong> Because Hive maintains the active index registry in memory for fast performance, systems with low available RAM may notice processing lag if the patient database grows to contain tens of thousands of records with multiple rich text notes.</li>
            </ul>
        </section>

        <section id="roadmap">
            <h2>🗺️ Production Roadmap</h2>
            <table>
                <thead>
                    <tr>
                        <th>Development Priority Status</th>
                        <th>Target System Enhancement Feature</th>
                        <th>Implementation Strategy Plan Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong style="color: var(--alert-coral);">🔴 High Priority</strong></td>
                        <td>Advanced AES-256 Box Encryption Insertion</td>
                        <td>Secure all local NoSQL data boxes at rest using encrypted database keys.</td>
                    </tr>
                    <tr>
                        <td><strong style="color: #F59E0B;">🟡 Medium Priority</strong></td>
                        <td>Automated Chronological Cloud Synchronization</td>
                        <td>Add a background worker thread that auto-syncs data backups to Google Drive at set intervals.</td>
                    </tr>
                    <tr>
                        <td><strong style="color: #F59E0B;">🟡 Medium Priority</strong></td>
                        <td>PDF Prescription Compilation Engine</td>
                        <td>Add a one-click button to compile treatment cards into printable PDF prescription layouts.</td>
                    </tr>
                    <tr>
                        <td><strong style="color: #10B981;">🟢 Low Priority</strong></td>
                        <td>Advanced Metric & Clinical Analytics Panel</td>
                        <td>Add data charts to track clinic operations, such as monthly income and patient distribution statistics.</td>
                    </tr>
                </tbody>
            </table>
        </section>

        <section id="contributors">
            <h2>👥 Engineering Contributors</h2>
            <p>This multi-platform system was designed, styled, and built to streamline patient record management for specialized clinics:</p>
            <ul>
                <li><strong>Lead Architecture Developer:</strong> Handled the Flutter architecture setup, local state provider flows, and cross-platform native file interactions.</li>
                <li><strong>UX & Visual Design:</strong> Designed the "Mint Tech Medical" interface theme, search bar interactions, and responsive card layouts.</li>
                <li><strong>Strategic Project Anchor:</strong> Dr. Wahab (Wahab Dawakhana) — Provided field validation requirements and insights into traditional clinical register workflows.</li>
            </ul>
        </section>

    </div>

    <div class="footer">
        <p>Built with ❤️ for accessible medical data management — Breaking operational friction barriers one patient file at a time.</p>
        <p style="font-size: 0.8rem; margin-top: 0.5rem; opacity: 0.7;">Wahab Dawakhana Internal Operations System Portfolio Sheet Documentation — Ver 1.0.0</p>
    </div>

</body>
</html>
