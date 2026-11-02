import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/app_theme.dart';
import '../../core/formatters.dart';
import '../../widgets/batik_widgets.dart';
import '../../widgets/form_widgets.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key, required this.newsId});
  final String newsId;

  @override
  Widget build(BuildContext context) {
    final n = appState.news.firstWhere((e) => e.id == newsId);
    return Scaffold(
      appBar: desaAppBar('Detail Berita'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 150,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    AppAssets.batik2,
                    fit: BoxFit.cover,
                    cacheWidth: 900,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.purpleDark.withValues(alpha: 0.85),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerLeft,
            child: StatusChip(label: n.categoryLabel, color: AppColors.maroon),
          ),
          const SizedBox(height: 10),
          Text(
            n.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          IconLine(
            icon: Icons.calendar_today_rounded,
            text: fmtDateLong(n.date),
            color: AppColors.textMuted,
          ),
          IconLine(
            icon: Icons.person_outline_rounded,
            text: n.author,
            color: AppColors.textMuted,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: BatikDivider(height: 6),
          ),
          Text(n.body, style: const TextStyle(fontSize: 17, height: 1.6)),
        ],
      ),
    );
  }
}
