import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';

class StorageInfoCard extends StatelessWidget {
  const StorageInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated storage data
    const totalStorage = 1024; // MB
    const usedStorage = 256; // MB
    const memoriesStorage = 128; // MB
    const documentsStorage = 64; // MB
    const otherStorage = 64; // MB

    final usagePercentage = (usedStorage / totalStorage) * 100;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.getEnhancedGlassmorphicDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: AppTheme.oceanGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.storage,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Storage Usage',
                      style: AppTheme.techHeading.copyWith(
                        color: AppTheme.getTextPrimaryColor(context),
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                      ),
                    ),
                    Text(
                      'Manage your app data',
                      style: AppTheme.techCaption.copyWith(
                        color: AppTheme.getTextSecondaryColor(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: usagePercentage > 80
                      ? AppTheme.secondaryGradient
                      : usagePercentage > 60
                          ? AppTheme.neonGradient
                          : AppTheme.cyberGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${usedStorage}MB / ${totalStorage}MB',
                  style: AppTheme.techLabel.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Enhanced Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Used Space',
                    style: AppTheme.techBody.copyWith(
                      color: AppTheme.getTextPrimaryColor(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${usagePercentage.toStringAsFixed(1)}%',
                    style: AppTheme.techBody.copyWith(
                      color: usagePercentage > 80
                          ? AppTheme.errorRed
                          : usagePercentage > 60
                              ? AppTheme.warningOrange
                              : AppTheme.successGreen,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
                             Container(
                 height: 8,
                 decoration: BoxDecoration(
                   color: AppTheme.getGlassBackgroundColor(context),
                   borderRadius: BorderRadius.circular(4),
                   border: Border.all(
                     color: AppTheme.getGlassBorderColor(context),
                     width: 1,
                   ),
                 ),
                 child: Stack(
                   children: [
                     Container(
                       width: (MediaQuery.of(context).size.width - 80) * (usagePercentage / 100),
                       decoration: BoxDecoration(
                         gradient: usagePercentage > 80
                             ? AppTheme.secondaryGradient
                             : usagePercentage > 60
                                 ? AppTheme.neonGradient
                                 : AppTheme.cyberGradient,
                         borderRadius: BorderRadius.circular(4),
                       ),
                     ),
                   ],
                 ),
               ),
            ],
          ),
          const SizedBox(height: 24),

          // Enhanced Storage Breakdown
          Text(
            'Storage Breakdown',
            style: AppTheme.techBody.copyWith(
              color: AppTheme.getTextPrimaryColor(context),
              fontWeight: FontWeight.w700,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStorageItem(
                  context,
                  'Memories',
                  memoriesStorage,
                  usedStorage,
                  AppTheme.primaryGradient,
                  Icons.psychology,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStorageItem(
                  context,
                  'Documents',
                  documentsStorage,
                  usedStorage,
                  AppTheme.accentGradient,
                  Icons.description,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStorageItem(
                  context,
                  'Other',
                  otherStorage,
                  usedStorage,
                  AppTheme.sunsetGradient,
                  Icons.folder,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate()
      .fadeIn(
        duration: const Duration(milliseconds: 600),
        curve: AppTheme.gentleCurve,
      )
      .slideY(
        begin: 0.3,
        duration: const Duration(milliseconds: 600),
        curve: AppTheme.gentleCurve,
      );
  }

  Widget _buildStorageItem(
    BuildContext context,
    String label,
    int size,
    int total,
    LinearGradient gradient,
    IconData icon,
  ) {
    final percentage = (size / total) * 100;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradient.colors.first.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const Spacer(),
              Text(
                '${size}MB',
                style: AppTheme.techLabel.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: AppTheme.techBody.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${percentage.toStringAsFixed(1)}% of total',
            style: AppTheme.techCaption.copyWith(
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
          );
    }
} 