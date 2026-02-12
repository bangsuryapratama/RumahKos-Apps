import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumahkosapps/app/core/values/app_colors.dart';
import 'package:rumahkosapps/app/core/values/app_radius.dart';
import 'package:rumahkosapps/app/core/values/app_spacing.dart';
import 'package:rumahkosapps/app/core/values/app_typography.dart';
import '../controllers/profile_controller.dart';



class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackground(context),
      body: Obx(() {
        if (controller.isLoading.value && controller.name.value.isEmpty) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryBlue),
          );
        }

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildSliverAppBar(context),
            SliverToBoxAdapter(
              child: Padding(
                padding: AppSpacing.screenPadding(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacing.gapXXL,
                    _buildProfileCompletion(context),
                    AppSpacing.gapSection,
                    _buildSectionLabel(context, "DATA PRIBADI"),
                    AppSpacing.gapLG,
                    _buildPersonalInfoCard(context),
                    AppSpacing.gapSection,
                    _buildSectionLabel(context, "DOKUMEN IDENTITAS"),
                    AppSpacing.gapLG,
                    _buildDocumentsCard(context),
                    AppSpacing.gapSection,
                    _buildSectionLabel(context, "PENGATURAN AKUN"),
                    AppSpacing.gapLG,
                    _buildMenuCard(context),
                    AppSpacing.gapSection,
                    _buildSectionLabel(context, "SISTEM"),
                    AppSpacing.gapLG,
                    _buildLogoutCard(context),
                    AppSpacing.gapXXL,
                    Center(
                      child: Opacity(
                        opacity: 0.5,
                        child: Text(
                          "RumahKos Pro v1.0.0",
                          style: AppTypography.caption(context),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // SLIVER APP BAR
  // ═══════════════════════════════════════════════════════════════
  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.primaryBlue,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh_rounded),
          onPressed: () => controller.fetchProfile(),
          tooltip: 'Refresh',
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryBlue, AppColors.primaryDark],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: -50,
                top: -50,
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white.withOpacity(0.05),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  _buildAvatar(context),
                  AppSpacing.gapLG,
                  Obx(() => Text(
                        controller.name.value.isEmpty
                            ? "User RumahKos"
                            : controller.name.value,
                        style: AppTypography.h2Static.copyWith(
                          color: Colors.white,
                        ),
                      )),
                  AppSpacing.gapXXS,
                  Obx(() => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: AppRadius.badgePillRadius,
                        ),
                        child: Text(
                          controller.role.value.toUpperCase(),
                          style: AppTypography.labelSmallStatic.copyWith(
                            color: Colors.white,
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

  Widget _buildAvatar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.xxs),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Obx(() {
        final initial = controller.name.value.isNotEmpty
            ? controller.name.value[0].toUpperCase()
            : "U";
        return CircleAvatar(
          radius: 45,
          backgroundColor: AppColors.slate100,
          child: Text(
            initial,
            style: AppTypography.displayMediumStatic.copyWith(
              color: AppColors.primaryBlue,
            ),
          ),
        );
      }),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // PROFILE COMPLETION
  // ═══════════════════════════════════════════════════════════════
  Widget _buildProfileCompletion(BuildContext context) {
    return Obx(() => Container(
          padding: EdgeInsets.all(AppSpacing.cardPadding),
          decoration: BoxDecoration(
            color: AppColors.getBackground(context),
            borderRadius: AppRadius.cardRadius,
            border: Border.all(color: AppColors.getBorder(context)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kelengkapan Profile",
                    style: AppTypography.h5(context),
                  ),
                  Text(
                    "${controller.completionPercent.value}%",
                    style: AppTypography.h4Static.copyWith(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
              AppSpacing.gapMD,
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: controller.completionPercent.value / 100,
                  backgroundColor: AppColors.slate100,
                  color: AppColors.primaryBlue,
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ));
  }

  // ═══════════════════════════════════════════════════════════════
  // PERSONAL INFO CARD
  // ═══════════════════════════════════════════════════════════════
  Widget _buildPersonalInfoCard(BuildContext context) {
    return Obx(() => Container(
          decoration: BoxDecoration(
            color: AppColors.getBackground(context),
            borderRadius: AppRadius.cardRadius,
            border: Border.all(color: AppColors.getBorder(context)),
          ),
          child: Column(
            children: [
              _buildInfoRow(
                context,
                "Nama",
                controller.name.value,
                Icons.person_outline,
              ),
              _divider(context),
              _buildInfoRow(
                context,
                "Email",
                controller.email.value,
                Icons.email_outlined,
              ),
              _divider(context),
              _buildInfoRow(
                context,
                "No. Telepon",
                controller.phone.value.isEmpty ? "-" : controller.phone.value,
                Icons.phone_outlined,
              ),
              _divider(context),
              _buildInfoRow(
                context,
                "No. KTP",
                controller.identityNumber.value.isEmpty
                    ? "-"
                    : controller.identityNumber.value,
                Icons.badge_outlined,
              ),
              _divider(context),
              _buildInfoRow(
                context,
                "Alamat",
                controller.address.value.isEmpty ? "-" : controller.address.value,
                Icons.home_outlined,
                maxLines: 2,
              ),
            ],
          ),
        ));
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.cardPadding,
        vertical: AppSpacing.lg,
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryBlue, size: 22),
          AppSpacing.hGapLG,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTypography.caption(context)),
                AppSpacing.gapXXS,
                Text(
                  value,
                  style: AppTypography.labelMedium(context),
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // DOCUMENTS CARD
  // ═══════════════════════════════════════════════════════════════
  Widget _buildDocumentsCard(BuildContext context) {
    return Obx(() => Container(
          decoration: BoxDecoration(
            color: AppColors.getBackground(context),
            borderRadius: AppRadius.cardRadius,
            border: Border.all(color: AppColors.getBorder(context)),
          ),
          child: Column(
            children: [
              _buildDocumentRow(
                context,
                "KTP",
                "Kartu Tanda Penduduk",
                controller.ktpPhoto.value,
                "ktp_photo",
                Icons.credit_card,
              ),
              _divider(context),
              _buildDocumentRow(
                context,
                "SIM",
                "Surat Izin Mengemudi",
                controller.simPhoto.value,
                "sim_photo",
                Icons.directions_car,
              ),
              _divider(context),
              _buildDocumentRow(
                context,
                "Passport",
                "Paspor Internasional",
                controller.passportPhoto.value,
                "passport_photo",
                Icons.flight_takeoff,
              ),
            ],
          ),
        ));
  }

  Widget _buildDocumentRow(
    BuildContext context,
    String title,
    String subtitle,
    String imageUrl,
    String documentType,
    IconData icon,
  ) {
    final bool hasDocument = imageUrl.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.cardPadding,
        vertical: AppSpacing.lg,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppSpacing.sm + 2),
            decoration: BoxDecoration(
              color: hasDocument
                  ? AppColors.primaryBlue.withOpacity(0.1)
                  : AppColors.slate200,
              borderRadius: AppRadius.iconRadius,
            ),
            child: Icon(
              icon,
              color: hasDocument ? AppColors.primaryBlue : AppColors.slate400,
              size: 24,
            ),
          ),
          AppSpacing.hGapLG,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.h5(context)),
                AppSpacing.gapXXS,
                Text(
                  hasDocument ? "Dokumen tersedia" : subtitle,
                  style: AppTypography.captionStatic.copyWith(
                    color: hasDocument ? AppColors.success : AppColors.getTextSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          if (hasDocument)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
              onPressed: () => controller.deleteDocument(documentType),
            ),
          IconButton(
            icon: Icon(
              hasDocument ? Icons.visibility : Icons.upload_file,
              color: AppColors.primaryBlue,
              size: 20,
            ),
            onPressed: () {
              if (hasDocument) {
                Get.snackbar("Info", "Menampilkan dokumen...");
              } else {
                controller.uploadDocument(documentType);
              }
            },
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // MENU CARD
  // ═══════════════════════════════════════════════════════════════
  Widget _buildMenuCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getBackground(context),
        borderRadius: AppRadius.cardRadius,
        border: Border.all(color: AppColors.getBorder(context)),
      ),
      child: Column(
        children: [
          _buildMenuRow(
            context,
            icon: Icons.edit_outlined,
            title: "Edit Profil",
            onTap: () => Get.snackbar("Info", "Fitur Edit Profil akan segera hadir"),
          ),
          _divider(context),
          _buildMenuRow(
            context,
            icon: Icons.security_outlined,
            title: "Keamanan Akun",
            onTap: () => Get.snackbar("Info", "Fitur Keamanan akan segera hadir"),
          ),
          _divider(context),
          _buildMenuRow(
            context,
            icon: Icons.notifications_outlined,
            title: "Notifikasi",
            onTap: () => Get.snackbar("Info", "Fitur Notifikasi akan segera hadir"),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // LOGOUT CARD
  // ═══════════════════════════════════════════════════════════════
  Widget _buildLogoutCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getBackground(context),
        borderRadius: AppRadius.cardRadius,
        border: Border.all(color: AppColors.getBorder(context)),
      ),
      child: _buildMenuRow(
        context,
        icon: Icons.logout_rounded,
        title: "Keluar Akun",
        isDanger: true,
        onTap: () => controller.logout(),
      ),
    );
  }

  Widget _buildMenuRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    final color = isDanger ? AppColors.error : AppColors.primaryBlue;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.cardRadius,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.cardPadding,
            vertical: AppSpacing.lg + 2,
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.08),
                  borderRadius: AppRadius.iconRadius,
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              AppSpacing.hGapLG,
              Text(
                title,
                style: AppTypography.h5(context).copyWith(
                  color: isDanger ? AppColors.error : null,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.getTextSecondary(context).withOpacity(0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // HELPERS
  // ═══════════════════════════════════════════════════════════════
  Widget _divider(BuildContext context) => Padding(
        padding: AppSpacing.horizontalXL,
        child: Divider(
          height: 1,
          color: AppColors.getDivider(context),
        ),
      );

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Text(
      label,
      style: AppTypography.sectionHeader(context),
    );
  }
}
