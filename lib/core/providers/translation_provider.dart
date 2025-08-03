import 'package:flutter/material.dart';

class TranslationProvider extends ChangeNotifier {
  String _sourceLanguage = 'English';
  String _targetLanguage = 'Spanish';
  String _inputText = '';
  String _translatedText = '';
  bool _isLiveMode = false;
  bool _isConversationMode = false;

  String get sourceLanguage => _sourceLanguage;
  String get targetLanguage => _targetLanguage;
  String get inputText => _inputText;
  String get translatedText => _translatedText;
  bool get isLiveMode => _isLiveMode;
  bool get isConversationMode => _isConversationMode;

  final List<String> supportedLanguages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
    'Korean',
    'Arabic',
    'Russian',
    'Portuguese',
  ];

  void setSourceLanguage(String language) {
    _sourceLanguage = language;
    notifyListeners();
  }

  void setTargetLanguage(String language) {
    _targetLanguage = language;
    notifyListeners();
  }

  void setInputText(String text) {
    _inputText = text;
    notifyListeners();
  }

  void setTranslatedText(String text) {
    _translatedText = text;
    notifyListeners();
  }

  void toggleLiveMode() {
    _isLiveMode = !_isLiveMode;
    notifyListeners();
  }

  void toggleConversationMode() {
    _isConversationMode = !_isConversationMode;
    notifyListeners();
  }

  Future<String> translateText(String text) async {
    // In a real app, this would use an offline translation model
    // For now, we'll simulate translation with a simple mapping
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (_targetLanguage == 'Spanish') {
      return _translateToSpanish(text);
    } else if (_targetLanguage == 'French') {
      return _translateToFrench(text);
    } else if (_targetLanguage == 'German') {
      return _translateToGerman(text);
    } else if (_targetLanguage == 'Chinese') {
      return _translateToChinese(text);
    } else if (_targetLanguage == 'Japanese') {
      return _translateToJapanese(text);
    }
    
    return text; // Default to original text
  }

  String _translateToSpanish(String text) {
    final translations = {
      'hello': 'hola',
      'goodbye': 'adiós',
      'thank you': 'gracias',
      'please': 'por favor',
      'yes': 'sí',
      'no': 'no',
      'how are you': 'cómo estás',
      'good morning': 'buenos días',
      'good night': 'buenas noches',
    };

    String translated = text.toLowerCase();
    for (final entry in translations.entries) {
      translated = translated.replaceAll(entry.key, entry.value);
    }
    return translated;
  }

  String _translateToFrench(String text) {
    final translations = {
      'hello': 'bonjour',
      'goodbye': 'au revoir',
      'thank you': 'merci',
      'please': 's\'il vous plaît',
      'yes': 'oui',
      'no': 'non',
      'how are you': 'comment allez-vous',
      'good morning': 'bonjour',
      'good night': 'bonne nuit',
    };

    String translated = text.toLowerCase();
    for (final entry in translations.entries) {
      translated = translated.replaceAll(entry.key, entry.value);
    }
    return translated;
  }

  String _translateToGerman(String text) {
    final translations = {
      'hello': 'hallo',
      'goodbye': 'auf wiedersehen',
      'thank you': 'danke',
      'please': 'bitte',
      'yes': 'ja',
      'no': 'nein',
      'how are you': 'wie geht es dir',
      'good morning': 'guten morgen',
      'good night': 'gute nacht',
    };

    String translated = text.toLowerCase();
    for (final entry in translations.entries) {
      translated = translated.replaceAll(entry.key, entry.value);
    }
    return translated;
  }

  String _translateToChinese(String text) {
    final translations = {
      'hello': '你好',
      'goodbye': '再见',
      'thank you': '谢谢',
      'please': '请',
      'yes': '是',
      'no': '不',
      'how are you': '你好吗',
      'good morning': '早上好',
      'good night': '晚安',
    };

    String translated = text.toLowerCase();
    for (final entry in translations.entries) {
      translated = translated.replaceAll(entry.key, entry.value);
    }
    return translated;
  }

  String _translateToJapanese(String text) {
    final translations = {
      'hello': 'こんにちは',
      'goodbye': 'さようなら',
      'thank you': 'ありがとう',
      'please': 'お願いします',
      'yes': 'はい',
      'no': 'いいえ',
      'how are you': 'お元気ですか',
      'good morning': 'おはよう',
      'good night': 'おやすみ',
    };

    String translated = text.toLowerCase();
    for (final entry in translations.entries) {
      translated = translated.replaceAll(entry.key, entry.value);
    }
    return translated;
  }

  void swapLanguages() {
    final temp = _sourceLanguage;
    _sourceLanguage = _targetLanguage;
    _targetLanguage = temp;
    notifyListeners();
  }

  void clearText() {
    _inputText = '';
    _translatedText = '';
    notifyListeners();
  }
} 