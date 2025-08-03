import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isFirstLaunch = true;
  String _userName = '';
  String _userAvatar = '';
  bool _forgetModeEnabled = false;
  int _forgetModeInterval = 5; // minutes

  bool get isDarkMode => _isDarkMode;
  bool get isFirstLaunch => _isFirstLaunch;
  String get userName => _userName;
  String get userAvatar => _userAvatar;
  bool get forgetModeEnabled => _forgetModeEnabled;
  int get forgetModeInterval => _forgetModeInterval;

  AppProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    _userName = prefs.getString('userName') ?? '';
    _userAvatar = prefs.getString('userAvatar') ?? '';
    _forgetModeEnabled = prefs.getBool('forgetModeEnabled') ?? false;
    _forgetModeInterval = prefs.getInt('forgetModeInterval') ?? 5;
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  Future<void> setFirstLaunchComplete() async {
    _isFirstLaunch = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);
    notifyListeners();
  }

  Future<void> updateUserName(String name) async {
    _userName = name;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    notifyListeners();
  }

  Future<void> updateUserAvatar(String avatar) async {
    _userAvatar = avatar;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userAvatar', avatar);
    notifyListeners();
  }

  Future<void> toggleForgetMode() async {
    _forgetModeEnabled = !_forgetModeEnabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('forgetModeEnabled', _forgetModeEnabled);
    notifyListeners();
  }

  Future<void> updateForgetModeInterval(int minutes) async {
    _forgetModeInterval = minutes;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('forgetModeInterval', minutes);
    notifyListeners();
  }
} 