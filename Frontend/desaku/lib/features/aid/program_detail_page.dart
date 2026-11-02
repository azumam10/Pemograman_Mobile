import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/app_theme.dart';
import '../../core/formatters.dart';
import '../../core/models.dart';
import '../../widgets/batik_widgets.dart';
import '../../widgets/form_widgets.dart';
import 'application_detail_page.dart';
import 'application_form_page.dart';

/// FR-17, AB-03, FR-26: persyaratan tampil sebelum formulir.
class ProgramDetailPage extends StatelessWidget {
  const ProgramDetailPage({super.key, required this.programId});
  final String programId;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final p = appState.programById(programId);
        final existing = appState.applicationFor(p);

        Widget action;
        if (existing != null) {
          action = Column(
            children: [
              InfoBanner(
                title: 'Anda sudah mengajukan program ini',
                text:
                    'Pengajuan ganda pada periode yang sama tidak diperbolehkan. Status saat ini: ${existing.status.label}.',
                icon: Icons.info_outline_rounded,
                color: AppColors.info,
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: 'Lihat Status Pengajuan',
                icon: Icons.fact_check_rounded,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        ApplicationDetailPage(applicationId: existing.id),
                  ),
                ),
              ),
            ],
          );
        } else if (!p.isOpen) {
          action = InfoBanner(
            title: p.notStarted
                ? 'Pendaftaran belum dibuka'
                : 'Pendaftaran ditutup',
            text: p.notStarted
                ? 'Pendaftaran dibuka pada ${fmtDate(p.periodStart)}.'
                : 'Periode pendaftaran berakhir pada ${fmtDate(p.periodEnd)}.',
            icon: Icons.event_busy_rounded,
            color: AppColors.warning,
          );
        } else {
          action = PrimaryButton(
            label: 'Ajukan Sekarang',
            icon: Icons.edit_document,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ApplicationFormPage(programId: p.id),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: desaAppBar('Detail Program'),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BatikBackground(
                  overlayOpacity: 0.84,
                  padding: const EdgeInsets.all(18),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(p.icon, color: AppColors.goldLight, size: 36),
                        const SizedBox(height: 8),
                        Text(
                          p.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Periode ${fmtDate(p.periodStart)} – ${fmtDate(p.periodEnd)}',
                          style: const TextStyle(
                            color: AppColors.goldLight,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                p.description,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 18),
              const SectionHeader(title: 'Persyaratan'),
              const SizedBox(height: 10),
              SoftCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final r in p.requirements)
                      IconLine(
                        icon: Icons.check_circle_outline_rounded,
                        text: r,
                        color: AppColors.success,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const SectionHeader(title: 'Dokumen yang Disiapkan'),
              const SizedBox(height: 10),
              SoftCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final d in p.documents)
                      IconLine(icon: Icons.description_outlined, text: d),
                    const SizedBox(height: 6),
                    const Text(
                      'Format foto (JPG/PNG) atau PDF, maksimal 5 MB per berkas.',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const InfoBanner(
                title: 'Pengajuan bersifat permohonan',
                text: 'Aplikasi hanya mencatat permohonan Anda. Penetapan penerima bantuan ditentukan oleh pemerintah desa.',
                icon: Icons.gavel_rounded,
              ),
              const SizedBox(height: 16),
              action,
            ],
          ),
        );
      },
    );
  }
}
