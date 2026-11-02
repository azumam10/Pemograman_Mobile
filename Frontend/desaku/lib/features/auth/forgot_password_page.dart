import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/app_theme.dart';
import '../../widgets/form_widgets.dart';
import 'auth_header.dart';

/// FR-05: pemulihan kata sandi melalui OTP (3 langkah).
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // TODO(backend): OTP nyata dikirim server. Kode di bawah hanya untuk uji tampilan.
  static const _demoOtp = '123456';

  int _step = 0;
  final _phoneKey = GlobalKey<FormState>();
  final _otpKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormState>();
  final _phone = TextEditingController();
  final _otp = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  bool _loading = false;
  int _countdown = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in [_phone, _otp, _pass, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _countdown = 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return t.cancel();
      setState(() => _countdown--);
      if (_countdown <= 0) t.cancel();
    });
  }

  Future<void> _sendOtp() async {
    if (!_phoneKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() {
      _loading = false;
      _step = 1;
    });
    _startCountdown();
  }

  Future<void> _verifyOtp() async {
    if (!_otpKey.currentState!.validate()) return;
    setState(() => _step = 2);
  }

  Future<void> _savePassword() async {
    if (!_passKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    appState.resetPassword(_pass.text);
    setState(() => _loading = false);
    showInfo(context, 'Kata sandi berhasil diubah. Silakan masuk.');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      'Lupa Kata Sandi',
      'Masukkan Kode OTP',
      'Buat Kata Sandi Baru',
    ];
    final subs = [
      'Masukkan nomor telepon terdaftar. Kami akan mengirim kode OTP.',
      'Kode 6 digit telah dikirim ke +62 ${_phone.text}.',
      'Buat kata sandi baru untuk akun Anda.',
    ];

    return Scaffold(
      appBar: authAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            children: [
              AuthHeader(
                title: titles[_step],
                subtitle: subs[_step],
                icon: Icons.lock_reset_rounded,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  for (var i = 0; i < 3; i++) ...[
                    if (i > 0) const SizedBox(width: 6),
                    Expanded(
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: i <= _step ? AppColors.gold : AppColors.border,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Langkah ${_step + 1} dari 3',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SoftCard(
                child: switch (_step) {
                  0 => Form(
                    key: _phoneKey,
                    child: Column(
                      children: [
                        LabeledField(
                          label: 'Nomor Telepon Terdaftar',
                          controller: _phone,
                          hint: '81234567890',
                          prefixText: '+62',
                          keyboardType: TextInputType.phone,
                          digitsOnly: true,
                          maxLength: 13,
                          textInputAction: TextInputAction.done,
                          validator: (v) => (v ?? '').trim().length < 9
                              ? 'Masukkan nomor telepon yang valid'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        PrimaryButton(
                          label: 'Kirim Kode OTP',
                          icon: Icons.sms_outlined,
                          loading: _loading,
                          onPressed: _sendOtp,
                        ),
                      ],
                    ),
                  ),
                  1 => Form(
                    key: _otpKey,
                    child: Column(
                      children: [
                        LabeledField(
                          label: 'Kode OTP',
                          controller: _otp,
                          hint: '6 digit',
                          icon: Icons.pin_outlined,
                          keyboardType: TextInputType.number,
                          digitsOnly: true,
                          maxLength: 6,
                          textInputAction: TextInputAction.done,
                          helper: 'Kode demo: $_demoOtp',
                          validator: (v) => (v ?? '') == _demoOtp
                              ? null
                              : 'Kode OTP tidak sesuai',
                        ),
                        const SizedBox(height: 16),
                        PrimaryButton(
                          label: 'Verifikasi Kode',
                          icon: Icons.check_rounded,
                          onPressed: _verifyOtp,
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _countdown > 0 ? null : _startCountdown,
                          child: Text(
                            _countdown > 0
                                ? 'Kirim ulang dalam $_countdown detik'
                                : 'Kirim ulang kode',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _ => Form(
                    key: _passKey,
                    child: Column(
                      children: [
                        LabeledField(
                          label: 'Kata Sandi Baru',
                          controller: _pass,
                          hint: 'Minimal 8 karakter',
                          icon: Icons.lock_outline_rounded,
                          obscure: true,
                          helper: 'Kombinasi huruf dan angka.',
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
                        const SizedBox(height: 16),
                        LabeledField(
                          label: 'Konfirmasi Kata Sandi',
                          controller: _confirm,
                          hint: 'Ulangi kata sandi',
                          icon: Icons.lock_reset_rounded,
                          obscure: true,
                          textInputAction: TextInputAction.done,
                          validator: (v) =>
                              v != _pass.text ? 'Kata sandi tidak sama' : null,
                        ),
                        const SizedBox(height: 16),
                        PrimaryButton(
                          label: 'Simpan Kata Sandi',
                          icon: Icons.save_rounded,
                          loading: _loading,
                          onPressed: _savePassword,
                        ),
                      ],
                    ),
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
