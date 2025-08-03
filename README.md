# Untethered AI - Privacy-First Smartphone Assistant

An offline, privacy-first AI smartphone assistant that runs completely on-device, providing context-aware memory, multilingual translation, personal document search, object detection, and peer-to-peer sharing capabilities.

## 🌟 Features

### 🔒 Privacy-First Design
- **100% Offline Operation**: All AI processing happens locally on your device
- **No Cloud Dependencies**: Your data never leaves your device
- **Local Storage**: All memories, documents, and settings stored locally
- **Forget Mode**: Automatic deletion of recent memories for enhanced privacy

### 🧠 Context-Aware Memory
- **Daily Memory Journal**: Timeline of your day's experiences
- **Audio Transcription**: Convert speech to text with offline processing
- **Object Detection**: Identify objects in photos using on-device AI
- **Mood Analysis**: Track emotional patterns throughout your day
- **Smart Summarization**: AI-powered daily summaries

### 🌍 Multilingual Translation
- **Offline Translation**: Translate text without internet connection
- **Live Camera Translation**: Real-time text translation through camera
- **Conversation Mode**: Maintain context for back-and-forth conversations
- **Multiple Languages**: Support for 10+ languages

### 📱 Smartphone Integration
- **Camera AI**: Object detection and calorie counting
- **Dashcam Mode**: Automatic video recording with AI analysis
- **Quick Actions**: Easy access to common tasks
- **Favorites**: Quick access to important contacts

### 🔗 Peer-to-Peer Sharing
- **Mesh Network**: Direct device-to-device communication
- **File Sharing**: Share memories and documents locally
- **QR Code Pairing**: Easy device connection
- **Offline Collaboration**: Work together without internet

## 🏗️ Architecture

### Core Components
- **State Management**: Provider pattern for reactive UI
- **Local Database**: Hive for fast, encrypted local storage
- **Offline AI**: TensorFlow Lite for on-device machine learning
- **Camera Integration**: Real-time image processing
- **Audio Processing**: Speech-to-text with offline models

### Technology Stack
- **Framework**: Flutter 3.0+
- **Language**: Dart
- **Database**: Hive (NoSQL)
- **AI/ML**: TensorFlow Lite
- **Camera**: Camera plugin
- **Audio**: Speech-to-text plugin
- **UI**: Material Design 3 with glassmorphic effects

## 📱 Screens & Features

### 1. Onboarding
- App introduction with privacy-first messaging
- Feature overview with animated slides
- First-time setup and permissions

### 2. Home Dashboard
- Quick action buttons for common tasks
- Mood indicator based on daily memories
- Recent activity summary
- Navigation to all app features

### 3. Daily Memory Journal
- Timeline view of daily memories
- Filter by category (Work, Personal, General)
- Memory cards with transcripts and objects
- Search functionality
- Swipe-to-delete memories

### 4. Translation
- Text translation with language selection
- Live camera translation
- Conversation mode for context retention
- Offline language models

### 5. Mesh Network
- Device discovery and pairing
- QR code connection
- File and memory sharing
- Connection status monitoring

### 6. Profile & Settings
- User profile management
- Privacy controls and forget mode
- Storage usage monitoring
- Data export/import
- App preferences

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0 or higher
- Dart SDK 2.19 or higher
- Android Studio / VS Code
- Android device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/untethered-ai.git
   cd untethered-ai
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Production

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

## 🔧 Configuration

### Permissions
The app requires the following permissions:
- **Camera**: For object detection and translation
- **Microphone**: For speech-to-text and voice recording
- **Storage**: For saving memories and documents
- **Location**: For mesh network device discovery

### AI Models
Download and place the following TensorFlow Lite models in `assets/models/`:
- `object_detection.tflite` - Object detection model
- `translation_en_es.tflite` - English-Spanish translation
- `speech_recognition.tflite` - Speech-to-text model

## 🎨 Design System

### Color Palette
- **Primary Blue**: `#1E3A8A` - Main brand color
- **Secondary Teal**: `#0F766E` - Accent color
- **Accent Orange**: `#EA580C` - Action buttons
- **Soft White**: `#F8FAFC` - Background
- **Dark Blue**: `#0F172A` - Text and dark mode

### Typography
- **Font Family**: Inter (Google Fonts)
- **Weights**: Regular (400), Medium (500), Bold (700)

### UI Components
- **Glassmorphic Cards**: Translucent backgrounds with blur effects
- **Rounded Corners**: 12-16px border radius
- **Subtle Shadows**: Depth and elevation
- **Smooth Animations**: 200-600ms transitions

## 🔒 Privacy & Security

### Data Protection
- **Local Storage Only**: No data transmitted to external servers
- **Encrypted Database**: Hive encryption for sensitive data
- **Permission Control**: Granular permission management
- **Forget Mode**: Automatic data deletion

### Privacy Features
- **Offline Processing**: All AI operations on-device
- **No Analytics**: No tracking or data collection
- **User Control**: Complete control over data retention
- **Transparent**: Open source for auditability

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Setup
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flutter Team**: For the amazing framework
- **TensorFlow Team**: For on-device ML capabilities
- **Hive Team**: For fast local database
- **Open Source Community**: For inspiration and support

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/yourusername/untethered-ai/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/untethered-ai/discussions)
- **Email**: support@untethered-ai.com

## 🔮 Roadmap

### Version 1.1
- [ ] Enhanced object detection
- [ ] More language support
- [ ] Voice commands
- [ ] Calendar integration

### Version 1.2
- [ ] Advanced AI models
- [ ] Cloud backup (optional)
- [ ] Wearable integration
- [ ] API for developers

### Version 2.0
- [ ] Multi-device sync
- [ ] Advanced privacy controls
- [ ] Custom AI models
- [ ] Enterprise features

---

**Untethered AI** - Your privacy-first, always-on AI companion. 

C:\flutter\bin\flutter.bat run -d web-server --web-port 8080
.\run_app_complete.ps1
.\run_app_web_server.bat

$env:PATH = "C:\Program Files\Git\bin;C:\Program Files\Git\cmd;C:\flutter\bin;C:\Windows\System32;C:\Windows;" + $env:PATH; $env:FLUTTER_ROOT = "C:\flutter"; & "C:\flutter\bin\flutter.bat" build web --release
python serve_app.py
