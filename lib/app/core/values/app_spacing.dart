import 'package:flutter/material.dart';

class AppSpacing {
  // Private constructor
  AppSpacing._();

  // ═══════════════════════════════════════════════════════════════
  // BASE SPACING SCALE (4px base unit)
  // ═══════════════════════════════════════════════════════════════
  static const double xxs = 2.0;   // 2px
  static const double xs = 4.0;    // 4px
  static const double sm = 8.0;    // 8px
  static const double md = 12.0;   // 12px
  static const double lg = 16.0;   // 16px
  static const double xl = 20.0;   // 20px
  static const double xxl = 24.0;  // 24px
  static const double xxxl = 32.0; // 32px
  static const double xxxxl = 40.0; // 40px
  static const double xxxxxl = 48.0; // 48px

  // ═══════════════════════════════════════════════════════════════
  // SEMANTIC SPACING
  // ═══════════════════════════════════════════════════════════════

  /// Gap between sections in a screen
  static const double sectionGap = 32.0;

  /// Gap between related items in a list
  static const double listItemGap = 12.0;

  /// Gap between card elements
  static const double cardGap = 16.0;

  /// Standard card padding
  static const double cardPadding = 20.0;

  /// Small card padding
  static const double cardPaddingSmall = 16.0;

  /// Large card padding
  static const double cardPaddingLarge = 24.0;

  // ═══════════════════════════════════════════════════════════════
  // SCREEN PADDING
  // ═══════════════════════════════════════════════════════════════

  /// Default horizontal screen padding (mobile)
  static const double screenHorizontalMobile = 20.0;

  /// Default horizontal screen padding (tablet)
  static const double screenHorizontalTablet = 40.0;

  /// Default horizontal screen padding (desktop)
  static const double screenHorizontalDesktop = 60.0;

  /// Responsive horizontal screen padding
  static double screenHorizontal(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1240) return screenHorizontalDesktop;
    if (width > 600) return screenHorizontalTablet;
    return screenHorizontalMobile;
  }

  /// Default vertical screen padding
  static const double screenVertical = 24.0;

  /// Screen padding with responsive horizontal
  static EdgeInsets screenPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: screenHorizontal(context),
      vertical: screenVertical,
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // GRID/LIST SPACING
  // ═══════════════════════════════════════════════════════════════

  /// Grid item spacing (small)
  static const double gridSpacingSmall = 8.0;

  /// Grid item spacing (medium)
  static const double gridSpacingMedium = 12.0;

  /// Grid item spacing (large)
  static const double gridSpacingLarge = 16.0;

  // ═══════════════════════════════════════════════════════════════
  // COMPONENT-SPECIFIC SPACING
  // ═══════════════════════════════════════════════════════════════

  /// Space between icon and text in buttons
  static const double iconTextGap = 8.0;

  /// Space between badge dot and text
  static const double badgeDotTextGap = 6.0;

  /// Space between form fields
  static const double formFieldGap = 16.0;

  /// Space after section headers
  static const double sectionHeaderGap = 12.0;

  // ═══════════════════════════════════════════════════════════════
  // EDGEINSETS PRESETS
  // ═══════════════════════════════════════════════════════════════

  /// All XXS (2px)
  static const EdgeInsets allXXS = EdgeInsets.all(xxs);

  /// All XS (4px)
  static const EdgeInsets allXS = EdgeInsets.all(xs);

  /// All SM (8px)
  static const EdgeInsets allSM = EdgeInsets.all(sm);

  /// All MD (12px)
  static const EdgeInsets allMD = EdgeInsets.all(md);

  /// All LG (16px)
  static const EdgeInsets allLG = EdgeInsets.all(lg);

  /// All XL (20px)
  static const EdgeInsets allXL = EdgeInsets.all(xl);

  /// All XXL (24px)
  static const EdgeInsets allXXL = EdgeInsets.all(xxl);

  /// All XXXL (32px)
  static const EdgeInsets allXXXL = EdgeInsets.all(xxxl);

  // Horizontal presets

  /// Horizontal SM (8px)
  static const EdgeInsets horizontalSM = EdgeInsets.symmetric(horizontal: sm);

  /// Horizontal MD (12px)
  static const EdgeInsets horizontalMD = EdgeInsets.symmetric(horizontal: md);

  /// Horizontal LG (16px)
  static const EdgeInsets horizontalLG = EdgeInsets.symmetric(horizontal: lg);

  /// Horizontal XL (20px)
  static const EdgeInsets horizontalXL = EdgeInsets.symmetric(horizontal: xl);

  /// Horizontal XXL (24px)
  static const EdgeInsets horizontalXXL = EdgeInsets.symmetric(horizontal: xxl);

  // Vertical presets

  /// Vertical SM (8px)
  static const EdgeInsets verticalSM = EdgeInsets.symmetric(vertical: sm);

  /// Vertical MD (12px)
  static const EdgeInsets verticalMD = EdgeInsets.symmetric(vertical: md);

  /// Vertical LG (16px)
  static const EdgeInsets verticalLG = EdgeInsets.symmetric(vertical: lg);

  /// Vertical XL (20px)
  static const EdgeInsets verticalXL = EdgeInsets.symmetric(vertical: xl);

  /// Vertical XXL (24px)
  static const EdgeInsets verticalXXL = EdgeInsets.symmetric(vertical: xxl);

  // Combined presets

  /// Card padding preset (20px all)
  static const EdgeInsets card = EdgeInsets.all(cardPadding);

  /// Card padding small preset (16px all)
  static const EdgeInsets cardSmall = EdgeInsets.all(cardPaddingSmall);

  /// Card padding large preset (24px all)
  static const EdgeInsets cardLarge = EdgeInsets.all(cardPaddingLarge);

  // ═══════════════════════════════════════════════════════════════
  // SIZEDBOX PRESETS (for vertical spacing)
  // ═══════════════════════════════════════════════════════════════

  /// Vertical gap XXS (2px)
  static const Widget gapXXS = SizedBox(height: xxs);

  /// Vertical gap XS (4px)
  static const Widget gapXS = SizedBox(height: xs);

  /// Vertical gap SM (8px)
  static const Widget gapSM = SizedBox(height: sm);

  /// Vertical gap MD (12px)
  static const Widget gapMD = SizedBox(height: md);

  /// Vertical gap LG (16px)
  static const Widget gapLG = SizedBox(height: lg);

  /// Vertical gap XL (20px)
  static const Widget gapXL = SizedBox(height: xl);

  /// Vertical gap XXL (24px)
  static const Widget gapXXL = SizedBox(height: xxl);

  /// Vertical gap XXXL (32px)
  static const Widget gapXXXL = SizedBox(height: xxxl);

  /// Section gap (32px)
  static const Widget gapSection = SizedBox(height: sectionGap);

  // Horizontal gaps

  /// Horizontal gap XS (4px)
  static const Widget hGapXS = SizedBox(width: xs);

  /// Horizontal gap SM (8px)
  static const Widget hGapSM = SizedBox(width: sm);

  /// Horizontal gap MD (12px)
  static const Widget hGapMD = SizedBox(width: md);

  /// Horizontal gap LG (16px)
  static const Widget hGapLG = SizedBox(width: lg);

  /// Horizontal gap XL (20px)
  static const Widget hGapXL = SizedBox(width: xl);

  // ═══════════════════════════════════════════════════════════════
  // RESPONSIVE HELPERS
  // ═══════════════════════════════════════════════════════════════

  /// Returns appropriate spacing based on screen width
  /// mobile: small, tablet: medium, desktop: large
  static double responsive(
    BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final width = MediaQuery.of(context).size.width;

    if (width > 1240 && desktop != null) return desktop;
    if (width > 600 && tablet != null) return tablet;
    return mobile ?? md;
  }

  /// Returns EdgeInsets based on screen width
  static EdgeInsets responsivePadding(
    BuildContext context, {
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    final width = MediaQuery.of(context).size.width;

    if (width > 1240 && desktop != null) return desktop;
    if (width > 600 && tablet != null) return tablet;
    return mobile ?? allMD;
  }

  // ═══════════════════════════════════════════════════════════════
  // SAFE AREA HELPERS
  // ═══════════════════════════════════════════════════════════════

  /// Get safe area top padding
  static double safeTop(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// Get safe area bottom padding
  static double safeBottom(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  /// Get safe area left padding
  static double safeLeft(BuildContext context) {
    return MediaQuery.of(context).padding.left;
  }

  /// Get safe area right padding
  static double safeRight(BuildContext context) {
    return MediaQuery.of(context).padding.right;
  }

  // ═══════════════════════════════════════════════════════════════
  // DIVIDER HELPERS
  // ═══════════════════════════════════════════════════════════════

  /// Standard divider with vertical spacing
  static Widget divider({
    double height = 1,
    double spacing = md,
    Color? color,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spacing),
      child: Divider(height: height, color: color),
    );
  }

  /// Thin divider without spacing
  static Widget dividerThin({Color? color}) {
    return Divider(height: 1, thickness: 1, color: color);
  }
}
