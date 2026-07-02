💚 Wahab Dawakhana
A medical-grade, privacy-first, ultra-responsive cross-platform application designed to digitize manual clinic registers into a clean, searchable, and secure offline NoSQL engine. Engineered natively in Flutter for Dr. Wahab to manage patient histories, infinite treatment files, and dynamic clinical note tracking across Mobile (Android/iOS), Web, and Desktop (Windows, macOS, Linux).

<br>

📋 Table of Contents
- Problem Statement
- Solution Overview
- Key Features
- Tech Stack
- System Architecture
- Application Data Pipeline & Logic
- App Screens & Navigation Workflow
- Data Serialization Schema
- Project Directory Structure
- Prerequisites
- Getting Started
- Google Cloud Setup for Drive Sync
- Known Limitations & Core Considerations
- Roadmap
- Contributors

🧩 Problem Statement
Many traditional clinics and independent practitioners continue to manage vital patient consultation files manually using paper registers. This physical approach introduces significant operational challenges:
1. Retrieval Latency: Finding historical entries during a patient's return visit requires searching through hundreds of paper pages, reducing clinic efficiency.
2. Loss of Continuity: Tracking sequential treatments, changes in medication dosages, or past clinical observations across multiple visits is disorganized and error-prone.
3. Rigid Database Schemas: Standard digital health tools force doctors into fixed data entry templates that do not support arbitrary, quick textual updates (such as specific dietary restrictions or distinct vitals tracking).
4. Privacy Compromises: Uploading sensitive medical histories directly to public cloud web servers introduces risks of unauthorized data exposure and relies heavily on continuous internet connectivity.

💡 Solution Overview
Wahab Dawakhana addresses these challenges by replacing manual registers with a modern, air-gapped database solution. It is designed around two key architectural goals:

1. Local Autonomy & Privacy-First Security
The application operates entirely offline. It utilizes a highly optimized embedded NoSQL key-value store (Hive) directly on the host device. Patient records are read and written instantly to local disk storage, eliminating cloud data leaks and ensuring the system is completely functional without internet access.

2. Flexible Clinical Ledgers
The platform features an adaptive, nested layout schema. Each patient profile acts as a continuous medical folder capable of holding infinite, independent treatment cards. Each card automatically logs a hardware-validated timestamp and includes dynamic string fields. This allows Dr. Wahab to add custom notes on the fly, matching the flexibility of handwritten paper logs while gaining the speed of digital retrieval.

✨ Key Features
Patient Registration & Folder Ledger
💬 Continuous Folder Framework: Create, open, update, or remove patient entries seamlessly. 
💊 Infinite Treatment Cards: Group independent consultations under a single patient file. Each card tracks specific formulas, costs, quantities, durations, and auto-generated device timestamps.
✏️ Dynamic "Other Notes" Input: Append infinite text fields inside any entry to record custom indicators (e.g., `Avoid: cold drinks`, `Visit: after 7 days`, `Blood pressure: high`) with on-the-fly field deletion.

Search & Contextual Filtering
🔍 High-Performance Search Bar: Instantly parses the local data cache using string matches across patient names or cities, updating the viewport in real time.
📅 Multi-Tier Dropdown Filter Panel: Expand an inline configuration panel to filter the register directory by an exact date match (`DD/MM/YYYY`), a target year (`YYYY`), a single month (`MM`), or a combined compound calendar timeline (`YYYY` and `MM`).

Data Portability & System Administration
💾 Dual-Strategy Local Exports: Serialize entire data states into local structured JSON/TXT files. The settings dashboard offers two file-writing modes: *Override Existing File* (keeping a clean, singular up-to-date backup) or *Create New File* (generating sequential, numbered files like `patientData1.json`).
📥 Cross-Device Restorations: Read previously exported backup packages into any device, automatically validating schemas before overwriting the active runtime database state.
☁️ Authenticated Google Drive Mirroring: Securely sync your registry file manually to cloud storage using native Google OAuth 2.0 and the Drive API v3.

🛠 Tech Stack
Core Platform Environment
Layer | Technology | Purpose
--- | --- | ---
Cross-Platform SDK | Flutter 3.12+ (Dart ^3.12.0) | Multi-platform native UI compilation from a single codebase
State Architecture | Provider Pattern (^6.1.2) | Reactive, decoupled data propagation and UI update streaming
Local Storage Core | Hive Flutter (^1.1.0) | Embedded, memory-mapped NoSQL performance for sub-millisecond execution
Date / Time Utilities | Intl (^0.19.0) | Secure locale parsing and custom medical history date formatting

Hardware Integration & Native Interoperability
Component | Package | Purpose
--- | --- | ---
Storage Directories | path_provider (^2.1.3) | Resolves secure application storage paths across 6 target operating systems
File System Input | file_picker (^8.0.0) | Natively selects local files for data imports across mobile and desktop environments
System Share Sheet | share_plus (^7.2.1) | Triggers host OS share windows to export files via AirDrop, Bluetooth, or messaging
Cloud Storage Client | googleapis (^13.2.0) | Implements raw REST streaming protocols directly into Google Drive V3 paths
Identity Verification | google_sign_in (^6.2.1) | Manages client-side OAuth 2.0 validation tokens and authentication states

🏗 System Architecture
The application is structured using a clean, decoupled layout layer architecture, dividing presentation code from local and remote data interactions.

┌─────────────────────────────────────────────────────────────────┐
│                       PRESENTATION LAYER                        │
│                                                                 │
│   MainNavigationHub (Bottom Navigation Shell Tab System)       │
│         ├── PeoplePage (Rosters, Live Query Filters)            │
│         │     └── PatientDetailPage (Timeline Treatment Cards)   │
│         └── SettingsPage (Data Export / Import / Sync Panels)   │
│                                                                 │
│   Dialog Components: PatientFormDialog, MedicineCardFormDialog  │
└──────────────────────────────┬──────────────────────────────────┘
                               │
┌──────────────────────────────▼──────────────────────────────────┐
│                         BUSINESS LOGIC                          │
│                                                                 │
│  • Reactive state streaming via ChangeNotifierProvider          │
│  • In-memory global filtering operations                        │
│  • Real-time, conditional query search matching                 │
│  • Dynamic inline custom note key-value appends                 │
└──────────────────────────────┬──────────────────────────────────┘
                               │
┌──────────────────────────────▼──────────────────────────────────┐
│                           DATA LAYER                            │
│                                                                 │
│   DatabaseService   │    ExportService    │  GoogleDriveService │
│  (Hive Storage Box) │ (File System I/O)   │ (OAuth 2.0 / REST)  │
│                     │                     │                     │
│   Local App Disk    │ Native File Pickers │ Google Drive Cloud  │
└─────────────────────────────────────────────────────────────────┘

⚙️ Deterministic Multi-Platform Document Routing
To guarantee zero-configuration execution across diverse target systems, data mapping is simplified by avoiding hard-coded native file extensions or platform-dependent DB drivers. The app treats the underlying database as an atomic string buffer. 

When changes are triggered, data models convert directly to text payloads using strict JSON encoding. This text data is written asynchronously to disk via Hive memory-mapped files. This allows an export generated on an Android phone to be read instantly by a macOS desktop or web browser without data conversion steps.

⚙️ Application Data Pipeline & Logic
Live Compound Filtering Model
The data filtering system is optimized for real-time performance. Instead of making heavy round-trip queries to disk for every keystroke, the app uses an in-memory evaluation logic pattern inside the `build()` lifecycle step of the interface:

```dart
final filteredPatients = db.patients.where((patient) {
  // 1. Text Query String Parsing Evaluation
  final matchesSearch = patient.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      patient.city.toLowerCase().contains(_searchQuery.toLowerCase());
  
  bool matchesDateCondition = true;
  
  // 2. Exact Specific Date Conditional Route Match
  if (_filterDate.isNotEmpty) {
    final formattedPatientDate = DateFormat('dd/MM/yyyy').format(patient.createdDate);
    matchesDateCondition = (formattedPatientDate == _filterDate);
  } else {
    // 3. Fallback to Compound Segmented Chronological Matches (Year and/or Month)
    bool matchesYear = true;
    bool matchesMonth = true;
    if (_filterYear.isNotEmpty) {
      matchesYear = (patient.createdDate.year.toString() == _filterYear);
    }
    if (_filterMonth.isNotEmpty) {
      matchesMonth = (patient.createdDate.month.toString().padLeft(2, '0') == _filterMonth);
    }
    matchesDateCondition = matchesYear && matchesMonth;
  }
  return matchesSearch && matchesDateCondition;
}).toList();
```

File Strategy Implementation (Override vs. Incremental)
When Dr. Wahab runs a data export operation from the Settings dashboard, the `ExportService` executes target logic based on his selected preference:
* Override Strategy: Locates `patientData.json` inside the document directory and overwrites it directly.
* Incremental Strategy: Enters a loop checked by the host system files API to verify existing names:
  ```dart
  int index = 1;
  while (await File("${directory.path}/patientData$index.json").exists()) {
    index++;
  }
  targetFile = File("${directory.path}/patientData$index.json");
  ```
  This creates clean, sequential backup history files (`patientData1.json`, `patientData2.json`) automatically.

📱 App Screens & Navigation Workflow
1. MainNavigationHub (`main_navigation_hub.dart`)
The root scaffolding shell of the layout. It utilizes a persistent bottom navigation bar to switch views cleanly between the active medical case manager (`PeoplePage`) and the data tools section (`SettingsPage`). It uses an `IndexedStack` to preserve active input states and scroll offsets across tab switches.

2. PeoplePage (`people.dart`)
The primary patient interaction dashboard.
* Layout: Features an integrated teal header bar containing a text query search input and an expanding filter toggle button.
* Workflow: Tapping the filter action icon opens an overlay panel containing input fields for specific dates, target months, or years. The list underneath dynamically redraws as input is entered, showing patient previews with clean icon-anchored geographic details.

3. PatientDetailPage (`patient_detail_page.dart`)
The complete medical profile workspace for an individual patient.
* Layout: Displays a vertical, chronological timeline list of all logged consultation records for the active patient.
* Actions: Includes app bar options to modify the patient's basic profile or delete the entire file. A persistent sticky button sits at the bottom to instantly attach a new treatment card.

4. MedicineCardFormDialog (`medicine_card_form_dialog.dart`)
A modal overlay container for configuring prescriptions.
* Dynamic Fields: Includes text fields for standard parameters (Medicine Name, Cost, Quantity, Duration). The custom notes section features a dynamic appender. Tapping the `(+)` icon adds a new key-value text input row to the screen instantly. Tapping the delete icon next to a row removes it from the data payload before saving.

5. SettingsPage (`settings_page.dart`)
The data management control panel.
* Layout: Organized into clean, distinct content sections that contain clear, descriptive card elements matching the interface designs.
* Interactions: Features radio toggles for backup naming preferences, along with explicit action buttons to execute file imports, exports, or log into Google Drive to trigger secure cloud backups.

🔥 Data Serialization Schema
Below is an example of the structured JSON data schema handled by the app's models (`Patient`, `MedicineCard`, `CustomField`). This demonstrates how the database nests infinite treatment histories and dynamic notes into a portable data object:

```json
[
  {
    "id": "1719927000000",
    "name": "Ahmed Khan",
    "city": "Lahore",
    "address": "123 Model Town",
    "createdDate": "2026-05-20T10:30:00.000Z",
    "medicineCards": [
      {
        "id": "1719927540000",
        "medicineName": "Paracetamol 500mg",
        "cost": "200",
        "quantity": "20 tablets",
        "duration": "5 days",
        "dateTime": "2026-05-24T10:30:00.000Z",
        "customFields": [
          {
            "key": "Avoid",
            "value": "Cold drinks"
          },
          {
            "key": "Visit",
            "value": "After 7 days"
          }
        ]
      }
    ]
  }
]
```

📁 Project Directory Structure
```text
wahab_dawakhana/
│
├── lib/
│   ├── main.dart                      # Application initialization & state injection
│   ├── models/                        # Rigid type data transformation structures
│   │   ├── custom_field.dart          # Dynamic Note sub-properties mapping
│   │   ├── medicine_card.dart         # Prescription structure template mappings
│   │   └── patient.dart               # Core nested patient profile system records
│   │
│   ├── services/                      # Systemic business operations & hardware links
│   │   ├── database_service.dart      # Hive storage operations controller
│   │   ├── export_service.dart        # Native device file system input/output managers
│   │   └── google_drive_service.dart  # Google Rest Cloud connection manager
│   │
│   ├── views/                         # Presentation layout user interfaces
│   │   ├── main_navigation_hub.dart   # Navigation base shell layout controller
│   │   │
│   │   ├── people/                    # Patient folder feature group module
│   │   │   ├── people_page.dart       # Primary case dashboard list view UI
│   │   │   ├── patient_detail_page.dart # Patient timeline timeline history manager
│   │   │   └── widgets/               # Functional component interface objects
│   │   │       ├── medicine_card_form_dialog.dart # Custom dynamic fields generator
│   │   │       ├── medicine_treatment_card.dart  # Detailed prescription renderer
│   │   │       ├── patient_form_dialog.dart       # Core profile management overlay
│   │   │       └── patient_tile_card.dart         # Patient roster overview listing card
│   │   │
│   │   └── settings/                  # System data control panel group module
│   │       └── settings_page.dart     # System administration management dashboard
│   │
│   └── utils/
│       └── app_theme.dart             # Color tokens & Light Mode configuration
│
├── pubspec.yaml                       # Application asset and library dependencies
└── README.md                          # Documentation guide
```

✅ Prerequisites
Development Environment & Compilation Toolchains
* Flutter SDK: Version `3.12.0` or higher configured on your machine target.
* Dart SDK: Version `3.0.0` or higher.
* Android Setup: SDK API 21+ with Android Studio toolchains verified.
* Apple Setup: Xcode 14+ (for native iOS and macOS desktop app builds).
* Desktop Configuration: C++ compilers installed via Visual Studio Build Tools (Windows) or Clang utilities (Linux).

🚀 Getting Started
1. System Source Acquisition
```bash
git clone [https://github.com/your-username/wahab_dawakhana.git](https://github.com/your-username/wahab_dawakhana.git)
cd wahab_dawakhana
```

2. Fetch Asset Packages
Retrieve and configure all external libraries declared in the environment file:
```bash
flutter pub get
```

3. Verification Check
Run the Flutter diagnostic tool to confirm all target software toolchains are ready:
```bash
flutter doctor
```

4. Platform Launch Sequences
Execute the app natively on your active device target using the appropriate launch flags:
```bash
# Launch on an attached Mobile Emulator or Physical Device
flutter run

# Compile and launch natively on a Windows Desktop machine
flutter run -d windows

# Compile and launch natively on a macOS Desktop system
flutter run -d macos

# Compile and launch natively on a Linux Desktop environment
flutter run -d linux

# Run as a local responsive Web Application instance
flutter run -d chrome
```

🔥 Google Cloud Setup for Drive Sync
To enable the Google Drive cloud backup feature on your system builds, configure access permissions within the Google Cloud Platform (GCP) Console:

1. Create a Project Profile
* Visit the Google Cloud Console.
* Click the project dropdown and select **New Project**. Name it `Wahab Dawakhana`.

2. Enable API Libraries
* Navigate to **APIs & Services > Library**.
* Search for **Google Drive API** and click **Enable**.

3. Configure the OAuth Consent Screen
* Go to **APIs & Services > OAuth consent screen**.
* Choose **External** and fill out the required application details.
* In the **Scopes** section, add this specific permission scope:
  `.../auth/drive.file` (This grants the app permission to upload, read, and modify files it creates).
* Under **Test users**, add the specific Gmail address Dr. Wahab will use to authenticate inside his clinic.

4. Generate Access Credentials
* Go to **APIs & Services > Credentials** and click **Create Credentials > OAuth client ID**.
* Select your target platform:
  * Android: Provide your unique package name (`com.example.wahab_dawakhana`) along with your local development SHA-1 certificate fingerprint.
  * Desktop / iOS: Generate matching client configuration profiles as needed.
* Download or copy the generated client IDs and add them to your native project configuration files.

⚠️ Known Limitations & Core Considerations
* Web Execution Local Fallback: Web browsers operate within sandboxed storage constraints. Because of this, the `exportLocalFile` function automatically switches to a raw download stream via `Share.share()` on web targets, bypassing direct storage path writing (`path_provider`).
* Google Authentication State: The `google_sign_in` package requires active network access. If Dr. Wahab tries to run a cloud backup while completely offline, the system will catch the connection error gracefully and notify him via an interface snackbar prompt without interrupting local app functions.
* Cross-Device Sizing Fluidity: The app layout is built responsively to adapt to varying screen layouts. On extreme ultra-wide desktop monitors, form dialog fields scale horizontally to preserve usability. It is recommended to use standard window aspect ratios for optimal density.

🗺 Roadmap
Priority | Feature Description | Target Deployment
--- | --- | ---
**High** | Automated Local Auto-Save on Dialog Interruption Points | v1.1.0
**High** | Full Native Print Spooler Integration for Physical Prescription Paper Slips | v1.2.0
**Medium** | Bulk Multi-File Backup Importer with Conflict De-Duplication Logic | v1.4.0
**Medium** | PDF Generation Engine with Professional Clinic Header Overlays | v1.5.0
**Low** | Automatic Background Data Syncing when Connected to Wi-Fi Networks | v2.0.0

👥 Contributors
* **You** — Lead Systems Architect & App Developer (Building the platform for Dr. Wahab).
* **Dr. Wahab** — Primary Clinical Stakeholder & End-User (Providing design input and field validation rules for Wahab Dawakhana).

***

<p align="center">Built with ❤️ for Dr. Wahab — Digitizing Patient Registries with Modern, Secure Mobile Engineering.</p>
