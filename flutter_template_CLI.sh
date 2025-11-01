#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color
TICK="✅"

# =========================
# Ask for Flutter project name
# =========================
echo -e "${YELLOW}Welcome to Flutter Project Setup Script!${NC}"
read -p "Enter your Flutter project name: " project_name

# =========================
# Create Flutter project
# =========================
echo -e "${YELLOW}Creating Flutter project named '${project_name}'...${NC}"
flutter create "$project_name"
if [ $? -eq 0 ]; then
  echo -e "${GREEN}${TICK} Flutter project '${project_name}' created successfully!${NC}"
else
  echo -e "${RED}✗ Failed to create Flutter project. Exiting.${NC}"
  exit 1
fi

# =========================
# Move into project directory
# =========================
cd "$project_name" || { echo -e "${RED}✗ Could not enter project directory. Exiting.${NC}"; exit 1; }
echo -e "${GREEN}${TICK} Changed directory to '$project_name'${NC}"

# =========================
# Run flutter pub get
# =========================
echo -e "${YELLOW}Running 'flutter pub get' to fetch dependencies...${NC}"
flutter pub get
if [ $? -eq 0 ]; then
  echo -e "${GREEN}${TICK} Dependencies fetched successfully!${NC}"
else
  echo -e "${RED}✗ Failed to fetch dependencies. Exiting.${NC}"
  exit 1
fi

# =========================
# Ask user for architecture choice
# =========================
architecture_choice=""
while true; do
  echo -e "${YELLOW}Which architecture pattern would you like to follow?${NC}"
  echo -e "  1) Clean Architecture with BLoC"
  echo -e "  2) MVVM Architecture with GetX"
  read -p "Please enter your choice [1/2]: " architecture_choice

  if [ "$architecture_choice" == "1" ]; then
    echo -e "${GREEN}${TICK} You have selected Clean Architecture with BLoC.${NC}"
    break
  elif [ "$architecture_choice" == "2" ]; then
    echo -e "${GREEN}${TICK} You have selected MVVM Architecture with GetX.${NC}"
    break
  else
    echo -e "${RED}Invalid choice, please try again.${NC}"
  fi
done

# =========================
# Clean Architecture Setup
# =========================
    if [ "$architecture_choice" == "1" ];
then

# =========================
# Create Core Folders
# =========================

echo -e "${YELLOW}Creating core folders...${NC}"

mkdir -p lib/core/constants
mkdir -p lib/core/themes
mkdir -p lib/core/utils
mkdir -p lib/core/errors
mkdir -p lib/l10n
mkdir -p lib/core/managers

if [ $? -eq 0 ]; then
  echo -e "${GREEN}${TICK} Core folders created successfully!${NC}"
else
  echo -e "${RED}✗ Failed to create core folders.${NC}"
fi


# ==========================
# Constants Setup
# ==========================

echo -e "${YELLOW}Creating AppStrings file...${NC}"

cat <<EOL > lib/core/constants/app_strings.dart
import 'package:$project_name/generated/l10n.dart';
import 'package:$project_name/router/app_navigator.dart';

class AppStrings {
  static S get _s => S.of(kNavigatorKey.currentContext!);
  static String get hello => _s.hello;
  static String get welcome => _s.welcome;
}

EOL

echo -e "${YELLOW}Creating custom Spacers file...${NC}"

cat <<EOL > lib/core/constants/spacers.dart
import 'package:flutter/widgets.dart';

class CustomSpacers {
    // Heights
    static final height4 = SizedBox(height: 4);
    static final height8 = SizedBox(height: 8);
    static final height10 = SizedBox(height: 10);
    static final height12 = SizedBox(height: 12);
    static final height15 = SizedBox(height: 15);
    static final height16 = SizedBox(height: 16);
    static final height20 = SizedBox(height: 20);
    static final height30 = SizedBox(height: 30);
    static final height24 = SizedBox(height: 24);
    static final height28 = SizedBox(height: 28);
    static final height32 = SizedBox(height: 32);
    static final height36 = SizedBox(height: 36);
    static final height40 = SizedBox(height: 40);
    static final height44 = SizedBox(height: 44);
    static final height48 = SizedBox(height: 48);
    static final height52 = SizedBox(height: 52);
    static final height56 = SizedBox(height: 56);
    static final height60 = SizedBox(height: 60);
    static final height6 = SizedBox(height: 6);
    static final height17 = SizedBox(height: 17);
    static final height64 = SizedBox(height: 64);
    static final height68 = SizedBox(height: 68);
    static final height72 = SizedBox(height: 72);
    static final height80 = SizedBox(height: 80);
    static final height88 = SizedBox(height: 88);
    static final height96 = SizedBox(height: 96);
    static final height100 = SizedBox(height: 100);
    static final height112 = SizedBox(height: 112);
    static final height120 = SizedBox(height: 120);
    static final height140 = SizedBox(height: 140);
    static final height160 = SizedBox(height: 160);
    static final height360 = SizedBox(height: 360);

    // Widths
    static final width4 = SizedBox(width: 4);
    static final width6 = SizedBox(width: 6);
    static final width8 = SizedBox(width: 8);
    static final width10 = SizedBox(width: 10);
    static final width12 = SizedBox(width: 12);
    static final width16 = SizedBox(width: 16);
    static final width20 = SizedBox(width: 20);
    static final width25 = SizedBox(width: 25);
    static final width24 = SizedBox(width: 24);
    static final width28 = SizedBox(width: 28);
    static final width32 = SizedBox(width: 32);
    static final width36 = SizedBox(width: 36);
    static final width40 = SizedBox(width: 40);
    static final width44 = SizedBox(width: 44);
    static final width48 = SizedBox(width: 48);
    static final width52 = SizedBox(width: 52);
    static final width56 = SizedBox(width: 56);
    static final width60 = SizedBox(width: 60);
    static final width64 = SizedBox(width: 64);
    static final width68 = SizedBox(width: 68);
    static final width72 = SizedBox(width: 72);
    static final width80 = SizedBox(width: 80);
    static final width88 = SizedBox(width: 88);
    static final width96 = SizedBox(width: 96);
    static final width100 = SizedBox(width: 100);
    static final width112 = SizedBox(width: 112);
    static final width120 = SizedBox(width: 120);
}
EOL

if [ $? -eq 0 ]; then
  echo -e "${GREEN}${TICK} Created custom Spacers successfully!${NC}"
else
  echo -e "${RED}✗ Failed to create custom Spacers.${NC}"
fi

echo -e "${YELLOW}Creating Figma constants file...${NC}"

cat <<EOL > lib/core/constants/figma_constants.dart
/// Holds constant values based on Figma design specifications.
///
/// This includes design dimensions, default padding, and border radius
/// used throughout the app for consistent UI.
class FigmaConstants {
    /// The width used in Figma designs.
    static const double figmaWidth = 375.0;

    /// The height used in Figma designs.
    static const double figmaHeight = 812.0;

    /// Default horizontal padding based on Figma design.
    static const double paddingHorizontal = 20.0;

    /// Default vertical padding based on Figma design.
    static const double paddingVertical = 20.0;

    /// Default border radius used in Figma design.
    static const double borderRadius = 10.0;
}


EOL

if [ $? -eq 0 ]; then
  echo -e "${GREEN}${TICK} Created Figma constants successfully!${NC}"
else
  echo -e "${RED}✗ Failed to create Figma constants.${NC}"
fi


# ==========================
# Theme Setup
# ==========================

echo "creating app themes"

mkdir -p lib/core/themes/widgets/appbar
mkdir -p lib/core/themes/widgets/buttons
mkdir -p lib/core/themes/widgets/inputs
mkdir -p lib/core/themes/widgets/selectables

echo -e "${YELLOW}Let's set up your app's color palette.${NC}"
echo -e "${YELLOW}Enter your app's primary color in ARGB hexadecimal format.${NC}"
echo -e "${YELLOW}Example: 0xFF1E88E5 (opaque blue)${NC}"

# Prompt user for primary color, keep it user-friendly and validate basic input format
while true; do
  read -p "Primary color (format: 0xAARRGGBB): " primary_color
  if [[ "$primary_color" =~ ^0x[0-9a-fA-F]{8}$ ]]; then
    echo -e "${GREEN}${TICK} Valid primary color received: $primary_color${NC}"
    break
  else
    echo -e "${RED}❌ Invalid format! Please enter color in ARGB hex format like 0xFF1E88E5.${NC}"
  fi
done

echo -e "${YELLOW}Generating color_palette.dart with your primary color...${NC}"

cat <<EOL > lib/core/themes/color_palette.dart
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

class ColorPalette {
  // Light Theme colors goes under
  static const Color primaryColor = Color(0xFF000000); // Black
  static const Color secondaryColor = Color(0xFFFFFFFF); // White
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFFC4C4C4);
  static const Color red = Color(0xFFEB5757);

  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFD32F2F);
  static const Color info = Color(0xFF2196F3);
  static const Color warning = Color(0xFFFFC107);

  // Dark Theme colors goes under
  //  Eg : ColorPalette.darkPrimaryColor
}


EOL

if [ $? -eq 0 ]; then
  echo -e "${GREEN}${TICK} color_palette.dart created successfully!${NC}"
else
  echo -e "${RED}❌ Failed to create color_palette.dart${NC}"
fi



echo -e "${YELLOW}Creating AppBar theme file...${NC}"

cat <<EOL > lib/core/themes/widgets/appbar/app_bar_theme.dart
import 'package:flutter/material.dart';
import 'package:$project_name/core/themes/color_palette.dart';

class CustomAppBarTheme {
  static const AppBarTheme lightTheme = AppBarTheme(
    backgroundColor: ColorPalette.white,
    centerTitle: true,
    // You can customize other properties here, e.g. elevation, iconTheme, titleTextStyle
  );

  // TODO: Add dark theme configuration here
}
EOL

if [ $? -eq 0 ]; then
  echo -e "${GREEN}${TICK} AppBar theme created successfully!${NC}"
else
  echo -e "${RED}❌ Failed to create AppBar theme.${NC}"
fi

echo -e "${YELLOW}Creating ElevatedButton theme file...${NC}"

cat <<EOL > lib/core/themes/widgets/buttons/elevated_button_theme.dart
import 'package:flutter/material.dart';
import 'package:$project_name/core/themes/color_palette.dart';

class CustomElevatedButtonTheme {
  static ElevatedButtonThemeData get lightTheme => const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(ColorPalette.primaryColor),
      foregroundColor: MaterialStatePropertyAll(ColorPalette.white),
      textStyle: MaterialStatePropertyAll(
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      padding: MaterialStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
  );

  // TODO: Add dark theme if needed
}
EOL

if [ $? -eq 0 ]; then
  echo -e "${GREEN}${TICK} ElevatedButton theme created successfully!${NC}"
else
  echo -e "${RED}❌ Failed to create ElevatedButton theme.${NC}"
fi


echo -e "${YELLOW}Creating FloatingActionButton theme file...${NC}"

cat <<EOL > lib/core/themes/widgets/buttons/fab_button_theme.dart
import 'package:flutter/material.dart';
import 'package:$project_name/core/themes/color_palette.dart';

class CustomFabButtonTheme {
  static final FloatingActionButtonThemeData lightTheme = FloatingActionButtonThemeData(
    backgroundColor: ColorPalette.primaryColor,
    foregroundColor: ColorPalette.white,
    elevation: 4,
  );

  // TODO: Add dark theme, if needed
}
EOL

if [ $? -eq 0 ]; then
  echo -e "${GREEN}${TICK} FloatingActionButton theme created successfully!${NC}"
else
  echo -e "${RED}❌ Failed to create FloatingActionButton theme.${NC}"
fi


echo -e "${YELLOW}Creating IconButton theme file...${NC}"

cat <<EOL > lib/core/themes/widgets/buttons/icon_button_theme.dart
import 'package:flutter/material.dart';
import 'package:$project_name/core/themes/color_palette.dart';

class CustomIconButtonTheme {
  static IconButtonThemeData get lightTheme => IconButtonThemeData(
    style: IconButton.styleFrom(
      iconSize: 24,
      foregroundColor: ColorPalette.primaryColor,
      padding: const EdgeInsets.all(8),
    ),
  );

  // TODO: Add dark theme, if needed
}
EOL

if [ $? -eq 0 ]; then
  echo -e "${GREEN}${TICK} IconButton theme created successfully!${NC}"
else
  echo -e "${RED}❌ Failed to create IconButton theme.${NC}"
fi

echo -e "${YELLOW}Creating OutlinedButton theme file...${NC}"

cat <<EOL > lib/core/themes/widgets/buttons/outlined_button_theme.dart
import 'package:flutter/material.dart';
import 'package:$project_name/core/themes/color_palette.dart';

class CustomOutlinedButtonTheme {
  static final OutlinedButtonThemeData lightTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ColorPalette.primaryColor,
      side: const BorderSide(color: ColorPalette.primaryColor),
      textStyle: const TextStyle(fontSize: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  // TODO: Add dark theme if needed
}
EOL

if [ $? -eq 0 ]; then
  echo -e "${GREEN}${TICK} OutlinedButton theme created successfully!${NC}"
else
  echo -e "${RED}❌ Failed to create OutlinedButton theme.${NC}"
fi


echo -e "${YELLOW}Creating InputTheme file...${NC}"

cat <<EOL > lib/core/themes/widgets/inputs/input_theme.dart
import 'package:flutter/material.dart';
import 'package:$project_name/core/themes/color_palette.dart';

/// Centralized input field theme for the app
class CustomInputTheme {
  /// Default InputDecoration for TextFields
  static InputDecorationTheme lightTheme = InputDecorationTheme(
    filled: true,
    fillColor: ColorPalette.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: ColorPalette.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: ColorPalette.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: ColorPalette.primaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: ColorPalette.red),
    ),
  );

  // TODO: add dark theme, if needed
}
EOL

if [ $? -eq 0 ]; then
  echo -e "${GREEN}${TICK} InputTheme created successfully!${NC}"
else
  echo -e "${RED}❌ Failed to create InputTheme.${NC}"
fi


# =========================
# Creating selectable widget themes
# =========================

echo -e "${YELLOW}Creating Checkbox theme...${NC}"

cat <<EOL > lib/core/themes/widgets/checkbox_theme.dart
import 'package:flutter/material.dart';
import 'package:$project_name/core/themes/color_palette.dart';

class CustomCheckboxTheme {
  static final CheckboxThemeData lightTheme = CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith(
      (states) => states.contains(MaterialState.selected)
          ? ColorPalette.primaryColor
          : ColorPalette.white,
    ),
    checkColor: MaterialStateProperty.all(ColorPalette.white),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  );

  // TODO: add dark theme, if needed
}
EOL

if [ $? -eq 0 ]; then
  echo -e "${GREEN}${TICK} Checkbox theme created successfully!${NC}"
else
  echo -e "${RED}❌ Failed to create Checkbox theme.${NC}"
fi

echo -e "${YELLOW}Creating Radio theme...${NC}"

cat <<EOL > lib/core/themes/widgets/radio_theme.dart
import 'package:flutter/material.dart';
import 'package:$project_name/core/themes/color_palette.dart';

class CustomRadioTheme {
  static final RadioThemeData theme = RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith(
      (states) => states.contains(MaterialState.selected)
          ? ColorPalette.primaryColor
          : ColorPalette.white,
    ),
  );

  // TODO: add dark theme, if needed
}
EOL

if [ $? -eq 0 ]; then
  echo -e "${GREEN}${TICK} Radio theme created successfully!${NC}"
else
  echo -e "${RED}❌ Failed to create Radio theme.${NC}"
fi

echo -e "${YELLOW}Creating Switch theme...${NC}"

cat <<EOL > lib/core/themes/widgets/switch_theme.dart
import 'package:flutter/material.dart';
import 'package:$project_name/core/themes/color_palette.dart';

class CustomSwitchTheme {
  static final SwitchThemeData lightTheme = SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith(
      (states) => states.contains(MaterialState.selected)
          ? ColorPalette.primaryColor
          : ColorPalette.white,
    ),
    trackColor: MaterialStateProperty.resolveWith(
      (states) => states.contains(MaterialState.selected)
          ? ColorPalette.primaryColor.withOpacity(0.5)
          : ColorPalette.grey.withOpacity(0.5),
    ),
  );

  // TODO: add dark theme, if needed
}
EOL

if [ $? -eq 0 ]; then
  echo -e "${GREEN}${TICK} Switch theme created successfully!${NC}"
else
  echo -e "${RED}❌ Failed to create Switch theme.${NC}"
fi

echo -e "${YELLOW}Creating ToggleButtons theme...${NC}"

cat <<EOL > lib/core/themes/widgets/toggle_buttons_theme.dart
import 'package:flutter/material.dart';
import 'package:$project_name/core/themes/color_palette.dart';

class CustomToggleButtonsTheme {
  static final ToggleButtonsThemeData lightTheme = ToggleButtonsThemeData(
    fillColor: ColorPalette.primaryColor.withOpacity(0.1),
    selectedColor: ColorPalette.primaryColor,
    color: ColorPalette.grey,
    borderRadius: BorderRadius.circular(8),
    borderColor: ColorPalette.grey,
    selectedBorderColor: ColorPalette.primaryColor,
  );

  // TODO: add dark theme, if needed
}
EOL

if [ $? -eq 0 ]; then
  echo -e "${GREEN}${TICK} ToggleButtons theme created successfully!${NC}"
else
  echo -e "${RED}❌ Failed to create ToggleButtons theme.${NC}"
fi


# =========================
# Creating main AppThemes configuration file
# =========================

echo -e "${YELLOW}Creating main app_theme.dart file...${NC}"

cat <<EOL > lib/core/themes/app_theme.dart
import 'package:flutter/material.dart';
import 'package:$project_name/core/themes/widgets/appbar/app_bar_theme.dart';
import 'package:$project_name/core/themes/widgets/buttons/elevated_button_theme.dart';
import 'package:$project_name/core/themes/widgets/buttons/fab_button_theme.dart';
import 'package:$project_name/core/themes/widgets/buttons/icon_button_theme.dart';
import 'package:$project_name/core/themes/widgets/buttons/outlined_button_theme.dart';
import 'package:$project_name/core/themes/widgets/inputs/input_theme.dart';
import 'package:$project_name/core/themes/widgets/checkbox_theme.dart';
import 'package:$project_name/core/themes/widgets/radio_theme.dart';
import 'package:$project_name/core/themes/widgets/switch_theme.dart';
import 'package:$project_name/core/themes/widgets/toggle_buttons_theme.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: CustomAppBarTheme.lightTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.lightTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.lightTheme,
    iconButtonTheme: CustomIconButtonTheme.lightTheme,
    floatingActionButtonTheme: CustomFabButtonTheme.lightTheme,
    inputDecorationTheme: CustomInputTheme.lightTheme,
    checkboxTheme: CustomCheckboxTheme.lightTheme,
    radioTheme: CustomRadioTheme.theme,
    switchTheme: CustomSwitchTheme.lightTheme,
    toggleButtonsTheme: CustomToggleButtonsTheme.lightTheme,
  );

  // TODO: Define darkTheme if needed
}
EOL

if [ $? -eq 0 ]; then
  echo -e "${GREEN}${TICK} app_theme.dart created successfully!${NC}"
else
  echo -e "${RED}❌ Failed to create app_theme.dart.${NC}"
fi


# =========================
# Localization Setup
# =========================

echo -e "${YELLOW}Would you like to set up localization for your Flutter app?${NC}"
echo "1. Yes"
echo "2. No"

while true; do
  read -rp "Enter choice [1/2]: " enable_localization

  case "$enable_localization" in
    1|y|Y)
      echo -e "${GREEN}${TICK} Localization setup started...${NC}"

      # Add localization dependencies
      flutter pub add flutter_localizations --sdk flutter
      flutter pub add intl
      flutter pub add intl_utils

      # Create default English ARB file
      mkdir -p lib/l10n
      cat <<EOL > lib/l10n/intl_en.arb
{
  "@@locale": "en",
  "hello": "Hello",
  "welcome": "Welcome to my app"
}
EOL

      # Create LocaleConfigs helper class
      mkdir -p lib/core/localization
      cat <<EOL > lib/core/localization/app_localization.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:$project_name/generated/l10n.dart';

class LocaleConfigs {
  static List<Locale> supportedLocales = [
    const Locale('en'),
    // Add more locales here
  ];

  static Locale locale = const Locale('en');

  static List<LocalizationsDelegate<dynamic>> delegates() {
    return [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
  }
}
EOL

      # Append generate: true under flutter: section only if not already present
      if ! grep -q 'generate:' pubspec.yaml; then
        sed -i '' '/^flutter:/a\
  generate: true
' pubspec.yaml
        echo -e "${GREEN}${TICK} Added 'generate: true' to pubspec.yaml under flutter section.${NC}"
      else
        echo -e "${YELLOW}'generate:' already present in pubspec.yaml.${NC}"
      fi

      # Generate Dart localization files
      flutter pub run intl_utils:generate

      echo -e "${GREEN}${TICK} Localization setup completed successfully!${NC}"
      break
      ;;
    2|n|N)
      echo -e "${YELLOW}Localization setup skipped.${NC}"
      break
      ;;
    *)
      echo -e "${RED}❌ Invalid input. Please enter '1' or '2'.${NC}"
      ;;
  esac
done

# ======================
# Errors
# ======================

cat <<EOL > lib/core/errors/exceptions.dart
   /// Abstract class for Exceptions in the Data Layer
abstract class AppException implements Exception {
  final String message;
  final int? code;

  AppException({required this.message, this.code});
}

// -------------------------
// Specific Exceptions
// -------------------------

class ServerException extends AppException {
  ServerException({String message = "Server error occurred", int? code})
      : super(message: message, code: code);
}

class CacheException extends AppException {
  CacheException({String message = "Cache error occurred"}) : super(message: message);
}

class NetworkException extends AppException {
  NetworkException({String message = "No internet connection"}) : super(message: message);
}

class AuthenticationException extends AppException {
  AuthenticationException({String message = "Authentication failed"}) : super(message: message);
}

class ValidationException extends AppException {
  ValidationException({required String message}) : super(message: message);
}

class PermissionException extends AppException {
  PermissionException({String message = "Permission denied"}) : super(message: message);
}

class FileException extends AppException {
  FileException({String message = "File error occurred"}) : super(message: message);
}

class UnknownException extends AppException {
  UnknownException({String message = "Something went wrong"}) : super(message: message);
}
EOL

cat <<EOL > lib/core/errors/failures.dart
 /// Abstract class for Failures in the Domain Layer
abstract class Failure {
  final String message;
  final int? code;

  Failure({required this.message, this.code});
}

// -------------------------
// Common Failures
// -------------------------

class ServerFailure extends Failure {
  ServerFailure({String message = "Server error occurred", int? code})
    : super(message: message, code: code);
}

class CacheFailure extends Failure {
  CacheFailure({String message = "Cache error occurred", int? code})
    : super(message: message, code: code);
}

class NetworkFailure extends Failure {
  NetworkFailure({String message = "No internet connection", int? code})
    : super(message: message, code: code);
}

class AuthenticationFailure extends Failure {
  AuthenticationFailure({String message = "Authentication failed", int? code})
    : super(message: message, code: code);
}

class ValidationFailure extends Failure {
  ValidationFailure({required String message}) : super(message: message);
}

class PermissionFailure extends Failure {
  PermissionFailure({String message = "Permission denied"})
    : super(message: message);
}

class FileFailure extends Failure {
  FileFailure({String message = "File error occurred"})
    : super(message: message);
}

class UnknownFailure extends Failure {
  UnknownFailure({String message = "Something went wrong"})
    : super(message: message);
}
EOL

# ======================
# Error mapper
# ======================

cat <<EOL > lib/core/errors/error_mapper.dart
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:$project_name/core/errors/exceptions.dart';
import 'package:$project_name/core/errors/failures.dart';

AppException mapException(dynamic error) {
  if (error is AppException) {
    return error; // Already mapped
  }

  if (error is DioException) {
    final statusCode = error.response?.statusCode;

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return NetworkException(message: "Connection timeout");
    }

    if (error.type == DioExceptionType.badResponse) {
      final message = error.response?.data is Map
          ? error.response?.data['message'] ?? "Bad response from server"
          : "Bad response from server";

      if (statusCode == 401) {
        return AuthenticationException(message: message);
      } else if (statusCode == 403) {
        return PermissionException(message: message);
      } else if (statusCode == 422) {
        return ValidationException(message: message);
      } else if (statusCode != null && statusCode >= 500) {
        return ServerException(message: message, code: statusCode);
      } else {
        return ServerException(message: message, code: statusCode);
      }
    }

    if (error.type == DioExceptionType.cancel) {
      return UnknownException(message: "Request cancelled");
    }

    return UnknownException(message: error.message ?? "Unknown Dio error");
  }

  if (error is SocketException) {
    return NetworkException(message: "No internet connection");
  }

  if (error is FormatException) {
    return ValidationException(message: "Data format error");
  }

  if (error is FileSystemException) {
    return FileException(message: error.message);
  }

  // Default fallback
  return UnknownException(message: error.toString());
}

/// Maps an [AppException] from the Data layer to a [Failure] in the Domain layer.
Failure mapFailure(AppException exception) {
  if (exception is ServerException) {
    return ServerFailure(message: exception.message, code: exception.code);
  }
  if (exception is CacheException) {
    return CacheFailure(message: exception.message, code: exception.code);
  }
  if (exception is NetworkException) {
    return NetworkFailure(message: exception.message, code: exception.code);
  }
  if (exception is AuthenticationException) {
    return AuthenticationFailure(
      message: exception.message,
      code: exception.code,
    );
  }
  if (exception is ValidationException) {
    return ValidationFailure(message: exception.message);
  }
  if (exception is PermissionException) {
    return PermissionFailure(message: exception.message);
  }
  if (exception is FileException) {
    return FileFailure(message: exception.message);
  }
  if (exception is UnknownException) {
    return UnknownFailure(message: exception.message);
  }

  // Fallback for any unhandled exception type
  return UnknownFailure(message: exception.message);
}
EOL


# =====================
# Utils
# ======================

mkdir -p lib/core/utils/extensions
mkdir -p lib/core/utils/validators
mkdir -p lib/core/utils/helpers

cat <<EOL > lib/core/utils/extensions/text_styles.dart
import 'package:flutter/material.dart';
import 'package:$project_name/core/themes/color_palette.dart';

class TextStyles {
  static const TextStyle _base = TextStyle(
    color: Colors.black,
  );

  // Sizes (example sizes, modify as required)
  static TextStyle const10 = _base.copyWith(fontSize: 10);
  static TextStyle const11 = _base.copyWith(fontSize: 11);
  static TextStyle const12 = _base.copyWith(fontSize: 12);
  static TextStyle const14 = _base.copyWith(fontSize: 14);
  static TextStyle const13 = _base.copyWith(fontSize: 13);
  static TextStyle const15 = _base.copyWith(fontSize: 15);
  static TextStyle const16 = _base.copyWith(fontSize: 16);
  static TextStyle const17 = _base.copyWith(fontSize: 17);
  static TextStyle const18 = _base.copyWith(fontSize: 18);
  static TextStyle const20 = _base.copyWith(fontSize: 20);
  static TextStyle const24 = _base.copyWith(fontSize: 24);
  static TextStyle const28 = _base.copyWith(fontSize: 28);
  static TextStyle const32 = _base.copyWith(fontSize: 32);
}

extension TextStyleExtension on TextStyle {
  TextStyle get w100 => copyWith(fontWeight: FontWeight.w100);
  TextStyle get w200 => copyWith(fontWeight: FontWeight.w200);
  TextStyle get w300 => copyWith(fontWeight: FontWeight.w300);
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get w800 => copyWith(fontWeight: FontWeight.w800);
  TextStyle get w900 => copyWith(fontWeight: FontWeight.w900);

  TextStyle get black => copyWith(color: ColorPalette.black);
  // Add more extensions as needed
}

EOL

cat <<EOL > lib/core/utils/validators/validators.dart
class AppValidators {
  // -------------------------
  // Check if string is not empty
  // -------------------------
  static String? validateNotEmpty(String? value, {String fieldName = "Field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName cannot be empty";
    }
    return null;
  }

  // -------------------------
  // Email validation
  // -------------------------
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return "Email cannot be empty";

    final emailRegex = RegExp(
      r"",
    );
    if (!emailRegex.hasMatch(value)) return "Enter a valid email address";

    return null;
  }

  // -------------------------
  // Password validation
  // -------------------------
  static String? validatePassword(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) return "Password cannot be empty";
    if (value.length < minLength) {
      return "Password must be at least $minLength characters long";
    }
    return null;
  }

  // -------------------------
  // Phone number validation
  // -------------------------
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty)
      return "Phone number cannot be empty";

    final phoneRegex = RegExp(
      r'',
    ); // allows optional + and 10-15 digits
    if (!phoneRegex.hasMatch(value)) return "Enter a valid phone number";

    return null;
  }

  // -------------------------
  // Minimum length validation
  // -------------------------
  static String? validateMinLength(
    String? value,
    int minLength, {
    String fieldName = "Field",
  }) {
    if (value == null || value.trim().length < minLength) {
      return "$fieldName must be at least $minLength characters long";
    }
    return null;
  }
}

EOL

cat <<EOL > lib/core/utils/helpers/scaffold_helper.dart
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:$project_name/core/constants/figma_constants.dart';
import 'package:$project_name/core/themes/color_palette.dart';

enum SnackbarType { success, error, info, warning }

extension SnackbarTypeExtension on SnackbarType {
  Color get color {
    switch (this) {
      case SnackbarType.success:
        return ColorPalette.success;
      case SnackbarType.error:
        return ColorPalette.error;
      case SnackbarType.info:
        return ColorPalette.info;
      case SnackbarType.warning:
        return ColorPalette.warning;
    }
  }
}

class ScaffoldHelper {
  // show snacbark helper
  static void showSnackbar({
    required BuildContext context,
    required String message,
    SnackbarType? type = SnackbarType.info,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: type?.color),
    );
  }

  static void showAdaptiveDialog({
    required BuildContext context,
    required String title,
    required String message,
    required List<Widget> actions,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: actions,
      ),
    );
  }

  static void showCustomCupertinoDialog({
    required BuildContext context,
    required String title,
    required String message,
    required List<Widget> actions,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: actions,
      ),
    );
  }

  static Future<T?> showAdaptiveDialogSheet<T>({
    required BuildContext context,
    required Widget child,
    String? title,
  }) async {
    return showModalBottomSheet<T>(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(FigmaConstants.borderRadius),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: FigmaConstants.paddingHorizontal,
            right: FigmaConstants.paddingHorizontal,
            top: FigmaConstants.paddingHorizontal,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) ...[
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                ],
                child,
              ],
            ),
          ),
        );
      },
    );
  }

  // add heptic feedback

  static void triggerHepticFeedBack() {
    if (Platform.isAndroid) {
      HapticFeedback.vibrate(); // Android-style vibration
    } else {
      HapticFeedback.mediumImpact(); // iOS-style medium impact
    }
  }

  // Add close keyboard

  static void closeKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}


EOL



# =========================
# Managers
# =========================


# =========================
# App Manager
# =========================
echo -e "${YELLOW}📦 Adding app manager${NC}"


cat <<EOL > lib/core/managers/app_manager.dart
import 'package:flutter/services.dart';
// import 'package:$project_name/core/managers/shared_preferences_manager.dart';
import 'package:$project_name/injection/injection_container.dart' as di;

class AppManager {
  static Future<void> init() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    //. Uncomment the following line if you want to use SharedPreferences
    // await SharedPreferencesManager.init();
    await di.init();
  }
}

EOL


# ==========================
# Shared Preferences Manager
# ==========================
echo -e "${YELLOW}📦 Do you want to use a Shared Preferences Manager?${NC}"
echo -e "${GREEN}1.${NC} Yes"
echo -e "${RED}2.${NC} No"
read -p "Enter choice [1/2]: " shared_preferences_manager_choice

if [ "$shared_preferences_manager_choice" == "1" ]; then
  echo -e "${GREEN}${TICK} Adding shared_preferences package...${NC}"
  flutter pub add shared_preferences

  echo -e "${YELLOW}🛠️ Creating SharedPreferencesManager Dart file...${NC}"
  mkdir -p lib/core/managers
  cat <<EOL > lib/core/managers/shared_preferences_manager.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferencesManager provides easy access to the local key-value store.
/// Call SharedPreferencesManager.init() at app start to initialize.
class SharedPreferencesManager {
  static SharedPreferences? _prefs;

  //==================================================
  // Initialize SharedPreferences instance
  static Future<SharedPreferences> get _prefInstance async =>
      _prefs ?? (await SharedPreferences.getInstance());

  static Future<SharedPreferences> init() async {
    _prefs = await _prefInstance;
    return _prefs!;
  }

  //==================================================
  // String
  static String getString(String? strKey) {
    String strValue = '';
    if (strKey != null && strKey.isNotEmpty && _prefs != null) {
      strValue = _prefs!.getString(strKey) ?? '';
    }
    return strValue;
  }

  static void setString(String? strKey, String? strValue) {
    if (strKey != null && strValue != null) {
      _prefs!.setString(strKey, strValue);
    }
  }

  //==================================================
  // Int
  static int getInt(String? strKey) {
    int nValue = -1;
    if (strKey != null && strKey.isNotEmpty && _prefs != null) {
      nValue = _prefs!.getInt(strKey) ?? -1;
    }
    return nValue;
  }

  static void setInt(String? strKey, int nValue) {
    if (strKey != null) {
      _prefs!.setInt(strKey, nValue);
    }
  }

  //==================================================
  // Double
  static double getDouble(String? strKey) {
    double dValue = -1;
    if (strKey != null && strKey.isNotEmpty && _prefs != null) {
      dValue = _prefs!.getDouble(strKey) ?? -1;
    }
    return dValue;
  }

  static void setDouble(String? strKey, double dValue) {
    if (strKey != null) {
      _prefs!.setDouble(strKey, dValue);
    }
  }

  //==================================================
  // Bool
  static bool getBool(String? strKey) {
    return (strKey != null && strKey.isNotEmpty && _prefs != null)
        ? _prefs!.getBool(strKey) ?? false
        : false;
  }

  static void setBool(String? strKey, bool bValue) {
    if (strKey != null) {
      _prefs!.setBool(strKey, bValue);
    }
  }

  //==================================================
  // String List
  static List<String> getStringList(String? strKey) {
    return (strKey != null && strKey.isNotEmpty && _prefs != null)
        ? _prefs!.getStringList(strKey) ?? []
        : [];
  }

  static void setStringList(String? strKey, List<String> listOfValue) {
    if (strKey != null) {
      _prefs!.setStringList(strKey, listOfValue);
    }
  }

  //==================================================
  // Generic Object
  static Object get(String? strKey) {
    return (strKey != null && strKey.isNotEmpty && _prefs != null)
        ? _prefs!.get(strKey) ?? false
        : false;
  }

  static Object getObject(String? strKey) {
    if (strKey != null && strKey.isNotEmpty && _prefs != null && _prefs!.containsKey(strKey)) {
      return json.decode(json.decode(_prefs!.getString(strKey)!));
    }
    return {};
  }

  static void setObject(String? strKey, Object obj) {
    if (strKey != null) {
      String data = jsonEncode(obj);
      _prefs!.setString(strKey, data);
    }
  }

  //==================================================
  // Remove key
  static void removeKey(String key) async {
    try {
      _prefs!.remove(key);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
EOL

  echo -e "${GREEN}${TICK} ✅ SharedPreferencesManager setup complete!${NC}"
fi




# =========================
# Permission Manager
# =========================

echo -e "${YELLOW}🔐 Do you want to use a comprehensive Permission Manager?${NC}"
echo -e "${GREEN}1.${NC} Yes"
echo -e "${RED}2.${NC} No"
read -p "Enter choice [1/2]: " permission_manager_choice

if [ "$permission_manager_choice" == "1" ]; then
  echo -e "${GREEN}${TICK} Adding permission_handler package... 📦${NC}"
  flutter pub add permission_handler

  echo -e "${YELLOW}🛠️ Creating PermissionManager Dart file with all common permissions...${NC}"
  mkdir -p lib/core/managers
  cat <<EOL > lib/core/managers/permission_manager.dart
import 'package:permission_handler/permission_handler.dart';

/// AppPermissionManager provides easy permission requests for common Flutter app features.
class AppPermissionManager {
  /// Requests camera permission
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  /// Requests photos/gallery permission
  static Future<bool> requestPhotosPermission() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  /// Requests microphone permission
  static Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  /// Requests storage permission (Android)
  static Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  /// Requests location permission (foreground)
  static Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  /// Requests location permission (always)
  static Future<bool> requestLocationAlwaysPermission() async {
    final status = await Permission.locationAlways.request();
    return status.isGranted;
  }

  /// Requests contacts permission
  static Future<bool> requestContactsPermission() async {
    final status = await Permission.contacts.request();
    return status.isGranted;
  }

  /// Requests notifications permission (iOS)
  static Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  /// Requests Bluetooth permission (Android 12+)
  static Future<bool> requestBluetoothPermission() async {
    final status = await Permission.bluetooth.request();
    return status.isGranted;
  }

  /// Requests calendar permission
  static Future<bool> requestCalendarPermission() async {
    final status = await Permission.calendar.request();
    return status.isGranted;
  }

  /// Requests reminders permission (iOS)
  static Future<bool> requestRemindersPermission() async {
    final status = await Permission.reminders.request();
    return status.isGranted;
  }

  /// Requests sensors permission (e.g., for step counter)
  static Future<bool> requestSensorsPermission() async {
    final status = await Permission.sensors.request();
    return status.isGranted;
  }
}
EOL

  echo -e "${GREEN}${TICK} ✅ Comprehensive PermissionManager setup complete!${NC}"
fi

# =========================
# Camera Manager
# =========================
echo "Do you want to use a Camera Manager?"
echo "1. Yes"
echo "2. No"
read -p "Enter choice [1/2]: " camera_manager_choice

if [ "$camera_manager_choice" == "1" ];
then
echo "Adding image_picker package..."
flutter pub add image_picker

# Create CameraManager Dart file
cat <<EOL > lib/core/managers/camera_manager.dart
    import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:$project_name/core/managers/permission_manager.dart';

class CameraManager {
    static final ImagePicker _picker = ImagePicker();

    static Future<File?> pickImageFromCamera() async {
        final hasPermission = await AppPermissionManager.requestCameraPermission();
        if (!hasPermission) return null;
        final pickedFile = await _picker.pickImage(source: ImageSource.camera);
        return pickedFile != null ? File(pickedFile.path) : null;
    }

    static Future<File?> pickImageFromGallery() async {
        final hasPermission = await AppPermissionManager.requestPhotosPermission();
        if (!hasPermission) return null;
        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
        return pickedFile != null ? File(pickedFile.path) : null;
    }

    static Future<List<File>?> pickMultipleImagesFromGallery() async {
        final hasPermission = await AppPermissionManager.requestPhotosPermission();
        if (!hasPermission) return null;
        final pickedFiles = await _picker.pickMultiImage();
        return pickedFiles.isNotEmpty
        ? pickedFiles.map((f) => File(f.path)).toList()
        : null;
    }

    static Future<File?> pickVideoFromCamera() async {
        final hasPermission = await AppPermissionManager.requestCameraPermission();
        if (!hasPermission) return null;
        final pickedFile = await _picker.pickVideo(source: ImageSource.camera);
        return pickedFile != null ? File(pickedFile.path) : null;
    }

    static Future<File?> pickVideoFromGallery() async {
        final hasPermission = await AppPermissionManager.requestPhotosPermission();
        if (!hasPermission) return null;
        final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
        return pickedFile != null ? File(pickedFile.path) : null;
    }
}
EOL
fi




# ======================
# Creating API Client
# ======================
echo -e "${YELLOW}🌐 Will you need an API client for server communication?${NC}"
echo -e "${GREEN}1.${NC} Yes"
echo -e "${RED}2.${NC} No"
read -p "Enter choice [1/2]: " api_client_choice

if [ "$api_client_choice" == "1" ]; then
  echo -e "${GREEN}${TICK} Creating client directory...${NC}"
  mkdir -p lib/core/client

  echo -e "${GREEN}${TICK} Adding Dio package... 📦${NC}"
  flutter pub add dio

  echo -e "${YELLOW}✏️ Creating API client file...${NC}"
  cat <<EOL > lib/core/client/api_client.dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:$project_name/core/constants/api_endpoints.dart';
import 'package:$project_name/core/errors/error_mapper.dart';
import 'package:$project_name/core/errors/exceptions.dart';

/// Enum for multipart request method types
enum MutipartRequestMethodType { post, put }

/// A custom HTTP client built on top of Dio.
///
/// All requests are wrapped in a try-catch block to ensure that
/// any error is mapped to an [AppException] using [mapException].
class CustomHttpClient {
  final Dio _dio;

  /// Creates an instance of [CustomHttpClient] with an optional [baseUrl]
  CustomHttpClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl, // Set the default base URL
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'Accept': 'application/json'},
        ),
      );

  /// Default headers that can be reused across requests
  Map<String, String> _headers = {};

  /// Sends a GET request.
  ///
  /// [url] is the endpoint.
  /// [queryParams] is an optional map of query parameters.
  /// [headers] is an optional map of headers.
  ///
  /// Throws [AppException] on any failure.
  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(headers: headers ?? _headers),
      );
      return response;
    } catch (e) {
      throw mapException(e);
    }
  }

  /// Sends a POST request.
  ///
  /// [url] is the endpoint.
  /// [headers] is optional headers map.
  /// [bodyData] is the request body.
  ///
  /// Throws [AppException] on any failure.
  Future<Response> post({
    required String url,
    Map<String, String>? headers,
    dynamic bodyData,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: jsonEncode(bodyData ?? {}),
        options: Options(headers: headers ?? _headers),
      );
      return response;
    } catch (e) {
      throw mapException(e);
    }
  }

  /// Sends a PUT request.
  ///
  /// [url] is the endpoint.
  /// [headers] is optional headers map.
  /// [bodyData] is the request body.
  ///
  /// Throws [AppException] on any failure.
  Future<Response> put({
    required String url,
    Map<String, String>? headers,
    required dynamic bodyData,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: jsonEncode(bodyData),
        options: Options(headers: headers ?? {'Accept': 'application/json'}),
      );
      return response;
    } catch (e) {
      throw mapException(e);
    }
  }

  /// Sends a PATCH request.
  ///
  /// [url] is the endpoint.
  /// [headers] is optional headers map.
  /// [bodyData] is the request body.
  ///
  /// Throws [AppException] on any failure.
  Future<Response> patch({
    required String url,
    Map<String, String>? headers,
    dynamic bodyData,
  }) async {
    try {
      final response = await _dio.patch(
        url,
        data: jsonEncode(bodyData),
        options: Options(headers: headers ?? {'Accept': 'application/json'}),
      );
      return response;
    } catch (e) {
      throw mapException(e);
    }
  }

  /// Sends a DELETE request.
  ///
  /// [url] is the endpoint.
  /// [headers] is optional headers map.
  /// [bodyData] is optional body data.
  ///
  /// Throws [AppException] on any failure.
  Future<Response> delete({
    required String url,
    Map<String, String>? headers,
    dynamic bodyData,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: jsonEncode(bodyData),
        options: Options(headers: headers ?? _headers),
      );
      return response;
    } catch (e) {
      throw mapException(e);
    }
  }

  /// Sends a multipart/form-data request.
  ///
  /// [formData] is the FormData containing files or fields.
  /// [url] is the endpoint.
  /// [method] specifies whether POST or PUT (default: POST).
  ///
  /// Throws [AppException] on any failure.
  Future<Response> createMultipartRequest({
    required FormData formData,
    required String url,
    MutipartRequestMethodType method = MutipartRequestMethodType.post,
  }) async {
    try {
      if (method == MutipartRequestMethodType.post) {
        final response = await _dio.post(
          url,
          data: formData,
          options: Options(headers: _headers),
        );
        return response;
      } else {
        final response = await _dio.put(
          url,
          data: formData,
          options: Options(headers: _headers),
        );
        return response;
      }
    } catch (e) {
      throw mapException(e);
    }
  }
}
EOL

  echo -e "${YELLOW}📌 Creating API endpoints...${NC}"
  cat <<EOL > lib/core/constants/api_endpoints.dart
/// A centralized class for defining all API endpoints used in the application.
class ApiEndpoints {
  /// The base URL of the API server.
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
}
EOL

  echo -e "${YELLOW}🔌 Creating connectivity service...${NC}"
  flutter pub add internet_connection_checker

  mkdir -p lib/core/network
  cat <<EOL > lib/core/network/network_info.dart
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl extends NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
EOL

  echo -e "${GREEN}${TICK} API client and connectivity setup done!${NC}"
fi

echo -e "${YELLOW}🛠️ Creating generic utility functions...${NC}"
flutter pub add dartz

mkdir -p lib/core/utils/functions
cat <<EOL > lib/core/utils/functions/genric_repository_method.dart
import 'package:dartz/dartz.dart';
import 'package:$project_name/core/errors/error_mapper.dart';
import 'package:$project_name/core/errors/exceptions.dart';
import 'package:$project_name/core/errors/failures.dart';

/// Generic repository method that returns Either<Failure, T>
Future<Either<Failure, T>> genricRepositoryMethod<T>({
  required Future<T> Function() getData,
}) async {
  try {
    return Right(await getData());
  } catch (e) {
    if (e is AppException) {
      return Left(mapFailure(e));
    }
    return Left(UnknownFailure(message: e.toString()));
  }
}
EOL

cat <<EOL > lib/core/utils/functions/genric_cache_operation.dart
import 'package:$project_name/core/errors/error_mapper.dart';

Future<T> genericCacheOperation<T>({
  required Future<T> Function() getData,
  Future<T?> Function()? getCachedData,
  required Future<void> Function(T data) cacheData,
}) async {
  try {
    // 1️⃣ Check cached data first
    if (getCachedData != null) {
      final cachedItem = await getCachedData();
      if (cachedItem != null) {
        return cachedItem;
      }
    }

    // 2️⃣ Fetch from network/source
    final data = await getData();

    // 3️⃣ Cache the new data
    await cacheData(data);

    // 4️⃣ Optional: recursive call if retry needed
    return data;
  } catch (e) {
    throw mapException(e);
  }
}
EOL

echo -e "${GREEN}${TICK} ✅ Generic functions setup complete!${NC}"



# =========================
# Local Storage / Drift
# =========================
echo -e "${YELLOW}💾 Will your app use local storage?${NC}"
echo -e "${GREEN}1.${NC} Yes"
echo -e "${RED}2.${NC} No"
read -p "Enter choice [1/2]: " local_storage_choice

if [ "$local_storage_choice" == "1" ]; then

  echo -e "${GREEN}${TICK} Creating database directories...${NC}"
  mkdir -p lib/core/database
  mkdir -p lib/core/database/tables

  echo -e "${GREEN}${TICK} Adding Drift packages...${NC}"
  flutter pub add drift
  flutter pub add drift_flutter
  flutter pub add path_provider
  flutter pub add --dev drift_dev
  flutter pub add --dev build_runner

  echo -e "${YELLOW}📄 Creating Todo table Dart file...${NC}"
  cat <<EOL > lib/core/database/tables/todo_table.dart
import 'package:drift/drift.dart';

class TodoItem extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body')();
  DateTimeColumn get createdAt => dateTime().nullable()();
}
EOL

  echo -e "${YELLOW}🗄️ Creating App Database Dart file...${NC}"
  cat <<EOL > lib/core/database/app_database.dart
import 'package:$project_name/core/database/tables/todo_table.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [TodoItem])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}


EOL
  echo -e "${GREEN}${TICK} Running code generator...${NC}"
  dart run build_runner build

  echo -e "${GREEN}${TICK} ✅ Drift setup complete! Your database is ready.${NC}"
fi



mkdir -p lib/injection

echo -e "${GREEN}${TICK} Adding get_it package...${NC}"
flutter pub add get_it

echo -e "${YELLOW}🛠️ Creating InjectionManager Dart file...${NC}"

cat <<EOL > lib/injection/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:$project_name/core/database/app_database.dart';
import 'package:$project_name/core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  general();
  home();
}

// For each feature you can create a function
void home() {}

void general() {
  // Network register
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // local storage
  sl.registerFactory(() => AppDatabase());
}

EOL
echo -e "${GREEN}${TICK} ✅ Injection setup complete!${NC}"

echo -e "${GREEN}${TICK} Adding router{NC}"

mkdir -p lib/router

cat <<EOL > lib/router/app_routes.dart
//  All the app routes are defined here
class AppRoutes {
  static const String home = '/home';
}

EOL


cat <<EOL > lib/router/app_navigator.dart
import 'package:flutter/material.dart';
import 'package:$project_name/main.dart';
import 'package:$project_name/router/app_routes.dart';

final kNavigatorKey = GlobalKey<NavigatorState>();

/// Enum defining available page transition types
enum PageTransition {
  fade,
  slide,
  scale,
  rotation,
  slideFromTop,
  slideFromBottom,
  slideFromLeft,
  slideFromRight,
  none,
}

class AppNavigator {
  AppNavigator._();

  static Route<dynamic> controller(RouteSettings settings) {
    // Extract transition settings from arguments if provided
    PageTransition? transition;
    Duration? transitionDuration;

    if (settings.arguments is Map<String, dynamic>) {
      final args = settings.arguments as Map<String, dynamic>;
      transition = args['_transition'] as PageTransition?;
      transitionDuration = args['_transitionDuration'] as Duration?;
    }

    switch (settings.name) {
      case AppRoutes.home:
        return _createRoute(
          MyHomePage(title: "Welcome to Flutter CLI Template"),
          settings,
          transition,
          transitionDuration,
        );
      // case '/profile':
      //   return _createRoute(ProfileScreen(), settings, transition, transitionDuration);

      default:
        throw Exception('This route name does not exist: ${settings.name}');
    }
  }

  /// Creates a custom route with the specified transition
  static Route<T> _createRoute<T>(
    Widget page,
    RouteSettings settings,
    PageTransition? transition,
    Duration? transitionDuration,
  ) {
    transitionDuration ??= const Duration(milliseconds: 300);

    if (transition == null || transition == PageTransition.none) {
      return MaterialPageRoute<T>(builder: (_) => page, settings: settings);
    }

    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: transitionDuration,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return _buildTransition(
          transition,
          animation,
          secondaryAnimation,
          child,
        );
      },
    );
  }

  /// Builds the specified transition animation
  static Widget _buildTransition(
    PageTransition transition,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    switch (transition) {
      case PageTransition.fade:
        return FadeTransition(opacity: animation, child: child);

      case PageTransition.slide:
      case PageTransition.slideFromRight:
        return SlideTransition(
          position:
              Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
          child: child,
        );

      case PageTransition.slideFromLeft:
        return SlideTransition(
          position:
              Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
          child: child,
        );

      case PageTransition.slideFromTop:
        return SlideTransition(
          position:
              Tween<Offset>(
                begin: const Offset(0.0, -1.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
          child: child,
        );

      case PageTransition.slideFromBottom:
        return SlideTransition(
          position:
              Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
          child: child,
        );

      case PageTransition.scale:
        return ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );

      case PageTransition.rotation:
        return RotationTransition(
          turns: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: FadeTransition(opacity: animation, child: child),
        );

      case PageTransition.none:
        return child;
    }
  }

  static Future<T?> pushTo<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    PageTransition? transition,
    Duration? transitionDuration,
  }) async {
    // Combine user arguments with transition settings
    final Map<String, dynamic> combinedArgs = {};

    if (arguments != null) {
      if (arguments is Map<String, dynamic>) {
        combinedArgs.addAll(arguments);
      } else {
        combinedArgs['data'] = arguments;
      }
    }

    if (transition != null) {
      combinedArgs['_transition'] = transition;
    }
    if (transitionDuration != null) {
      combinedArgs['_transitionDuration'] = transitionDuration;
    }

    return await Navigator.of(context, rootNavigator: true).pushNamed(
      routeName,
      arguments: combinedArgs.isEmpty ? null : combinedArgs,
    );
  }

  static void pop(BuildContext context, {Object? result}) {
    Navigator.pop(context, result);
  }

  static Future<T?> popTo<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    PageTransition? transition,
    Duration? transitionDuration,
  }) async {
    // Combine user arguments with transition settings
    final Map<String, dynamic> combinedArgs = {};

    if (arguments != null) {
      if (arguments is Map<String, dynamic>) {
        combinedArgs.addAll(arguments);
      } else {
        combinedArgs['data'] = arguments;
      }
    }

    if (transition != null) {
      combinedArgs['_transition'] = transition;
    }
    if (transitionDuration != null) {
      combinedArgs['_transitionDuration'] = transitionDuration;
    }

    return await Navigator.popAndPushNamed(
      context,
      routeName,
      arguments: combinedArgs.isEmpty ? null : combinedArgs,
    );
  }

  static void popUntilFirst(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  static void popUntilRoute(
    BuildContext context,
    String routeName, {
    dynamic result,
  }) {
    Navigator.popUntil(context, (route) {
      if (route.settings.name == routeName &&
          route.settings.arguments != null) {
        if (route.settings.arguments is Map<String, dynamic>) {
          (route.settings.arguments as Map<String, dynamic>)["result"] = result;
        }
        return true;
      }
      return route.settings.name == routeName;
    });
  }

  static Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    PageTransition? transition,
    Duration? transitionDuration,
  }) async {
    // Combine user arguments with transition settings
    final Map<String, dynamic> combinedArgs = {};

    if (arguments != null) {
      if (arguments is Map<String, dynamic>) {
        combinedArgs.addAll(arguments);
      } else {
        combinedArgs['data'] = arguments;
      }
    }

    if (transition != null) {
      combinedArgs['_transition'] = transition;
    }
    if (transitionDuration != null) {
      combinedArgs['_transitionDuration'] = transitionDuration;
    }

    return Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
      arguments: combinedArgs.isEmpty ? null : combinedArgs,
    );
  }

  static Future<T?> pushReplace<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    PageTransition? transition,
    Duration? transitionDuration,
  }) async {
    // Combine user arguments with transition settings
    final Map<String, dynamic> combinedArgs = {};

    if (arguments != null) {
      if (arguments is Map<String, dynamic>) {
        combinedArgs.addAll(arguments);
      } else {
        combinedArgs['data'] = arguments;
      }
    }

    if (transition != null) {
      combinedArgs['_transition'] = transition;
    }
    if (transitionDuration != null) {
      combinedArgs['_transitionDuration'] = transitionDuration;
    }

    return await Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: combinedArgs.isEmpty ? null : combinedArgs,
    );
  }

  static Map<String, dynamic>? getArguments(RouteSettings settings) {
    if (settings.arguments == null) return null;

    if (settings.arguments is Map<String, dynamic>) {
      final args = Map<String, dynamic>.from(
        settings.arguments as Map<String, dynamic>,
      );
      // Remove internal transition parameters
      args.remove('_transition');
      args.remove('_transitionDuration');
      return args.isEmpty ? null : args;
    }

    return {'data': settings.arguments};
  }
}

EOL

echo -e "${YELLOW}🌐 Creating main ${NC}"

cat <<EOL > lib/main.dart
import 'package:flutter/material.dart';
import 'package:$project_name/core/localization/app_localization.dart';
import 'package:$project_name/core/managers/app_manager.dart';
import 'package:$project_name/core/themes/app_theme.dart';
import 'package:$project_name/router/app_navigator.dart';
import 'package:$project_name/router/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: LocaleConfigs.supportedLocales,
      localizationsDelegates: LocaleConfigs.delegates(),
      title: 'Flutter CLI Template',
      navigatorKey: kNavigatorKey,
      onGenerateRoute: AppNavigator.controller,
      initialRoute: AppRoutes.home,
      theme: AppThemes.lightTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
EOL

echo -e "${GREEN}${TICK} ✅ Main file created!${NC}"

mkdir -p lib/features

echo -e "${GREEN}${TICK} ✅ Features folder created!${NC}"

echo -e "${GREEN}${TICK} ✅ Project setup complete!${NC}"


# =========================
# MVVM with GetX
# =========================
elif [ "$architecture_choice" == "2" ];
then
echo "Coming soon: MVVM with GetX development in progress."
fi
