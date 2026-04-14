import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/dashboard_controller.dart';
import '../../../core/values/app_colors.dart';
import '../../../routes/app_pages.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  String _formatCurrency(dynamic amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: AppColors.getBackground(context),
      body: Obx(() {
        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: controller.fetchDashboard,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? screenWidth * 0.1 : 20,
                  vertical: 24,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildHeader(context),
                    const SizedBox(height: 24),
                    // Kondisional Custom Shimmer vs Konten
                    controller.isLoading.value 
                        ? _buildCustomShimmerRoomCard(context) 
                        : _buildRoomCard(context),
                    const SizedBox(height: 24),
                    controller.isLoading.value
                        ? _buildCustomShimmerStats(context)
                        : _buildQuickStats(context),
                    const SizedBox(height: 32),
                    _buildSectionHeader(
                      context,
                      title: "Histori Pembayaran",
                      onAction: () => Get.toNamed(Routes.TRANSACTION),
                    ),
                    const SizedBox(height: 12),
                    controller.isLoading.value
                        ? _buildCustomShimmerList(context)
                        : _buildPaymentList(context),
                  ]),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // ================= CUSTOM SHIMMER COMPONENT (TANPA PACKAGE) =================

  Widget _buildCustomShimmerLoading({required Widget child}) {
    return _CustomShimmerEffect(child: child);
  }

  Widget _buildCustomShimmerRoomCard(BuildContext context) {
    return _buildCustomShimmerLoading(
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }

  Widget _buildCustomShimmerStats(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildCustomShimmerLoading(
          child: Container(height: 110, decoration: BoxDecoration(color: Colors.black.withOpacity(0.05), borderRadius: BorderRadius.circular(20))),
        )),
        const SizedBox(width: 16),
        Expanded(child: _buildCustomShimmerLoading(
          child: Container(height: 110, decoration: BoxDecoration(color: Colors.black.withOpacity(0.05), borderRadius: BorderRadius.circular(20))),
        )),
      ],
    );
  }

  Widget _buildCustomShimmerList(BuildContext context) {
    return Column(
      children: List.generate(3, (index) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _buildCustomShimmerLoading(
          child: Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
          ),
        ),
      )),
    );
  }

  // ================= ORIGINAL WIDGETS =================

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.getSurface(context),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.getShadow(context, 0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Image.asset(
            "assets/images/logo.png",
            width: 40,
            height: 40,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.home_work_rounded,
              color: AppColors.primary,
              size: 30,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "RumahKos Apps",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.getTextTertiary(context),
                  letterSpacing: 0.5,
                ),
              ),
              Obx(() => controller.isLoading.value 
                ? _buildCustomShimmerLoading(child: Container(height: 24, width: 150, decoration: BoxDecoration(color: Colors.black.withOpacity(0.05), borderRadius: BorderRadius.circular(4))))
                : Text(
                    "Halo, ${controller.name.value}!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.getTextPrimary(context),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoomCard(BuildContext context) {
    if (!controller.hasKos.value) {
      return _buildEmptyState(context, "Informasi kos tidak ditemukan.");
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Kamar Saat Ini",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Tenant",
                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            controller.roomName.value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.location_pin, color: AppColors.secondary, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  controller.property.value,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return Row(
      children: [
        _buildStatCard(
          context,
          "Pending",
          controller.pendingCount.value.toString(),
          Icons.timer_outlined,
          AppColors.warning,
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          context,
          "Overdue",
          controller.overdueCount.value.toString(),
          Icons.error_outline_rounded,
          AppColors.error,
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.getSurface(context),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.getBorder(context)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.getTextPrimary(context),
              ),
            ),
            Text(
              label,
              style: TextStyle(color: AppColors.getTextSecondary(context), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, {required String title, required VoidCallback onAction}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.getTextPrimary(context),
          ),
        ),
        TextButton(
          onPressed: onAction,
          child: const Text("Lihat Riwayat"),
        ),
      ],
    );
  }

  Widget _buildPaymentList(BuildContext context) {
    if (controller.payments.isEmpty) {
      return _buildEmptyState(context, "Semua tagihan lunas. Mantap!");
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.payments.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final p = controller.payments[index];
        final color = AppColors.getStatusColor(p['status']);

        return InkWell(
          onTap: () => Get.toNamed(Routes.TRANSACTION),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.getSurface(context),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.getBorder(context)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.receipt_long_rounded, color: AppColors.primary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tagihan Sewa",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.getTextPrimary(context),
                        ),
                      ),
                      Text(
                        p['status'].toString().toUpperCase(),
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: color),
                      ),
                    ],
                  ),
                ),
                Text(
                  _formatCurrency(p['amount']),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.getTextPrimary(context),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: AppColors.getSurface(context),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.getBorder(context), style: BorderStyle.solid),
      ),
      child: Column(
        children: [
          Icon(Icons.verified_outlined, size: 40, color: AppColors.slate300),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(color: AppColors.getTextTertiary(context), fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// ================= PRIVATE CLASS UNTUK ANIMASI SHIMMER MANUAL =================

class _CustomShimmerEffect extends StatefulWidget {
  final Widget child;
  const _CustomShimmerEffect({required this.child});

  @override
  State<_CustomShimmerEffect> createState() => _CustomShimmerEffectState();
}

class _CustomShimmerEffectState extends State<_CustomShimmerEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey.withOpacity(0.1),
                Colors.grey.withOpacity(0.3),
                Colors.grey.withOpacity(0.1),
              ],
              stops: [
                _controller.value - 0.3,
                _controller.value,
                _controller.value + 0.3,
              ],
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}