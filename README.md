# Tele App

A Flutter-based telemedicine application that enables video consultations between doctors and patients. The app provides real-time video calling, chat functionality, doctor search, document management, and prescription features.

## Features

- **Video Consultations**: Real-time video calls powered by Agora RTC Engine
- **Doctor Search**: Browse and search for doctors by specialty
- **Medical Categories**: Filter doctors by medical categories
- **Chat System**: In-app messaging between patients and doctors
- **Document Management**: Upload and manage medical documents
- **Prescription Management**: View and manage prescriptions
- **Patient Information**: Display and manage patient details
- **Cross-platform Support**: Available on Android, iOS, macOS, Linux, and Windows

## Prerequisites

Before running this application, ensure you have the following installed:

- **Flutter SDK**: Version 3.10.4 or higher
  - [Download Flutter](https://flutter.dev/docs/get-started/install)
  - Verify installation: `flutter doctor`

- **Dart SDK**: Version 3.10.4 or higher (included with Flutter)

- **Platform-specific requirements**:
  - **Android**: Android Studio and Android SDK
  - **iOS**: Xcode (macOS only)
  - **macOS**: Xcode
  - **Linux**: Build essentials and GTK libraries
  - **Windows**: Visual Studio 2022 with C++ desktop development

## Installation

### 1. Clone the Repository

```bash
git clone <repository-url>
cd tele_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure Environment Variables

Copy the example environment file and update it with your Agora credentials:

```bash
cp .env.example .env
```

Edit the `.env` file and add your Agora credentials:

```env
# Agora App ID
AGORA_APP_ID=your_actual_agora_app_id

# Agora Token (temporary token for testing)
AGORA_TOKEN=your_actual_agora_token

# Default channel name for testing
AGORA_DEFAULT_CHANNEL_NAME=your_channel_name
```

**Note**: You'll need to create an account at [Agora.io](https://www.agora.io/) to get your App ID and Token.

### 4. Platform-specific Setup

#### Android

No additional setup required beyond Android Studio installation.

#### iOS (macOS only)

```bash
cd ios
pod install
cd ..
```

#### macOS (macOS only)

```bash
cd macos
pod install
cd ..
```

#### Linux

Install required dependencies:

```bash
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
```

#### Windows

Ensure Visual Studio 2022 with C++ desktop development workload is installed.

## Running the Application

### Run on Connected Device/Emulator

```bash
# Check connected devices
flutter devices

# Run on specific device
flutter run -d <device-id>

# Or simply run (will prompt for device selection)
flutter run
```

### Run on Specific Platform

```bash
# Android
flutter run -d android

# iOS (macOS only)
flutter run -d ios

# macOS (macOS only)
flutter run -d macos

# Linux
flutter run -d linux

# Windows
flutter run -d windows
```

### Build for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS (macOS only)
flutter build ios --release

# macOS (macOS only)
flutter build macos --release

# Linux
flutter build linux --release

# Windows
flutter build windows --release
```

## Project Structure

```
lib/
├── config/
│   └── agora_config.dart       # Agora configuration
├── models/
│   └── medical_category.dart   # Medical category model
├── screens/
│   ├── chat_screen.dart        # Chat interface
│   ├── doctor_search.dart      # Doctor search screen
│   ├── documents_screen.dart   # Documents management
│   ├── home_screen.dart        # Home screen
│   ├── main_screen.dart       # Main navigation screen
│   ├── prescription_screen.dart # Prescription management
│   └── video_call_screen.dart  # Video call interface
├── services/
│   └── agora_service.dart      # Agora RTC service
└── widgets/
    ├── bottom_nav_bar.dart     # Bottom navigation bar
    ├── category_selector.dart  # Medical category selector
    ├── error_view_widget.dart  # Error display widget
    ├── patient_info_widget.dart # Patient information widget
    ├── return_to_call_banner.dart # Return to call banner
    ├── video_call_controls_widget.dart # Video call controls
    └── video_views_widget.dart  # Video views display
```

## Dependencies

Key dependencies used in this project:

- `agora_rtc_engine: ^6.5.3` - Real-time communication for video calls
- `permission_handler: ^11.3.1` - Handle runtime permissions
- `http: ^0.13.5` - HTTP client for API requests
- `image: ^4.1.3` - Image manipulation
- `path: 1.9.1` - Path manipulation utilities
- `path_provider: ^2.1.1` - Access to file system paths
- `flutter_dotenv: ^5.1.0` - Load environment variables
- `cupertino_icons: ^1.0.8` - iOS-style icons

## Permissions

The app requires the following permissions:

### Android
- `CAMERA` - For video calls
- `RECORD_AUDIO` - For audio during calls
- `INTERNET` - For network communication
- `WRITE_EXTERNAL_STORAGE` - For document management (optional)

### iOS
- Camera usage description
- Microphone usage description

These permissions are automatically configured in the respective platform manifests.

## Development

### Code Quality

The project uses `flutter_lints` for code quality enforcement. Run lints with:

```bash
flutter analyze
```

### Testing

Run tests with:

```bash
flutter test
```

## Troubleshooting

### Common Issues

1. **Flutter command not found**: Ensure Flutter is added to your PATH
2. **Dependencies not found**: Run `flutter pub get`
3. **Agora connection issues**: Verify your Agora App ID and Token in `.env`
4. **Permission denied**: Grant necessary permissions in device settings
5. **Build failures**: Run `flutter clean` and try again

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Open an issue in the GitHub repository
- Contact the development team

## Acknowledgments

- [Flutter](https://flutter.dev/) - UI framework
- [Agora.io](https://www.agora.io/) - Real-time communication platform
- All contributors who helped build this project
