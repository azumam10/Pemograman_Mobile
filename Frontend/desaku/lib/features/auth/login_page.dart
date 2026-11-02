import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/app_theme.dart';
import '../../core/models.dart';
import '../../widgets/form_widgets.dart';
import '../home/main_shell.dart';
import 'auth_header.dart';
import 'forgot_password_page.dart';
import 'register_page.dart';
import 'verification_page.dart';

/// Rute tujuan setelah login berhasil: beranda bila terverifikasi,
/// selain itu halaman status verifikasi (FR-03, AB-01).
Route<void> homeRouteFor(UserProfile user) => MaterialPageRoute(
  builder: (_) => user.status == VerificationStatus.verified
      ? const MainShell()
      : const VerificationPage(),
);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _id = TextEditingController();
  final _password = TextEditingController();
  bool _remember = false;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _id.dispose();
    _password.dispose();
    super.dispose();
  }

  String? _validateId(String? v) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return 'NIK atau nomor telepon wajib diisi';
    final isNik = value.length == 16;
    final isPhone =
        value.startsWith('0') && value.length >= 10 && value.length <= 14;
    if (!isNik && !isPhone) {
      return 'Isi NIK 16 digit atau nomor telepon (08xx...)';
    }
    return null;
  }

  Future<void> _submit() async {
    setState(() => _error = null);
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    // TODO(backend): POST /auth/login
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    final user = appState.login(_id.text.trim(), _password.text);
    setState(() => _loading = false);
    if (user == null) {
      setState(
        () => _error = 'NIK/nomor telepon atau kata sandi salah. Periksa kembali data Anda.',
      );
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(homeRouteFor(user), (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authAppBar(context, canPop: Navigator.of(context).canPop()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            children: [
              const AuthHeader(
                title: 'Masuk Layanan Warga',
                subtitle: 'Akses informasi kegiatan, program bantuan, dan berita resmi Desa Sukamaju.',
              ),
              const SizedBox(height: 16),
              SoftCard(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabeledField(
                        label: 'NIK atau No. Telepon',
                        controller: _id,
                        hint: '3603xxxxxxxxxxxx',
                        icon: Icons.badge_outlined,
                        keyboardType: TextInputType.number,
                        digitsOnly: true,
                        maxLength: 16,
                        validator: _validateId,
                        helper:
                            'Format: 16 digit NIK atau nomor telepon aktif.',
                      ),
                      const SizedBox(height: 14),
                      LabeledField(
                        label: 'Kata Sandi',
                        controller: _password,
                        hint: 'Masukkan kata sandi',
                        icon: Icons.lock_outline_rounded,
                        obscure: true,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _submit(),
                        validator: (v) =>
                            (v ?? '').isEmpty ? 'Kata sandi wajib diisi' : null,
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 12),
                        InfoBanner(
                          text: _error!,
                          icon: Icons.error_outline_rounded,
                          color: AppColors.danger,
                        ),
                      ],
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Checkbox(
                            value: _remember,
                            activeColor: AppColors.purple,
                            onChanged: (v) =>
                                setState(() => _remember = v ?? false),
                          ),
                          const Text(
                            'Ingat Saya',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ForgotPasswordPage(),
                            ),
                          ),
                          child: const Text(
                            'Lupa Kata Sandi?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.maroon,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      PrimaryButton(
                        label: 'Masuk ke Desa Ku',
                        icon: Icons.login_rounded,
                        loading: _loading,
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'BELUM PUNYA AKUN?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 14),
              SoftCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Warga Sukamaju Baru?',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Daftarkan NIK dan nomor KK Anda. Akun aktif setelah diverifikasi admin desa.',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textMuted,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlineActionButton(
                      label: 'Daftar Akun Baru',
                      icon: Icons.arrow_forward_rounded,
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const RegisterPage()),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const HelpCard(
                title: 'Butuh Bantuan Masuk?',
                lines: [
                  'Kantor Desa Sukamaju • Senin–Jumat',
                  'Jam layanan 08.00 – 15.00 WIB',
                ],
              ),
              const SizedBox(height: 14),
              // TODO(backend): hapus kartu demo ini setelah login terhubung ke server.
              const InfoBanner(
                title: 'Akun Demo',
                icon: Icons.science_outlined,
                color: AppColors.info,
                text: 'NIK 3603010101900001\nKata sandi demo1234',
              ),
              const SizedBox(height: 14),
              const Text(
                'Sistem Informasi Pelayanan Terpadu • Kabupaten Tangerang',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColors.textMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
