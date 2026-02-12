import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumahkosapps/app/core/values/app_colors.dart';
import 'package:rumahkosapps/app/core/values/app_radius.dart';
import 'package:rumahkosapps/app/core/values/app_spacing.dart';
import 'package:rumahkosapps/app/core/values/app_typography.dart';
import '../controllers/dashboard_controller.dart';


class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return Scaffold(
      backgroundColor: AppColors.getBackground(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context, isDark),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppSpacing.screenPadding(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.gapMD,
                  _buildMainUnitCard(context, isDark),
                  AppSpacing.gapSection,
                  _buildSectionHeader(
                    context,
                    "LAYANAN PENGHUNI",
                    Icons.grid_view_rounded,
                  ),
                  AppSpacing.gapLG,
                  _buildServiceGrid(context, isDark),
                  AppSpacing.gapSection,
                  _buildBillingCard(context, isDark),
                  AppSpacing.gapSection,
                  _buildSectionHeader(
                    context,
                    "AKTIVITAS HUNIAN",
                    Icons.history_toggle_off_rounded,
                  ),
                  AppSpacing.gapLG,
                  _buildActivityTimeline(context, isDark),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // APP BAR
  // ═══════════════════════════════════════════════════════════════
  Widget _buildAppBar(BuildContext context, bool isDark) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      backgroundColor: AppColors.getSurface(context).withOpacity(0.9),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      actions: [SizedBox(width: AppSpacing.xl)],
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal(context),
            0,
            AppSpacing.screenHorizontal(context),
            15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  // Logo Container
                  Container(
                    height: 52,
                    width: 52,
                    padding: AppSpacing.allSM,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : Colors.white,
                      borderRadius: AppRadius.cardRadius,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.getShadow(context, 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.home_work_rounded,
                        color: AppColors.primaryBlue,
                        size: 28,
                      ),
                    ),
                  ),
                  AppSpacing.hGapMD,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: AppTypography.h1Static.copyWith(
                            color: AppColors.getTextPrimary(context),
                          ),
                          children: const [
                            TextSpan(text: "Rumah"),
                            TextSpan(
                              text: "Kos",
                              style: TextStyle(color: AppColors.primaryBlue),
                            ),
                          ],
                        ),
                      ),
                      Obx(() => Text(
                            "Halo, ${controller.name.value} 👋",
                            style: AppTypography.bodySmall(context),
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

  // ═══════════════════════════════════════════════════════════════
  // MAIN UNIT CARD (Hero Card)
  // ═══════════════════════════════════════════════════════════════
  Widget _buildMainUnitCard(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.cardPaddingLarge),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: AppRadius.cardXLRadius,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withOpacity(0.3),
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
                style: AppTypography.overlineStatic.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const Icon(
                Icons.verified_user_rounded,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
          AppSpacing.gapMD,
          Text(
            "Kamar Deluxe A-12",
            style: AppTypography.h1Static.copyWith(
              color: Colors.white,
            ),
          ),
          AppSpacing.gapXXL,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoPoint("MASA SEWA", "12 Bulan"),
              _buildInfoPoint("TIPE", "AC + KM Dalam"),
              _buildInfoPoint("STATUS", "TERBAYAR"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoPoint(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.captionStatic.copyWith(
            color: Colors.white.withOpacity(0.6),
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.gapXXS,
        Text(
          value,
          style: AppTypography.labelMediumStatic.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // SERVICE GRID
  // ═══════════════════════════════════════════════════════════════
  Widget _buildServiceGrid(BuildContext context, bool isDark) {
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: AppSpacing.gridSpacingMedium,
        crossAxisSpacing: AppSpacing.gridSpacingMedium,
        childAspectRatio: 1.05,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return Material(
          color: AppColors.getBackground(context),
          borderRadius: AppRadius.cardRadius,
          child: InkWell(
            onTap: () {},
            borderRadius: AppRadius.cardRadius,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: AppRadius.cardRadius,
                border: Border.all(color: AppColors.getBorder(context)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    services[index]['icon'],
                    color: AppColors.primaryBlue,
                    size: 26,
                  ),
                  AppSpacing.gapSM,
                  Text(
                    services[index]['label'],
                    style: AppTypography.labelSmallStatic.copyWith(
                      color: AppColors.getTextPrimary(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // BILLING CARD
  // ═══════════════════════════════════════════════════════════════
  Widget _buildBillingCard(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.getBackground(context),
        borderRadius: AppRadius.cardXLRadius,
        border: Border.all(color: AppColors.getBorder(context)),
        boxShadow: [
          BoxShadow(
            color: AppColors.getShadow(context, 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tagihan Bulan Ini",
                style: AppTypography.h4(context),
              ),
              _buildBadge("BELUM LUNAS", AppColors.error),
            ],
          ),
          AppSpacing.gapXL,
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sewa + Listrik",
                      style: AppTypography.bodySmall(context),
                    ),
                    AppSpacing.gapXXS,
                    Text(
                      "Rp 1.250.000",
                      style: AppTypography.priceStatic.copyWith(
                        color: AppColors.getTextPrimary(context),
                      ),
                    ),
                  ],
                ),
              ),
              _buildPayButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton(BuildContext context) {
    return Material(
      color: AppColors.primaryBlue,
      borderRadius: AppRadius.buttonRadius,
      child: InkWell(
        onTap: () {},
        borderRadius: AppRadius.buttonRadius,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Text(
            "Bayar",
            style: AppTypography.labelLargeStatic.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: AppRadius.badgeRadius,
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: AppTypography.badgeStatic.copyWith(color: color),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // ACTIVITY TIMELINE
  // ═══════════════════════════════════════════════════════════════
  Widget _buildActivityTimeline(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.getBackground(context),
        borderRadius: AppRadius.cardXLRadius,
        border: Border.all(color: AppColors.getBorder(context)),
      ),
      child: Column(
        children: [
          _buildTimelineItem(
            context,
            "Laundry Masuk",
            "3 Kg pakaian sedang diproses.",
            true,
          ),
          Padding(
            padding: AppSpacing.verticalLG,
            child: Divider(height: 1, color: AppColors.getDivider(context)),
          ),
          _buildTimelineItem(
            context,
            "Pembayaran Listrik",
            "Token berhasil diisi oleh admin.",
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    String title,
    String subtitle,
    bool isNew,
  ) {
    return Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: isNew
                ? AppColors.primaryBlue
                : AppColors.getTextSecondary(context).withOpacity(0.3),
            shape: BoxShape.circle,
          ),
        ),
        AppSpacing.hGapLG,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.labelMedium(context),
              ),
              AppSpacing.gapXXS,
              Text(
                subtitle,
                style: AppTypography.caption(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // SECTION HEADER
  // ═══════════════════════════════════════════════════════════════
  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primaryBlue),
        AppSpacing.hGapSM,
        Text(
          title,
          style: AppTypography.sectionHeader(context),
        ),
      ],
    );
  }
}
