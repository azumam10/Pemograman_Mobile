import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/app_theme.dart';
import '../../widgets/form_widgets.dart';
import 'auth_header.dart';
import 'verification_page.dart';

/// FR-01, FR-02, FR-03: registrasi akun warga.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _nik = TextEditingController();
  final _kk = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _agree = false;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    for (final c in [_name, _nik, _kk, _phone, _password, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  String? _digits(String? v, int len, String label) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return '$label wajib diisi';
    if (value.length != len) {
      return '$label harus $len digit (sekarang ${value.length})';
    }
    return null;
  }

  Future<void> _submit() async {
    setState(() => _error = null);
    if (!_formKey.currentState!.validate()) return;
    if (!_agree) {
      showInfo(context, 'Centang pernyataan kebenaran data terlebih dahulu.');
      return;
    }
    setState(() => _loading = true);
    // TODO(backend): POST /auth/register
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    final err = appState.register(
      name: _name.text.trim(),
      nik: _nik.text.trim(),
      kk: _kk.text.trim(),
      phone: _phone.text.trim().replaceFirst(RegExp(r'^0'), ''),
      password: _password.text,
    );
    setState(() => _loading = false);
    if (err != null) {
      setState(() => _error = err); // FR-02: NIK ganda ditolak.
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const VerificationPage()),
      (_) => false,
    );
  }

  Widget _gap() => const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            children: [
              const AuthHeader(
                title: 'Pendaftaran Akun Warga',
                subtitle: 'Isi data sesuai KTP dan Kartu Keluarga. Admin desa akan memverifikasi data Anda.',
                icon: Icons.how_to_reg_rounded,
              ),
              const SizedBox(height: 12),
              const InfoBanner(
                title: 'Verifikasi Kependudukan',
                icon: Icons.verified_user_outlined,
                color: AppColors.purple,
                text: 'Data Anda hanya dipakai untuk layanan desa dan tidak dibagikan kepada pihak yang tidak berwenang.',
              ),
              const SizedBox(height: 14),
              SoftCard(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.badge_rounded,
                            color: AppColors.purple,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Data Diri Warga',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(height: 1),
                      ),
                      LabeledField(
                        label: 'Nama Lengkap Sesuai KTP',
                        controller: _name,
                        hint: 'Contoh: Azkiya Zahrul Umam',
                        icon: Icons.person_outline_rounded,
                        validator: (v) => (v ?? '').trim().length < 3
                            ? 'Nama lengkap wajib diisi'
                            : null,
                      ),
                      _gap(),
                      LabeledField(
                        label: 'Nomor Induk Kependudukan (NIK)',
                        controller: _nik,
                        hint: '16 digit NIK',
                        icon: Icons.credit_card_rounded,
                        keyboardType: TextInputType.number,
                        digitsOnly: true,
                        maxLength: 16,
                        showCounter: true,
                        validator: (v) => _digits(v, 16, 'NIK'),
                      ),
                      _gap(),
                      LabeledField(
                        label: 'Nomor Kartu Keluarga (KK)',
                        controller: _kk,
                        hint: '16 digit nomor KK',
                        icon: Icons.family_restroom_rounded,
                        keyboardType: TextInputType.number,
                        digitsOnly: true,
                        maxLength: 16,
                        showCounter: true,
                        validator: (v) => _digits(v, 16, 'Nomor KK'),
                      ),
                      _gap(),
                      LabeledField(
                        label: 'Nomor Telepon Aktif',
                        controller: _phone,
                        hint: '81234567890',
                        prefixText: '+62',
                        keyboardType: TextInputType.phone,
                        digitsOnly: true,
                        maxLength: 13,
                        helper: 'Dipakai untuk kode OTP pemulihan kata sandi.',
                        validator: (v) {
                          final value = (v ?? '').trim();
                          if (value.isEmpty) return 'Nomor telepon wajib diisi';
                          if (value.length < 9) {
                            return 'Nomor telepon terlalu pendek';
                          }
                          return null;
                        },
                      ),
                      _gap(),
                      LabeledField(
                        label: 'Kata Sandi',
                        controller: _password,
                        hint: 'Buat kata sandi',
                        icon: Icons.lock_outline_rounded,
                        obscure: true,
                        helper:
                            'Minimal 8 karakter, kombinasi huruf dan angka.',
                        validator: (v) {
                          final value = v ?? '';
                          if (value.length < 8) return 'Minimal 8 karakter';
                          if (!RegExp(r'[A-Za-z]').hasMatch(value) ||
                              !RegExp(r'\d').hasMatch(value)) {
                            return 'Harus kombinasi huruf dan angka';
                          }
                          return null;
                        },
                      ),
                      _gap(),
                      LabeledField(
                        label: 'Konfirmasi Kata Sandi',
                        controller: _confirm,
                        hint: 'Ulangi kata sandi',
                        icon: Icons.lock_reset_rounded,
                        obscure: true,
                        textInputAction: TextInputAction.done,
                        validator: (v) => v != _password.text
                            ? 'Kata sandi tidak sama'
                            : null,
                      ),
                      _gap(),
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => setState(() => _agree = !_agree),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.purpleSoft.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: _agree,
                                activeColor: AppColors.purple,
                                onChanged: (v) =>
                                    setState(() => _agree = v ?? false),
                              ),
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10, right: 4),
                                  child: Text(
                                    'Saya menyatakan data yang diisikan benar dan setuju datanya diproses untuk layanan desa.',
                                    style: TextStyle(fontSize: 16, height: 1.4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 12),
                        InfoBanner(
                          title: 'Pendaftaran ditolak',
                          text: _error!,
                          icon: Icons.error_outline_rounded,
                          color: AppColors.danger,
                        ),
                      ],
                      const SizedBox(height: 16),
                      PrimaryButton(
                        label: 'Kirim Pendaftaran Akun',
                        icon: Icons.send_rounded,
                        loading: _loading,
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text(
                    'Sudah memiliki akun? ',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    child: const Text(
                      'Masuk di sini',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.maroon,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const HelpCard(
                title: 'Butuh Bantuan Pendaftaran?',
                lines: [
                  'Kantor Desa Sukamaju',
                  'Senin–Jumat, 08.00 – 15.00 WIB',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
