import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_nav_controller.dart';

class MainNavView extends StatelessWidget {
  MainNavView({super.key});

  final MainNavController controller = Get.put(MainNavController());

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF2563EB);

    return Scaffold(
      // extendBody dihapus agar konten tidak tertutup navbar yang menempel
      body: Obx(() => controller.pages[controller.selectedIndex.value]),
      bottomNavigationBar: _buildModernNav(primaryBlue),
    );
  }

  Widget _buildModernNav(Color activeColor) {
    return Container(
      // Margin dihapus agar menempel ke pinggir dan bawah layar
      height: 85, // Sedikit lebih tinggi untuk area aman (safe area)
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
        // Garis tipis di bagian atas untuk pemisah yang bersih
        border: Border(
          top: BorderSide(color: Colors.grey[100]!, width: 1),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.grid_view_rounded, "Beranda", activeColor),
            _buildNavItem(1, Icons.info_outline_rounded, "Info Kos", activeColor),
            _buildNavItem(2, Icons.payment_outlined, "Transaksi", activeColor),
            _buildNavItem(3, Icons.person_outline_rounded, "Profile", activeColor),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, Color activeColor) {
    return Obx(() {
      bool isSelected = controller.selectedIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changeTab(index),
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: 80, // Ukuran tetap agar simetris
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? activeColor : const Color(0xFF94A3B8),
                size: 26,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? activeColor : const Color(0xFF94A3B8),
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
