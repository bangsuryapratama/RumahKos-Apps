import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  static const primaryBlue = Color(0xFF2563EB);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    final logoSize = isTablet ? 70.0 : 52.0;
    final titleSize = isTablet ? 42.0 : 30.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

      
          Positioned(
            top: -size.height * 0.15,
            left: -size.width * 0.2,
            child: Container(
              width: size.width * 0.9,
              height: size.width * 0.9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    primaryBlue.withOpacity(0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          /// MAIN CONTENT
          Center(
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              tween: Tween(begin: 0, end: 1),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.95 + (0.05 * value),
                    child: child,
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// LOGO
                  Container(
                    width: logoSize,
                    height: logoSize,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// TITLE
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: titleSize,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                        color: Colors.black,
                      ),
                      children: const [
                        TextSpan(text: 'Rumah'),
                        TextSpan(
                          text: 'Kos',
                          style: TextStyle(
                            color: primaryBlue,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// TAGLINE
                  Text(
                    "Temukan hunian terbaikmu",
                    style: TextStyle(
                      fontSize: isTablet ? 18 : 14,
                      color: Colors.grey.shade600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// PROGRESS BAR
          Positioned(
            bottom: 50,
            left: size.width * 0.15,
            right: size.width * 0.15,
            child: Obx(
              () => ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: LinearProgressIndicator(
                  value: controller.progress.value,
                  minHeight: 6,
                  backgroundColor: Colors.grey.shade200,
                  valueColor:
                      const AlwaysStoppedAnimation(primaryBlue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
