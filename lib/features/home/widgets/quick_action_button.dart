import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import 'dart:ui';

class QuickActionButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final IconData? secondaryIcon;
  final Color color;
  final VoidCallback onTap;
  final bool isActive;

  const QuickActionButton({
    super.key,
    required this.title,
    required this.icon,
    this.secondaryIcon,
    required this.color,
    required this.onTap,
    this.isActive = false,
  });

  @override
  State<QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<QuickActionButton>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _pulseController;
  late AnimationController _glowController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    if (widget.isActive) {
      _pulseController.repeat(reverse: true);
      _glowController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _pulseController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  LinearGradient _getGradient() {
    // Create gradient based on color
    if (widget.color == AppTheme.primaryBlue) {
      return AppTheme.primaryGradient;
    } else if (widget.color == AppTheme.accentCyan) {
      return AppTheme.cyberGradient;
    } else if (widget.color == AppTheme.accentPink) {
      return AppTheme.accentGradient;
    } else if (widget.color == AppTheme.secondaryPurple) {
      return AppTheme.secondaryGradient;
    } else if (widget.color == AppTheme.warningOrange) {
      return AppTheme.neonGradient;
    } else if (widget.color == AppTheme.errorRed) {
      return AppTheme.secondaryGradient;
    }
    return AppTheme.primaryGradient;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _hoverController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _hoverController.reverse();
      },
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          widget.onTap();
        },
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (_hoverController.value * 0.08),
              child: Container(
                decoration: BoxDecoration(
                  gradient: _getGradient(),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.color.withOpacity(0.4),
                      blurRadius: 20 + (_hoverController.value * 15),
                      offset: Offset(0, 8 + (_hoverController.value * 4)),
                      spreadRadius: _hoverController.value * 3,
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Enhanced Icon with glow effect
                          AnimatedBuilder(
                            animation: _glowController,
                            builder: (context, child) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.2),
                                  boxShadow: widget.isActive ? [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.3 + (_glowController.value * 0.2)),
                                      blurRadius: 25,
                                      spreadRadius: 8,
                                    ),
                                  ] : [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.1),
                                      blurRadius: 15,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    if (widget.secondaryIcon != null)
                                      Positioned(
                                        right: -2,
                                        bottom: -2,
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            gradient: AppTheme.cyberGradient,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppTheme.cyberGradientStart.withOpacity(0.4),
                                                blurRadius: 8,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            widget.secondaryIcon,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    Icon(
                                      widget.icon,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          // Enhanced Title
                          Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: AppTheme.techBody.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.1,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ).animate()
      .fadeIn(
        duration: const Duration(milliseconds: 800),
        curve: AppTheme.gentleCurve,
      )
      .slideY(
        begin: 0.4,
        duration: const Duration(milliseconds: 800),
        curve: AppTheme.gentleCurve,
      )
      .then()
      .shimmer(
        duration: const Duration(milliseconds: 2500),
        color: Colors.white.withOpacity(0.08),
      );
  }
}