import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/app_theme.dart';
import '../../core/models.dart';
import '../../widgets/batik_widgets.dart';
import '../../widgets/form_widgets.dart';
import '../home/main_shell.dart';
import 'auth_header.dart';
import 'login_page.dart';

/// FR-03: status akun "menunggu verifikasi"; fitur layanan dikunci (AB-01).
class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  void _toLogin(BuildContext context) {
    appState.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final user = appState.user;
        if (user == null) return const Scaffold();
        final status = user.status;

        final (icon, title, subtitle) = switch (status) {
          VerificationStatus.pending => (
            Icons.hourglass_top_rounded,
            'Menunggu Verifikasi',
            'Pendaftaran Anda sudah kami terima dan sedang diperiksa admin Desa Sukamaju.',
          ),
          VerificationStatus.verified => (
            Icons.verified_rounded,
            'Akun Terverifikasi',
            'Data Anda telah disetujui. Seluruh layanan DesaKu kini dapat digunakan.',
          ),
          VerificationStatus.rejected => (
            Icons.gpp_bad_rounded,
            'Verifikasi Ditolak',
            'Admin desa belum dapat menyetujui pendaftaran Anda.',
          ),
        };

        return Scaffold(
          appBar: authAppBar(context, canPop: false),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                children: [
                  AuthHeader(title: title, subtitle: subtitle, icon: icon),
                  const SizedBox(height: 16),
                  SoftCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Data Pendaftaran',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        IconLine(
                          icon: Icons.person_outline_rounded,
                          text: user.name,
                        ),
                        IconLine(
                          icon: Icons.credit_card_rounded,
                          text: 'NIK ${user.maskedNik}',
                        ),
                        IconLine(
                          icon: Icons.family_restroom_rounded,
                          text: 'KK ${user.maskedKk}',
                        ),
                        IconLine(
                          icon: Icons.phone_outlined,
                          text: '+62 ${user.phone}',
                        ),
                        const SizedBox(height: 8),
                        StatusChip(
                          label: switch (status) {
                            VerificationStatus.pending => 'Menunggu verifikasi',
                            VerificationStatus.verified => 'Terverifikasi',
                            VerificationStatus.rejected => 'Ditolak',
                          },
                          color: switch (status) {
                            VerificationStatus.pending => AppColors.warning,
                            VerificationStatus.verified => AppColors.success,
                            VerificationStatus.rejected => AppColors.danger,
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  if (status == VerificationStatus.pending)
                    const InfoBanner(
                      title: 'Layanan dikunci sementara',
                      icon: Icons.lock_clock_rounded,
                      color: AppColors.warning,
                      text:
                          'Pendaftaran kegiatan dan pengajuan bantuan hanya tersedia untuk warga yang sudah diverifikasi. '
                          'Anda akan menerima notifikasi hasil verifikasi.',
                    ),
                  if (status == VerificationStatus.rejected)
                    InfoBanner(
                      title: 'Alasan penolakan',
                      icon: Icons.info_outline_rounded,
                      color: AppColors.danger,
                      text: user.rejectReason ?? '-',
                    ),
                  if (status == VerificationStatus.verified) ...[
                    PrimaryButton(
                      label: 'Masuk ke Beranda',
                      icon: Icons.arrow_forward_rounded,
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const MainShell()),
                        (_) => false,
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  if (status != VerificationStatus.verified)
                    const HelpCard(
                      title: 'Perlu bantuan verifikasi?',
                      lines: [
                        'Datang ke Kantor Desa Sukamaju',
                        'Senin–Jumat, 08.00 – 15.00 WIB',
                      ],
                    ),
                  const SizedBox(height: 12),
                  OutlineActionButton(
                    label: 'Keluar',
                    icon: Icons.logout_rounded,
                    color: AppColors.maroon,
                    onPressed: () => _toLogin(context),
                  ),
                  // Simulasi tindakan admin (panel web) — hanya muncul pada mode debug.
                  if (kDebugMode && status == VerificationStatus.pending) ...[
                    const SizedBox(height: 20),
                    const BatikDivider(height: 6),
                    const SizedBox(height: 12),
                    const Text(
                      'MODE DEMO • Simulasi tindakan admin',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.info,
                      ),
                    ),
                    const SizedBox(height: 8),
                    PrimaryButton(
                      label: 'Simulasikan: Disetujui',
                      color: AppColors.success,
                      onPressed: () =>
                          appState.simulateVerification(approve: true),
                    ),
                    const SizedBox(height: 8),
                    OutlineActionButton(
                      label: 'Simulasikan: Ditolak',
                      color: AppColors.danger,
                      onPressed: () =>
                          appState.simulateVerification(approve: false),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
