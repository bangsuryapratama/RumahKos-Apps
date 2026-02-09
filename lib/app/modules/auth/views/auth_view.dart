import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'login_view.dart';
import 'register_view.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  controller.isLogin.value
                      ? "Welcome Back 👋"
                      : "Create Account 🚀",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                controller.isLogin.value
                    ? const LoginView()
                    : const RegisterView(),

                const SizedBox(height: 20),

                Center(
                  child: TextButton(
                    onPressed: controller.toggleAuthMode,
                    child: Text(
                      controller.isLogin.value
                          ? "Belum punya akun? Daftar"
                          : "Sudah punya akun? Login",
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
