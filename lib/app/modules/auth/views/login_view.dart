import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF2563EB);

    return Column(
      key: const ValueKey('LoginMode'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Selamat Datang",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Masuk untuk mengelola hunian Anda",
          style: TextStyle(
            color: Color(0xFF64748B),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 32),

        // Email
        _buildLabel("Email"),
        TextField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: _buildInputDecoration(
            "contoh@email.com",
            Icons.email_outlined,
          ),
        ),
        const SizedBox(height: 20),

        // Password
        _buildLabel("Password"),
        Obx(() => TextField(
          controller: controller.passwordController,
          obscureText: !controller.isPasswordVisible.value,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => controller.login(),
          decoration: _buildInputDecoration(
            "Masukkan password",
            Icons.lock_outline,
          ).copyWith(
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordVisible.value
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: const Color(0xFF64748B),
              ),
              onPressed: () => controller.isPasswordVisible.toggle(),
            ),
          ),
        )),

        const SizedBox(height: 32),

        // Button Login
        Obx(() => SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: controller.isLoading.value
                ? null
                : () => controller.login(),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBlue,
              disabledBackgroundColor: primaryBlue.withOpacity(0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: controller.isLoading.value
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    "Masuk",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        )),

        const SizedBox(height: 24),

        // Divider
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: const Color(0xFFE2E8F0),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Atau masuk dengan",
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: const Color(0xFFE2E8F0),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Google Button
        Obx(() => SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton.icon(
            onPressed: controller.isLoading.value
                ? null
                : () => controller.loginWithGoogle(),
            icon: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.png',
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.g_mobiledata_rounded,
                  size: 32,
                  color: Color(0xFF1E293B),
                );
              },
            ),
            label: const Text(
              "Masuk dengan Google",
              style: TextStyle(
                color: Color(0xFF1E293B),
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFE2E8F0)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.white,
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF1E293B),
          fontSize: 14,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF94A3B8),
        fontSize: 15,
      ),
      prefixIcon: Icon(icon, color: const Color(0xFF64748B), size: 22),
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFEF4444)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
      ),
    );
  }
}
