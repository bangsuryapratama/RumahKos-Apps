import 'package:flutter/material.dart';

/// Standardized color system untuk RumahKos App
class AppColors {
  // Private constructor
  AppColors._();

  // ═══════════════════════════════════════════════════════════════
  // PRIMARY BRAND (Original)
  // ═══════════════════════════════════════════════════════════════
  static const primary = Color(0xFF1E3A8A); // Navy Blue
  static const secondary = Color(0xFFFBBF24); // Amber

  // ═══════════════════════════════════════════════════════════════
  // EXTENDED BRAND COLORS
  // ═══════════════════════════════════════════════════════════════
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color primaryDark = Color(0xFF1E40AF);
  static const Color primaryDarker = Color(0xFF1D4ED8);

  static const Color secondaryLight = Color(0xFFFCD34D);
  static const Color secondaryDark = Color(0xFFF59E0B);

  // ═══════════════════════════════════════════════════════════════
  // BACKGROUND (Original)
  // ═══════════════════════════════════════════════════════════════
  static const background = Color(0xFFF8FAFC);
  static const card = Colors.white;

  // ═══════════════════════════════════════════════════════════════
  // TEXT COLORS (Original)
  // ═══════════════════════════════════════════════════════════════
  static const textDark = Color(0xFF111827);
  static const textMedium = Color(0xFF374151);
  static const textLight = Color(0xFF9CA3AF);

  // ═══════════════════════════════════════════════════════════════
  // BORDER COLORS (Original)
  // ═══════════════════════════════════════════════════════════════
  static const borderLight = Color(0xFFE5E7EB);
  static const borderMedium = Color(0xFFD1D5DB);

  // ═══════════════════════════════════════════════════════════════
  // INPUT / SURFACE (Original)
  // ═══════════════════════════════════════════════════════════════
  static const inputFill = Color(0xFFF9FAFB);

  // ═══════════════════════════════════════════════════════════════
  // GRADIENTS (Original)
  // ═══════════════════════════════════════════════════════════════
  static const gradientStart = Color(0xFFF9FAFB);
  static const gradientEnd = Color(0xFFE5E7EB);

  // ═══════════════════════════════════════════════════════════════
  // STATUS (Original)
  // ═══════════════════════════════════════════════════════════════
  static const success = Color(0xFF16A34A);
  static const danger = Color(0xFFDC2626);

  // ═══════════════════════════════════════════════════════════════
  // ERROR (Original)
  // ═══════════════════════════════════════════════════════════════
  static const error = Color(0xFFB91C1C);

  // ═══════════════════════════════════════════════════════════════
  // EXTENDED SEMANTIC COLORS
  // ═══════════════════════════════════════════════════════════════
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);

  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF2563EB);

  // ═══════════════════════════════════════════════════════════════
  // NEUTRAL COLORS (Slate Palette)
  // ═══════════════════════════════════════════════════════════════
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color slate950 = Color(0xFF020617);

  // ═══════════════════════════════════════════════════════════════
  // SURFACE COLORS - Dark Mode
  // ═══════════════════════════════════════════════════════════════
  static const Color darkBackground = Color(0xFF080F1F);
  static const Color darkSurface = Color(0xFF0F172A);
  static const Color darkCard = Color(0xFF131D35);
  static const Color darkCardElevated = Color(0xFF1E293B);
  static const Color darkBorder = Color(0xFF1E293B);
  static const Color darkDivider = Color(0xFF1E293B);

  // ═══════════════════════════════════════════════════════════════
  // SURFACE COLORS - Light Mode
  // ═══════════════════════════════════════════════════════════════
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightDivider = Color(0xFFF1F5F9);

  // ═══════════════════════════════════════════════════════════════
  // OVERLAY & SHADOW COLORS
  // ═══════════════════════════════════════════════════════════════
  static const Color overlay = Color(0x0A000000); // 4% black
  static const Color overlayMedium = Color(0x14000000); // 8% black
  static const Color overlayStrong = Color(0x29000000); // 16% black

  static const Color shadowLight = Color(0x0D000000); // 5% black
  static const Color shadowMedium = Color(0x1A000000); // 10% black
  static const Color shadowStrong = Color(0x33000000); // 20% black

  // ═══════════════════════════════════════════════════════════════
  // SHIMMER COLORS
  // ═══════════════════════════════════════════════════════════════
  static const Color shimmerBase = Color(0xFFE2E8F0);
  static const Color shimmerHighlight = Color(0xFFF1F5F9);
  static const Color shimmerBaseDark = Color(0xFF1A2640);
  static const Color shimmerHighlightDark = Color(0xFF253654);

  // ═══════════════════════════════════════════════════════════════
  // CONTEXT-AWARE HELPER METHODS
  // ═══════════════════════════════════════════════════════════════

  /// Check if current theme is dark
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Get background color based on theme
  static Color getBackground(BuildContext context) {
    return isDark(context) ? darkBackground : background;
  }

  /// Get surface/card color based on theme
  static Color getSurface(BuildContext context) {
    return isDark(context) ? darkCard : card;
  }

  /// Get border color based on theme
  static Color getBorder(BuildContext context) {
    return isDark(context) ? darkBorder : borderLight;
  }

  /// Get divider color based on theme
  static Color getDivider(BuildContext context) {
    return isDark(context) ? darkDivider : lightDivider;
  }

  /// Get primary text color based on theme
  static Color getTextPrimary(BuildContext context) {
    return isDark(context) ? Colors.white : textDark;
  }

  /// Get secondary text color based on theme
  static Color getTextSecondary(BuildContext context) {
    return isDark(context) ? slate400 : textMedium;
  }

  /// Get tertiary/hint text color based on theme
  static Color getTextTertiary(BuildContext context) {
    return isDark(context) ? slate500 : textLight;
  }

  /// Get shimmer base color based on theme
  static Color getShimmerBase(BuildContext context) {
    return isDark(context) ? shimmerBaseDark : shimmerBase;
  }

  /// Get shimmer highlight color based on theme
  static Color getShimmerHighlight(BuildContext context) {
    return isDark(context) ? shimmerHighlightDark : shimmerHighlight;
  }

  /// Get shadow color with adaptive opacity based on theme
  static Color getShadow(BuildContext context, [double opacity = 0.1]) {
    return Colors.black.withOpacity(
      isDark(context) ? opacity * 2 : opacity,
    );
  }

  /// Subtle overlay for hover states
  static Color getOverlay(BuildContext context, [double opacity = 0.05]) {
    return isDark(context)
        ? Colors.white.withOpacity(opacity)
        : Colors.black.withOpacity(opacity);
  }

  /// Returns color with adaptive opacity based on theme
  static Color withAdaptiveOpacity(
    BuildContext context,
    Color color,
    double lightOpacity,
    double darkOpacity,
  ) {
    return color.withOpacity(
      isDark(context) ? darkOpacity : lightOpacity,
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // GRADIENT PRESETS
  // ═══════════════════════════════════════════════════════════════

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [success, successDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient errorGradient = LinearGradient(
    colors: [error, errorDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// Dark mode card gradient
  static LinearGradient get darkCardGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      darkCard,
      darkCard.withOpacity(0.8),
    ],
  );

  // ═══════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ═══════════════════════════════════════════════════════════════

  /// Get status color by type
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'success':
      case 'completed':
      case 'paid':
      case 'active':
        return success;
      case 'warning':
      case 'pending':
      case 'processing':
        return warning;
      case 'error':
      case 'failed':
      case 'rejected':
      case 'cancelled':
        return error;
      case 'info':
      case 'draft':
        return info;
      default:
        return textMedium;
    }
  }
}
