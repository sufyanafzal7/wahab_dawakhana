# 🏥 Wahab Dawakhana (Patient Entry Management App)
A real-time, ultra-fast, cross-platform clinical ledger application that empowers traditional doctors to digitize and manage complex patient records, history cards, and customizable prescription notes seamlessly on Mobile, Web, and Desktop—100% offline, with zero round-trip latency and absolute data privacy.

<br>

## 📋 Table of Contents
* [Problem Statement](#-problem-statement)
* [Solution Overview](#-solution-overview)
* [Key Features](#-key-features)
* [Tech Stack](#-tech-stack)
* [System Architecture](#-system-architecture)
* [Data Models & Serialization Schemas](#-data-models--serialization-schemas)
* [Mobile & Desktop App — Screen by Screen](#-mobile--desktop-app--screen-by-screen)
* [Project Directory Structure](#-project-directory-structure)
* [Prerequisites](#-prerequisites)
* [Getting Started](#-getting-started)
* [Advanced Storage & Platform Setup](#-advanced-storage--platform-setup)
* [Known Limitations](#-known-limitations)
* [Roadmap](#-roadmap)
* [Contributors](#-contributors)

---

## 🧩 Problem Statement
In traditional and semi-urban medical environments across South Asia, many doctors manage patient histories manually using paper registers. While simple, this approach presents several operational challenges:
* **Inability to Search & Track Multi-Year Records:** Retrieving a specific patient's medical history among thousands of handwritten entries takes significant time, slowing down patient care during busy clinic hours.
* **Rigid Clinical Notes:** Fixed digital health systems require doctors to type data into rigid, pre-defined fields. However, real-world clinical notes are unstructured and variable—one patient might require tracking blood pressure and specific lifestyle limitations, while another needs monitoring for allergies or follow-up timelines.
* **Privacy Risks with Cloud Storage:** Storing sensitive, personal health data on public third-party cloud databases can expose medical files to data leaks, system downtime, and compliance risks if internet connectivity is unstable.
* **The Multi-Platform Technical Challenge:** Building a lightweight database app that runs fast on a basic Android smartphone, an iPad, or a Windows desktop computer without using a web-dependent cloud infrastructure requires careful management of offline state serialization.

---

## 💡 Solution Overview
**Wahab Dawakhana** solves these challenges by combining a flexible user interface with a fast, offline-first data model. The application features two core architectural innovations:

### 1. NoSQL Edge Ledger Database
Instead of routing patient information to a remote cloud server, the app stores data directly on the device using an asynchronous, memory-mapped key-value engine (Hive). This design provides:
* **Instant In-Memory Searches:** Search queries scan through local database tables in less than 10 milliseconds.
* **Fully Offline Operation:** Dr. Wahab can access records, update prescriptions, and check historical logs with zero internet availability.
* **Absolute Data Privacy:** Patient information remains securely stored on the local device hardware until explicitly backed up by the doctor.

### 2. Flexible Clinical Schema Design
The data model uses nested structures. Each patient file contains an unlimited number of sequential treatment cards. Inside these cards, doctors can add custom fields dynamically. This lets Dr. Wahab write notes freely on screen, combining the flexibility of a physical paper register with the benefits of digital data management.

---

## ✨ Key Features

### Core Ledger Management
* **Dynamic Patient Timelines:** View, add, update, or remove patient profiles. Each file supports an unlimited history of standalone treatment and prescription cards.
* **Infinite Custom Notes:** Add custom key-value pairs (e.g., `Avoid: cold drinks`, `Blood Pressure: High`, `Visit: after 7 days`) on the fly using a flexible, dynamic field builder.
* **Immutable Timestamps:** The app records the precise creation time of each treatment card directly from the system clock, preventing manual tampering and ensuring accurate clinical timelines.

### User Experience & Filtering
* **Live Query Indexing:** Instantly filter thousands of rows by name or city directly from the top search bar as you type.
* **Multi-Tier Date Filter:** Toggle an expandable inline filter panel to refine patient lists by an exact date (`DD/MM/YYYY`), a single year (`YYYY`), a singular month (`MM`), or a combination of both.
* **Mint Tech Medical UI:** Built with a clean color system (`#00A896`, `#028090`, `#F4F7F6`) that provides a soft, comfortable workspace for long clinical shifts.

### Backup & Portability
* **Dual Local Export Strategies:** Export the entire local database file into structured JSON payloads with two writing options:
  1. *Override Existing File:* Keeps a single up-to-date backup file (`patientData.json`).
  2. *Create New File:* Generates sequential backup snapshots (`patientData1.json`, `patientData2.json`) to keep histories over time.
* **Air-Gapped Cross-Device Sync:** Share or import raw backup text streams natively across devices via standard share sheets and custom file pickers.
* **Google Drive Cloud Sync:** Authenticate securely using Google OAuth 2.0 to back up dataset files directly to a personal Google Drive account.

---

## 🛠 Tech Stack

### Frontend & Application Layer
| Technology | Purpose |
| :--- | :--- |
| **Flutter (Dart v3.x)** | Cross-platform framework generating unified binary apps for Android, iOS, Web, Windows, macOS, and Linux from one codebase. |
| **Provider (v6.1.2)** | Reactive state management that handles the database data stream and updates UI widgets only when records change. |
| **Intl (v0.19.0)** | Localized date parsing and explicit formatting for chronological medical ledgers. |

### Storage & Native Integration Layers
| Technology | Purpose |
| :--- | :--- |
| **Hive Flutter (v1.1.0)** | Fast, lightweight local NoSQL key-value database that stores records securely on the device. |
| **Path Provider (v2.1.3)** | Locates standard, secure data directories across different operating systems. |
| **File Picker (v8.0.0)** | Opens native file dialogs to locate and select backup JSON data sets. |
| **Share Plus (v7.2.1)** | Uses native operating system share sheets to send backup records via messaging apps, email, or local transfers. |

### Backup & Identity Authentications
| Technology | Purpose |
| :--- | :--- |
| **Google Sign-In (v6.2.1)** | Secure user authentication via Google OAuth 2.0. |
| **Googleapis (Drive v3)** | Communicates with the Google Drive API to create files and upload clinical dataset sheets. |

---

## 🏗 System Architecture
The application uses a clean, decoupled design structured into three layers to separate core concerns:

```text
┌─────────────────────────────────────────────────────────────────┐
│                        PRESENTATION LAYER                       │
│                                                                 │
│  MainNavigationHub ──► PeoplePage ──────► PatientDetailPage      │
│         │                  │                      │             │
│         ▼                  ▼                      ▼             │
│   SettingsPage      PatientFormDialog     MedicineCardForm      │
│                                                                 │
│  Widgets: PatientTileCard, MedicineTreatmentCard                │
└──────────────────────────────┬──────────────────────────────────┘
                               │ Reads/Writes States Reactively
┌──────────────────────────────▼──────────────────────────────────┐
│                          DOMAIN LAYER                           │
│                                                                 │
│  • Compound Query Filtering (Name/City Matches)                 │
│  • Real-Time Date Parsing (Exact Date vs. Year/Month Split)     │
│  • In-Memory Dataset Transformations & Type Casting             │
│  • File Path Evaluation & Incremental Filename Generation       │
└──────────────────────────────┬──────────────────────────────────┘
                               │ Serializes Data Streams
┌──────────────────────────────▼──────────────────────────────────┐
│                           DATA LAYER                            │
│                                                                 │
│  Hive Local Box  │  Export/Import Engine  │  Google Drive API   │
│  (NoSQL Engine)  │  (File Picker Core)    │  (OAuth Client)     │
└─────────────────────────────────────────────────────────────────┘
