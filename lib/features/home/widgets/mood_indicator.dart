import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';

class MoodIndicator extends StatefulWidget {
  const MoodIndicator({super.key});

  @override
  State<MoodIndicator> createState() => _MoodIndicatorState();
}

class _MoodIndicatorState extends State<MoodIndicator>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _floatController;
  int _selectedMood = 1; // Default to neutral (index 1 since we removed the first item)

  final List<Map<String, dynamic>> _moods = [
    {'emoji': '😕', 'name': 'Down', 'gradient': AppTheme.neonGradient},
    {'emoji': '😐', 'name': 'Neutral', 'gradient': AppTheme.oceanGradient},
    {'emoji': '🙂', 'name': 'Good', 'gradient': AppTheme.cyberGradient},
    {'emoji': '😄', 'name': 'Great', 'gradient': AppTheme.primaryGradient},
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.getEnhancedGlassmorphicDecoration(context),
      child: Column(
        children: [
          // Current mood display
          _buildCurrentMood(),
          const SizedBox(height: 24),
          // Mood selection
          _buildMoodSelection(),
        ],
      ),
    );
  }

  Widget _buildCurrentMood() {
    final currentMood = _moods[_selectedMood];
    return Column(
      children: [
        AnimatedBuilder(
          animation: _floatController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _floatController.value * 8),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: currentMood['gradient'],
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: currentMood['gradient'].colors.first.withOpacity(0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 12),
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    currentMood['emoji'],
                    style: const TextStyle(fontSize: 48),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Text(
          currentMood['name'],
          style: AppTheme.techHeading.copyWith(
            color: AppTheme.getTextPrimaryColor(context),
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
        ),
        Text(
          'Current Mood',
          style: AppTheme.techCaption.copyWith(
            color: AppTheme.getTextSecondaryColor(context),
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
      ],
    ).animate()
      .fadeIn(
        duration: const Duration(milliseconds: 1000),
        curve: AppTheme.gentleCurve,
      )
      .scale(
        duration: const Duration(milliseconds: 800),
        curve: AppTheme.bounceCurve,
      );
  }

  Widget _buildMoodSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How are you feeling?',
          style: AppTheme.techBody.copyWith(
            color: AppTheme.getTextPrimaryColor(context),
            fontWeight: FontWeight.w700,
            letterSpacing: -0.1,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          constraints: const BoxConstraints(maxHeight: 120),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_moods.length, (index) {
              final mood = _moods[index];
              final isSelected = _selectedMood == index;
              
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => _selectedMood = index);
                    HapticFeedback.lightImpact();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: AppTheme.springCurve,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      gradient: isSelected ? mood['gradient'] : null,
                      color: isSelected ? null : AppTheme.getGlassBackgroundColor(context),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected 
                          ? Colors.white.withOpacity(0.3)
                          : AppTheme.getGlassBorderColor(context),
                        width: isSelected ? 2 : 1.5,
                      ),
                      boxShadow: isSelected ? [
                        BoxShadow(
                          color: mood['gradient'].colors.first.withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                          spreadRadius: 2,
                        ),
                      ] : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBuilder(
                          animation: isSelected ? _pulseController : const AlwaysStoppedAnimation(0),
                          builder: (context, child) {
                            return Transform.scale(
                              scale: isSelected ? 1.0 + (_pulseController.value * 0.1) : 1.0,
                              child: Text(
                                mood['emoji'],
                                style: TextStyle(
                                  fontSize: isSelected ? 28 : 24,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 6),
                        Text(
                          mood['name'],
                          style: AppTheme.techCaption.copyWith(
                            color: isSelected ? Colors.white : AppTheme.getTextSecondaryColor(context),
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            letterSpacing: 0.1,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ).animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 800),
                    delay: Duration(milliseconds: index * 150),
                    curve: AppTheme.gentleCurve,
                  )
                  .slideY(
                    begin: 0.4,
                    duration: const Duration(milliseconds: 800),
                    delay: Duration(milliseconds: index * 150),
                    curve: AppTheme.gentleCurve,
                  ),
              );
            }),
          ),
        ),
      ],
    );
  }
} 