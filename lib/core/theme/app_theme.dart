import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Enhanced Futuristic Tech Color Palette
  static const Color primaryGradientStart = Color(0xFF667eea);
  static const Color primaryGradientEnd = Color(0xFF764ba2);
  static const Color secondaryGradientStart = Color(0xFFf093fb);
  static const Color secondaryGradientEnd = Color(0xFFf5576c);
  static const Color accentGradientStart = Color(0xFF4facfe);
  static const Color accentGradientEnd = Color(0xFF00f2fe);
  static const Color cyberGradientStart = Color(0xFF43e97b);
  static const Color cyberGradientEnd = Color(0xFF38f9d7);
  static const Color neonGradientStart = Color(0xFFfa709a);
  static const Color neonGradientEnd = Color(0xFFfee140);
  static const Color sunsetGradientStart = Color(0xFFffecd2);
  static const Color sunsetGradientEnd = Color(0xFFfcb69f);
  static const Color oceanGradientStart = Color(0xFFa8edea);
  static const Color oceanGradientEnd = Color(0xFFfed6e3);
  
  static const Color primaryBlue = Color(0xFF667eea);
  static const Color secondaryPurple = Color(0xFFf093fb);
  static const Color accentPink = Color(0xFFfa709a);
  static const Color accentCyan = Color(0xFF43e97b);
  static const Color successGreen = Color(0xFF38f9d7);
  static const Color warningOrange = Color(0xFFfee140);
  static const Color errorRed = Color(0xFFf5576c);
  static const Color infoBlue = Color(0xFF4facfe);
  
  // Additional enhanced colors
  static const Color secondaryTeal = Color(0xFF38f9d7);
  static const Color darkBlue = Color(0xFF1a1a2e);
  static const Color accentOrange = Color(0xFFfee140);
  static const Color glassBackground = Color(0xF2FFFFFF);
  static const Color glassBackgroundDark = Color(0xF21a1a2e);
  static const Color glassBorder = Color(0x1AFFFFFF);
  static const Color glassBorderDark = Color(0x1A000000);
  
  static const Color backgroundLight = Color(0xFFf8fafc);
  static const Color backgroundDark = Color(0xFF0f0f23);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1a1a2e);
  static const Color textPrimaryLight = Color(0xFF1e293b);
  static const Color textSecondaryLight = Color(0xFF64748b);
  static const Color textPrimaryDark = Color(0xFFf1f5f9);
  static const Color textSecondaryDark = Color(0xFF94a3b8);

  // Enhanced Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryGradientStart, primaryGradientEnd],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondaryGradientStart, secondaryGradientEnd],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentGradientStart, accentGradientEnd],
  );

  static const LinearGradient cyberGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [cyberGradientStart, cyberGradientEnd],
  );

  static const LinearGradient neonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [neonGradientStart, neonGradientEnd],
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [sunsetGradientStart, sunsetGradientEnd],
  );

  static const LinearGradient oceanGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [oceanGradientStart, oceanGradientEnd],
  );

  // Theme-aware methods
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? backgroundDark 
        : backgroundLight;
  }

  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? surfaceDark 
        : surfaceLight;
  }

  static Color getTextPrimaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? textPrimaryDark 
        : textPrimaryLight;
  }

  static Color getTextSecondaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? textSecondaryDark 
        : textSecondaryLight;
  }

  static Color getGlassBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? glassBackgroundDark 
        : glassBackground;
  }

  static Color getGlassBorderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark 
        ? glassBorderDark 
        : glassBorder;
  }

  // Enhanced Decorations
  static BoxDecoration getGlassmorphicDecoration(BuildContext context) {
    return BoxDecoration(
      color: getGlassBackgroundColor(context),
      borderRadius: BorderRadius.circular(28),
      border: Border.all(
        color: getGlassBorderColor(context),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 32,
          offset: const Offset(0, 16),
          spreadRadius: 0,
        ),
        BoxShadow(
          color: getSurfaceColor(context).withOpacity(0.1),
          blurRadius: 2,
          offset: const Offset(0, 2),
          spreadRadius: 0,
        ),
      ],
    );
  }

  static BoxDecoration getEnhancedGlassmorphicDecoration(BuildContext context) {
    return BoxDecoration(
      color: getGlassBackgroundColor(context),
      borderRadius: BorderRadius.circular(32),
      border: Border.all(
        color: getGlassBorderColor(context),
        width: 2,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 40,
          offset: const Offset(0, 20),
          spreadRadius: 0,
        ),
        BoxShadow(
          color: primaryBlue.withOpacity(0.05),
          blurRadius: 60,
          offset: const Offset(0, 30),
          spreadRadius: 0,
        ),
      ],
    );
  }

  static final BoxDecoration gradientCardDecoration = BoxDecoration(
    gradient: primaryGradient,
    borderRadius: BorderRadius.circular(28),
    boxShadow: [
      BoxShadow(
        color: primaryGradientStart.withOpacity(0.3),
        blurRadius: 24,
        offset: const Offset(0, 12),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: primaryGradientEnd.withOpacity(0.2),
        blurRadius: 40,
        offset: const Offset(0, 20),
        spreadRadius: 0,
      ),
    ],
  );

  static BoxDecoration getGradientCardDecoration(LinearGradient gradient) {
    return BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(28),
      boxShadow: [
        BoxShadow(
          color: gradient.colors.first.withOpacity(0.3),
          blurRadius: 24,
          offset: const Offset(0, 12),
          spreadRadius: 0,
        ),
        BoxShadow(
          color: gradient.colors.last.withOpacity(0.2),
          blurRadius: 40,
          offset: const Offset(0, 20),
          spreadRadius: 0,
        ),
      ],
    );
  }

  // Enhanced Text Styles with Modern Fonts
  static TextStyle get techTitle => GoogleFonts.spaceGrotesk(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    height: 1.1,
  );

  static TextStyle get techSubtitle => GoogleFonts.spaceGrotesk(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    height: 1.2,
  );

  static TextStyle get techHeading => GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    height: 1.3,
  );

  static TextStyle get techBody => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.1,
    height: 1.5,
  );

  static TextStyle get techCaption => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.4,
  );

  static TextStyle get techButton => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
    color: Colors.white,
  );

  static TextStyle get techLabel => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.2,
  );

  // Enhanced Animation Curves
  static const Curve techCurve = Curves.easeOutCubic;
  static const Curve bounceCurve = Curves.elasticOut;
  static const Curve smoothCurve = Curves.easeInOut;
  static const Curve springCurve = Curves.easeOutBack;
  static const Curve gentleCurve = Curves.easeInOutQuart;

  // Enhanced Button Styles
  static ButtonStyle getPrimaryButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      textStyle: techButton,
    );
  }

  static ButtonStyle getSecondaryButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: getGlassBackgroundColor(context),
      foregroundColor: getTextPrimaryColor(context),
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: getGlassBorderColor(context),
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      textStyle: techButton.copyWith(color: getTextPrimaryColor(context)),
    );
  }

  // Enhanced Input Decoration
  static InputDecoration getInputDecoration(BuildContext context, String label, IconData? icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon, color: getTextSecondaryColor(context)) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: getGlassBorderColor(context)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: getGlassBorderColor(context)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primaryBlue, width: 2),
      ),
      filled: true,
      fillColor: getGlassBackgroundColor(context),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      labelStyle: techCaption.copyWith(color: getTextSecondaryColor(context)),
    );
  }
} 