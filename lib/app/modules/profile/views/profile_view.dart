import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  // Avatar
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blue.shade100,
                          child: Obx(() {
                            final initial = controller.name.value.isNotEmpty
                                ? controller.name.value[0].toUpperCase()
                                : 'U';
                            return Text(
                              initial,
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            );
                          }),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            // TODO: Add image picker functionality
                            Get.snackbar(
                              'Coming Soon',
                              'Change photo feature will be available soon',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.blue,
                              colorText: Colors.white,
                              margin: const EdgeInsets.all(16),
                              borderRadius: 8,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFF1E3A8A),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Name
                  Obx(
                    () => Text(
                      controller.name.value.isEmpty ? 'User' : controller.name.value,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Role Badge
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: controller.role.value.toLowerCase() == 'admin'
                            ? Colors.purple.shade50
                            : Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        controller.role.value.isEmpty
                            ? 'TENANT'
                            : controller.role.value.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: controller.role.value.toLowerCase() == 'admin'
                              ? Colors.purple.shade700
                              : Colors.blue.shade700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Edit Profile Button
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/edit-profile');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E3A8A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // User Info Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: controller.email,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    icon: Icons.phone_android_outlined,
                    label: 'Phone',
                    value: controller.phone,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Menu Items
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.settings_outlined,
                    title: "Settings",
                    onTap: () {
                      Get.snackbar(
                        'Coming Soon',
                        'Settings feature will be available soon',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.history,
                    title: "My Bookings",
                    onTap: () {
                      Get.snackbar(
                        'Coming Soon',
                        'Booking history will be available soon',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.notifications_outlined,
                    title: "Notifications",
                    onTap: () {
                      Get.snackbar(
                        'Coming Soon',
                        'Notifications feature will be available soon',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.help_outline,
                    title: "Help & Support",
                    onTap: () {
                      Get.snackbar(
                        'Coming Soon',
                        'Help & Support will be available soon',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.info_outline,
                    title: "About",
                    onTap: () {
                      Get.dialog(
                        AlertDialog(
                          title: const Text('About RumahKos'),
                          content: const Text(
                            'RumahKos App v1.0.0\n\nFind your perfect boarding house with ease.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.logout,
                    title: "Log out",
                    onTap: () => _showLogoutDialog(),
                    textColor: Colors.red,
                    iconColor: Colors.red,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // App Version
            Text(
              'RumahKos v1.0.0',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required RxString value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.blue, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Obx(
                () => Text(
                  value.value.isEmpty ? '-' : value.value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: iconColor ?? Colors.black87,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor ?? Colors.black87,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey.shade400,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 4,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey.shade100,
      indent: 60,
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Logout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close dialog
              controller.logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
