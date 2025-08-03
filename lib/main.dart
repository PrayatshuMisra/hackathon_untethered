import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/theme/app_theme.dart';
import 'core/providers/app_provider.dart';
import 'core/providers/memory_provider.dart';
import 'core/providers/translation_provider.dart';
import 'core/providers/camera_provider.dart';
import 'core/providers/mesh_provider.dart';
import 'core/models/memory.dart';
import 'core/models/contact.dart';
import 'features/onboarding/screens/onboarding_screen.dart';
import 'features/home/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  
  // Register Hive adapters
  Hive.registerAdapter(MemoryAdapter());
  Hive.registerAdapter(ContactAdapter());
  
  // Open Hive boxes
  await Hive.openBox<Memory>('memories');
  await Hive.openBox<Contact>('contacts');
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => MemoryProvider()),
        ChangeNotifierProvider(create: (_) => CameraProvider()),
        ChangeNotifierProvider(create: (_) => MeshProvider()),
        ChangeNotifierProvider(create: (_) => TranslationProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          return MaterialApp(
            title: 'Untethered AI',
            debugShowCheckedModeBanner: false,
            theme: _buildLightTheme(),
            darkTheme: _buildDarkTheme(),
            themeMode: appProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const OnboardingScreen(),
          );
        },
      ),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppTheme.primaryBlue,
        secondary: AppTheme.secondaryPurple,
        tertiary: AppTheme.accentPink,
        surface: AppTheme.surfaceLight,
        background: AppTheme.backgroundLight,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppTheme.textPrimaryLight,
        onBackground: AppTheme.textPrimaryLight,
        error: AppTheme.errorRed,
      ),
      textTheme: TextTheme(
        displayLarge: AppTheme.techTitle.copyWith(color: AppTheme.textPrimaryLight),
        displayMedium: AppTheme.techSubtitle.copyWith(color: AppTheme.textPrimaryLight),
        headlineLarge: AppTheme.techHeading.copyWith(color: AppTheme.textPrimaryLight),
        bodyLarge: AppTheme.techBody.copyWith(color: AppTheme.textPrimaryLight),
        bodyMedium: AppTheme.techBody.copyWith(color: AppTheme.textPrimaryLight),
        bodySmall: AppTheme.techCaption.copyWith(color: AppTheme.textSecondaryLight),
        labelLarge: AppTheme.techButton,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTheme.techHeading.copyWith(color: AppTheme.textPrimaryLight),
        iconTheme: const IconThemeData(color: AppTheme.textPrimaryLight),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryBlue,
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: AppTheme.primaryBlue.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: AppTheme.techButton,
        ),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppTheme.primaryBlue,
        secondary: AppTheme.secondaryPurple,
        tertiary: AppTheme.accentPink,
        surface: AppTheme.surfaceDark,
        background: AppTheme.backgroundDark,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppTheme.textPrimaryDark,
        onBackground: AppTheme.textPrimaryDark,
        error: AppTheme.errorRed,
      ),
      textTheme: TextTheme(
        displayLarge: AppTheme.techTitle.copyWith(color: AppTheme.textPrimaryDark),
        displayMedium: AppTheme.techSubtitle.copyWith(color: AppTheme.textPrimaryDark),
        headlineLarge: AppTheme.techHeading.copyWith(color: AppTheme.textPrimaryDark),
        bodyLarge: AppTheme.techBody.copyWith(color: AppTheme.textPrimaryDark),
        bodyMedium: AppTheme.techBody.copyWith(color: AppTheme.textPrimaryDark),
        bodySmall: AppTheme.techCaption.copyWith(color: AppTheme.textSecondaryDark),
        labelLarge: AppTheme.techButton,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTheme.techHeading.copyWith(color: AppTheme.textPrimaryDark),
        iconTheme: const IconThemeData(color: AppTheme.textPrimaryDark),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryBlue,
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: AppTheme.primaryBlue.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: AppTheme.techButton,
        ),
      ),
    );
  }
} 