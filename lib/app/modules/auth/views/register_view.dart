import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller.nameController,
          decoration: const InputDecoration(labelText: "Nama"),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: controller.emailController,
          decoration: const InputDecoration(labelText: "Email"),
        ),
        const SizedBox(height: 16),
        Obx(() => TextField(
              controller: controller.passwordController,
              obscureText: !controller.isPasswordVisible.value,
              decoration: InputDecoration(
                labelText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(controller.isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: controller.togglePasswordVisibility,
                ),
              ),
            )),
        const SizedBox(height: 16),
        Obx(() => TextField(
              controller: controller.confirmPasswordController,
              obscureText: !controller.isConfirmPasswordVisible.value,
              decoration: InputDecoration(
                labelText: "Konfirmasi Password",
                suffixIcon: IconButton(
                  icon: Icon(controller.isConfirmPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: controller.toggleConfirmPasswordVisibility,
                ),
              ),
            )),
        const SizedBox(height: 16),
        Row(
          children: [
            Obx(() => Checkbox(
                  value: controller.agreeToTerms.value,
                  onChanged: (value) =>
                      controller.agreeToTerms.value = value ?? false,
                )),
            const Expanded(
              child: Text("Saya menyetujui syarat & ketentuan"),
            )
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.register,
            child: const Text("Register"),
          ),
        ),
      ],
    );
  }
}
