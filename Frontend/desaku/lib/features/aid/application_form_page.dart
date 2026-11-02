import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/app_theme.dart';
import '../../core/formatters.dart';
import '../../core/models.dart';
import '../../widgets/batik_widgets.dart';
import '../../widgets/form_widgets.dart';

const maxUploadBytes = 5 * 1024 * 1024;
const allowedUploadExt = ['jpg', 'jpeg', 'png', 'pdf'];

/// FR-18, FR-19, FR-20, FR-22: formulir pengajuan (baru atau perbaikan).
class ApplicationFormPage extends StatefulWidget {
  const ApplicationFormPage({
    super.key,
    required this.programId,
    this.existingId,
  });
  final String programId;

  /// Bila diisi, formulir dipakai untuk memperbaiki pengajuan "Perlu Perbaikan".
  final String? existingId;

  @override
  State<ApplicationFormPage> createState() => _ApplicationFormPageState();
}

class _ApplicationFormPageState extends State<ApplicationFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final AidProgram _program = appState.programById(widget.programId);
  late final AidApplication? _existing = widget.existingId == null
      ? null
      : appState.applications.firstWhere((a) => a.id == widget.existingId);

  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String?> _choices = {};
  final Map<String, AttachedDoc> _docs = {};
  final Set<String> _docErrors = {};
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    for (final f in _program.fields) {
      final initial = _existing?.data[f.key] ?? '';
      if (f.kind == FieldKind.choice) {
        _choices[f.key] = initial.isEmpty ? null : initial;
      } else {
        _controllers[f.key] = TextEditingController(text: initial);
      }
    }
    for (final d in _existing?.docs ?? const <AttachedDoc>[]) {
      _docs[d.label] = d;
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pick(String label) async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: allowedUploadExt,
      compressionQuality: 70, // NFR-11: gambar dikompresi agar hemat kuota.
    );
    if (file == null || !mounted) return;
    final size = await file.length() ?? 0;
    if (!mounted) return;
    final ext = file.name.split('.').last.toLowerCase();
    if (!allowedUploadExt.contains(ext)) {
      showInfo(context, 'Format berkas harus JPG, PNG, atau PDF.');
      return;
    }
    if (size > maxUploadBytes) {
      showInfo(context, 'Ukuran berkas ${fmtSize(size)} melebihi batas 5 MB.');
      return;
    }
    setState(() {
      _docs[label] = AttachedDoc(
        label: label,
        fileName: file.name,
        path: file.path,
        sizeBytes: size,
      );
      _docErrors.remove(label);
    });
  }

  Future<void> _submit() async {
    setState(() => _error = null);
    final formOk = _formKey.currentState!.validate();
    final missingChoice = _program.fields.any(
      (f) => f.kind == FieldKind.choice && _choices[f.key] == null,
    );
    final missing = _program.documents
        .where((d) => !_docs.containsKey(d))
        .toSet();
    setState(
      () => _docErrors
        ..clear()
        ..addAll(missing),
    );
    if (!formOk || missingChoice || missing.isNotEmpty) {
      setState(
        () => _error =
            'Pengajuan belum lengkap. Periksa bagian yang ditandai merah.',
      );
      return;
    }
    final ok = await confirmDialog(
      context,
      title: 'Kirim pengajuan?',
      message: 'Pastikan data dan dokumen sudah benar. Pengajuan bersifat permohonan, bukan jaminan diterima.',
      confirmLabel: 'Kirim',
    );
    if (!ok || !mounted) return;
    setState(() => _loading = true);
    // TODO(backend): POST /applications (multipart: data + dokumen)
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    final data = {
      for (final f in _program.fields)
        f.key: f.kind == FieldKind.choice
            ? (_choices[f.key] ?? '')
            : _controllers[f.key]!.text.trim(),
    };
    final docs = [for (final d in _program.documents) _docs[d]!];
    final err = _existing == null
        ? appState.submitApplication(_program, data, docs)
        : appState.resubmitApplication(_existing, data, docs);
    setState(() => _loading = false);
    if (err != null) {
      setState(() => _error = err);
      return;
    }
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: const Icon(
          Icons.check_circle_rounded,
          color: AppColors.success,
          size: 52,
        ),
        title: Text(
          _existing == null ? 'Pengajuan Terkirim' : 'Perbaikan Terkirim',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        content: const Text(
          'Status pengajuan: Dikirim. Anda akan menerima notifikasi setiap kali status berubah.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Lihat Status'),
          ),
        ],
      ),
    );
    if (!mounted) return;
    Navigator.of(context).pop(); // kembali ke detail program / pengajuan
  }

  String? _required(String? v, String label) =>
      (v ?? '').trim().isEmpty ? '$label wajib diisi' : null;

  @override
  Widget build(BuildContext context) {
    final u = appState.user!;
    return Scaffold(
      appBar: desaAppBar(
        _existing == null ? 'Formulir Pengajuan' : 'Perbaiki Pengajuan',
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Text(
            _program.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 10),
          if (_existing?.reason != null) ...[
            InfoBanner(
              title: 'Catatan dari admin',
              text: _existing!.reason!,
              icon: Icons.edit_note_rounded,
              color: AppColors.orange,
            ),
            const SizedBox(height: 10),
          ],
          const InfoBanner(
            title: 'Pengajuan bersifat permohonan',
            text: 'Penetapan penerima bantuan ditentukan oleh pemerintah desa.',
            icon: Icons.gavel_rounded,
          ),
          const SizedBox(height: 14),
          SoftCard(
            color: AppColors.purpleSoft.withValues(alpha: 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data Pemohon (otomatis)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                IconLine(icon: Icons.person_outline_rounded, text: u.name),
                IconLine(
                  icon: Icons.credit_card_rounded,
                  text: 'NIK ${u.maskedNik}',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Form(
            key: _formKey,
            child: SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Isian Pengajuan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 14),
                  for (final f in _program.fields) ...[
                    if (f.kind == FieldKind.choice)
                      _ChoiceField(
                        label: f.label,
                        options: f.options,
                        value: _choices[f.key],
                        showError: _error != null && _choices[f.key] == null,
                        onChanged: (v) => setState(() => _choices[f.key] = v),
                      )
                    else
                      LabeledField(
                        label: f.label,
                        controller: _controllers[f.key]!,
                        hint: f.hint,
                        maxLines: f.kind == FieldKind.multiline ? 4 : 1,
                        keyboardType: f.kind == FieldKind.number
                            ? TextInputType.number
                            : null,
                        digitsOnly: f.kind == FieldKind.number,
                        validator: (v) => _required(v, f.label),
                      ),
                    const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dokumen Pendukung',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Foto harus jelas, tidak buram, dan seluruh sisi dokumen terlihat. Format JPG, PNG, atau PDF, maksimal 5 MB.',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textMuted,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                for (final d in _program.documents) ...[
                  _DocTile(
                    label: d,
                    doc: _docs[d],
                    hasError: _docErrors.contains(d),
                    onPick: () => _pick(d),
                    onRemove: () => setState(() => _docs.remove(d)),
                  ),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 14),
            InfoBanner(
              text: _error!,
              icon: Icons.error_outline_rounded,
              color: AppColors.danger,
            ),
          ],
          const SizedBox(height: 16),
          PrimaryButton(
            label: _existing == null
                ? 'Kirim Pengajuan'
                : 'Kirim Ulang Perbaikan',
            icon: Icons.send_rounded,
            loading: _loading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}

class _ChoiceField extends StatelessWidget {
  const _ChoiceField({
    required this.label,
    required this.options,
    required this.value,
    required this.onChanged,
    required this.showError,
  });
  final String label;
  final List<String> options;
  final String? value;
  final ValueChanged<String> onChanged;
  final bool showError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final o in options)
              ChoiceChip(
                label: Text(o),
                selected: value == o,
                selectedColor: AppColors.purple,
                showCheckmark: false,
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: value == o ? Colors.white : AppColors.text,
                ),
                onSelected: (_) => onChanged(o),
              ),
          ],
        ),
        if (showError)
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Text(
              'Pilih salah satu',
              style: TextStyle(fontSize: 16, color: AppColors.danger),
            ),
          ),
      ],
    );
  }
}

class _DocTile extends StatelessWidget {
  const _DocTile({
    required this.label,
    required this.doc,
    required this.hasError,
    required this.onPick,
    required this.onRemove,
  });
  final String label;
  final AttachedDoc? doc;
  final bool hasError;
  final VoidCallback onPick;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final attached = doc != null;
    final color = hasError
        ? AppColors.danger
        : (attached ? AppColors.success : AppColors.border);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color, width: hasError ? 1.8 : 1.2),
        color: attached ? AppColors.success.withValues(alpha: 0.06) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label *',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          if (attached)
            Row(
              children: [
                Icon(
                  doc!.fileName.toLowerCase().endsWith('.pdf')
                      ? Icons.picture_as_pdf_rounded
                      : Icons.image_rounded,
                  color: AppColors.success,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${doc!.fileName}${doc!.sizeBytes > 0 ? ' • ${fmtSize(doc!.sizeBytes)}' : ''}',
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  tooltip: 'Hapus berkas',
                  onPressed: onRemove,
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            )
          else ...[
            if (hasError)
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text(
                  'Dokumen ini wajib dilampirkan',
                  style: TextStyle(fontSize: 16, color: AppColors.danger),
                ),
              ),
            OutlineActionButton(
              label: 'Pilih Berkas / Foto',
              icon: Icons.upload_file_rounded,
              onPressed: onPick,
            ),
          ],
        ],
      ),
    );
  }
}
