import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/app_theme.dart';
import '../../widgets/batik_widgets.dart';
import '../../widgets/form_widgets.dart';
import 'profile_page.dart';

/// FR-06: hanya data non-identitas (telepon dan foto) yang dapat diubah.
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final _phone = TextEditingController(text: appState.user!.phone);
  String? _photo;

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final file = await FilePicker.pickFile(
      type: FileType.image,
      compressionQuality: 70,
    );
    if (file == null || file.path == null) return;
    final size = await file.length() ?? 0;
    if (size > 5 * 1024 * 1024) {
      if (mounted) showInfo(context, 'Ukuran foto melebihi 5 MB.');
      return;
    }
    setState(() => _photo = file.path);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    // TODO(backend): PATCH /profile
    appState.updateProfile(
      phone: _phone.text.trim().replaceFirst(RegExp(r'^0'), ''),
      photoPath: _photo,
    );
    showInfo(context, 'Profil berhasil diperbarui.');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final u = appState.user!;
    return Scaffold(
      appBar: desaAppBar('Ubah Profil'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Center(
            child: Stack(
              children: [
                const UserAvatar(radius: 52),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Material(
                    color: AppColors.gold,
                    shape: const CircleBorder(),
                    child: IconButton(
                      tooltip: 'Ganti foto',
                      onPressed: _pickPhoto,
                      icon: const Icon(
                        Icons.camera_alt_rounded,
                        color: AppColors.purpleDark,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_photo != null)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Center(
                child: Text(
                  'Foto baru dipilih. Tekan Simpan.',
                  style: TextStyle(fontSize: 16, color: AppColors.success),
                ),
              ),
            ),
          const SizedBox(height: 16),
          SoftCard(
            color: AppColors.purpleSoft.withValues(alpha: 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data identitas (tidak dapat diubah)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                IconLine(icon: Icons.person_outline_rounded, text: u.name),
                IconLine(
                  icon: Icons.credit_card_rounded,
                  text: 'NIK ${u.maskedNik}',
                ),
                IconLine(
                  icon: Icons.family_restroom_rounded,
                  text: 'KK ${u.maskedKk}',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SoftCard(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  LabeledField(
                    label: 'Nomor Telepon',
                    controller: _phone,
                    prefixText: '+62',
                    keyboardType: TextInputType.phone,
                    digitsOnly: true,
                    maxLength: 13,
                    textInputAction: TextInputAction.done,
                    validator: (v) => (v ?? '').trim().length < 9
                        ? 'Nomor telepon tidak valid'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    label: 'Simpan Perubahan',
                    icon: Icons.save_rounded,
                    onPressed: _save,
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
