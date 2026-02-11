import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  // Warna Branding Utama (Solid Branding)
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color slate900 = Color(0xFF1E293B);
  static const Color slate500 = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    // Kita kunci visualnya agar tetap terlihat premium di berbagai kondisi
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildElegantAppBar(context, isDark),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _buildMainUnitCard(isDark),
                  const SizedBox(height: 32),
                  _buildSectionHeader(context, "LAYANAN PENGHUNI", Icons.grid_view_rounded),
                  const SizedBox(height: 16),
                  _buildPremiumServiceGrid(context),
                  const SizedBox(height: 32),
                  _buildBillingFocus(context),
                  const SizedBox(height: 32),
                  _buildSectionHeader(context, "AKTIVITAS HUNIAN", Icons.history_toggle_off_rounded),
                  const SizedBox(height: 16),
                  _buildMinimalistTimeline(context),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildElegantAppBar(BuildContext context, bool isDark) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white.withOpacity(0.9),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      // Actions dihilangkan agar fokus ke Branding
      actions: const [
        SizedBox(width: 24),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  // LOGO BRANDING
                  Container(
                    height: 52,
                    width: 52,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF334155) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.home_work_rounded, color: primaryBlue, size: 28),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.8,
                            color: isDark ? Colors.white : slate900,
                          ),
                          children: const [
                            TextSpan(text: "Rumah"),
                            TextSpan(
                              text: "Kos",
                              style: TextStyle(color: primaryBlue),
                            ),
                          ],
                        ),
                      ),
                      Obx(() => Text(
                        "Halo, ${controller.name.value} 👋",
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.white60 : slate500,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainUnitCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [primaryBlue, Color(0xFF1D4ED8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "DETAIL UNIT AKTIF",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const Icon(Icons.verified_user_rounded, color: Colors.white, size: 18),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "Kamar Deluxe A-12",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoPoint("MASA SEWA", "12 Bulan"),
              _infoPoint("TIPE", "AC + KM Dalam"),
              _infoPoint("STATUS", "TERBAYAR"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoPoint(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildPremiumServiceGrid(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final List<Map<String, dynamic>> services = [
      {'icon': Icons.payment_rounded, 'label': 'Bayar Kos'},
      {'icon': Icons.cleaning_services_outlined, 'label': 'Request Bersih'},
      {'icon': Icons.plumbing_rounded, 'label': 'Komplain'},
      {'icon': Icons.article_outlined, 'label': 'E-Kontrak'},
      {'icon': Icons.local_laundry_service_outlined, 'label': 'Laundry'},
      {'icon': Icons.grid_view_rounded, 'label': 'Lainnya'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.05,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(services[index]['icon'], color: primaryBlue, size: 26),
              const SizedBox(height: 10),
              Text(
                services[index]['label'],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : slate900
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBillingFocus(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tagihan Bulan Ini",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: isDark ? Colors.white : slate900
                )
              ),
              _buildBadge("BELUM LUNAS", Colors.red),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sewa + Listrik", style: TextStyle(color: isDark ? Colors.white60 : slate500, fontSize: 12)),
                    Text(
                      "Rp 1.250.000",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: isDark ? Colors.white : slate900
                      )
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text("Bayar", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w900)),
    );
  }

  Widget _buildMinimalistTimeline(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          _timelineRow(context, "Laundry Masuk", "3 Kg pakaian sedang diproses.", true),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Divider(height: 1, color: isDark ? Colors.white10 : const Color(0xFFF1F5F9)),
          ),
          _timelineRow(context, "Pembayaran Listrik", "Token berhasil diisi oleh admin.", false),
        ],
      ),
    );
  }

  Widget _timelineRow(BuildContext context, String title, String sub, bool isNew) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: isNew ? primaryBlue : (isDark ? Colors.white24 : slate500.withOpacity(0.3)),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: isDark ? Colors.white : slate900
                )
              ),
              Text(
                sub,
                style: TextStyle(
                  color: isDark ? Colors.white60 : slate500,
                  fontSize: 11
                )
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Icon(icon, size: 18, color: primaryBlue),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: isDark ? Colors.white54 : slate500,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
