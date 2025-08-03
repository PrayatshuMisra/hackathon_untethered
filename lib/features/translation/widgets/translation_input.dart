import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class TranslationInput extends StatelessWidget {
  final String sourceLanguage;
  final String targetLanguage;
  final String inputText;
  final String translatedText;
  final Function(String) onInputChanged;
  final VoidCallback onTranslate;
  final VoidCallback onClear;

  const TranslationInput({
    super.key,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.inputText,
    required this.translatedText,
    required this.onInputChanged,
    required this.onTranslate,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          // Input Area
          Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text(
                        sourceLanguage,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.primaryBlue.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      if (inputText.isNotEmpty)
                        IconButton(
                          onPressed: onClear,
                          icon: const Icon(Icons.clear),
                          iconSize: 20,
                          color: AppTheme.primaryBlue.withOpacity(0.7),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: TextField(
                    onChanged: onInputChanged,
                    controller: TextEditingController(text: inputText),
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Enter text to translate...',
                      border: InputBorder.none,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppTheme.darkBlue
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Translate Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: inputText.isNotEmpty ? onTranslate : null,
              icon: const Icon(Icons.translate),
              label: const Text('Translate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Output Area
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? AppTheme.glassBackground
                  : AppTheme.glassBackgroundDark,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.secondaryTeal.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text(
                        targetLanguage,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.secondaryTeal.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      if (translatedText.isNotEmpty)
                        IconButton(
                          onPressed: () {
                            // Copy to clipboard
                            // Clipboard.setData(ClipboardData(text: translatedText));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Translation copied to clipboard'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: const Icon(Icons.copy),
                          iconSize: 20,
                          color: AppTheme.secondaryTeal.withOpacity(0.7),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 100),
                    child: translatedText.isNotEmpty
                        ? Text(
                            translatedText,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).brightness == Brightness.light
                                  ? AppTheme.darkBlue
                                  : Colors.white,
                              height: 1.4,
                            ),
                          )
                        : Text(
                            'Translation will appear here...',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.secondaryTeal.withOpacity(0.5),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 