import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/app_theme.dart';
import '../../core/formatters.dart';
import '../../core/models.dart';
import '../../widgets/batik_widgets.dart';
import '../../widgets/form_widgets.dart';
import 'activity_detail_page.dart';

/// Kartu ringkas kegiatan dengan lencana tanggal.
class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key, required this.activity});
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    final a = activity;
    final mine = appState.isRegistered(a);
    final (label, color) = mine
        ? ('Terdaftar', AppColors.success)
        : a.isPast
        ? ('Selesai', AppColors.textMuted)
        : a.isFull
        ? ('Kuota penuh', AppColors.danger)
        : ('Sisa ${a.remaining} kuota', AppColors.info);

    return SoftCard(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ActivityDetailPage(activityId: a.id)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateBadge(date: a.start, dimmed: a.isPast),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  a.category,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  a.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 6),
                IconLine(
                  icon: Icons.schedule_rounded,
                  text: fmtTime(a.start),
                  color: AppColors.textMuted,
                ),
                IconLine(
                  icon: Icons.location_on_outlined,
                  text: a.location,
                  color: AppColors.textMuted,
                ),
                const SizedBox(height: 6),
                StatusChip(
                  label: label,
                  color: color,
                  icon: mine ? Icons.check_circle_rounded : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DateBadge extends StatelessWidget {
  const DateBadge({super.key, required this.date, this.dimmed = false});
  final DateTime date;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: dimmed ? AppColors.textMuted : AppColors.maroon,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gold),
      ),
      child: Column(
        children: [
          Text(
            monthShort(date),
            style: const TextStyle(
              color: AppColors.goldLight,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            '${date.day}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

/// FR-07: daftar kegiatan terurut dari yang terdekat, dengan filter kategori.
class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  String _category = 'Semua';
  bool _onlyMine = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: desaAppBar('Kegiatan Desa', showBack: false),
      body: ListenableBuilder(
        listenable: appState,
        builder: (context, _) {
          final categories = appState.activityCategories;
          if (!categories.contains(_category)) _category = 'Semua';
          final upcoming = appState.upcomingActivities;
          final past = appState.sortedActivities
              .where((a) => a.isPast)
              .toList()
              .reversed
              .toList();

          bool match(Activity a) =>
              (_category == 'Semua' || a.category == _category) &&
              (!_onlyMine || appState.isRegistered(a));

          final up = upcoming.where(match).toList();
          final ps = past.where(match).toList();

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              SizedBox(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (final c in categories)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(c),
                          selected: _category == c,
                          selectedColor: AppColors.purple,
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: _category == c
                                ? Colors.white
                                : AppColors.text,
                          ),
                          showCheckmark: false,
                          onSelected: (_) => setState(() => _category = c),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              SoftCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                onTap: () => setState(() => _onlyMine = !_onlyMine),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Hanya kegiatan yang saya ikuti',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Switch(
                      value: _onlyMine,
                      onChanged: (v) => setState(() => _onlyMine = v),
                      thumbColor: const WidgetStatePropertyAll(Colors.white),
                      trackColor: WidgetStateProperty.resolveWith(
                        (s) => s.contains(WidgetState.selected)
                            ? AppColors.purple
                            : AppColors.textMuted,
                      ),
                      trackOutlineColor: const WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const SectionHeader(title: 'Akan Datang'),
              const SizedBox(height: 12),
              if (up.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: EmptyState(
                    icon: Icons.event_busy_rounded,
                    title: _onlyMine
                        ? 'Belum ada kegiatan yang Anda ikuti'
                        : 'Belum ada kegiatan',
                    message: _onlyMine
                        ? 'Daftar pada kegiatan yang tersedia, lalu kegiatan Anda akan tampil di sini.'
                        : 'Tidak ada kegiatan yang cocok dengan filter Anda.',
                  ),
                ),
              for (final a in up) ...[
                ActivityCard(activity: a),
                const SizedBox(height: 12),
              ],
              if (ps.isNotEmpty) ...[
                const SizedBox(height: 12),
                const SectionHeader(title: 'Telah Selesai'),
                const SizedBox(height: 12),
                for (final a in ps) ...[
                  ActivityCard(activity: a),
                  const SizedBox(height: 12),
                ],
              ],
            ],
          );
        },
      ),
    );
  }
}
