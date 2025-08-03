import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/translation_provider.dart';
import '../../../core/theme/app_theme.dart';

class CameraTranslateView extends StatelessWidget {
  const CameraTranslateView({super.key});

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
                    child: _buildLanguageSelector(
                      context,
                      'From',
                      translationProvider.sourceLanguage,
                      translationProvider.supportedLanguages,
                      translationProvider.setSourceLanguage,
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
                    child: _buildLanguageSelector(
                      context,
                      'To',
                      translationProvider.targetLanguage,
                      translationProvider.supportedLanguages,
                      translationProvider.setTargetLanguage,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Camera Preview Placeholder
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppTheme.glassBackground
                        : AppTheme.glassBackgroundDark,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.primaryBlue.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Camera placeholder
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 64,
                              color: AppTheme.primaryBlue.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Camera Translation',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppTheme.primaryBlue.withOpacity(0.7),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Point camera at text to translate',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.primaryBlue.withOpacity(0.5),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      // Live Mode Toggle
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: translationProvider.isLiveMode
                                ? AppTheme.accentOrange
                                : Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.radio_button_checked,
                                size: 12,
                                color: translationProvider.isLiveMode
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'LIVE',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: translationProvider.isLiveMode
                                      ? Colors.white
                                      : Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Detected Text Overlay
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Detected Text:',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Sample text detected in camera view',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Translation:',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Texto de muestra detectado en la vista de la cámara',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppTheme.secondaryTeal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Control Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        translationProvider.toggleLiveMode();
                      },
                      icon: Icon(
                        translationProvider.isLiveMode
                            ? Icons.stop
                            : Icons.play_arrow,
                      ),
                      label: Text(
                        translationProvider.isLiveMode ? 'Stop' : 'Start Live',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: translationProvider.isLiveMode
                            ? Colors.red
                            : AppTheme.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Capture and translate
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Capture'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondaryTeal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageSelector(
    BuildContext context,
    String title,
    String selectedLanguage,
    List<String> languages,
    Function(String) onLanguageChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.primaryBlue.withOpacity(0.7),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
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
          child: PopupMenuButton<String>(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedLanguage,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppTheme.darkBlue
                          : Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: AppTheme.primaryBlue,
                  ),
                ],
              ),
            ),
            itemBuilder: (context) => languages.map((language) {
              return PopupMenuItem<String>(
                value: language,
                child: Text(
                  language,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppTheme.darkBlue
                        : Colors.white,
                  ),
                ),
              );
            }).toList(),
            onSelected: (value) {
              onLanguageChanged(value);
            },
          ),
        ),
      ],
    );
  }
} 