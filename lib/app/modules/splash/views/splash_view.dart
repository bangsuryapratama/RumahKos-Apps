import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360 || size.height < 640;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E40AF),
              Color(0xFF2563EB),
              Color(0xFF3B82F6),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 16 : 20,
                        vertical: 16,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: isSmallScreen ? 6 : 7,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildAnimatedLogo(isSmallScreen),
                                  SizedBox(height: isSmallScreen ? 20 : 30),
                                  _buildTitleSection(isSmallScreen),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: _buildLoadingSection(),
                          ),
                          Expanded(
                            flex: 1,
                            child: _buildBottomSection(isSmallScreen),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo(bool isSmallScreen) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1500),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Transform.rotate(
            angle: (1 - value) * 1.5,
            child: Hero(
              tag: 'rumahkos_logo',
              child: Container(
                padding: EdgeInsets.all(isSmallScreen ? 18 : 22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 25,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.home_rounded,
                  size: isSmallScreen ? 40 : 50,
                  color: const Color(0xFF2563EB),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleSection(bool isSmallScreen) {
    return TweenAnimationBuilder<Offset>(
      duration: const Duration(milliseconds: 1200),
      tween: Tween(begin: const Offset(0, 50), end: const Offset(0, 0)),
      curve: Curves.easeOutBack,
      builder: (context, offset, child) {
        return Transform.translate(
          offset: offset,
          child: Opacity(
            opacity: offset == const Offset(0, 0) ? 1.0 : 0.0,
            child: Column(
              children: [
                Text(
                  'RumahKos',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 28 : 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Cari kos nyaman & terpercaya',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 14 : 20,
                    vertical: isSmallScreen ? 6 : 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    'Temukan hunian terbaik untukmu',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Menyiapkan hunian terbaik...',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 280),
          height: 6,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Obx(
            () => Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: 280 * controller.progress.value,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Obx(
          () => Text(
            '${(controller.progress.value * 100).toInt()}%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSection(bool isSmallScreen) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Version 1.0.0',
          style: TextStyle(
            color: Colors.white54,
            fontSize: isSmallScreen ? 10 : 12,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
