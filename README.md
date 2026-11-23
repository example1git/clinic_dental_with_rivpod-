# 🦷 MySen - Dental Clinic Management System

A cross-platform dental clinic management and appointment booking application built with **Flutter and Dart**.

MySen connects dentists and patients through dedicated workflows for patient management, appointment scheduling, dental treatment records, and payment tracking.

The project focuses on maintainable architecture, efficient state management, and local data persistence.

---

## 📱 Screenshots

## 📱 Screenshots

<p align="center">
  <img src="assets/screenShots/doctorScreen.png" width="300" alt="Doctor Screen">
</p>

<p align="center">
  <img src="assets/screenShots/Doctors.png" width="300" alt="Doctors">
</p>

<p align="center">
  <img src="assets/screenShots/Doctor-Patient.png" width="300" alt="Doctor Patient">
</p>

<p align="center">
  <img src="assets/screenShots/doctorProfile.png" width="300" alt="Doctor Profile">
</p>

<p align="center">
  <img src="assets/screenShots/DentalChart.png" width="300" alt="Dental Chart">
</p>

<p align="center">
  <img src="assets/screenShots/Treatment-Appointment.png" width="300" alt="Treatment Appointment">
</p>

<p align="center">
  <img src="assets/screenShots/Signin-Signup.png" width="300" alt="Sign In and Sign Up">
</p>

<p align="center">
  <img src="assets/screenShots/Theme.png" width="300" alt="Application Themes">
</p>

---

## ✨ Features

### 👨‍⚕️ Doctor Features

- Manage personal patient records.
- Add patients using their phone numbers.
- Search and filter patients.
- Manage doctor-patient relationships.
- Receive, accept, and reject appointment requests.
- Schedule and manage patient appointments.
- View appointments by date.
- Create and manage treatment records.
- Use an interactive dental chart to select treated teeth.
- Add treatment descriptions for individual teeth.
- Track treatment costs, payments, and remaining balances.
- Receive appointment notifications.
- Manage profile information and qualifications.
- Enable or disable booking availability.
- Customize the application with six themes and multilingual support.

### 🧑‍💻 Patient Features

- Browse available doctors.
- View doctor profiles and information.
- Send appointment booking requests.
- Cancel pending booking requests.
- View appointments and treatment history.
- View treated teeth and their treatment descriptions.
- Track treatment information associated with each doctor.

---

## 🔐 Data Privacy & Access Control

- Role-based access for doctors and patients.
- Doctors can access only their own patients' records.
- Patients can access their own information and records associated with their doctors.
- Patient records can be linked to multiple doctors while keeping each doctor's data separate.
- Existing patient records can be linked to a newly registered patient account using the same phone number.

---

## 🏗️ Architecture

The application follows **Clean Architecture** principles to separate responsibilities and improve maintainability, scalability, and testability.

### Architecture Layers

| Layer | Responsibility |
|---|---|
| Presentation | UI, state management, and user interactions |
| Domain | Business logic, entities, repository contracts, and use cases |
| Data | Repository implementations, models, and data sources |
| Remote Data Source | Supabase integration |
| Local Data Source | SQLite local database |

### Data Flow

```mermaid
flowchart TD
    A[Presentation Layer] --> B[Riverpod]
    B --> C[Use Cases]
    C --> D[Repository]
    D --> E[Remote Data Source]
    D --> F[Local Data Source]

    E --> G[Supabase]
    F --> H[SQLite]
```

The repository coordinates data access and handles online/offline data operations.

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform mobile development |
| Dart | Programming language |
| Riverpod | State management and dependency injection |
| Supabase | Backend services |
| PostgreSQL | Relational database |
| SQLite (sqflite) | Local data persistence |
| REST APIs | API communication |
| Git & GitHub | Version control |
| Postman | API testing |

---

## 💾 Data Management

The application uses **Supabase** and **SQLite** to manage remote and local data.

### 👨‍⚕️ Doctor Side

- Reads application data from SQLite.
- On the first launch, if the local database is empty, data is fetched from Supabase and stored locally.
- When online, create, update, and delete operations are performed on Supabase first.
- Local SQLite data is updated after the remote operation succeeds.
- Existing local data is used when the application is reopened.

### 🧑‍💻 Patient Side

- Fetches data from Supabase when an internet connection is available.
- Uses SQLite to access locally stored data when offline.

---

## 🦷 Treatment Management

The treatment management system supports multiple appointments within a treatment case.

Each treatment can include:

- Multiple appointments.
- One or more treated teeth.
- Individual descriptions for each treated tooth.
- Total treatment cost.
- Payments recorded across appointments.
- Automatically calculated remaining balance.

### Remaining Balance Calculation

```text
Remaining Balance = Total Treatment Cost - Total Payments
```

---

## 🔔 Notifications

The application includes appointment reminder notifications to help patients remember their scheduled visits.

---

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

- Flutter SDK
- Dart SDK
- Android Studio or VS Code
- Supabase account

### Installation

**1. Clone the repository**

```bash
git clone YOUR_REPOSITORY_URL
```

**2. Navigate to the project directory**

```bash
cd YOUR_PROJECT_DIRECTORY
```

**3. Install dependencies**

```bash
flutter pub get
```

**4. Configure Supabase**

Configure your Supabase credentials according to the project's configuration.

**5. Run the application**

```bash
flutter run
```

---

## 🔒 Authentication Note

The current phone verification flow is simulated inside the application.

It does not currently send real SMS OTP messages.

---

## 📌 Project Goals

This project was developed to demonstrate practical experience in:

- Building real-world Flutter applications.
- Applying Clean Architecture principles.
- Managing application state with Riverpod.
- Integrating Supabase and PostgreSQL.
- Implementing local data persistence with SQLite.
- Designing online/offline data access.
- Building complex business workflows.
- Managing relational data and user permissions.

---

## 👨‍💻 Developer

**YOUR NAME**

Flutter Developer

- GitHub: YOUR_GITHUB_PROFILE
- LinkedIn: YOUR_LINKEDIN_PROFILE
- Email: YOUR_EMAIL

---