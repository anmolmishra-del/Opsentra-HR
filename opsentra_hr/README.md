# 🚀 Opsentra HRMS – Flutter Mobile Application

Opsentra HRMS is a **secure, scalable Human Resource Management System (HRMS) mobile application**
built using **Flutter 3.38 (stable)** and **BLoC (Cubit)** architecture.

The application supports employee self-service, attendance tracking, leave management,
payroll viewing, and manager approvals.  
It follows **enterprise-grade clean architecture** with a **feature-based folder structure**.

---

## 📌 Key Features

### 👨‍💼 Employee
- Login & profile management
- Daily check-in / check-out
- Attendance history
- Leave request & status tracking
- Holiday calendar
- Payroll & payslip viewing

### 👩‍💼 Manager / HR
- Team attendance overview
- Leave approval / rejection
- Employee information access

---

## 🛠 Technology Stack

| Category | Technology |
|--------|-----------|
| Framework | Flutter 3.38 (Stable) |
| Language | Dart |
| State Management | flutter_bloc (Cubit) |
| Architecture | Feature-based Clean Architecture |
| Backend | FastAPI / Odoo (API based) |
| Networking | Dio |
| Local Storage | Hive / SharedPreferences |
| Dependency Injection | get_it |
| UI | Material 3 |
| Assets | SVG (flutter_svg) |
| Authentication | JWT / Session based |

---

## 🧠 Architecture Overview

The application follows **Feature-Based Clean Architecture** for scalability and maintainability.

```
UI
 → Cubit (Business Logic)
 → Repository
 → API / Local Storage
```

Each feature is **independent, testable, and scalable**.

---

## 📁 Project Folder Structure

```
lib/
├── core/                      # Shared app-wide code
│   ├── constants/             # Colors, strings, assets, API constants
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   ├── app_assets.dart
│   │   └── api_constants.dart
│   │
│   ├── theme/
│   │   └── app_theme.dart
│   │
│   ├── network/
│   │   ├── api_client.dart
│   │   ├── api_interceptor.dart
│   │   └── api_endpoints.dart
│   │
│   ├── utils/
│   │   ├── date_utils.dart
│   │   ├── validators.dart
│   │   └── helpers.dart
│   │
│   └── widgets/
│       ├── app_button.dart
│       ├── app_textfield.dart
│       ├── empty_state.dart
│       └── loading_widget.dart
│
├── features/                  # Feature-based modules
│   ├── auth/                  # Authentication
│   │   ├── cubit/
│   │   │   ├── auth_cubit.dart
│   │   │   └── auth_state.dart
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── employee_model.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── services/
│   │   │       └── auth_api_service.dart
│   │   └── presentation/
│   │       └── pages/
│   │           └── login_page.dart
│   │
│   ├── attendance/             # Attendance management
│   │   ├── cubit/
│   │   │   ├── attendance_cubit.dart
│   │   │   └── attendance_state.dart
│   │   ├── data/
│   │   │   └── models/
│   │   │       └── attendance_model.dart
│   │   └── presentation/
│   │       └── pages/
│   │           ├── checkin_page.dart
│   │           └── attendance_history_page.dart
│   │
│   ├── leave/                  # Leave management
│   │   ├── cubit/
│   │   │   ├── leave_cubit.dart
│   │   │   └── leave_state.dart
│   │   └── presentation/
│   │       └── pages/
│   │           ├── leave_request_page.dart
│   │           └── leave_status_page.dart
│   │
│   └── payroll/                # Payroll & payslips
│       ├── cubit/
│       │   ├── payroll_cubit.dart
│       │   └── payroll_state.dart
│       └── presentation/
│           └── pages/
│               └── payslip_page.dart
│
├── routes/
│   └── app_routes.dart         # App navigation
│
├── di/
│   └── injection_container.dart # Dependency injection setup
│
├── app.dart                    # Root widget
└── main.dart                   # Application entry point
```

---

## 🔄 State Management

The app uses **Cubit (BLoC)** for predictable and testable state management.

```
UI → Cubit → State → UI
```

Benefits:
- Lightweight and performant
- Clear UI & business logic separation
- Enterprise-friendly

---

## 🔌 Dependency Injection

Dependencies such as Cubits, repositories, and API services are managed using **get_it**,
ensuring loose coupling and easy scalability.

---

## 📦 Assets Management

SVG assets are used to:
- Reduce app size
- Improve UI scaling
- Support multiple resolutions

```
assets/
├── images/
├── icons/
└── svg/
```

---

## 🏁 Getting Started

### Install dependencies
```bash
flutter pub get
```

### Run the app
```bash
flutter run
```

### Build release APK
```bash
flutter build apk --release
```

---

## ✅ Best Practices Followed

- Feature-based clean architecture
- Cubit instead of setState
- Reusable UI components
- API-driven HRMS design
- Scalable and maintainable folder structure
- Enterprise-ready coding standards

---

## 👨‍💻 Maintained By

**Opsentra – HRMS Mobile Team**  
Flutter Application Development

---

## 🔮 Planned Enhancements

- Offline-first attendance
- Push notifications
- Face / geo-based attendance
- ATS & ERP integration
