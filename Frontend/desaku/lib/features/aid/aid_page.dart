import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/app_theme.dart';
import '../../core/formatters.dart';
import '../../core/models.dart';
import '../../widgets/form_widgets.dart';
import 'application_detail_page.dart';
import 'program_detail_page.dart';

/// FR-17 dan FR-21: daftar program bantuan dan pengajuan milik warga.
class AidPage extends StatelessWidget {
  const AidPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Program Bantuan',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          bottom: TabBar(
            labelColor: AppColors.purple,
            indicatorColor: AppColors.purple,
            indicatorWeight: 3,
            unselectedLabelColor: AppColors.textMuted,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              Tab(text: 'Program'),
              Tab(text: 'Pengajuan Saya'),
            ],
          ),
        ),
        body: ListenableBuilder(
          listenable: appState,
          builder: (context, _) =>
              TabBarView(children: [_ProgramList(), _ApplicationList()]),
        ),
      ),
    );
  }
}

class _ProgramList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        const InfoBanner(
          title: 'Pengajuan = permohonan',
          text: 'Mengajukan bantuan tidak menjamin diterima. Penetapan penerima ditentukan oleh pemerintah desa.',
          icon: Icons.gavel_rounded,
        ),
        const SizedBox(height: 14),
        for (final p in appState.programs) ...[
          _ProgramCard(program: p),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _ProgramCard extends StatelessWidget {
  const _ProgramCard({required this.program});
  final AidProgram program;

  @override
  Widget build(BuildContext context) {
    final p = program;
    final app = appState.applicationFor(p);
    final (label, color) = app != null
        ? ('Sudah diajukan', AppColors.info)
        : p.isOpen
        ? ('Pendaftaran dibuka', AppColors.success)
        : p.notStarted
        ? ('Segera dibuka', AppColors.warning)
        : ('Ditutup', AppColors.textMuted);
    return SoftCard(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ProgramDetailPage(programId: p.id)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.purpleSoft,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gold),
                ),
                child: Icon(p.icon, color: AppColors.purple, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  p.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            p.description,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textMuted,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          IconLine(
            icon: Icons.date_range_rounded,
            text:
                'Periode: ${fmtDate(p.periodStart)} – ${fmtDate(p.periodEnd)}',
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: StatusChip(label: label, color: color),
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.purple),
            ],
          ),
        ],
      ),
    );
  }
}

class _ApplicationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apps = appState.applications;
    if (apps.isEmpty) {
      return const EmptyState(
        icon: Icons.folder_open_rounded,
        title: 'Belum ada pengajuan',
        message: 'Pilih salah satu program pada tab Program untuk mulai mengajukan bantuan.',
      );
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        for (final a in apps) ...[
          ApplicationCard(application: a),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class ApplicationCard extends StatelessWidget {
  const ApplicationCard({super.key, required this.application});
  final AidApplication application;

  @override
  Widget build(BuildContext context) {
    final a = application;
    final p = appState.programById(a.programId);
    return SoftCard(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ApplicationDetailPage(applicationId: a.id),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            p.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Diajukan ${fmtDate(a.submittedAt)}',
            style: const TextStyle(fontSize: 16, color: AppColors.textMuted),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: StatusChip(
                    label: a.status.label,
                    color: a.status.color,
                    icon: a.status.icon,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.purple),
            ],
          ),
          if (a.status == ApplicationStatus.needsFix) ...[
            const SizedBox(height: 8),
            const Text(
              'Ketuk untuk melihat alasan dan memperbaiki.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
