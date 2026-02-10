import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF2563EB);

    return Column(
      key: const ValueKey('RegisterMode'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Buat Akun",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Daftar untuk mulai menjadi penghuni",
          style: TextStyle(
            color: Color(0xFF64748B),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 28),

        // Nama Lengkap
        _buildLabel("Nama Lengkap"),
        TextField(
          controller: controller.nameController,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          decoration: _buildInputDecoration(
            "Masukkan nama lengkap",
            Icons.person_outline_rounded,
          ),
        ),
        const SizedBox(height: 16),

        // Email
        _buildLabel("Email"),
        TextField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: _buildInputDecoration(
            "email@anda.com",
            Icons.email_outlined,
          ),
        ),
        const SizedBox(height: 16),

        // Nomor Telepon
        _buildLabel("Nomor Telepon"),
        TextField(
          controller: controller.phoneController,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          decoration: _buildInputDecoration(
            "08xxxxxxxxxx",
            Icons.phone_android_outlined,
          ),
        ),
        const SizedBox(height: 16),

        // Password
        _buildLabel("Password"),
        Obx(() => TextField(
          controller: controller.passwordController,
          obscureText: !controller.isPasswordVisible.value,
          textInputAction: TextInputAction.next,
          decoration: _buildInputDecoration(
            "Minimal 8 karakter",
            Icons.lock_outline_rounded,
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
        const SizedBox(height: 16),

        // Konfirmasi Password
        _buildLabel("Konfirmasi Password"),
        Obx(() => TextField(
          controller: controller.confirmPasswordController,
          obscureText: !controller.isConfirmPasswordVisible.value,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => controller.register(),
          decoration: _buildInputDecoration(
            "Ulangi password",
            Icons.lock_reset_outlined,
          ).copyWith(
            suffixIcon: IconButton(
              icon: Icon(
                controller.isConfirmPasswordVisible.value
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: const Color(0xFF64748B),
              ),
              onPressed: () => controller.isConfirmPasswordVisible.toggle(),
            ),
          ),
        )),

        const SizedBox(height: 20),

        // Checkbox S&K
        Obx(() => InkWell(
          onTap: () => controller.agreeToTerms.toggle(),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: controller.agreeToTerms.value,
                    onChanged: (val) => controller.agreeToTerms.value = val!,
                    activeColor: primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "Saya menyetujui Syarat dan Ketentuan yang berlaku",
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),

        const SizedBox(height: 28),

        // Button Daftar
        Obx(() => SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: controller.isLoading.value
                ? null
                : () => controller.register(),
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
                    "Daftar Sekarang",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
