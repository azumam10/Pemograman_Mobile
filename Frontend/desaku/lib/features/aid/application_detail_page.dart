import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/app_theme.dart';
import '../../core/formatters.dart';
import '../../core/models.dart';
import '../../widgets/batik_widgets.dart';
import '../../widgets/form_widgets.dart';
import 'application_form_page.dart';

/// FR-21, FR-22, AB-05: status, alasan, riwayat, dan perbaikan pengajuan.
class ApplicationDetailPage extends StatelessWidget {
  const ApplicationDetailPage({super.key, required this.applicationId});
  final String applicationId;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final a = appState.applications.firstWhere(
          (e) => e.id == applicationId,
        );
        final p = appState.programById(a.programId);
        final status = a.status;

        return Scaffold(
          appBar: desaAppBar('Status Pengajuan'),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              SoftCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Diajukan ${fmtDateTime(a.submittedAt)}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 12),
                    StatusChip(
                      label: status.label,
                      color: status.color,
                      icon: status.icon,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              if (status == ApplicationStatus.needsFix ||
                  status == ApplicationStatus.rejected)
                InfoBanner(
                  title: status == ApplicationStatus.needsFix
                      ? 'Alasan perlu perbaikan'
                      : 'Alasan penolakan',
                  text: a.reason ?? '-',
                  icon: status.icon,
                  color: status.color,
                ),
              if (status == ApplicationStatus.approved)
                const InfoBanner(
                  title: 'Pengajuan disetujui',
                  text: 'Penetapan dan penyaluran bantuan mengikuti keputusan pemerintah desa. Pantau informasi resmi dari kantor desa.',
                  icon: Icons.check_circle_rounded,
                  color: AppColors.success,
                ),
              if (status == ApplicationStatus.needsFix) ...[
                const SizedBox(height: 12),
                PrimaryButton(
                  label: 'Perbaiki & Kirim Ulang',
                  icon: Icons.edit_rounded,
                  color: AppColors.orange,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ApplicationFormPage(
                        programId: p.id,
                        existingId: a.id,
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 18),
              const SectionHeader(title: 'Perkembangan'),
              const SizedBox(height: 10),
              SoftCard(
                child: Column(
                  children: [
                    for (var i = a.history.length - 1; i >= 0; i--)
                      _TimelineRow(
                        event: a.history[i],
                        isLast: i == 0,
                        isCurrent: i == a.history.length - 1,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const SectionHeader(title: 'Data yang Diajukan'),
              const SizedBox(height: 10),
              SoftCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final f in p.fields)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              f.label,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.textMuted,
                              ),
                            ),
                            Text(
                              a.data[f.key]?.isNotEmpty == true
                                  ? a.data[f.key]!
                                  : '-',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const Divider(),
                    const SizedBox(height: 6),
                    for (final d in a.docs)
                      IconLine(
                        icon: d.fileName.toLowerCase().endsWith('.pdf')
                            ? Icons.picture_as_pdf_rounded
                            : Icons.image_rounded,
                        text: '${d.label}\n${d.fileName}',
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const InfoBanner(
                text: 'Pengajuan bersifat permohonan. Penetapan penerima bantuan ditentukan oleh pemerintah desa.',
                icon: Icons.gavel_rounded,
              ),
              // Simulasi tindakan admin (panel web) — hanya pada mode debug.
              if (kDebugMode) ...[
                const SizedBox(height: 20),
                const BatikDivider(height: 6),
                const SizedBox(height: 12),
                const Text(
                  'MODE DEMO • Simulasi admin mengubah status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.info,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final s in ApplicationStatus.values)
                      ActionChip(
                        label: Text(s.label),
                        onPressed: () => appState.simulateStatus(a, s),
                      ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.event,
    required this.isLast,
    required this.isCurrent,
  });
  final StatusEvent event;
  final bool isLast;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final color = isCurrent ? event.status.color : AppColors.textMuted;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Icon(event.status.icon, color: color, size: 26),
              if (!isLast)
                Expanded(child: Container(width: 2, color: AppColors.border)),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.status.label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
                      color: color,
                    ),
                  ),
                  Text(
                    fmtDateTime(event.time),
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textMuted,
                    ),
                  ),
                  if (event.reason != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        event.reason!,
                        style: const TextStyle(fontSize: 16, height: 1.3),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
