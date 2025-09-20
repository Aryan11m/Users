# Flutter Users App

A simple Flutter application that fetches user data from a public API and displays it in a clean, user-friendly interface. This app demonstrates Flutter development best practices, API integration, state management, and error handling.

## 📱 Project Overview

This Flutter app displays a list of users fetched from the JSONPlaceholder API. Users can view names and email addresses, refresh the data with pull-to-refresh, and experience smooth loading states with proper error handling.

## ✨ Features

### Core Features
- **Splash Screen**: Professional app loading screen with branding
- **User Authentication**: Firebase Authentication with login/signup functionality
- **User List Display**: Shows users with their names and email addresses
- **API Integration**: Fetches data from `https://jsonplaceholder.typicode.com/users`
- **Loading States**: Displays loading indicators while fetching data
- **Pull-to-Refresh**: Swipe down to refresh the user list
- **Error Handling**: Graceful error handling with user-friendly error messages
- **Route Management**: Clean navigation using GetX route management
- **Responsive Design**: Clean and intuitive UI following Flutter design principles

### Bonus Features (if implemented)
- **Search Functionality**: Filter users by name
- **User Detail Screen**: Tap on a user to view detailed information
- **Custom Widgets**: Modular code organization with reusable widgets
- **Authentication Flow**: Secure login/logout with session management

## 🛠️ Technical Stack

- **Framework**: Flutter (Latest Stable Version)
- **Language**: Dart
- **State Management & Navigation**: GetX (State management, Route management, Dependency injection)
- **Authentication**: Firebase Authentication
- **HTTP Client**: `http` package for API requests
- **Architecture**: Clean Architecture with GetX pattern and separation of concerns

## 📋 Prerequisites

Before running this app, make sure you have:

- Flutter SDK (3.0.0 or higher)
- Dart SDK (2.17.0 or higher)
- Android Studio / VS Code with Flutter extensions
- Android Emulator or physical device for testing
- iOS Simulator (for Mac users)
- Firebase project with Authentication enabled
- Google Services configuration files (`google-services.json` for Android, `GoogleService-Info.plist` for iOS)

## 🚀 Getting Started

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Aryan11m/Users.git
   cd Users/firsttask
   ```

2. **Firebase Setup**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication and configure sign-in methods (Email/Password, Google, etc.)
   - Download configuration files:
     - `google-services.json` (place in `android/app/`)
     - `GoogleService-Info.plist` (place in `ios/Runner/`)

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Configure Firebase for Flutter**
   ```bash
   # Install Firebase CLI (if not already installed)
   npm install -g firebase-tools
   
   # Login to Firebase
   firebase login
   
   # Install FlutterFire CLI
   dart pub global activate flutterfire_cli
   
   # Configure Firebase for your Flutter project
   flutterfire configure
   ```

5. **Run the app**
   ```bash
   # For debug mode
   flutter run
   
   # For release mode
   flutter run --release
   ```

### Running on Different Platforms

```bash
# Run on Android
flutter run -d android

# Run on iOS
flutter run -d ios

# Run on Web
flutter run -d chrome
```

## 📱 Screenshots

<img width="591" height="1280" alt="image" src="https://github.com/user-attachments/assets/b7b91a6e-a78e-440b-ab53-9006049f77a4" />,<img width="591" height="1280" alt="image" src="https://github.com/user-attachments/assets/25e570f2-848b-4d85-89f9-016980c909f5" />,
 <img width="591" height="1280" alt="image" src="https://github.com/user-attachments/assets/2170b3fa-2958-4cd5-958d-f179479c9c95" />,<img width="591" height="1280" alt="image" src="https://github.com/user-attachments/assets/298ec42a-b4eb-4f77-8b3c-5fb6fb0db5f7" />,<img width="591" height="1280" alt="image" src="https://github.com/user-attachments/assets/4cb0f9d0-ab80-4e57-bdbe-0006536268da" />





## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── controller/
│   └── ucontroller.dart      # GetX controller for user management and authentication
├── models/
│   └── umodel.dart           # User data model
└── screen/
    ├── details.dart          # User detail screen
    ├── homepage.dart         # Main user list screen
    ├── loginpage.dart        # Login/authentication screen
    └── splashscreen.dart     # App splash screen
```

## 🔧 Configuration

### Firebase Configuration

The app uses Firebase Authentication for user management:
- **Authentication Methods**: Email/Password, Google Sign-in (configurable)
- **Security Rules**: Implemented for user data protection
- **Configuration Files**: 
  - Android: `android/app/google-services.json`
  - iOS: `ios/Runner/GoogleService-Info.plist`

### API Configuration

The app uses JSONPlaceholder API:
- **Base URL**: `https://jsonplaceholder.typicode.com`
- **Endpoint**: `/users`
- **Method**: GET
- **No authentication required**

### Dependencies

Key dependencies used in this project:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management & Navigation
  get: ^4.6.5                # GetX for state management and routing
  
  # Firebase
  firebase_core: ^2.15.1     # Firebase core functionality
  firebase_auth: ^4.9.0      # Firebase authentication
  
  # API & HTTP
  http: ^0.13.5              # HTTP requests
  
  # UI Components
  cupertino_icons: ^1.0.2    # iOS style icons

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0      # Code linting
```

## 🧪 Testing

Run the test suite:

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

## 🔄 State Management & Architecture

This project uses **GetX** for comprehensive state management, route management, and dependency injection.



## 🎨 UI/UX Design Decisions

### Design Principles
- **Material Design**: Following Flutter's Material Design guidelines
- **Responsive Layout**: Adapts to different screen sizes
- **Accessibility**: Proper semantic labels and color contrast
- **Consistent Spacing**: Using consistent margins and padding throughout

### Color Scheme
- Primary Color: `#2196F3` (Blue)
- Secondary Color: `#FFC107` (Amber)
- Error Color: `#F44336` (Red)
- Background: `#FAFAFA` (Light Grey)

## 🚨 Error Handling

The app implements comprehensive error handling:

### Network & API Errors
- **No Internet Connection**: Displays offline message with retry option
- **Server Errors**: API server issues (5xx errors)
- **Client Errors**: Bad requests (4xx errors)
- **Parsing Errors**: Invalid JSON response handling
- **Timeout Errors**: Request timeout with retry functionality

### Authentication Errors
- **Invalid Credentials**: Wrong email/password combination
- **User Not Found**: Account doesn't exist
- **Email Already in Use**: During registration
- **Weak Password**: Password validation errors
- **Network Issues**: Firebase connection problems

Each error type displays appropriate user-friendly messages with retry options and is handled gracefully using GetX's built-in snackbar system.

## 🔍 Development Decisions & Assumptions

### Key Decisions Made:
1. **Single Controller Approach**: Used one main controller (`UController`) to handle all app state including authentication, user data, and navigation logic
2. **Simple Folder Structure**: Organized code into basic folders (controller, models, screen) for straightforward development
3. **GetX Framework**: Chosen for its lightweight nature and comprehensive solution (state management + routing + dependency injection)
4. **Firebase Authentication**: Provides secure, scalable authentication with minimal setup
5. **UI Framework**: Used Material Design for consistent Android/iOS experience
6. **Error Handling Strategy**: Implemented centralized error handling with user-friendly messages
7. **App Flow**: Splash → Auth Check → Login/Home based on authentication status

### Assumptions:
- Users have stable internet connection for API calls and authentication
- JSONPlaceholder API will remain available and maintain current structure
- Firebase services will remain accessible
- App will primarily be used on mobile devices (Android/iOS)
- Users will register with valid email addresses

## 🚀 Deployment

### Build APK for Android
```bash
flutter build apk --release
```

### Build iOS App
```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/awesome-feature`)
3. Commit your changes (`git commit -m 'Add awesome feature'`)
4. Push to the branch (`git push origin feature/awesome-feature`)
5. Open a Pull Request

## 📝 Code Style

This project follows:
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- [Flutter Best Practices](https://flutter.dev/docs/development/best-practices)
- Consistent code formatting using `dart format`
- Linting rules defined in `analysis_options.yaml`

## 🐛 Known Issues

- [List any known issues or limitations]
- [Mention any planned improvements]

## 📄 License

This project is created for educational purposes as part of a Flutter development assignment.

## 👤 Developer

**Aryan** - [GitHub Profile](https://github.com/Aryan11m)

## 🔗 API Reference

**JSONPlaceholder Users API**
- **URL**: `https://jsonplaceholder.typicode.com/users`
- **Method**: GET
- **Response Format**: JSON Array of User objects

**Sample User Object:**
```json
{
  "id": 1,
  "name": "Leanne Graham",
  "username": "Bret",
  "email": "Sincere@april.biz",
  "address": {
    "street": "Kulas Light",
    "suite": "Apt. 556",
    "city": "Gwenborough",
    "zipcode": "92998-3874"
  },
  "phone": "1-770-736-8031 x56442",
  "website": "hildegard.org",
  "company": {
    "name": "Romaguera-Crona",
    "catchPhrase": "Multi-layered client-server neural-net"
  }
}
```

---

**Note**: This app was developed as part of a Flutter development assessment to demonstrate skills in API integration, state management, and Flutter best practices.
