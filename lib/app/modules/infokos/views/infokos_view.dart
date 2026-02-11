import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/infokos_controller.dart';

class InfokosView extends GetView<InfokosController> {
  const InfokosView({super.key});

  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color slate900 = Color(0xFF1E293B);
  static const Color slate500 = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: Text(
          'Informasi Kamar',
          style: TextStyle(
            color: isDark ? Colors.white : slate900,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroRoomCard(isDark),
            const SizedBox(height: 32),
            _buildSectionLabel(context, "FASILITAS KAMAR"),
            const SizedBox(height: 16),
            _buildFacilityGrid(isDark),
            const SizedBox(height: 32),
            _buildSectionLabel(context, "DETAIL BANGUNAN"),
            const SizedBox(height: 16),
            _buildTechnicalDetails(isDark),
            const SizedBox(height: 32),
            _buildSectionLabel(context, "LAYANAN TERSEDIA"),
            const SizedBox(height: 16),
            _buildServiceList(isDark),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // Kartu Utama Detail Kamar
  Widget _buildHeroRoomCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryBlue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.meeting_room_rounded, color: primaryBlue, size: 40),
          ),
          const SizedBox(height: 16),
          Text(
            "Nomor Kamar",
            style: TextStyle(color: isDark ? Colors.white60 : slate500, fontSize: 14),
          ),
          const Text(
            "Deluxe A-12",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: primaryBlue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Lantai 2 - Sayap Kanan",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : slate900,
            ),
          ),
        ],
      ),
    );
  }

  // Grid Fasilitas Kamar
  Widget _buildFacilityGrid(bool isDark) {
    final facilities = [
      {'icon': Icons.ac_unit_rounded, 'label': 'AC LG 1/2 PK'},
      {'icon': Icons.bed_rounded, 'label': 'Queen Bed'},
      {'icon': Icons.shower_rounded, 'label': 'KM Dalam'},
      {'icon': Icons.desk_rounded, 'label': 'Meja Kerja'},
      // {'icon': Icons.closet_rounded, 'label': 'Lemari 2 Pintu'},
      {'icon': Icons.wifi_rounded, 'label': 'WiFi 50Mbps'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.5,
      ),
      itemCount: facilities.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              Icon(facilities[index]['icon'] as IconData, color: primaryBlue, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  facilities[index]['label'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : slate900,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Detail Teknis Kamar
  Widget _buildTechnicalDetails(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          _detailRow(isDark, "Luas Kamar", "4 x 4 Meter"),
          const Divider(height: 24),
          _detailRow(isDark, "Daya Listrik", "1300 Watt (Token)"),
          const Divider(height: 24),
          _detailRow(isDark, "Arah Jendela", "Menghadap Taman"),
        ],
      ),
    );
  }

  Widget _detailRow(bool isDark, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : slate900,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  // Layanan Terintegrasi
  Widget _buildServiceList(bool isDark) {
    return Column(
      children: [
        _serviceTile(isDark, "Layanan Kebersihan", "2x seminggu (Senin & Kamis)", Icons.clean_hands_rounded),
        const SizedBox(height: 12),
        _serviceTile(isDark, "Keamanan 24 Jam", "CCTV & Penjaga Area", Icons.security_rounded),
      ],
    );
  }

  Widget _serviceTile(bool isDark, String title, String sub, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryBlue, size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isDark ? Colors.white : slate900,
                ),
              ),
              Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w900,
        color: isDark ? Colors.white54 : slate500,
        letterSpacing: 1.5,
      ),
    );
  }
}
