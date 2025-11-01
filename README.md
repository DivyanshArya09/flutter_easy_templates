## How to Use the Shell Script

This shell script automates common tasks in the Flutter project, such as building, running, cleaning, or testing the app.

### Prerequisites

- macOS
- Flutter installed 

### Steps to Run

1. **Copy the `flutter_template.sh` file to your local machine.**  

2. **Open a terminal and navigate to the folder** where you saved the script:

```bash
cd path/to/folder
```

## Generated Folder Structure

Running the `flutter_template.sh` script will generate the following folder structure inside the `lib/` directory:

## Project Directory Structure

```plaintext
lib/
├── core/         # Core utilities, constants, helpers, theme, and shared code across features.
├── features/     # Feature-based modules. Each feature (like auth, profile) gets its own folder with data, domain, and presentation layers.
├── generated/    # Auto-generated files, usually from code generation (like localization, JSON serialization, etc.).
├── injection/    # Dependency injection setup (e.g., using get_it or injectable).
├── l10n/         # Localization files (arb/json files for multi-language support).
├── router/       # App routing/navigation setup.
└── main.dart     # Entry point of the Flutter application.
```

## Now let's go through each file and folder in core folder and understand it 

```plaintext
core/
├── client/        # API client layer (HTTP/Dio setup, interceptors, etc.)
├── constants/     # Static values (API endpoints, sizes, strings)
├── database/      # Local database (SQLite, Hive, Drift, DAOs, models)
├── errors/        # Error & exception handling (custom errors, failures)
├── localization/  # App translations & internationalization (i18n/l10n)
├── managers/      # Managers for system-wide tasks (permissions, app state)
├── network/       # Network utilities (connectivity checks, API responses)
├── themes/        # App design system (themes, colors)
└── utils/         # Generic helpers & extensions (validators, formatters, etc.)
```

## API Client (`CustomHttpClient`) ( Core/client/api_client.dart )

The `CustomHttpClient` is a wrapper around [Dio](https://pub.dev/packages/dio) that provides HTTP methods and centralized error handling for the app.  

All requests automatically map any Dio or unknown errors into `AppException` using the `mapException` method.

### Features

- Supports standard HTTP methods: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`.
- Supports multipart/form-data requests with `POST` and `PUT`.
- Centralized error handling via `mapException`.
- Default headers and timeout options configured.

### Usage Example

```dart
final client = CustomHttpClient();

// GET request
final response = await client.get(
  url: '/users',
  queryParams: {'page': 1},
);

// POST request
final response = await client.post(
  url: '/login',
  bodyData: {'email': 'example@mail.com', 'password': '123456'},
);

// Multipart request
final formData = FormData.fromMap({
  'file': await MultipartFile.fromFile('path/to/file.jpg'),
});
final response = await client.createMultipartRequest(
  url: '/upload',
  formData: formData,
  method: MutipartRequestMethodType.post,
);
```

## Now let's understand the constant folder 

## `lib/core/constants/` Folder

The `constants/` folder contains all app-wide constant values that are used throughout the Flutter project.  
Anything that remains constant across the entire app—like API endpoints, static strings, or design tokens—should be placed here.

```plaintext
   lib/core/constants/
├── api_endpoints.dart # All API endpoint URLs used in the app
├── app_strings.dart # App-wide static strings (like button labels, error messages)
└── figma_constants.dart # Design-related constants from Figma (colors, spacing, etc.)
```

## Understand database folder
## `lib/core/database/` Folder

The `database/` folder contains all database-related code for the app, including the database setup and table definitions.  
This folder centralizes database logic to keep it consistent and reusable across the project.

```plaintext
lib/core/database/
├── tables/
│ ├── todo_table.dart # Definition of the "Todo" table and its fields
├── app_database.dart # Main database setup and configuration
```

## Understand error folder
## `lib/core/errors/` Folder

The `errors/` folder contains all custom error handling logic for the app, including:

- Network errors (via Dio)
- Local storage/Drift errors
- General app exceptions and failure mapping  

This ensures **consistent error handling** across Data and Domain layers.

```plaintext
lib/core/errors/
├── drift_error_handler.dart # Handles Drift (local database) exceptions and maps them to user-friendly messages
├── error_mapper.dart # Maps Dio, Socket, File, and other errors into AppException
├── exceptions.dart # Defines custom AppException types
└── failures.dart # Maps AppException to Domain-layer Failures
```

## Understand localization 
## `lib/core/localization/local_config.dart`

The `local_config.dart` file centralizes the **app's localization setup**, including supported locales and localization delegates.

## Understanding Managers 

## `lib/core/managers/` Folder

The `managers/` folder contains utility classes that handle app-wide operations like app initialization, camera access, permissions, and local storage.  
These classes centralize common functionality to keep your code clean and reusable.

```plaintext
ib/core/managers/
├── app_manager.dart # App initialization and system configurations
├── camera_manager.dart # Camera and gallery image/video picking
├── permission_manager.dart # Handles runtime permissions
└── shared_preferences_manager.dart # Local key-value storage using SharedPreferences
```

### Usage

---

### `app_manager.dart`

Handles **app initialization** and system configurations like device orientation and status bar.  

**Usage:**

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppManager.init(); // Initialize system configurations and dependency injection
  runApp(MyApp());
}
```

---

### `camera_manager.dart`  

**Usage:**

```dart
// Pick a single image from the gallery
File? image = await CameraManager.pickImageFromGallery();
if (image != null) {
  print("Picked image path: ${image.path}");
}

// Pick multiple images from the gallery
List<File>? images = await CameraManager.pickMultipleImagesFromGallery();
if (images != null && images.isNotEmpty) {
  print("Picked ${images.length} images");
}

// Pick a video from camera
File? video = await CameraManager.pickVideoFromCamera();

```
---

### `permission_manager.dart`  

**Usage:**

```dart
// Request camera permission
bool cameraGranted = await AppPermissionManager.requestCameraPermission();
if (cameraGranted) {
  print("Camera permission granted!");
}

// Request location permission
bool locationGranted = await AppPermissionManager.requestLocationPermission();
```

Adding Your Own Managers

You can add custom managers to handle app-wide functionality, such as notifications, analytics, or background tasks.

## Understanding network folder
## `lib/core/network` Folder

### Network

- **`network_info.dart`** – Utility to check network connectivity (online/offline) and manage network-related conditions across the app.  

**Usage Example:**

```dart
bool isConnected = await NetworkInfo.isConnected();
if (isConnected) {
  print("Device is online");
} else {
  print("Device is offline");
}
```
## Understanding Themes folder
## `lib/core/themes` Folder

```plaintext
lib/core/themes/
├── widgets/
│ ├── appbar/ # Theme definitions for AppBar widgets
│ ├── buttons/ # Theme definitions for buttons
│ ├── inputs/ # Theme definitions for input fields and TextFields
│ └── selectables/ # Theme definitions for chips, dropdowns, toggle buttons, etc.
├── checkbox_theme.dart # Checkbox styling
├── radio_theme.dart # Radio button styling
├── switch_theme.dart # Switch styling
├── toggle_buttons_theme.dart # Toggle buttons styling
├── app_theme.dart # Main theme configuration for MaterialApp
└── color_palette.dart # App-wide color definitions
```

#### Key Points

- **`widgets/`** – Contains **theme definitions** (colors, shapes, padding, text styles) for individual widgets.  
  > ⚠️ This folder does **not** contain actual reusable widget components.  
- **`*_theme.dart` files** – Define consistent styling for checkboxes, radios, switches, and toggle buttons.  
- **`app_theme.dart`** – Centralized MaterialApp theme configuration (light/dark themes, typography, etc.).  
- **`color_palette.dart`** – Defines all app colors to maintain a consistent color scheme.  

> 💡 **Key Highlight:** The `.sh` script will ask for the app's **primary color** and automatically configure the theme files (`app_theme.dart`, `color_palette.dart`, and widget themes) based on the selected color.

**Usage Example (MaterialApp):**

```dart
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  home: MyHomePage(),
);
```

## Understanding Utils folder
## `lib/core/utils` Folder

```plantext

lib/core/utils/
├── extensions/
│ ├── date_time.dart # Extensions for DateTime objects (formatting, comparisons)
│ ├── num.dart # Number extensions for spacing, padding, etc.
│ └── text_styles.dart # TextStyle extensions for font weights and colors
├── functions/
│ ├── genric_cache_operation.dart # Generic cache operations (get/set/remove)
│ └── genric_repository_method.dart # Generic repository helper methods
├── helpers/
│ └── scaffold_helper.dart # Helper methods for Scaffold (e.g., showing snackbars)
└── validators/
└── validators.dart # Input validation methods
```


#### Key Points

- **`extensions/`** – Adds useful Dart/Flutter extensions for `num`, `DateTime`, and `TextStyle`.  
- **`functions/`** – Generic utility methods for cache and repository operations.  
- **`helpers/`** – Common helper classes, e.g., for scaffolds and UI helpers.  
- **`validators/`** – Centralized input validation functions for forms or user input.  

---

#### Usage Examples

**1. Using `num.dart` for spacing & padding**

```dart
Column(
  children: [
    16.verticalSpace,  // SizedBox(height: 16)
    Text("Hello World"),
    8.horizontalSpace, // SizedBox(width: 8)
    Container(
      padding: 12.allPadding,        // EdgeInsets.all(12)
      child: Text("Padded Container"),
    ),
  ],
);
```
**2. Using `text_styles.dart` for text styling**

```dart
Text(
  "Hello World",
  style: TextStyles.const16.w600.black,  // Font size 16, weight 600, black color
);

Text(
  "Another Text",
  style: TextStyles.const20.w700,       // Font size 20, weight 700
);

```

### Utils / Generic Methods

The `functions/` folder contains **reusable generic methods** for data fetching, caching, and repository operations. These methods standardize error handling and network checks.

---

#### `genricCacheOperation<T>`

A generic method for **fetching data from cache first, then network**, and caching it afterward.

**Key Points:**

- Checks for cached data first using `getCachedData`.
- Checks internet connection via `NetworkInfo`.
- Fetches fresh data from `getData` if no cache or connection available.
- Caches data using `cacheData` if provided.
- Returns `Either<Failure, T>` for easy error handling.
- Maps any exception to a `Failure` using `mapFailure`.

**Usage Example:  genericCacheOperation<T>**

```dart
Future<Either<Failure, UserModel>> getUserProfile() async {
  return await genericCacheOperation<UserModel>(
    getData: () => apiDataSource.fetchUserProfile(),
    getCachedData: () => localDataSource.getCachedUserProfile(),
    cacheData: (data) => localDataSource.saveUserProfile(data),
  );
}
```
**Usage Example: genricDataSourceMethod<T>**

```dart
Future<ApiResponse<UserModel>> registerUser(RegisterEntity entity) async {
  return await genricDataSourceMethod<ApiResponse<UserModel>>(
    method: () async {
      final response = await _client.post(
        url: ApiEndpoints.register,
        bodyData: entity.toJson(),
      );
      return ApiResponse.fromJson(response.data, (json) => UserModel.fromJson(json));
    },
  );
}

```
**Usage Example: genricDataSourceMethod<T>**

```dart
Future<ApiResponse<UserModel>> registerUser(RegisterEntity entity) async {
  return await genricDataSourceMethod<ApiResponse<UserModel>>(
    method: () async {
      final response = await _client.post(
        url: ApiEndpoints.register,
        bodyData: entity.toJson(),
      );
      return ApiResponse.fromJson(response.data, (json) => UserModel.fromJson(json));
    },
  );
}

```

### `genricCacheOperation<T>`

Fetches data **from cache first, then network**, and caches new data if provided.  
Returns `Either<Failure, T>`.

**Parameters:**

- `getData` – Required function to fetch data from API or source.
- `getCachedData` – Optional function to fetch cached data.
- `cacheData` – Optional function to cache the fetched data.

**Usage Example:**

```dart
Future<Either<Failure, UserModel>> getUserProfile() async {
  return await genericCacheOperation<UserModel>(
    getData: () => apiDataSource.fetchUserProfile(),
    getCachedData: () => localDataSource.getCachedUserProfile(),
    cacheData: (data) => localDataSource.saveUserProfile(data),
  );
}
```
## Core folder ends here 
---

## Localization Setup

This project uses **Flutter Intl** for localization. All localized strings are managed under the `lib/intl` folder.

---

### Folder Structure

```text
intl/
├── messages_all.dart          # Auto-generated file that combines all locale messages.
├── messages_en.dart           # Auto-generated file containing English translations.
├── l10n.dart                  # Main localization delegate used in the app.
└── l10n/
    └── intl_en.arb            # Base English translations in ARB format. Add other locales here (e.g., intl_es.arb for Spanish).
```
---

## 2. 🌍 Internationalization (i18n) Setup and Usage

This project uses the `intl` package and the `intl_utils` code generator for localization.

### 2.1. Adding a New Localized String

Follow these steps to add a new text string:

#### **Step 1: Open the `.arb` File**

Open the `.arb` file for your language. For English, this is:

`lib/intl/l10n/intl_en.arb`

#### **Step 2: Add the Key-Value Pair**

Add a new key-value pair for your string.

```json
{
  "welcomeMessage": "Welcome to MyApp",
  "loginButton": "Login",
  "newStringKey": "This is my new localized string"
}
```
## Then run this 

```bash
flutter pub run intl_utils:generate
```
**Usage Example:**

```dart
Text(S.of(context).welcomeMessage)
```

## Dependency Injection (`injection_container.dart`)

This project uses **GetIt** as the service locator for dependency injection.  
It helps manage the creation and lifecycle of objects, making your code modular and testable.

---

### `sl` – Service Locator

```dart
final sl = GetIt.instance;
void general() {
  // Network register (if you have API clients)
  
  // Local storage
  sl.registerFactory(() => AppDatabase());
}

```
## Types of Registrations in GetIt
```plaintext
| Method                             | Description                                                              | Use Case Examples                                      |
| ---------------------------------- | ------------------------------------------------------------------------ | ------------------------------------------------------ |
| `registerFactory(() => T())`       | Creates a **new instance** every time you call `sl.get<T>()`.            | Stateless services, helpers, temporary objects         |
| `registerLazySingleton(() => T())` | Creates an instance **only when first requested** and reuses it.         | API clients, network managers, shared repositories     |
| `registerSingleton(T())`           | Creates the instance **immediately** and always returns the same object. | Database instance, global configuration, theme manager |
```


### Global Widgets Rules
This folder contains globally reusable widgets.
All widgets that are meant to be used across the app should start with Common prefix to indicate they are shared/common widgets.

```plaintext
lib/widgets/
├── common_button.dart
├── common_text_field.dart
├── common_app_bar.dart
└── common_chip.dart
```
**Usage Example:**

```dart
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const CommonButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(backgroundColor: color ?? Colors.blue),
      child: Text(title),
    );
  }
}

```

## Navigation

App Navigator
=============

# App Navigator

`app_navigator.dart` manages navigation and page transitions centrally in the app.

## Key Features

- Supports multiple transition types:
  - `fade`
  - `slide`
  - `scale`
  - `rotation`
  - Custom transitions
- Provides utility methods for navigation:
  - `pushTo` – Navigate to a new screen
  - `pop` – Go back to the previous screen
  - `popTo` – Navigate to a specific route
  - `popUntilFirst` – Pop until the first route in the stack
  - `pushReplace` – Replace the current route
  - `pushAndRemoveUntil` – Push a new route and clear previous routes
- Handles route arguments safely
- `kNavigatorKey` allows **global navigation** without `BuildContext`

## Usage Examples

### Navigate to Login Screen

```dart
AppNavigator.pushTo(
  context,
  AppRoutes.login,
  arguments: {'referrer': 'onboarding'},
  transition: PageTransition.slideFromRight,
);
```








