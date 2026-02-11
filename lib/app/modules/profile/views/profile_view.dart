import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  // Theme Colors (Konsisten dengan Branding RumahKos)
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color slate900 = Color(0xFF1E293B);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color cardBorder = Color(0xFFE2E8F0);
  static const Color white = Colors.white;

  @override
  Widget build(BuildContext context) {
    // Memastikan responsivitas
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 360;

    return Scaffold(
      backgroundColor: slate100,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _buildSectionLabel("INFORMASI HUNIAN"),
                  const SizedBox(height: 16),
                  _buildUnitStatusCard(isSmallScreen),
                  const SizedBox(height: 32),
                  _buildSectionLabel("PENGATURAN AKUN"),
                  const SizedBox(height: 16),
                  _buildMenuSection(),
                  const SizedBox(height: 32),
                  _buildSectionLabel("SISTEM"),
                  const SizedBox(height: 16),
                  _buildDangerZone(),
                  const SizedBox(height: 40),
                  Center(
                    child: Opacity(
                      opacity: 0.5,
                      child: Text(
                        "RumahKos Pro v1.0.0",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: slate500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      stretch: true,
      backgroundColor: primaryBlue,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground, StretchMode.blurBackground],
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryBlue, Color(0xFF1E40AF)],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Pattern dekoratif
              Positioned(
                right: -50,
                top: -50,
                child: CircleAvatar(radius: 100, backgroundColor: white.withOpacity(0.05)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  _buildModernAvatar(),
                  const SizedBox(height: 16),
                  Obx(() => Text(
                        controller.name.value.isEmpty ? "User RumahKos" : controller.name.value,
                        style: const TextStyle(
                          color: white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      )),
                  const SizedBox(height: 4),
                  Obx(() => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          controller.role.value.toUpperCase(),
                          style: const TextStyle(
                            color: white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernAvatar() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: white,
        shape: BoxShape.circle,
      ),
      child: Obx(() {
        final initial = controller.name.value.isNotEmpty ? controller.name.value[0].toUpperCase() : "U";
        return CircleAvatar(
          radius: 45,
          backgroundColor: slate100,
          child: Text(
            initial,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: primaryBlue,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildUnitStatusCard(bool isSmall) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Row(
        children: [
          _unitBadge(Icons.meeting_room_rounded, "A-12", "Unit Kamar"),
          Container(width: 1, height: 40, color: cardBorder, margin: const EdgeInsets.symmetric(horizontal: 20)),
          _unitBadge(Icons.verified_rounded, "AKTIF", "Status Sewa", color: Colors.green),
        ],
      ),
    );
  }

  Widget _unitBadge(IconData icon, String val, String label, {Color color = primaryBlue}) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(val, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: slate900)),
              Text(label, style: const TextStyle(fontSize: 10, color: slate500, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: cardBorder),
      ),
      child: Column(
        children: [
          _buildMenuTile(
            icon: Icons.person_outline_rounded,
            title: "Data Pribadi",
            onTap: () => Get.toNamed('/edit-profile'),
          ),
          _divider(),
          _buildMenuTile(
            icon: Icons.history_rounded,
            title: "Riwayat Pembayaran",
            onTap: () {},
          ),
          _divider(),
          _buildMenuTile(
            icon: Icons.security_rounded,
            title: "Keamanan Akun",
            onTap: () {},
          ),
          _divider(),
          _buildMenuTile(
            icon: Icons.notifications_none_rounded,
            title: "Pengaturan Notifikasi",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildDangerZone() {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: cardBorder),
      ),
      child: _buildMenuTile(
        icon: Icons.logout_rounded,
        title: "Keluar Akun",
        isDanger: true,
        onTap: () => controller.logout(),
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDanger ? Colors.red.withOpacity(0.08) : primaryBlue.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: isDanger ? Colors.red : primaryBlue, size: 22),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isDanger ? Colors.red : slate900,
                ),
              ),
              const Spacer(),
              Icon(Icons.chevron_right_rounded, color: isDanger ? Colors.red.withOpacity(0.3) : slate500.withOpacity(0.3)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Divider(height: 1, color: cardBorder.withOpacity(0.5)),
      );

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w900,
        color: slate500,
        letterSpacing: 1.5,
      ),
    );
  }
}
