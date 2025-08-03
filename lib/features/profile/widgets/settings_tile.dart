import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? iconColor;
  final Color? textColor;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailing,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultIconColor = iconColor ?? AppTheme.primaryBlue;
    final defaultTextColor = textColor ?? AppTheme.getTextPrimaryColor(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: AppTheme.getGlassmorphicDecoration(context),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Enhanced Icon Container
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        defaultIconColor.withOpacity(0.2),
                        defaultIconColor.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: defaultIconColor.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: defaultIconColor,
                    size: 24,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTheme.techBody.copyWith(
                          fontWeight: FontWeight.w700,
                          color: defaultTextColor,
                          letterSpacing: -0.1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: AppTheme.techCaption.copyWith(
                          color: AppTheme.getTextSecondaryColor(context),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Trailing Widget
                trailing ?? (onTap != null
                    ? Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.getGlassBackgroundColor(context),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppTheme.getGlassBorderColor(context),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppTheme.getTextSecondaryColor(context),
                        ),
                      )
                    : const SizedBox.shrink()),
              ],
            ),
          ),
        ),
      ),
          );
    }
} 