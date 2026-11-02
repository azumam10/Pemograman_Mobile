import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/app_theme.dart';
import '../../core/formatters.dart';
import '../../widgets/batik_widgets.dart';
import '../../widgets/form_widgets.dart';
import 'activities_page.dart';

/// FR-08, FR-09, FR-10: detail kegiatan, daftar, dan batalkan.
class ActivityDetailPage extends StatelessWidget {
  const ActivityDetailPage({super.key, required this.activityId});
  final String activityId;

  Future<void> _register(BuildContext context) async {
    final a = appState.activities.firstWhere((e) => e.id == activityId);
    final ok = await confirmDialog(
      context,
      title: 'Daftar kegiatan?',
      message:
          'Anda akan didaftarkan pada "${a.title}" pada ${fmtDateTime(a.start)}.',
      confirmLabel: 'Ya, Daftar',
    );
    if (!ok || !context.mounted) return;
    final err = appState.registerActivity(a);
    showInfo(context, err ?? 'Pendaftaran berhasil. Sampai jumpa di lokasi!');
  }

  Future<void> _cancel(BuildContext context) async {
    final a = appState.activities.firstWhere((e) => e.id == activityId);
    if (!a.canCancel) {
      showInfo(
        context,
        'Batas waktu pembatalan telah lewat (${fmtDateTime(a.cancelDeadline)}).',
      );
      return;
    }
    final ok = await confirmDialog(
      context,
      title: 'Batalkan pendaftaran?',
      message: 'Kuota Anda akan dilepas untuk warga lain.',
      confirmLabel: 'Ya, Batalkan',
      cancelLabel: 'Tidak',
      confirmColor: AppColors.danger,
    );
    if (!ok || !context.mounted) return;
    final err = appState.cancelActivity(a);
    showInfo(context, err ?? 'Pendaftaran dibatalkan.');
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final a = appState.activities.firstWhere((e) => e.id == activityId);
        final mine = appState.isRegistered(a);
        final fill = a.quota == 0
            ? 0.0
            : (a.registered / a.quota).clamp(0.0, 1.0);

        Widget action;
        if (a.cancelled) {
          action = const InfoBanner(
            text: 'Kegiatan ini dibatalkan oleh penyelenggara.',
            icon: Icons.event_busy_rounded,
            color: AppColors.danger,
          );
        } else if (mine) {
          action = Column(
            children: [
              const InfoBanner(
                title: 'Anda sudah terdaftar',
                text: 'Hadir tepat waktu dan bawa kartu identitas.',
                icon: Icons.check_circle_rounded,
                color: AppColors.success,
              ),
              const SizedBox(height: 12),
              OutlineActionButton(
                label: 'Batalkan Pendaftaran',
                icon: Icons.close_rounded,
                color: AppColors.danger,
                onPressed: () => _cancel(context),
              ),
              const SizedBox(height: 6),
              Text(
                a.canCancel
                    ? 'Pembatalan dapat dilakukan sampai ${fmtDateTime(a.cancelDeadline)}.'
                    : 'Batas pembatalan telah lewat.',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          );
        } else if (a.isPast) {
          action = const InfoBanner(
            text: 'Kegiatan ini sudah lewat, pendaftaran ditutup.',
            icon: Icons.history_rounded,
            color: AppColors.textMuted,
          );
        } else if (a.isFull) {
          action = const InfoBanner(
            title: 'Kuota penuh',
            text: 'Maaf, seluruh kuota kegiatan ini sudah terisi.',
            icon: Icons.group_off_rounded,
            color: AppColors.danger,
          );
        } else {
          action = PrimaryButton(
            label: 'Daftar Kegiatan',
            icon: Icons.how_to_reg_rounded,
            onPressed: () => _register(context),
          );
        }

        return Scaffold(
          appBar: desaAppBar('Detail Kegiatan'),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BatikBackground(
                  asset: AppAssets.batik2,
                  overlayOpacity: 0.84,
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DateBadge(date: a.start, dimmed: a.isPast),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              a.category.toUpperCase(),
                              style: const TextStyle(
                                color: AppColors.goldLight,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                letterSpacing: .5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              a.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                height: 1.25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SoftCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconLine(
                      icon: Icons.calendar_month_rounded,
                      text: fmtDateLong(a.start),
                    ),
                    IconLine(
                      icon: Icons.schedule_rounded,
                      text: fmtTime(a.start),
                    ),
                    IconLine(icon: Icons.location_on_rounded, text: a.location),
                    IconLine(
                      icon: Icons.groups_rounded,
                      text: 'Penyelenggara: ${a.organizer}',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(height: 1),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Kuota',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${a.registered} / ${a.quota} terdaftar',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: fill,
                        minHeight: 10,
                        backgroundColor: AppColors.purpleSoft,
                        color: a.isFull ? AppColors.danger : AppColors.gold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      a.isFull ? 'Kuota penuh' : 'Sisa ${a.remaining} kuota',
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const SectionHeader(title: 'Deskripsi'),
              const SizedBox(height: 8),
              Text(
                a.description,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 20),
              action,
            ],
          ),
        );
      },
    );
  }
}
