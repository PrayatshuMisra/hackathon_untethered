import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';

class OnboardingSlideData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final LinearGradient gradient;
  final String animation;

  OnboardingSlideData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.gradient,
    required this.animation,
  });
}

class OnboardingSlide extends StatelessWidget {
  final OnboardingSlideData data;

  const OnboardingSlide({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon Container with Gradient Background
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: data.gradient,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: data.color.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Icon(
              data.icon,
              size: 60,
              color: Colors.white,
            ),
          ).animate().scale(
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
          ).then().shake(
            duration: const Duration(milliseconds: 500),
            hz: 4,
          ),
          
          const SizedBox(height: 32),
          
          // Title
          Text(
            data.title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimaryLight,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(
            duration: const Duration(milliseconds: 600),
            delay: const Duration(milliseconds: 200),
          ).slideY(
            begin: 0.3,
            duration: const Duration(milliseconds: 600),
            delay: const Duration(milliseconds: 200),
          ),
          
          const SizedBox(height: 16),
          
          // Description
          Text(
            data.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondaryLight,
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(
            duration: const Duration(milliseconds: 600),
            delay: const Duration(milliseconds: 400),
          ).slideY(
            begin: 0.3,
            duration: const Duration(milliseconds: 600),
            delay: const Duration(milliseconds: 400),
          ),
          
          const SizedBox(height: 32),
          
          // Feature Highlights
          _buildFeatureHighlights(context),
        ],
      ),
    );
  }

  Widget _buildFeatureHighlights(BuildContext context) {
    List<Widget> features = [];
    
    switch (data.title) {
      case "Your Private AI Companion":
        features = [
          _buildFeatureItem(context, "🔒 End-to-end encryption", "Your data is never shared"),
          _buildFeatureItem(context, "🚀 Offline processing", "Works without internet"),
          _buildFeatureItem(context, "⚡ Real-time analysis", "Instant AI insights"),
        ];
        break;
      case "Smart Memory & Translation":
        features = [
          _buildFeatureItem(context, "🧠 Context awareness", "Understands your patterns"),
          _buildFeatureItem(context, "🌍 Multi-language support", "Translate 50+ languages"),
          _buildFeatureItem(context, "📝 Smart summarization", "AI-powered day summaries"),
        ];
        break;
      case "Complete Data Control":
        features = [
          _buildFeatureItem(context, "🗑️ One-tap deletion", "Remove data instantly"),
          _buildFeatureItem(context, "⏰ Auto-cleanup", "Set automatic deletion"),
          _buildFeatureItem(context, "📊 Data insights", "See what's stored"),
        ];
        break;
    }

    return Column(
      children: features.asMap().entries.map((entry) {
        final index = entry.key;
        final feature = entry.value;
        return feature.animate().fadeIn(
          duration: const Duration(milliseconds: 400),
          delay: Duration(milliseconds: 600 + (index * 100)),
        ).slideX(
          begin: 0.2,
          duration: const Duration(milliseconds: 400),
          delay: Duration(milliseconds: 600 + (index * 100)),
        );
      }).toList(),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String icon, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: AppTheme.glassmorphicDecoration,
      child: Row(
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimaryLight,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 