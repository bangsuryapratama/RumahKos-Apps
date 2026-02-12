import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumahkosapps/app/core/values/app_colors.dart';
import 'package:rumahkosapps/app/core/values/app_radius.dart';
import 'package:rumahkosapps/app/core/values/app_spacing.dart';
import 'package:rumahkosapps/app/core/values/app_typography.dart';
import '../controllers/transaction_controller.dart';



class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColors.isDark(context);
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: AppColors.getBackground(context),
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context, isDark),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildShimmerLayout(context, isDark, isTablet);
        }

        return RefreshIndicator(
          onRefresh: controller.refreshData,
          color: AppColors.primaryBlue,
          edgeOffset: 100,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).padding.top + 75,
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal(context),
                ),
                sliver: SliverToBoxAdapter(
                  child: _buildSummarySection(context, isDark, isTablet),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: AppSpacing.xxl + AppSpacing.xxs,
                ),
              ),
              SliverToBoxAdapter(
                child: _buildFilterTabs(context, isDark),
              ),
              SliverToBoxAdapter(child: AppSpacing.gapXL),
              _buildTransactionList(context, isDark, isTablet),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).padding.bottom + AppSpacing.xl,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // APP BAR
  // ═══════════════════════════════════════════════════════════════
  PreferredSizeWidget _buildAppBar(BuildContext context, bool isDark) {
    return AppBar(
      title: Text(
        'Riwayat Transaksi',
        style: AppTypography.h3(context),
      ),
      centerTitle: true,
      backgroundColor: AppColors.getSurface(context).withOpacity(0.85),
      elevation: 0,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: Colors.transparent),
        ),
      ),
      leading: _AppBarIconButton(
        icon: Icons.arrow_back_ios_new_rounded,
        onTap: () => Get.back(),
        isDark: isDark,
      ),
      actions: [
        _AppBarIconButton(
          icon: Icons.refresh_rounded,
          onTap: () => controller.refreshData(),
          isDark: isDark,
        ),
        AppSpacing.hGapSM,
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // SUMMARY SECTION
  // ═══════════════════════════════════════════════════════════════
  Widget _buildSummarySection(BuildContext context, bool isDark, bool isTablet) {
    return Obx(() {
      final int total = controller.totalTransactions;
      final int unpaid = controller.unpaidCount;
      final int paid =
          controller.payments.where((p) => p['status'] == 'paid').length;

      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  label: 'Total Tagihan',
                  value: '$total',
                  icon: Icons.receipt_long_rounded,
                  color: AppColors.primaryBlue,
                  context: context,
                ),
              ),
              AppSpacing.hGapMD,
              Expanded(
                child: _SummaryCard(
                  label: 'Belum Bayar',
                  value: '$unpaid',
                  icon: Icons.pending_actions_rounded,
                  color: AppColors.warning,
                  context: context,
                ),
              ),
              AppSpacing.hGapMD,
              Expanded(
                child: _SummaryCard(
                  label: 'Sudah Lunas',
                  value: '$paid',
                  icon: Icons.check_circle_rounded,
                  color: AppColors.success,
                  context: context,
                ),
              ),
            ],
          ),
          AppSpacing.gapMD,
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(isDark ? 0.1 : 0.05),
              borderRadius: AppRadius.cardRadius,
              border: Border.all(color: AppColors.success.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.account_balance_wallet_rounded,
                  color: AppColors.success,
                  size: 20,
                ),
                AppSpacing.hGapMD,
                Text(
                  'Total Terbayar:',
                  style: AppTypography.labelMedium(context),
                ),
                const Spacer(),
                Text(
                  controller.formatPrice(controller.totalPaidAmount),
                  style: AppTypography.bodyLargeStatic.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  // ═══════════════════════════════════════════════════════════════
  // FILTER TABS
  // ═══════════════════════════════════════════════════════════════
  Widget _buildFilterTabs(BuildContext context, bool isDark) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal(context),
      ),
      child: Obx(() => Row(
            children: controller.filterOptions.map((opt) {
              final isActive = controller.selectedFilter.value == opt['key'];
              return Padding(
                padding: EdgeInsets.only(right: AppSpacing.sm + AppSpacing.xxs),
                child: Material(
                  color: isActive
                      ? AppColors.primaryBlue
                      : AppColors.getBackground(context),
                  borderRadius: AppRadius.badgePillRadius,
                  child: InkWell(
                    onTap: () => controller.setFilter(opt['key']!),
                    borderRadius: AppRadius.badgePillRadius,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg + AppSpacing.xxs,
                        vertical: AppSpacing.sm + AppSpacing.xxs,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: AppRadius.badgePillRadius,
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: AppColors.primaryBlue.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                )
                              ]
                            : null,
                        border: Border.all(
                          color: isActive
                              ? AppColors.primaryBlue
                              : AppColors.getBorder(context),
                        ),
                      ),
                      child: Text(
                        opt['label']!,
                        style: AppTypography.labelMediumStatic.copyWith(
                          fontWeight:
                              isActive ? FontWeight.w700 : FontWeight.w600,
                          color: isActive
                              ? Colors.white
                              : AppColors.getTextSecondary(context),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // TRANSACTION LIST
  // ═══════════════════════════════════════════════════════════════
  Widget _buildTransactionList(
    BuildContext context,
    bool isDark,
    bool isTablet,
  ) {
    return Obx(() {
      if (controller.filteredPayments.isEmpty) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: _buildEmptyState(context),
        );
      }

      if (isTablet) {
        return SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal(context),
          ),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              mainAxisExtent: 190,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildTransactionCard(
                context,
                controller.filteredPayments[index],
              ),
              childCount: controller.filteredPayments.length,
            ),
          ),
        );
      }

      return SliverPadding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal(context),
        ),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.md + AppSpacing.xxs),
              child: _buildTransactionCard(
                context,
                controller.filteredPayments[index],
              ),
            ),
            childCount: controller.filteredPayments.length,
          ),
        ),
      );
    });
  }

  Widget _buildTransactionCard(
    BuildContext context,
    Map<String, dynamic> trx,
  ) {
    final status = (trx['status'] as String?)?.toLowerCase() ?? 'pending';
    final paymentId = trx['id'] as int;
    final config = _getStatusConfig(status);

    return Obx(() {
      final isProcessing = controller.isPayingThis(paymentId) ||
          controller.isCheckingThis(paymentId);
      final canPay = controller.canPay(trx);

      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.getBackground(context),
          borderRadius: AppRadius.cardRadius,
          border: Border.all(color: AppColors.getBorder(context)),
          boxShadow: [
            BoxShadow(
              color: AppColors.getShadow(context, 0.05),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppSpacing.lg + AppSpacing.xxs),
              child: Row(
                children: [
                  _StatusIcon(config: config),
                  AppSpacing.hGapLG,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatTitle(trx),
                          style: AppTypography.h5(context),
                        ),
                        AppSpacing.gapXXS,
                        Row(
                          children: [
                              Icon(
                                Icons.event_note_rounded,
                                size: 14,
                                color: AppColors.getTextSecondary(context),
                              ),
                              SizedBox(width: AppSpacing.xs * 2),
                              Text(
                                _formatDate(trx['due_date']),
                                style: AppTypography.caption(context),
                              ),
                            ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        controller.formatPrice(trx['amount']),
                        style: AppTypography.h4(context),
                      ),
                      SizedBox(height: AppSpacing.xs + AppSpacing.xxs),
                      _StatusBadge(config: config),
                    ],
                  ),
                ],
              ),
            ),
            if (canPay || status == 'paid') ...[
              Divider(height: 1, color: AppColors.getDivider(context)),
              Container(
                padding: EdgeInsets.all(AppSpacing.md),
                color: AppColors.getBackground(context),
                child: Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        context: context,
                        label: isProcessing &&
                                controller.activeCheckId.value == paymentId
                            ? 'Checking...'
                            : 'Cek Status',
                        icon: Icons.sync_rounded,
                        isSecondary: true,
                        isLoading: controller.isCheckingThis(paymentId),
                        onTap: () => controller.checkPaymentStatus(paymentId),
                      ),
                    ),
                    if (canPay) AppSpacing.hGapMD,
                    if (canPay)
                      Expanded(
                        child: _ActionButton(
                          context: context,
                          label: isProcessing &&
                                  controller.activePayingId.value == paymentId
                              ? 'Process...'
                              : 'Bayar',
                          icon: Icons.bolt_rounded,
                          isLoading: controller.isPayingThis(paymentId),
                          onTap: isProcessing
                              ? null
                              : () => controller.payWithMidtrans(paymentId),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  // ═══════════════════════════════════════════════════════════════
  // EMPTY STATE
  // ═══════════════════════════════════════════════════════════════
  Widget _buildEmptyState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.receipt_long_outlined,
          size: 80,
          color: AppColors.getTextTertiary(context).withOpacity(0.3),
        ),
        AppSpacing.gapXL,
        Text(
          'Tidak ada transaksi ditemukan',
          style: AppTypography.h4(context),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // SHIMMER LAYOUT
  // ═══════════════════════════════════════════════════════════════
  Widget _buildShimmerLayout(
    BuildContext context,
    bool isDark,
    bool isTablet,
  ) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal(context),
        MediaQuery.of(context).padding.top + 75,
        AppSpacing.screenHorizontal(context),
        AppSpacing.xl,
      ),
      children: [
        Row(
         children: [
                Expanded(
                  child: _ShimmerBox(
                    height: 85,
                    borderRadius: 20,
                    context: context,
                  ),
                ),
                SizedBox(width: AppSpacing.sm + AppSpacing.xs),
                Expanded(
                  child: _ShimmerBox(
                    height: 85,
                    borderRadius: 20,
                    context: context,
                  ),
                ),
                SizedBox(width: AppSpacing.sm + AppSpacing.xs),
                Expanded(
                  child: _ShimmerBox(
                    height: 85,
                    borderRadius: 20,
                    context: context,
                  ),
                ),
              ],
        ),
       SizedBox(height: AppSpacing.xxxl - AppSpacing.xxs),
        Row(
          children: List.generate(
            4,
            (i) => Padding(
              padding: EdgeInsets.only(right: AppSpacing.sm + AppSpacing.xxs),
              child: _ShimmerBox(
                  height: 38, width: 80, borderRadius: 20, context: context),
            ),
          ),
        ),
        AppSpacing.gapXXL,
        ...List.generate(
          4,
          (i) => Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.lg),
            child: _ShimmerBox(
                height: 130, borderRadius: 24, context: context),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // HELPERS
  // ═══════════════════════════════════════════════════════════════
  _StatusConfig _getStatusConfig(String status) {
    switch (status) {
      case 'paid':
        return _StatusConfig(
          label: 'Lunas',
          color: AppColors.success,
          icon: Icons.verified_rounded,
        );
      case 'failed':
        return _StatusConfig(
          label: 'Gagal',
          color: AppColors.error,
          icon: Icons.error_outline_rounded,
        );
      default:
        return _StatusConfig(
          label: 'Tertunda',
          color: AppColors.warning,
          icon: Icons.schedule_rounded,
        );
    }
  }

  String _formatTitle(Map<String, dynamic> trx) {
    return trx['description'] ?? 'Tagihan Sewa';
  }

  String _formatDate(dynamic date) {
    if (date == null) return '-';
    try {
      final dt = DateTime.parse(date.toString());
      return '${dt.day}/${dt.month}/${dt.year}';
    } catch (_) {
      return date.toString();
    }
  }
}

// ══════════════════════════════════════════════════════════════════
// SUPPORTING WIDGETS
// ══════════════════════════════════════════════════════════════════

class _AppBarIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;

  const _AppBarIconButton({
    required this.icon,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.verticalSM,
      child: Center(
        child: Material(
          color: isDark ? AppColors.darkCard : AppColors.slate100,
          borderRadius: AppRadius.iconRadius,
          child: InkWell(
            onTap: onTap,
            borderRadius: AppRadius.iconRadius,
            child: SizedBox(
              width: 40,
              height: 40,
              child: Icon(
                icon,
                size: 20,
                color: AppColors.getTextPrimary(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final BuildContext context;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.getBackground(context),
        borderRadius: AppRadius.cardRadius,
        border: Border.all(color: AppColors.getBorder(context)),
        boxShadow: [
          BoxShadow(
            color: AppColors.getShadow(context, 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color),
          AppSpacing.gapMD,
          Text(
            value,
            style: AppTypography.h3Static.copyWith(
              color: AppColors.getTextPrimary(context),
            ),
          ),
          AppSpacing.gapXXS,
          Text(
            label,
            style: AppTypography.captionStatic.copyWith(
              color: AppColors.getTextSecondary(context),
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  final _StatusConfig config;
  const _StatusIcon({required this.config});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: config.color.withOpacity(0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(config.icon, color: config.color, size: 22),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final _StatusConfig config;
  const _StatusBadge({required this.config});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: config.color.withOpacity(0.1),
        borderRadius: AppRadius.badgePillRadius,
      ),
      child: Text(
        config.label,
        style: AppTypography.badgeStatic.copyWith(color: config.color),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final BuildContext context;
  final String label;
  final IconData icon;
  final bool isSecondary;
  final bool isLoading;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.context,
    required this.label,
    required this.icon,
    this.isSecondary = false,
    this.isLoading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isSecondary
        ? AppColors.getBackground(context)
        : AppColors.primaryBlue;
    final contentColor = isSecondary
        ? AppColors.getTextPrimary(context)
        : Colors.white;

    return Material(
      color: bgColor,
      borderRadius: AppRadius.buttonRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.buttonRadius,
        child: Container(
          height: 44,
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            border: isSecondary ? Border.all(color: AppColors.getBorder(context)) : null,
            borderRadius: AppRadius.buttonRadius,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: contentColor,
                  ),
                )
              else
                Icon(icon, size: 16, color: contentColor),
              AppSpacing.hGapSM,
              Text(
                label,
                style: AppTypography.labelMediumStatic.copyWith(
                  color: contentColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusConfig {
  final String label;
  final Color color;
  final IconData icon;
  _StatusConfig({
    required this.label,
    required this.color,
    required this.icon,
  });
}

class _ShimmerBox extends StatefulWidget {
  final double height;
  final double? width;
  final double borderRadius;
  final BuildContext context;

  const _ShimmerBox({
    required this.height,
    this.width,
    this.borderRadius = 12,
    required this.context,
  });

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = AppColors.getShimmerBase(context);
    final highlightColor = AppColors.getShimmerHighlight(context);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, -0.3),
              end: Alignment(_animation.value, 0.3),
              colors: [baseColor, highlightColor, baseColor],
            ),
          ),
        );
      },
    );
  }
}
