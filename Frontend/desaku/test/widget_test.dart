import 'package:desaku/core/app_state.dart';
import 'package:desaku/core/app_theme.dart';
import 'package:desaku/core/models.dart';
import 'package:desaku/features/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dart:io';

Future<void> _boot(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1080, 2340); // 360 x 780 dp
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  appState.reset();
  await tester.pumpWidget(
    MaterialApp(theme: buildTheme(), home: const LoginPage()),
  );
  await tester.pump();
}

Future<void> _center(WidgetTester tester, Finder finder) async {
  await Scrollable.ensureVisible(finder.evaluate().first, alignment: 0.5);
  await tester.pump();
}

Future<void> _tapText(
  WidgetTester tester,
  String text, {
  bool last = false,
}) async {
  var finder = find.text(text);
  if (find.text(text).evaluate().isEmpty) {
    // ListView memuat item secara lazy: gulir sampai muncul.
    await tester.scrollUntilVisible(
      find.text(text),
      300,
      scrollable: find
          .descendant(
            of: find.byType(ListView).last,
            matching: find.byType(Scrollable),
          )
          .first,
    );
  }
  finder = last ? find.text(text).last : find.text(text).first;
  await _center(tester, finder);
  await tester.tap(finder);
  await tester.pumpAndSettle(const Duration(milliseconds: 100));
}

Future<void> _loginDemo(WidgetTester tester) async {
  await tester.enterText(find.byType(TextFormField).at(0), AppState.demoNik);
  await tester.enterText(
    find.byType(TextFormField).at(1),
    AppState.demoPassword,
  );
  await _tapText(tester, 'Masuk ke Desa Ku');
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() async {
    // Muat Roboto asli agar pengukuran teks mendekati perangkat nyata (bukan font Ahem).
    final dir =
        '${Platform.environment['FLUTTER_ROOT'] ?? '/home/umam/development/flutter'}/bin/cache/artifacts/material_fonts';
    final loader = FontLoader('Roboto')
      ..addFont(
        File('$dir/Roboto-Regular.ttf')
            .readAsBytes()
            .then((b) => ByteData.sublistView(b)),
      )
      ..addFont(
        File('$dir/Roboto-Bold.ttf')
            .readAsBytes()
            .then((b) => ByteData.sublistView(b)),
      );
    await loader.load();
  });

  testWidgets('Login: validasi form kosong dan kredensial salah', (
    tester,
  ) async {
    await _boot(tester);
    await _tapText(tester, 'Masuk ke Desa Ku');
    expect(find.text('NIK atau nomor telepon wajib diisi'), findsOneWidget);
    expect(find.text('Kata sandi wajib diisi'), findsOneWidget);

    await tester.enterText(
      find.byType(TextFormField).at(0),
      '3603010101900001',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'salahsandi1');
    await _tapText(tester, 'Masuk ke Desa Ku');
    await tester.pump(const Duration(seconds: 1));
    expect(find.textContaining('atau kata sandi salah'), findsOneWidget);
  });

  testWidgets(
    'Registrasi: NIK ganda ditolak, NIK baru menunggu verifikasi (FR-01..03)',
    (tester) async {
      await _boot(tester);
      await _tapText(tester, 'Daftar Akun Baru');

      Future<void> fill(String nik) async {
        final f = find.byType(TextFormField);
        await tester.enterText(f.at(0), 'Siti Aminah');
        await tester.enterText(f.at(1), nik);
        await tester.enterText(f.at(2), '3603010101900077');
        await tester.enterText(f.at(3), '81299998888');
        await tester.enterText(f.at(4), 'sandi12345');
        await tester.enterText(f.at(5), 'sandi12345');
        await _center(tester, find.byType(Checkbox));
        if (!tester.widget<Checkbox>(find.byType(Checkbox)).value!) {
          await tester.tap(find.byType(Checkbox));
          await tester.pump();
        }
        await _tapText(tester, 'Kirim Pendaftaran Akun');
        await tester.pump(const Duration(seconds: 1));
        await tester.pumpAndSettle();
      }

      await fill(AppState.demoNik);
      expect(find.textContaining('NIK sudah terdaftar'), findsOneWidget);

      await fill('3603019999990001');
      expect(find.text('Menunggu Verifikasi'), findsWidgets);
      expect(find.text('Layanan dikunci sementara'), findsOneWidget);
      expect(appState.isVerified, isFalse);
    },
  );

  testWidgets('Navigasi seluruh tab + alur kegiatan (FR-07..10)', (
    tester,
  ) async {
    await _boot(tester);
    await _loginDemo(tester);
    expect(find.text('Selamat Datang, Azkiya Zahrul Umam!'), findsOneWidget);

    for (final tab in ['Kegiatan', 'Bantuan', 'Berita', 'Profil', 'Beranda']) {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(tab),
        ),
      );
      await tester.pumpAndSettle();
    }

    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Kegiatan'),
      ),
    );
    await tester.pumpAndSettle();
    await _tapText(tester, 'Posyandu Balita Melati II');
    expect(find.text('Detail Kegiatan'), findsOneWidget);

    await _tapText(tester, 'Daftar Kegiatan');
    await _tapText(tester, 'Ya, Daftar');
    expect(find.text('Anda sudah terdaftar'), findsOneWidget);
    expect(appState.myActivityIds, contains('k1'));

    await _tapText(tester, 'Batalkan Pendaftaran');
    await _tapText(tester, 'Ya, Batalkan');
    expect(appState.myActivityIds, isEmpty);
  });

  testWidgets('Kuota penuh & kegiatan lewat ditolak (FR-10)', (tester) async {
    await _boot(tester);
    await _loginDemo(tester);
    final full = appState.activities.firstWhere((a) => a.id == 'k3');
    final past = appState.activities.firstWhere((a) => a.id == 'k5');
    expect(appState.registerActivity(full), contains('penuh'));
    expect(appState.registerActivity(past), contains('lewat'));
  });

  testWidgets(
    'Bantuan: validasi formulir, pengajuan ganda, perbaikan (FR-18..22)',
    (tester) async {
      await _boot(tester);
      await _loginDemo(tester);

      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Bantuan'),
        ),
      );
      await tester.pumpAndSettle();
      await _tapText(tester, 'Bantuan Ibu Hamil & Menyusui');
      expect(find.text('Persyaratan'), findsOneWidget);
      await _tapText(tester, 'Ajukan Sekarang');
      await _tapText(tester, 'Kirim Pengajuan');
      expect(
        find.textContaining('Pengajuan belum lengkap', skipOffstage: false),
        findsOneWidget,
      );

      // Pengajuan ganda (FR-20) pada program BLT yang sudah diajukan.
      final blt = appState.programById('p2');
      expect(
        appState.submitApplication(blt, {}, []),
        contains('Pengajuan ganda'),
      );

      // Perbaikan hanya untuk status Perlu Perbaikan (FR-22).
      final app = appState.applications.first;
      expect(app.status.label, 'Perlu Perbaikan');
      expect(appState.resubmitApplication(app, app.data, app.docs), isNull);
      expect(app.status.label, 'Dikirim');
      expect(appState.resubmitApplication(app, app.data, app.docs), isNotNull);
    },
  );

  testWidgets('Notifikasi tampil & dapat dibuka (FR-14)', (tester) async {
    await _boot(tester);
    await _loginDemo(tester);
    await tester.tap(find.byTooltip('Notifikasi'));
    await tester.pumpAndSettle();
    expect(find.text('Riwayat'), findsNothing);
    await _tapText(tester, 'Perbaikan diperlukan pada pengajuan BLT');
    expect(find.text('Status Pengajuan'), findsOneWidget);
    expect(find.text('Perbaiki & Kirim Ulang'), findsOneWidget);
  });

  testWidgets('Kegiatan: filter "yang saya ikuti" dan chip kategori bekerja', (
    tester,
  ) async {
    await _boot(tester);
    await _loginDemo(tester);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Kegiatan'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Posyandu Balita Melati II'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
    expect(find.text('Belum ada kegiatan yang Anda ikuti'), findsOneWidget);

    appState.registerActivity(
      appState.activities.firstWhere((a) => a.id == 'k1'),
    );
    await tester.pumpAndSettle();
    expect(find.text('Posyandu Balita Melati II'), findsOneWidget);
    expect(find.text('Kerja Bakti Saluran Irigasi'), findsNothing);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kesehatan').first);
    await tester.pumpAndSettle();
    expect(find.text('Kerja Bakti Saluran Irigasi'), findsNothing);
    expect(find.text('Posyandu Balita Melati II'), findsOneWidget);
  });
}
