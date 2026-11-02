import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/batik_widgets.dart';

/// Kartu header bermotif batik untuk layar autentikasi.
class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.account_balance_rounded,
  });
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Column(
        children: [
          BatikBackground(
            asset: AppAssets.batik2,
            overlayOpacity: 0.78,
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    width: 66,
                    height: 66,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.14),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.gold, width: 1.6),
                    ),
                    child: Icon(icon, color: AppColors.goldLight, size: 34),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const BatikDivider(height: 10),
        ],
      ),
    );
  }
}

/// AppBar layar autentikasi: tombol kembali dan judul "DESA KU".
PreferredSizeWidget authAppBar(BuildContext context, {bool canPop = true}) {
  return AppBar(
    automaticallyImplyLeading: false,
    leading: canPop
        ? IconButton(
            tooltip: 'Kembali',
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            onPressed: () => Navigator.of(context).maybePop(),
          )
        : null,
    centerTitle: true,
    title: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.account_balance_rounded, size: 20, color: AppColors.purple),
        SizedBox(width: 6),
        Text(
          'DESA KU',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            color: AppColors.purple,
          ),
        ),
      ],
    ),
  );
}

/// Kartu bantuan di bagian bawah layar auth.
class HelpCard extends StatelessWidget {
  const HelpCard({super.key, required this.title, required this.lines});
  final String title;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.goldLight.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.support_agent_rounded,
            color: AppColors.maroon,
            size: 26,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: AppColors.maroon,
                  ),
                ),
                const SizedBox(height: 4),
                for (final l in lines)
                  Text(l, style: const TextStyle(fontSize: 16, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
