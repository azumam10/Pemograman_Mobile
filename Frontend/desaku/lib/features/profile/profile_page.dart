import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/app_theme.dart';
import '../../widgets/batik_widgets.dart';
import '../../widgets/form_widgets.dart';
import '../auth/login_page.dart';
import '../notifications/notifications_page.dart';
import 'edit_profile_page.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.radius});
  final double radius;

  @override
  Widget build(BuildContext context) {
    final u = appState.user;
    final path = u?.photoPath;
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.purple,
      backgroundImage: path != null && File(path).existsSync()
          ? FileImage(File(path))
          : null,
      child: path != null && File(path).existsSync()
          ? null
          : Text(
              (u?.name.isNotEmpty ?? false) ? u!.name[0].toUpperCase() : '?',
              style: TextStyle(
                fontSize: radius,
                fontWeight: FontWeight.w800,
                color: AppColors.goldLight,
              ),
            ),
    );
  }
}

/// FR-06: profil warga. Identitas (nama, NIK, KK) tidak dapat diubah.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _logout(BuildContext context) async {
    final ok = await confirmDialog(
      context,
      title: 'Keluar dari akun?',
      message: 'Anda perlu masuk kembali untuk memakai layanan.',
      confirmLabel: 'Keluar',
      confirmColor: AppColors.maroon,
    );
    if (!ok || !context.mounted) return;
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
        final u = appState.user!;
        return Scaffold(
          appBar: desaAppBar('Profil Saya', showBack: false),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: BatikBackground(
                  overlayOpacity: 0.84,
                  padding: const EdgeInsets.all(18),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: AppColors.gold,
                            shape: BoxShape.circle,
                          ),
                          child: const UserAvatar(radius: 42),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          u.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const StatusChip(
                          label: 'Warga Terverifikasi',
                          color: AppColors.goldLight,
                          icon: Icons.verified_rounded,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SoftCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Data Kependudukan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    IconLine(
                      icon: Icons.credit_card_rounded,
                      text: 'NIK  ${u.maskedNik}',
                    ),
                    IconLine(
                      icon: Icons.family_restroom_rounded,
                      text: 'KK  ${u.maskedKk}',
                    ),
                    IconLine(
                      icon: Icons.phone_outlined,
                      text: '+62 ${u.phone}',
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Nama, NIK, dan KK tidak dapat diubah. Hubungi kantor desa bila ada kesalahan data.',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textMuted,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlineActionButton(
                      label: 'Ubah Telepon & Foto',
                      icon: Icons.edit_rounded,
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const EditProfilePage(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _MenuTile(
                icon: Icons.notifications_rounded,
                title: 'Riwayat Notifikasi',
                badge: appState.unreadCount,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NotificationsPage()),
                ),
              ),
              const SizedBox(height: 10),
              _MenuTile(
                icon: Icons.privacy_tip_rounded,
                title: 'Pelindungan Data Pribadi',
                onTap: () => showDialog<void>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: const Text(
                      'Pelindungan Data Pribadi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    content: const Text(
                      'Data pribadi Anda (NIK, nomor KK, dan dokumen pengajuan) hanya digunakan untuk keperluan '
                      'layanan desa dan tidak dibagikan kepada pihak yang tidak berwenang, sesuai UU No. 27 Tahun 2022 '
                      'tentang Pelindungan Data Pribadi.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Mengerti'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _MenuTile(
                icon: Icons.support_agent_rounded,
                title: 'Bantuan & Kontak Kantor Desa',
                onTap: () => showDialog<void>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: const Text(
                      'Kantor Desa Sukamaju',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    content: const Text(
                      'Layanan tatap muka Senin–Jumat, 08.00 – 15.00 WIB.\n\n'
                      'Warga yang belum mahir memakai aplikasi dapat meminta pendampingan petugas di kantor desa.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              OutlineActionButton(
                label: 'Keluar',
                icon: Icons.logout_rounded,
                color: AppColors.maroon,
                onPressed: () => _logout(context),
              ),
              const SizedBox(height: 14),
              const Center(
                child: Text(
                  'DesaKu v1.0.0',
                  style: TextStyle(fontSize: 16, color: AppColors.textMuted),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.badge = 0,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final int badge;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: AppColors.purple, size: 26),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          if (badge > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.maroon,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$badge',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
