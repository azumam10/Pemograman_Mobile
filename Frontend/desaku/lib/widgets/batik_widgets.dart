import 'package:flutter/material.dart';

import '../core/app_theme.dart';

/// Latar bermotif batik dengan lapisan warna agar teks tetap terbaca.
class BatikBackground extends StatelessWidget {
  const BatikBackground({
    super.key,
    required this.child,
    this.asset = AppAssets.batik1,
    this.overlay = AppColors.purple,
    this.overlayOpacity = 0.82,
    this.borderRadius = BorderRadius.zero,
    this.padding = EdgeInsets.zero,
  });

  final Widget child;
  final String asset;
  final Color overlay;
  final double overlayOpacity;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(asset, fit: BoxFit.cover, cacheWidth: 700),
          ),
          Positioned.fill(
            child: ColoredBox(color: overlay.withValues(alpha: overlayOpacity)),
          ),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}

/// Garis pemisah bermotif batik (deretan belah ketupat emas).
class BatikDivider extends StatelessWidget {
  const BatikDivider({super.key, this.height = 10});
  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    width: double.infinity,
    child: CustomPaint(painter: _DiamondBandPainter()),
  );
}

class _DiamondBandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = AppColors.maroon,
    );
    final gold = Paint()..color = AppColors.gold;
    final step = size.height * 1.6;
    for (double x = step / 2; x < size.width + step; x += step) {
      final cy = size.height / 2;
      final r = size.height * 0.38;
      final path = Path()
        ..moveTo(x, cy - r)
        ..lineTo(x + r, cy)
        ..lineTo(x, cy + r)
        ..lineTo(x - r, cy)
        ..close();
      canvas.drawPath(path, gold);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

/// Judul bagian dengan ornamen emas kecil di sisi kiri.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.action,
    this.onAction,
  });
  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: AppColors.gold,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
        ),
        if (action != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              action!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.purple,
              ),
            ),
          ),
      ],
    );
  }
}

/// AppBar standar halaman dalam: judul + garis batik.
PreferredSizeWidget desaAppBar(
  String title, {
  List<Widget>? actions,
  bool showBack = true,
}) {
  return AppBar(
    automaticallyImplyLeading: showBack,
    title: Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
    ),
    actions: actions,
  );
}
