import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/app_theme.dart';
import '../../core/models.dart';
import '../../widgets/batik_widgets.dart';
import '../../widgets/form_widgets.dart';
import '../activities/activities_page.dart';
import '../aid/aid_page.dart';
import '../news/news_detail_page.dart';
import '../news/news_page.dart';
import '../notifications/notifications_page.dart';

// Indeks tab pada MainShell.
const tabActivities = 1;
const tabAid = 2;
const tabNews = 3;

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.onNavigate});

  /// Dipanggil untuk berpindah tab pada bottom navigation.
  final ValueChanged<int> onNavigate;

  void _openNotifications(BuildContext context) =>
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const NotificationsPage()));

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final user = appState.user!;
        final upcoming = appState.upcomingActivities.take(2).toList();
        final news = (List.of(appState.news)
          ..sort((a, b) => b.date.compareTo(a.date)));
        final notice = news
            .where((n) => n.category == NewsCategory.pengumuman)
            .firstOrNull;
        final apps = appState.applications;

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 16,
            title: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.purple,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.gold, width: 1.4),
                  ),
                  child: const Icon(
                    Icons.account_balance_rounded,
                    size: 22,
                    color: AppColors.goldLight,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'DesaKu',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: AppColors.purple,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                tooltip: 'Notifikasi',
                onPressed: () => _openNotifications(context),
                icon: Badge(
                  isLabelVisible: appState.unreadCount > 0,
                  label: Text(
                    '${appState.unreadCount}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  child: const Icon(
                    Icons.notifications_rounded,
                    size: 28,
                    color: AppColors.purple,
                  ),
                ),
              ),
              const SizedBox(width: 6),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              _HeroCard(user: user),
              if (notice != null) ...[
                const SizedBox(height: 14),
                _Announcement(
                  item: notice,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => NewsDetailPage(newsId: notice.id),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 22),
              const SectionHeader(title: 'Layanan Warga'),
              const SizedBox(height: 12),
              _ServiceGrid(
                onNavigate: onNavigate,
                onNotifications: () => _openNotifications(context),
              ),
              const SizedBox(height: 22),
              SectionHeader(
                title: 'Kegiatan Terdekat',
                action: 'Lihat Semua',
                onAction: () => onNavigate(tabActivities),
              ),
              const SizedBox(height: 12),
              if (upcoming.isEmpty)
                const InfoBanner(
                  text: 'Belum ada kegiatan mendatang.',
                  icon: Icons.event_busy_rounded,
                  color: AppColors.textMuted,
                ),
              for (final a in upcoming) ...[
                ActivityCard(activity: a),
                const SizedBox(height: 12),
              ],
              const SizedBox(height: 10),
              SectionHeader(
                title: 'Pengajuan Bantuan Saya',
                action: 'Semua',
                onAction: () => onNavigate(tabAid),
              ),
              const SizedBox(height: 12),
              if (apps.isEmpty)
                SoftCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Belum ada pengajuan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Lihat program bantuan yang tersedia dan ajukan permohonan Anda.',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textMuted,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      PrimaryButton(
                        label: 'Lihat Program Bantuan',
                        icon: Icons.arrow_forward_rounded,
                        onPressed: () => onNavigate(tabAid),
                      ),
                    ],
                  ),
                )
              else
                for (final a in apps.take(2)) ...[
                  ApplicationCard(application: a),
                  const SizedBox(height: 12),
                ],
              const SizedBox(height: 10),
              SectionHeader(
                title: 'Berita & Informasi Desa',
                action: 'Semua',
                onAction: () => onNavigate(tabNews),
              ),
              const SizedBox(height: 12),
              for (final n in news.take(2)) ...[
                NewsCard(item: n),
                const SizedBox(height: 12),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.user});
  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gold, width: 1.4),
        borderRadius: BorderRadius.circular(22),
      ),
      child: BatikBackground(
        asset: AppAssets.batik1,
        overlayOpacity: 0.92,
        borderRadius: BorderRadius.circular(20),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang, ${user.name}!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Desa Sukamaju, Kabupaten Tangerang',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.badge_outlined,
                    color: AppColors.goldLight,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NIK',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          user.maskedNik,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            letterSpacing: .5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Announcement extends StatelessWidget {
  const _Announcement({required this.item, required this.onTap});
  final NewsItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.goldLight.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.gold.withValues(alpha: 0.6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.campaign_rounded,
                    size: 22,
                    color: AppColors.maroon,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'PENGUMUMAN TERBARU',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.maroon,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.4,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Baca selengkapnya →',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.purple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceGrid extends StatelessWidget {
  const _ServiceGrid({required this.onNavigate, required this.onNotifications});
  final ValueChanged<int> onNavigate;
  final VoidCallback onNotifications;

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        Icons.event_rounded,
        'Kegiatan Desa',
        'Daftar & ikuti kegiatan',
        () => onNavigate(tabActivities),
      ),
      (
        Icons.volunteer_activism_rounded,
        'Program Bantuan',
        'Ajukan & pantau status',
        () => onNavigate(tabAid),
      ),
      (
        Icons.newspaper_rounded,
        'Berita Desa',
        'Informasi resmi desa',
        () => onNavigate(tabNews),
      ),
      (
        Icons.notifications_rounded,
        'Notifikasi',
        '${appState.unreadCount} belum dibaca',
        onNotifications,
      ),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.98,
      children: [
        for (final (icon, title, sub, onTap) in items)
          SoftCard(
            onTap: onTap,
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.purpleSoft,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.gold.withValues(alpha: 0.8),
                    ),
                  ),
                  child: Icon(icon, color: AppColors.purple, size: 28),
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  sub,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textMuted,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
