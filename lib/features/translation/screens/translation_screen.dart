import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/translation_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/language_selector.dart';
import '../widgets/translation_input.dart';
import '../widgets/camera_translate_view.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translation'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.camera_alt),
              text: 'Camera',
            ),
            Tab(
              icon: Icon(Icons.text_fields),
              text: 'Text',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Camera Translation Tab
          const CameraTranslateView(),
          
          // Text Translation Tab
          const TextTranslationView(),
        ],
      ),
    );
  }
}

class TextTranslationView extends StatelessWidget {
  const TextTranslationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TranslationProvider>(
      builder: (context, translationProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Language Selectors
              Row(
                children: [
                  Expanded(
                    child: LanguageSelector(
                      title: 'From',
                      selectedLanguage: translationProvider.sourceLanguage,
                      languages: translationProvider.supportedLanguages,
                      onLanguageChanged: translationProvider.setSourceLanguage,
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: translationProvider.swapLanguages,
                    icon: const Icon(Icons.swap_horiz),
                    style: IconButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue.withOpacity(0.1),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: LanguageSelector(
                      title: 'To',
                      selectedLanguage: translationProvider.targetLanguage,
                      languages: translationProvider.supportedLanguages,
                      onLanguageChanged: translationProvider.setTargetLanguage,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Conversation Mode Toggle
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppTheme.glassBackground
                      : AppTheme.glassBackgroundDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.primaryBlue.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      color: AppTheme.primaryBlue,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Conversation Mode',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Keep context for back-and-forth conversations',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.primaryBlue.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: translationProvider.isConversationMode,
                      onChanged: (value) => translationProvider.toggleConversationMode(),
                      activeColor: AppTheme.primaryBlue,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Translation Input
              TranslationInput(
                sourceLanguage: translationProvider.sourceLanguage,
                targetLanguage: translationProvider.targetLanguage,
                inputText: translationProvider.inputText,
                translatedText: translationProvider.translatedText,
                onInputChanged: translationProvider.setInputText,
                onTranslate: () async {
                  if (translationProvider.inputText.isNotEmpty) {
                    final translated = await translationProvider.translateText(
                      translationProvider.inputText,
                    );
                    translationProvider.setTranslatedText(translated);
                  }
                },
                onClear: translationProvider.clearText,
              ),
            ],
          ),
        );
      },
    );
  }
} 