# GitHub Pull Request Viewer

A Flutter application that displays GitHub pull requests with simulated authentication, built as a hiring assignment demonstration.

## 🎯 Features

### Core Requirements ✅
- ✅ Fetches open pull requests from GitHub REST API
- ✅ Displays PR title, description, author, and creation date
- ✅ Simulated login functionality with token storage
- ✅ Clean, modular folder structure
- ✅ Proper error handling and loading states
- ✅ Uses Provider for state management

### Bonus Features ✅
- ✅ Pull to refresh functionality
- ✅ Retry on failure with error handling
- ✅ Responsive layout that works on different screen sizes
- ✅ Dark mode support (follows system theme)
- ✅ Smooth animations and shimmer loading effects
- ✅ Comprehensive widget and unit tests
- ✅ Accessibility support for screen readers

## 🏗️ Architecture

### Folder Structure
```
lib/
├── main.dart                 # App entry point
├── models/
│   └── pull_request.dart     # PR data model
├── providers/
│   ├── auth_provider.dart    # Authentication state
│   └── pull_request_provider.dart # PR data state
├── screens/
│   ├── login_screen.dart     # Login UI
│   └── pull_requests_screen.dart # Main PR list
├── services/
│   └── github_service.dart   # GitHub API calls
├── widgets/
│   ├── pull_request_card.dart # PR display component
│   ├── loading_button.dart    # Animated button
│   ├── shimmer_loading.dart   # Loading skeleton
│   └── error_widget.dart      # Error display
└── utils/
    ├── theme.dart            # App theming
    └── date_formatter.dart   # Date utilities
```

### State Management
- **Provider Pattern**: Used for dependency injection and state management
- **AuthProvider**: Manages authentication state and token storage
- **PullRequestProvider**: Handles PR data fetching and error states

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd github_pr_viewer
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

4. **Run tests**
   ```bash
   flutter test
   ```

### Configuration

The app is currently configured to fetch PRs from the Flutter repository (`flutter/flutter`). To change the repository:

1. Open `lib/services/github_service.dart`
2. Update the `owner` and `repo` constants:
   ```dart
   static const String owner = 'your-username';
   static const String repo = 'your-repository';
   ```

## 🔧 Dependencies

### Core Dependencies
- **flutter**: UI framework
- **provider**: State management
- **http**: HTTP requests to GitHub API
- **shared_preferences**: Local token storage
- **url_launcher**: Open GitHub links in browser

### Development Dependencies
- **flutter_test**: Unit and widget testing
- **flutter_lints**: Code analysis and linting

## 🧪 Testing

The app includes comprehensive testing:

### Unit Tests
- **PullRequest Model**: JSON parsing and data validation
- **AuthProvider**: Authentication logic and token management
- **DateFormatter**: Relative time formatting

### Widget Tests
- **LoginScreen**: Form validation and user interactions
- **PullRequestCard**: PR data display and tap handling
- **ErrorWidget**: Error display and retry functionality

### Integration Tests
- **Complete App Flow**: Login to PR viewing workflow

Run all tests:
```bash
flutter test
```

Run with coverage:
```bash
flutter test --coverage
```

## 🎨 Design Features

### User Experience
- **Shimmer Loading**: Elegant skeleton loading animation
- **Pull to Refresh**: Intuitive refresh gesture
- **Error Handling**: Graceful error states with retry options
- **Dark Mode**: Automatic system theme detection
- **Smooth Animations**: Fade-in animations and loading states

### Accessibility
- **Screen Reader Support**: Semantic labels and hints
- **High Contrast**: Proper color contrast ratios
- **Touch Targets**: Adequate button sizes for easy tapping

## 🔐 Security Features

### Simulated Authentication
- **Token Storage**: Uses SharedPreferences for demo purposes
- **Secure Storage**: Includes flutter_secure_storage dependency for production use
- **Token Display**: Debug feature to view stored tokens
- **Logout Functionality**: Proper session cleanup

**Note**: This is a demo implementation. In production, use proper OAuth flows and secure storage.

## 📱 Screenshots

### Login Screen
- Clean, branded login interface
- Form validation with helpful error messages
- Loading states during authentication

### Pull Requests Screen
- List of open pull requests with rich information
- Author avatars and relative timestamps
- Pull to refresh functionality
- Error states with retry options

## 🚀 Performance Optimizations

- **Efficient List Rendering**: Optimized ListView.builder
- **Image Caching**: NetworkImage with built-in caching
- **Lazy Loading**: Only renders visible items
- **Memory Management**: Proper disposal of controllers and providers

## 🔄 Future Enhancements

Potential features for production use:
- Real GitHub OAuth authentication
- PR details screen with comments and files
- Search and filter functionality
- Offline caching with local database
- Push notifications for PR updates
- Multiple repository support
