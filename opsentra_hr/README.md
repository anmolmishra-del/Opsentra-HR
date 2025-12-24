OPSENTRA HRMS – FLUTTER MOBILE APPLICATION
=========================================

Opsentra HRMS is a secure, scalable Human Resource Management System (HRMS) mobile application built using Flutter 3.38 (stable) and BLoC (Cubit) architecture.

The application supports employee self-service, attendance tracking, leave management, payroll viewing, and manager approvals.
It follows enterprise-grade clean architecture and a feature-based folder structure.

--------------------------------------------------

KEY FEATURES
------------

Employee Features
- Login and profile management
- Daily check-in and check-out
- Attendance history
- Leave request and leave status tracking
- Holiday calendar
- Payroll and payslip viewing

Manager / HR Features
- Team attendance overview
- Leave approval and rejection
- Employee information access

--------------------------------------------------

TECHNOLOGY STACK
----------------

Framework            : Flutter 3.38 (Stable)
Language             : Dart
State Management     : flutter_bloc (Cubit)
Architecture         : Feature-based Clean Architecture
Backend              : FastAPI / Odoo (API based)
Networking           : Dio
Local Storage        : Hive / SharedPreferences
Dependency Injection : get_it
UI                   : Material 3
Assets               : SVG (flutter_svg)
Authentication       : JWT / Session based

--------------------------------------------------

ARCHITECTURE OVERVIEW
---------------------

UI
→ Cubit (Business Logic)
→ Repository
→ API / Local Storage

--------------------------------------------------

PROJECT FOLDER STRUCTURE
------------------------

lib/
|-- core/
|   |-- constants/
|   |   |-- app_colors.dart
|   |   |-- app_strings.dart
|   |   |-- app_assets.dart
|   |   |-- api_constants.dart
|   |
|   |-- theme/
|   |   |-- app_theme.dart
|   |
|   |-- network/
|   |   |-- api_client.dart
|   |   |-- api_interceptor.dart
|   |   |-- api_endpoints.dart
|   |
|   |-- utils/
|   |   |-- date_utils.dart
|   |   |-- validators.dart
|   |   |-- helpers.dart
|   |
|   |-- widgets/
|       |-- app_button.dart
|       |-- app_textfield.dart
|       |-- empty_state.dart
|       |-- loading_widget.dart
|
|-- features/
|   |-- auth/
|   |   |-- cubit/
|   |   |-- data/
|   |   |-- presentation/
|   |
|   |-- attendance/
|   |   |-- cubit/
|   |   |-- data/
|   |   |-- presentation/
|   |
|   |-- leave/
|   |   |-- cubit/
|   |   |-- presentation/
|   |
|   |-- payroll/
|       |-- cubit/
|       |-- presentation/
|
|-- routes/
|   |-- app_routes.dart
|
|-- di/
|   |-- injection_container.dart
|
|-- app.dart
|-- main.dart

--------------------------------------------------

BEST PRACTICES FOLLOWED
-----------------------

- Feature-based clean architecture
- Cubit instead of setState
- Reusable UI components
- API-driven HRMS design
- Scalable and maintainable folder structure

--------------------------------------------------

MAINTAINED BY
-------------

Opsentra – HRMS Mobile Team
Flutter Application Development
