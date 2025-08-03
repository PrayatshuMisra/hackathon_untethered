import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class LanguageSelector extends StatelessWidget {
  final String title;
  final String selectedLanguage;
  final List<String> languages;
  final Function(String) onLanguageChanged;

  const LanguageSelector({
    super.key,
    required this.title,
    required this.selectedLanguage,
    required this.languages,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
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