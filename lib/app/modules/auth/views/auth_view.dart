import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'login_view.dart';
import 'register_view.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF2563EB);
    const textDark = Color(0xFF1E293B);
    const textGray = Color(0xFF64748B);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          // Full Screen Loader
          if (controller.isLoading.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: primaryBlue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(primaryBlue),
                      strokeWidth: 3,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Mohon tunggu...",
                    style: TextStyle(
                      color: textGray,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          // Main Content
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Back Button (Hanya di mode Register)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: !controller.isLogin.value
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: controller.toggleAuthMode,
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.arrow_back_ios_rounded,
                                      size: 18,
                                      color: textDark,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      "Kembali",
                                      style: TextStyle(
                                        color: textDark,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                SizedBox(height: controller.isLogin.value ? 40 : 20),

                // Animated Header Icon
                Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: Container(
                      key: ValueKey(controller.isLogin.value),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: primaryBlue.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        controller.isLogin.value
                            ? Icons.login_rounded
                            : Icons.person_add_alt_1_rounded,
                        color: primaryBlue,
                        size: 48,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Animated Content Switch
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.05),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: controller.isLogin.value
                      ?  LoginView(key: ValueKey('login'))
                      : const RegisterView(key: ValueKey('register')),
                ),

                const SizedBox(height: 32),

                // Footer: Toggle Button
                Center(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: controller.toggleAuthMode,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              color: textGray,
                              fontSize: 15,
                            ),
                            children: [
                              TextSpan(
                                text: controller.isLogin.value
                                    ? "Belum punya akun? "
                                    : "Sudah punya akun? ",
                              ),
                              TextSpan(
                                text: controller.isLogin.value
                                    ? "Daftar Sekarang"
                                    : "Masuk di sini",
                                style: const TextStyle(
                                  color: primaryBlue,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          );
        }),
      ),
    );
  }
}
