import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/infokos_controller.dart';

class InfokosView extends GetView<InfokosController> {
  const InfokosView({super.key});

  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color slate900 = Color(0xFF1E293B);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate200 = Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF080F1F) : const Color(0xFFF1F5F9),
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(isDark),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildShimmerLayout(isDark, isTablet);
        }
        if (!controller.hasResidence.value) {
          return _buildEmptyState(isDark);
        }
        return _buildContent(isDark, isTablet);
      }),
    );
  }

  // ──────────────────────────────────────────
  // APP BAR
  // ──────────────────────────────────────────
  PreferredSizeWidget _buildAppBar(bool isDark) {
    return AppBar(
      title: Text(
        'Informasi Kamar',
        style: TextStyle(
          color: isDark ? Colors.white : slate900,
          fontWeight: FontWeight.w800,
          fontSize: 18,
          letterSpacing: -0.3,
        ),
      ),
      centerTitle: true,
      backgroundColor: isDark
          ? const Color(0xFF0D1526).withOpacity(0.92)
          : Colors.white.withOpacity(0.92),
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: isDark ? Colors.white10 : const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 15,
            color: isDark ? Colors.white70 : slate700,
          ),
        ),
        onPressed: () => Get.back(),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: IconButton(
            icon: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: isDark ? Colors.white10 : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.refresh_rounded,
                size: 18,
                color: isDark ? Colors.white70 : slate700,
              ),
            ),
            onPressed: () => controller.refreshData(),
            tooltip: 'Refresh',
          ),
        ),
      ],
    );
  }

  // ──────────────────────────────────────────
  // MAIN CONTENT
  // ──────────────────────────────────────────
  Widget _buildContent(bool isDark, bool isTablet) {
    return RefreshIndicator(
      onRefresh: controller.refreshData,
      color: primaryBlue,
      backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(
              top: 100,
              left: isTablet ? 40 : 20,
              right: isTablet ? 40 : 20,
              bottom: 40,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Hero card — manages its own shimmer until image loads
                Obx(() => _HeroRoomCard(
                      isDark: isDark,
                      isTablet: isTablet,
                      roomImage: controller.roomImage.value,
                      roomName: controller.roomName.value,
                      roomPrice:
                          controller.formatPrice(controller.roomPrice.value),
                      propertyName: controller.propertyName.value,
                      propertyAddress: controller.propertyAddress.value,
                    )),
                const SizedBox(height: 28),
                _buildSectionLabel("FASILITAS KAMAR"),
                const SizedBox(height: 12),
                _buildFacilityGrid(isDark, isTablet),
                const SizedBox(height: 28),
                _buildSectionLabel("DETAIL BANGUNAN"),
                const SizedBox(height: 12),
                _buildTechnicalDetails(isDark),
                const SizedBox(height: 28),
                _buildSectionLabel("INFORMASI KONTRAK"),
                const SizedBox(height: 12),
                _buildContractInfo(isDark),
                const SizedBox(height: 28),
                _buildSectionLabel("STATISTIK PEMBAYARAN"),
                const SizedBox(height: 12),
                _buildPaymentStats(isDark),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────
  // FULL PAGE SHIMMER LAYOUT
  // ──────────────────────────────────────────
  Widget _buildShimmerLayout(bool isDark, bool isTablet) {
    final double imageH = isTablet ? 220.0 : 180.0;
    final double heroH = imageH + 160; // image + info section approx

    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(
            top: 100,
            left: isTablet ? 40 : 20,
            right: isTablet ? 40 : 20,
            bottom: 40,
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Hero card shimmer
              _ShimmerBox(isDark: isDark, height: heroH, borderRadius: 28),
              const SizedBox(height: 28),

              // Section: Fasilitas
              _ShimmerBox(isDark: isDark, height: 11, width: 140, borderRadius: 4),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 3 : 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2.6,
                ),
                itemCount: 6,
                itemBuilder: (_, __) =>
                    _ShimmerBox(isDark: isDark, height: 50, borderRadius: 14),
              ),
              const SizedBox(height: 28),

              // Section: Detail Bangunan
              _ShimmerBox(isDark: isDark, height: 11, width: 130, borderRadius: 4),
              const SizedBox(height: 12),
              _ShimmerInfoCard(isDark: isDark, rows: 3),
              const SizedBox(height: 28),

              // Section: Kontrak
              _ShimmerBox(isDark: isDark, height: 11, width: 160, borderRadius: 4),
              const SizedBox(height: 12),
              _ShimmerInfoCard(isDark: isDark, rows: 4),
              const SizedBox(height: 28),

              // Section: Statistik
              _ShimmerBox(isDark: isDark, height: 11, width: 155, borderRadius: 4),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                      child: _ShimmerBox(isDark: isDark, height: 120, borderRadius: 20)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _ShimmerBox(isDark: isDark, height: 120, borderRadius: 20)),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }

  // ──────────────────────────────────────────
  // EMPTY STATE
  // ──────────────────────────────────────────
  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.05)
                    : const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.home_outlined,
                size: 48,
                color: isDark ? Colors.white24 : Colors.grey.shade300,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Belum Ada Kamar',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : slate900,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Anda belum terdaftar sebagai\npenghuni kos manapun',
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: isDark ? Colors.white54 : slate500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [primaryBlue, primaryLight],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: primaryBlue.withOpacity(0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search_rounded, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Cari Kamar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────
  // FACILITY GRID
  // ──────────────────────────────────────────
  Widget _buildFacilityGrid(bool isDark, bool isTablet) {
    return Obx(() {
      if (controller.facilities.isEmpty) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF131D35) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isDark ? Colors.white10 : slate200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline_rounded,
                  size: 18,
                  color: isDark ? Colors.white30 : Colors.grey.shade400),
              const SizedBox(width: 8),
              Text(
                'Tidak ada data fasilitas',
                style: TextStyle(
                    color: isDark ? Colors.white38 : slate500, fontSize: 13),
              ),
            ],
          ),
        );
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isTablet ? 3 : 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2.6,
        ),
        itemCount: controller.facilities.length,
        itemBuilder: (context, index) {
          final facility = controller.facilities[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF131D35) : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: isDark ? Colors.white10 : slate200),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(_getFacilityIcon(facility['icon'] ?? ''),
                      color: primaryBlue, size: 16),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    facility['name'] ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : slate900,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  // ──────────────────────────────────────────
  // TECHNICAL DETAILS
  // ──────────────────────────────────────────
  Widget _buildTechnicalDetails(bool isDark) {
    return Obx(() => _InfoCard(
          isDark: isDark,
          children: [
            _detailRow(isDark, Icons.layers_rounded, "Lantai",
                "Lantai ${controller.roomFloor.value}"),
            _divider(isDark),
            _detailRow(isDark, Icons.straighten_rounded, "Luas Kamar",
                controller.roomSize.value),
            _divider(isDark),
            _detailRow(
              isDark,
              Icons.circle_outlined,
              "Status Kamar",
              controller.roomStatus.value.toUpperCase(),
              valueColor: _statusColor(controller.roomStatus.value),
            ),
          ],
        ));
  }

  // ──────────────────────────────────────────
  // CONTRACT INFO
  // ──────────────────────────────────────────
  Widget _buildContractInfo(bool isDark) {
    return Obx(() => _InfoCard(
          isDark: isDark,
          children: [
            _detailRow(isDark, Icons.play_circle_outline_rounded, "Mulai Kontrak",
                controller.formatDate(controller.startDate.value)),
            _divider(isDark),
            _detailRow(isDark, Icons.stop_circle_outlined, "Akhir Kontrak",
                controller.formatDate(controller.endDate.value)),
            _divider(isDark),
            _detailRow(isDark, Icons.timelapse_rounded, "Durasi",
                "${controller.durationMonths.value} Bulan"),
            _divider(isDark),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.verified_rounded,
                        size: 16,
                        color: isDark ? Colors.white30 : slate500),
                    const SizedBox(width: 10),
                    Text("Status Kontrak",
                        style: TextStyle(
                            color: isDark ? Colors.white54 : slate500,
                            fontSize: 13)),
                  ],
                ),
                _contractBadge(isDark, controller.isContractActive.value),
              ],
            ),
          ],
        ));
  }

  Widget _contractBadge(bool isDark, bool isActive) {
    final color =
        isActive ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            isActive ? 'AKTIF' : 'TIDAK AKTIF',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 11,
              color: color,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────
  // PAYMENT STATS
  // ──────────────────────────────────────────
  Widget _buildPaymentStats(bool isDark) {
    return Obx(() => Row(
          children: [
            Expanded(
              child: _StatCard(
                isDark: isDark,
                icon: Icons.warning_amber_rounded,
                iconColor: Colors.amber.shade600,
                label: "Tagihan Belum Lunas",
                value: "${controller.unpaidPayments.value}",
                unit: "Tagihan",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                isDark: isDark,
                icon: Icons.receipt_long_rounded,
                iconColor: primaryBlue,
                label: "Total Pembayaran",
                value: "${controller.totalPayments.value}",
                unit: "Transaksi",
              ),
            ),
          ],
        ));
  }

  // ──────────────────────────────────────────
  // HELPERS
  // ──────────────────────────────────────────
  Widget _detailRow(bool isDark, IconData icon, String label, String value,
      {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: isDark ? Colors.white30 : slate500),
            const SizedBox(width: 10),
            Text(label,
                style: TextStyle(
                    color: isDark ? Colors.white54 : slate500, fontSize: 13)),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: valueColor ?? (isDark ? Colors.white : slate900),
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _divider(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Container(
        height: 1,
        color:
            isDark ? Colors.white.withOpacity(0.06) : const Color(0xFFF1F5F9),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: Color(0xFF64748B),
        letterSpacing: 1.8,
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'tersedia':
      case 'available':
        return Colors.green;
      case 'penuh':
      case 'occupied':
        return Colors.orange;
      default:
        return primaryBlue;
    }
  }

  IconData _getFacilityIcon(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'ac':
      case 'air_conditioner':
        return Icons.ac_unit_rounded;
      case 'bed':
      case 'kasur':
        return Icons.bed_rounded;
      case 'bathroom':
      case 'kamar_mandi':
        return Icons.shower_rounded;
      case 'desk':
      case 'meja':
        return Icons.desk_rounded;
      case 'wifi':
        return Icons.wifi_rounded;
      case 'tv':
        return Icons.tv_rounded;
      case 'wardrobe':
      case 'lemari':
        return Icons.checkroom_rounded;
      case 'kitchen':
      case 'dapur':
        return Icons.kitchen_rounded;
      case 'parking':
      case 'parkir':
        return Icons.local_parking_rounded;
      case 'laundry':
        return Icons.local_laundry_service_rounded;
      default:
        return Icons.check_circle_rounded;
    }
  }
}

class _HeroRoomCard extends StatefulWidget {
  final bool isDark;
  final bool isTablet;
  final String roomImage;
  final String roomName;
  final String roomPrice;
  final String propertyName;
  final String propertyAddress;

  const _HeroRoomCard({
    required this.isDark,
    required this.isTablet,
    required this.roomImage,
    required this.roomName,
    required this.roomPrice,
    required this.propertyName,
    required this.propertyAddress,
  });

  @override
  State<_HeroRoomCard> createState() => _HeroRoomCardState();
}

class _HeroRoomCardState extends State<_HeroRoomCard>
    with SingleTickerProviderStateMixin {
  bool _ready = false;
  late AnimationController _fc;
  late Animation<double> _fade;

  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate900 = Color(0xFF1E293B);
  static const Color slate200 = Color(0xFFE2E8F0);

  @override
  void initState() {
    super.initState();
    _fc = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 360));
    _fade = CurvedAnimation(parent: _fc, curve: Curves.easeOut);

    // Tidak ada gambar → langsung siap
    if (widget.roomImage.isEmpty) _markReady();
  }

  void _markReady() {
    if (_ready) return;
    _ready = true;
    _fc.forward();
  }

  @override
  void dispose() {
    _fc.dispose();
    super.dispose();
  }

  double get _imgH => widget.isTablet ? 220.0 : 180.0;
  // Tinggi total card shimmer = foto + bagian info bawah (~170 px)
  double get _cardH => _imgH + 170;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // Beri tinggi minimum agar shimmer tidak collapse
      child: Stack(
        children: [
          // ── SHIMMER — keliatan sampai _ready = true ──
          AnimatedOpacity(
            opacity: _ready ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: _ShimmerBox(
              isDark: widget.isDark,
              height: _cardH,
              borderRadius: 28,
            ),
          ),

          // ── KONTEN — fade in setelah gambar siap ──
          FadeTransition(
            opacity: _fade,
            child: _buildCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.isDark ? const Color(0xFF131D35) : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
            color: widget.isDark ? Colors.white10 : slate200),
        boxShadow: [
          BoxShadow(
            color: widget.isDark
                ? Colors.black.withOpacity(0.4)
                : Colors.black.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Column(
          children: [
            _buildImage(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: Column(
                children: [
                  // Room number + price row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nomor Kamar",
                              style: TextStyle(
                                color: widget.isDark
                                    ? Colors.white38
                                    : slate500,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.roomName,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                color: primaryBlue,
                                letterSpacing: -1,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              primaryBlue.withOpacity(0.15),
                              primaryLight.withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: primaryBlue.withOpacity(0.2)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              widget.roomPrice,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: primaryBlue,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Text(
                              '/ Bulan',
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryBlue.withOpacity(0.7),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Container(
                    height: 1,
                    color: widget.isDark
                        ? Colors.white.withOpacity(0.06)
                        : const Color(0xFFF1F5F9),
                  ),
                  const SizedBox(height: 16),

                  // Property info row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: widget.isDark
                              ? Colors.white.withOpacity(0.06)
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Icon(Icons.apartment_rounded,
                            size: 16,
                            color: widget.isDark
                                ? Colors.white54
                                : slate500),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.propertyName,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: widget.isDark
                                    ? Colors.white
                                    : slate900,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.propertyAddress,
                              style: TextStyle(
                                fontSize: 11,
                                color: widget.isDark
                                    ? Colors.white38
                                    : slate500,
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (widget.roomImage.isEmpty) {
      return _placeholder();
    }

    return SizedBox(
      height: _imgH,
      width: double.infinity,
      child: Image.network(
        widget.roomImage,
        height: _imgH,
        width: double.infinity,
        fit: BoxFit.cover,
        // frameBuilder dipanggil setiap frame tersedia
        // frame != null berarti sudah ada data gambar yang bisa dirender
        frameBuilder: (ctx, child, frame, wasSynchronous) {
          if (frame != null || wasSynchronous) {
            // Jadwalkan setelah build selesai agar tidak setState di tengah build
            WidgetsBinding.instance.addPostFrameCallback((_) => _markReady());
            return child;
          }
          // Belum ada frame — return transparan, shimmer di Stack tetap keliatan
          return const SizedBox.shrink();
        },
        errorBuilder: (ctx, err, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) => _markReady());
          return _placeholder();
        },
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      height: _imgH,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.isDark
              ? [const Color(0xFF1E2D4A), const Color(0xFF0D1A2E)]
              : [const Color(0xFFDBE9FF), const Color(0xFFC7DAFF)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.meeting_room_rounded,
              size: 52,
              color: primaryBlue
                  .withOpacity(widget.isDark ? 0.5 : 0.4)),
          const SizedBox(height: 8),
          Text(
            'Foto tidak tersedia',
            style: TextStyle(
              color: primaryBlue.withOpacity(0.5),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════
// _InfoCard
// ══════════════════════════════════════════════
class _InfoCard extends StatelessWidget {
  final bool isDark;
  final List<Widget> children;

  const _InfoCard({required this.isDark, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131D35) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }
}

// ══════════════════════════════════════════════
// _StatCard
// ══════════════════════════════════════════════
class _StatCard extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final String unit;

  const _StatCard({
    required this.isDark,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.unit,
  });

  static const Color slate900 = Color(0xFF1E293B);
  static const Color slate500 = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131D35) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : slate900,
              letterSpacing: -1,
              height: 1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            unit,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white38 : slate500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white30 : const Color(0xFF94A3B8),
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════
// _ShimmerInfoCard — skeleton untuk list rows
// ══════════════════════════════════════════════
class _ShimmerInfoCard extends StatelessWidget {
  final bool isDark;
  final int rows;

  const _ShimmerInfoCard({required this.isDark, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131D35) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: List.generate(rows * 2 - 1, (i) {
          if (i.isOdd) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Container(
                height: 1,
                color: isDark
                    ? Colors.white.withOpacity(0.06)
                    : const Color(0xFFF1F5F9),
              ),
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ShimmerBox(isDark: isDark, height: 13, width: 100, borderRadius: 4),
              _ShimmerBox(isDark: isDark, height: 13, width: 80, borderRadius: 4),
            ],
          );
        }),
      ),
    );
  }
}

// ══════════════════════════════════════════════
// _ShimmerBox — animated gradient placeholder
// ══════════════════════════════════════════════
class _ShimmerBox extends StatefulWidget {
  final bool isDark;
  final double height;
  final double? width;
  final double borderRadius;

  const _ShimmerBox({
    required this.isDark,
    required this.height,
    this.width,
    this.borderRadius = 8,
  });

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        duration: const Duration(milliseconds: 1400), vsync: this)
      ..repeat();
    _anim = Tween<double>(begin: -1.5, end: 2.5)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutSine));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base =
        widget.isDark ? const Color(0xFF1A2640) : const Color(0xFFE2E8F0);
    final hi =
        widget.isDark ? const Color(0xFF253654) : const Color(0xFFF1F5F9);

    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          gradient: LinearGradient(
            begin: Alignment(_anim.value - 1, 0),
            end: Alignment(_anim.value, 0),
            colors: [base, hi, hi, base],
            stops: const [0.0, 0.35, 0.65, 1.0],
          ),
        ),
      ),
    );
  }
}
