import 'package:flutter/material.dart';

/// Standardized typography system untuk RumahKos App
/// Based on Material Design 3 type scale with custom adjustments
///
/// Usage:
/// ```dart
/// Text(
///   'Hello World',
///   style: AppTypography.h1(context),
/// )
///
/// // Or for static usage
/// Text(
///   'Hello',
///   style: AppTypography.h1Static.copyWith(color: Colors.blue),
/// )
/// ```
class AppTypography {
  // Private constructor
  AppTypography._();

  // ═══════════════════════════════════════════════════════════════
  // DISPLAY STYLES (Large, prominent text)
  // ═══════════════════════════════════════════════════════════════

  static const TextStyle displayLargeStatic = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w900,
    letterSpacing: -1.5,
    height: 1.1,
  );

  static const TextStyle displayMediumStatic = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w900,
    letterSpacing: -1.0,
    height: 1.2,
  );

  static const TextStyle displaySmallStatic = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.8,
    height: 1.2,
  );

  // ═══════════════════════════════════════════════════════════════
  // HEADING STYLES
  // ═══════════════════════════════════════════════════════════════

  /// H1 - Main page titles
  static const TextStyle h1Static = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    height: 1.3,
  );

  /// H2 - Section titles
  static const TextStyle h2Static = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    height: 1.3,
  );

  /// H3 - Subsection titles
  static const TextStyle h3Static = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    height: 1.4,
  );

  /// H4 - Card titles
  static const TextStyle h4Static = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.1,
    height: 1.4,
  );

  /// H5 - Small titles
  static const TextStyle h5Static = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.4,
  );

  // ═══════════════════════════════════════════════════════════════
  // BODY TEXT STYLES
  // ═══════════════════════════════════════════════════════════════

  /// Body Large - Main content text
  static const TextStyle bodyLargeStatic = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.5,
  );

  /// Body Medium - Standard body text
  static const TextStyle bodyMediumStatic = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    height: 1.5,
  );

  /// Body Small - Secondary body text
  static const TextStyle bodySmallStatic = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    height: 1.4,
  );

  // ═══════════════════════════════════════════════════════════════
  // LABEL STYLES
  // ═══════════════════════════════════════════════════════════════

  /// Label Large - Button text, form labels
  static const TextStyle labelLargeStatic = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.2,
    height: 1.4,
  );

  /// Label Medium - Secondary labels
  static const TextStyle labelMediumStatic = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
    height: 1.3,
  );

  /// Label Small - Tiny labels, badges
  static const TextStyle labelSmallStatic = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    height: 1.3,
  );

  // ═══════════════════════════════════════════════════════════════
  // CAPTION & OVERLINE STYLES
  // ═══════════════════════════════════════════════════════════════

  /// Caption - Helper text, hints
  static const TextStyle captionStatic = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.4,
    height: 1.3,
  );

  /// Overline - Eyebrows, category labels
  static const TextStyle overlineStatic = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.5,
    height: 1.3,
  );

  // ═══════════════════════════════════════════════════════════════
  // SEMANTIC TEXT STYLES
  // ═══════════════════════════════════════════════════════════════

  /// Section header (all caps, spaced)
  static const TextStyle sectionHeaderStatic = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.8,
    height: 1.3,
  );

  /// Button text
  static const TextStyle buttonStatic = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.2,
    height: 1.2,
  );

  /// Button small
  static const TextStyle buttonSmallStatic = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
    height: 1.2,
  );

  /// Button large
  static const TextStyle buttonLargeStatic = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.2,
    height: 1.2,
  );

  /// Badge text
  static const TextStyle badgeStatic = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.4,
    height: 1.2,
  );

  /// Price text (numbers)
  static const TextStyle priceStatic = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w900,
    letterSpacing: -0.5,
    height: 1.2,
  );

  /// Price small
  static const TextStyle priceSmallStatic = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.3,
    height: 1.2,
  );

  /// Price large
  static const TextStyle priceLargeStatic = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w900,
    letterSpacing: -1.0,
    height: 1.0,
  );

  // ═══════════════════════════════════════════════════════════════
  // CONTEXT-AWARE METHODS (with theme colors)
  // ═══════════════════════════════════════════════════════════════

  /// Display Large with context-aware color
  static TextStyle displayLarge(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return displayLargeStatic.copyWith(
      color: color ?? (isDark ? Colors.white : const Color(0xFF0F172A)),
    );
  }

  /// Display Medium with context-aware color
  static TextStyle displayMedium(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return displayMediumStatic.copyWith(
      color: color ?? (isDark ? Colors.white : const Color(0xFF0F172A)),
    );
  }

  /// Display Small with context-aware color
  static TextStyle displaySmall(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return displaySmallStatic.copyWith(
      color: color ?? (isDark ? Colors.white : const Color(0xFF0F172A)),
    );
  }

  /// H1 with context-aware color
  static TextStyle h1(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return h1Static.copyWith(
      color: color ?? (isDark ? Colors.white : const Color(0xFF1E293B)),
    );
  }

  /// H2 with context-aware color
  static TextStyle h2(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return h2Static.copyWith(
      color: color ?? (isDark ? Colors.white : const Color(0xFF1E293B)),
    );
  }

  /// H3 with context-aware color
  static TextStyle h3(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return h3Static.copyWith(
      color: color ?? (isDark ? Colors.white : const Color(0xFF1E293B)),
    );
  }

  /// H4 with context-aware color
  static TextStyle h4(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return h4Static.copyWith(
      color: color ?? (isDark ? Colors.white : const Color(0xFF1E293B)),
    );
  }

  /// H5 with context-aware color
  static TextStyle h5(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return h5Static.copyWith(
      color: color ?? (isDark ? Colors.white : const Color(0xFF1E293B)),
    );
  }

  /// Body Large with context-aware color
  static TextStyle bodyLarge(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return bodyLargeStatic.copyWith(
      color: color ?? (isDark ? Colors.white70 : const Color(0xFF334155)),
    );
  }

  /// Body Medium with context-aware color
  static TextStyle bodyMedium(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return bodyMediumStatic.copyWith(
      color: color ?? (isDark ? Colors.white70 : const Color(0xFF334155)),
    );
  }

  /// Body Small with context-aware color
  static TextStyle bodySmall(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return bodySmallStatic.copyWith(
      color: color ?? (isDark ? Colors.white60 : const Color(0xFF64748B)),
    );
  }

  /// Label Large with context-aware color
  static TextStyle labelLarge(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return labelLargeStatic.copyWith(
      color: color ?? (isDark ? Colors.white : const Color(0xFF1E293B)),
    );
  }

  /// Label Medium with context-aware color
  static TextStyle labelMedium(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return labelMediumStatic.copyWith(
      color: color ?? (isDark ? Colors.white70 : const Color(0xFF334155)),
    );
  }

  /// Label Small with context-aware color
  static TextStyle labelSmall(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return labelSmallStatic.copyWith(
      color: color ?? (isDark ? Colors.white60 : const Color(0xFF64748B)),
    );
  }

  /// Caption with context-aware color
  static TextStyle caption(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return captionStatic.copyWith(
      color: color ?? (isDark ? Colors.white54 : const Color(0xFF64748B)),
    );
  }

  /// Overline with context-aware color
  static TextStyle overline(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return overlineStatic.copyWith(
      color: color ?? (isDark ? Colors.white54 : const Color(0xFF64748B)),
    );
  }

  /// Section Header with context-aware color
  static TextStyle sectionHeader(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return sectionHeaderStatic.copyWith(
      color: color ?? (isDark ? Colors.white54 : const Color(0xFF64748B)),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ═══════════════════════════════════════════════════════════════

  /// Apply color to any TextStyle
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Apply opacity to text style's color
  static TextStyle withOpacity(TextStyle style, double opacity) {
    return style.copyWith(
      color: style.color?.withOpacity(opacity),
    );
  }

  /// Make text style bold
  static TextStyle bold(TextStyle style) {
    return style.copyWith(fontWeight: FontWeight.w700);
  }

  /// Make text style bolder
  static TextStyle bolder(TextStyle style) {
    return style.copyWith(fontWeight: FontWeight.w900);
  }

  /// Make text style italic
  static TextStyle italic(TextStyle style) {
    return style.copyWith(fontStyle: FontStyle.italic);
  }

  /// Make text style underlined
  static TextStyle underline(TextStyle style) {
    return style.copyWith(decoration: TextDecoration.underline);
  }

  /// Scale font size by factor
  static TextStyle scale(TextStyle style, double factor) {
    return style.copyWith(fontSize: (style.fontSize ?? 14) * factor);
  }

  /// Adjust letter spacing
  static TextStyle letterSpacing(TextStyle style, double spacing) {
    return style.copyWith(letterSpacing: spacing);
  }

  /// Adjust line height
  static TextStyle lineHeight(TextStyle style, double height) {
    return style.copyWith(height: height);
  }

  // ═══════════════════════════════════════════════════════════════
  // RESPONSIVE HELPERS
  // ═══════════════════════════════════════════════════════════════

  /// Get responsive text style based on screen width
  /// Larger screens get slightly larger text
  static TextStyle responsive(
    BuildContext context,
    TextStyle baseStyle, {
    double mobileScale = 1.0,
    double tabletScale = 1.1,
    double desktopScale = 1.2,
  }) {
    final width = MediaQuery.of(context).size.width;
    final scaleFactor = width > 1240
        ? desktopScale
        : width > 600
            ? tabletScale
            : mobileScale;

    return scale(baseStyle, scaleFactor);
  }
}
