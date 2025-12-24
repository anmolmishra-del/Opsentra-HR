# opsentra_hr

A secure, scalable HRMS (Human Resource Management System) mobile application developed using Flutter 3.38 (stable) and BLoC (Cubit) architecture.
The app supports employee self-service, attendance tracking, leave management, payroll viewing, and manager approvals.
| Category             | Technology                       |
| -------------------- | -------------------------------- |
| Framework            | Flutter 3.38 (Stable)            |
| Language             | Dart                             |
| State Management     | flutter_bloc (Cubit)             |
| Architecture         | Feature-based Clean Architecture |
| Backend              | FastAPI / Odoo (API based)       |
| Networking           | Dio                              |
| Local Storage        | Hive / SharedPreferences         |
| Dependency Injection | get_it                           |
| UI                   | Material 3                       |
| Assets               | SVG (flutter_svg)                |
| Auth                 | JWT / Session based              |

Basic Folder Structure

lib/
│
├── core/
│   ├── constants/
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
├── features/
│   ├── auth/
│   │   ├── cubit/
│   │   │   ├── auth_cubit.dart
│   │   │   └── auth_state.dart
│   │   │
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── employee_model.dart
│   │   │   │
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   │
│   │   │   └── services/
│   │   │       └── auth_api_service.dart
│   │   │
│   │   └── presentation/
│   │       └── pages/
│   │           └── login_page.dart
│
│   ├── attendance/
│   │   ├── cubit/
│   │   │   ├── attendance_cubit.dart
│   │   │   └── attendance_state.dart
│   │   │
│   │   ├── data/
│   │   │   └── models/
│   │   │       └── attendance_model.dart
│   │   │
│   │   └── presentation/
│   │       └── pages/
│   │           ├── checkin_page.dart
│   │           └── attendance_history_page.dart
│
│   ├── leave/
│   │   ├── cubit/
│   │   │   ├── leave_cubit.dart
│   │   │   └── leave_state.dart
│   │   │
│   │   └── presentation/
│   │       └── pages/
│   │           ├── leave_request_page.dart
│   │           └── leave_status_page.dart
│
│   ├── payroll/
│   │   ├── cubit/
│   │   │   ├── payroll_cubit.dart
│   │   │   └── payroll_state.dart
│   │   │
│   │   └── presentation/
│   │       └── pages/
│   │           └── payslip_page.dart
│
├── routes/
│   └── app_routes.dart
│
├── di/
│   └── injection_container.dart
│
├── app.dart
└── main.dart

