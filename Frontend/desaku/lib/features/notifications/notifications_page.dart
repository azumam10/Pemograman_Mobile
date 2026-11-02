import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/app_theme.dart';
import '../../core/formatters.dart';
import '../../core/models.dart';
import '../../widgets/batik_widgets.dart';
import '../../widgets/form_widgets.dart';
import '../activities/activity_detail_page.dart';
import '../aid/application_detail_page.dart';
import '../news/news_detail_page.dart';

/// FR-14: riwayat notifikasi di dalam aplikasi.
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  void _open(BuildContext context, AppNotification n) {
    appState.markRead(n);
    final id = n.targetId;
    if (id == null) return;
    final page = switch (n.type) {
      NotifType.activity => ActivityDetailPage(activityId: id),
      NotifType.aid => ApplicationDetailPage(applicationId: id),
      NotifType.news => NewsDetailPage(newsId: id),
      NotifType.account => null,
    };
    if (page != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final items = appState.notifications;
        return Scaffold(
          appBar: desaAppBar(
            'Notifikasi',
            actions: [
              if (appState.unreadCount > 0)
                TextButton(
                  onPressed: appState.markAllRead,
                  child: const Text('Tandai dibaca'),
                ),
            ],
          ),
          body: items.isEmpty
              ? const EmptyState(
                  icon: Icons.notifications_none_rounded,
                  title: 'Belum ada notifikasi',
                  message: 'Info kegiatan, pengumuman, dan perubahan status pengajuan akan muncul di sini.',
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    final n = items[i];
                    final icon = switch (n.type) {
                      NotifType.activity => Icons.event_rounded,
                      NotifType.aid => Icons.volunteer_activism_rounded,
                      NotifType.news => Icons.campaign_rounded,
                      NotifType.account => Icons.verified_user_rounded,
                    };
                    return SoftCard(
                      color: n.read ? Colors.white : AppColors.purpleSoft,
                      onTap: () => _open(context, n),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.gold),
                            ),
                            child: Icon(icon, color: AppColors.purple),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  n.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: n.read
                                        ? FontWeight.w600
                                        : FontWeight.w800,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  n.body,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textMuted,
                                    height: 1.35,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  fmtAgo(n.time),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!n.read)
                            Container(
                              margin: const EdgeInsets.only(left: 8, top: 6),
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: AppColors.maroon,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
