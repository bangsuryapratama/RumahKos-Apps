import 'package:flutter/material.dart';

/// Standardized border radius system untuk RumahKos App
///
/// Usage:
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     borderRadius: AppRadius.card,
///     // or
///     borderRadius: BorderRadius.circular(AppRadius.lg),
///   ),
/// )
/// ```
class AppRadius {
  // Private constructor
  AppRadius._();

  // ═══════════════════════════════════════════════════════════════
  // BASE RADIUS SCALE
  // ═══════════════════════════════════════════════════════════════
  static const double none = 0.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 28.0;
  static const double xxxxl = 32.0;

  // ═══════════════════════════════════════════════════════════════
  // SEMANTIC RADIUS
  // ═══════════════════════════════════════════════════════════════

  /// Standard card radius
  static const double card = 20.0;

  /// Small card radius
  static const double cardSmall = 16.0;

  /// Large card radius (for hero cards)
  static const double cardLarge = 24.0;

  /// Extra large card radius (for featured cards)
  static const double cardXL = 28.0;

  /// Button radius
  static const double button = 14.0;

  /// Small button radius
  static const double buttonSmall = 10.0;

  /// Large button radius
  static const double buttonLarge = 16.0;

  /// Badge/Chip radius
  static const double badge = 8.0;

  /// Badge pill (fully rounded)
  static const double badgePill = 100.0;

  /// Input field radius
  static const double input = 12.0;

  /// Dialog/Bottom sheet radius
  static const double dialog = 24.0;

  /// Image radius
  static const double image = 16.0;

  /// Avatar radius
  static const double avatar = 12.0;

  /// Icon container radius
  static const double icon = 10.0;

  // ═══════════════════════════════════════════════════════════════
  // BORDERRADIUS PRESETS
  // ═══════════════════════════════════════════════════════════════

  /// No radius
  static const BorderRadius radiusNone = BorderRadius.zero;

  /// XS radius (4px)
  static const BorderRadius radiusXS = BorderRadius.all(Radius.circular(xs));

  /// SM radius (8px)
  static const BorderRadius radiusSM = BorderRadius.all(Radius.circular(sm));

  /// MD radius (12px)
  static const BorderRadius radiusMD = BorderRadius.all(Radius.circular(md));

  /// LG radius (16px)
  static const BorderRadius radiusLG = BorderRadius.all(Radius.circular(lg));

  /// XL radius (20px)
  static const BorderRadius radiusXL = BorderRadius.all(Radius.circular(xl));

  /// XXL radius (24px)
  static const BorderRadius radiusXXL = BorderRadius.all(Radius.circular(xxl));

  /// XXXL radius (28px)
  static const BorderRadius radiusXXXL = BorderRadius.all(Radius.circular(xxxl));

  /// XXXXL radius (32px)
  static const BorderRadius radiusXXXXL = BorderRadius.all(Radius.circular(xxxxl));

  // ═══════════════════════════════════════════════════════════════
  // SEMANTIC BORDERRADIUS PRESETS
  // ═══════════════════════════════════════════════════════════════

  /// Standard card border radius
  static BorderRadius get cardRadius =>
      const BorderRadius.all(Radius.circular(card));

  /// Small card border radius
  static BorderRadius get cardSmallRadius =>
      const BorderRadius.all(Radius.circular(cardSmall));

  /// Large card border radius
  static BorderRadius get cardLargeRadius =>
      const BorderRadius.all(Radius.circular(cardLarge));

  /// Extra large card border radius
  static BorderRadius get cardXLRadius =>
      const BorderRadius.all(Radius.circular(cardXL));

  /// Button border radius
  static BorderRadius get buttonRadius =>
      const BorderRadius.all(Radius.circular(button));

  /// Small button border radius
  static BorderRadius get buttonSmallRadius =>
      const BorderRadius.all(Radius.circular(buttonSmall));

  /// Large button border radius
  static BorderRadius get buttonLargeRadius =>
      const BorderRadius.all(Radius.circular(buttonLarge));

  /// Badge border radius
  static BorderRadius get badgeRadius =>
      const BorderRadius.all(Radius.circular(badge));

  /// Badge pill border radius (fully rounded)
  static BorderRadius get badgePillRadius =>
      const BorderRadius.all(Radius.circular(badgePill));

  /// Input field border radius
  static BorderRadius get inputRadius =>
      const BorderRadius.all(Radius.circular(input));

  /// Dialog border radius
  static BorderRadius get dialogRadius =>
      const BorderRadius.all(Radius.circular(dialog));

  /// Image border radius
  static BorderRadius get imageRadius =>
      const BorderRadius.all(Radius.circular(image));

  /// Avatar border radius
  static BorderRadius get avatarRadius =>
      const BorderRadius.all(Radius.circular(avatar));

  /// Icon container border radius
  static BorderRadius get iconRadius =>
      const BorderRadius.all(Radius.circular(icon));

  // ═══════════════════════════════════════════════════════════════
  // SPECIAL RADIUS PATTERNS
  // ═══════════════════════════════════════════════════════════════

  /// Top rounded only (for bottom sheets)
  static BorderRadius topRounded({double radius = xxl}) {
    return BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );
  }

  /// Bottom rounded only
  static BorderRadius bottomRounded({double radius = xxl}) {
    return BorderRadius.only(
      bottomLeft: Radius.circular(radius),
      bottomRight: Radius.circular(radius),
    );
  }

  /// Left rounded only
  static BorderRadius leftRounded({double radius = xxl}) {
    return BorderRadius.only(
      topLeft: Radius.circular(radius),
      bottomLeft: Radius.circular(radius),
    );
  }

  /// Right rounded only
  static BorderRadius rightRounded({double radius = xxl}) {
    return BorderRadius.only(
      topRight: Radius.circular(radius),
      bottomRight: Radius.circular(radius),
    );
  }

  /// Asymmetric radius (top-left different from others)
  static BorderRadius asymmetric({
    double topLeft = md,
    double topRight = md,
    double bottomLeft = md,
    double bottomRight = md,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft),
      topRight: Radius.circular(topRight),
      bottomLeft: Radius.circular(bottomLeft),
      bottomRight: Radius.circular(bottomRight),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // RESPONSIVE RADIUS
  // ═══════════════════════════════════════════════════════════════

  /// Returns responsive radius based on screen width
  /// Larger screens get slightly larger radius for better proportions
  static double responsive(
    BuildContext context, {
    double mobile = md,
    double tablet = lg,
    double desktop = xl,
  }) {
    final width = MediaQuery.of(context).size.width;

    if (width > 1240) return desktop;
    if (width > 600) return tablet;
    return mobile;
  }

  /// Returns responsive BorderRadius
  static BorderRadius responsiveBorderRadius(
    BuildContext context, {
    double mobile = md,
    double tablet = lg,
    double desktop = xl,
  }) {
    return BorderRadius.circular(
      responsive(context, mobile: mobile, tablet: tablet, desktop: desktop),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // CLIPRRECT HELPERS
  // ═══════════════════════════════════════════════════════════════

  /// Wrap widget with ClipRRect using standard card radius
  static Widget clipCard(Widget child) {
    return ClipRRect(
      borderRadius: cardRadius,
      child: child,
    );
  }

  /// Wrap widget with ClipRRect using button radius
  static Widget clipButton(Widget child) {
    return ClipRRect(
      borderRadius: buttonRadius,
      child: child,
    );
  }

  /// Wrap widget with ClipRRect using custom radius
  static Widget clip(Widget child, {double radius = md}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: child,
    );
  }

  /// Wrap widget with circular clip
  static Widget clipCircular(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(1000),
      child: child,
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // SHAPE HELPERS (for Material widgets)
  // ═══════════════════════════════════════════════════════════════

  /// RoundedRectangleBorder with card radius
  static RoundedRectangleBorder get cardShape => RoundedRectangleBorder(
    borderRadius: cardRadius,
  );

  /// RoundedRectangleBorder with button radius
  static RoundedRectangleBorder get buttonShape => RoundedRectangleBorder(
    borderRadius: buttonRadius,
  );

  /// RoundedRectangleBorder with dialog radius
  static RoundedRectangleBorder get dialogShape => RoundedRectangleBorder(
    borderRadius: dialogRadius,
  );

  /// RoundedRectangleBorder with custom radius
  static RoundedRectangleBorder shape({double radius = md}) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ═══════════════════════════════════════════════════════════════

  /// Get radius based on component type
  static double forComponent(String component) {
    switch (component.toLowerCase()) {
      case 'card':
        return card;
      case 'button':
        return button;
      case 'badge':
        return badge;
      case 'input':
        return input;
      case 'dialog':
        return dialog;
      case 'image':
        return image;
      default:
        return md;
    }
  }

  /// Scale radius by factor
  static double scale(double baseRadius, double factor) {
    return baseRadius * factor;
  }
}
