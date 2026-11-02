import 'package:flutter/material.dart';

import 'models.dart';

/// State aplikasi sementara (in-memory) dengan data contoh.
///
/// TODO(backend): ganti setiap method di sini dengan pemanggilan REST API.
/// Seluruh aturan bisnis (AB-01..AB-05, FR-02, FR-10, FR-20) sudah diterapkan
/// di sisi klien agar alur UI dapat diuji; server tetap harus memvalidasi ulang.
class AppState extends ChangeNotifier {
  AppState() {
    _seed();
  }

  /// NIK yang dianggap sudah terdaftar (FR-02).
  static const demoNik = '3603010101900001';
  static const demoPassword = 'demo1234';

  UserProfile? user;
  late Set<String> _takenNiks;
  late List<Activity> activities;
  late Set<String> myActivityIds;
  late List<AidProgram> programs;
  late List<AidApplication> applications;
  late List<NewsItem> news;
  late List<AppNotification> notifications;

  bool get isLoggedIn => user != null;
  bool get isVerified => user?.status == VerificationStatus.verified;
  int get unreadCount => notifications.where((n) => !n.read).length;

  void reset() {
    user = null;
    _seed();
    notifyListeners();
  }

  // ---------------------------------------------------------------- akun

  /// FR-01, FR-02, FR-03. Mengembalikan pesan error, atau null jika berhasil.
  String? register({
    required String name,
    required String nik,
    required String kk,
    required String phone,
    required String password,
  }) {
    if (_takenNiks.contains(nik)) {
      return 'NIK sudah terdaftar pada akun lain. Hubungi kantor desa bila ini kesalahan.';
    }
    _takenNiks.add(nik);
    user = UserProfile(
      name: name,
      nik: nik,
      kk: kk,
      phone: phone,
      password: password,
    );
    notifications = [];
    applications = [];
    myActivityIds = {};
    notifyListeners();
    return null;
  }

  /// FR-05. Mengembalikan null bila kredensial salah.
  UserProfile? login(String identifier, String password) {
    final u = user;
    if (u != null && (identifier == u.nik || _samePhone(identifier, u.phone))) {
      return u.password == password ? u : null;
    }
    // Akun demo (terverifikasi) untuk menguji seluruh fitur.
    if (identifier == demoNik && password == demoPassword) {
      _seed();
      user = UserProfile(
        name: 'Azkiya Zahrul Umam',
        nik: demoNik,
        kk: '3603010101900099',
        phone: '81234567890',
        password: demoPassword,
        status: VerificationStatus.verified,
      );
      notifyListeners();
      return user;
    }
    return null;
  }

  bool _samePhone(String a, String b) {
    String norm(String s) => s.replaceFirst(RegExp(r'^(\+62|62|0)'), '');
    return norm(a) == norm(b);
  }

  void resetPassword(String newPassword) {
    user?.password = newPassword;
    notifyListeners();
  }

  void logout() {
    user = null;
    notifyListeners();
  }

  /// FR-04 (disimulasikan; pada produk nyata dilakukan admin di panel web).
  void simulateVerification({required bool approve, String? reason}) {
    final u = user;
    if (u == null) return;
    u.status = approve
        ? VerificationStatus.verified
        : VerificationStatus.rejected;
    u.rejectReason = approve
        ? null
        : (reason ?? 'Nomor KK tidak sesuai dengan data kependudukan desa.');
    _notify(
      approve ? 'Akun Anda telah diverifikasi' : 'Verifikasi akun ditolak',
      approve
          ? 'Selamat datang di DesaKu. Anda kini dapat mendaftar kegiatan dan mengajukan bantuan.'
          : u.rejectReason!,
      NotifType.account,
    );
    notifyListeners();
  }

  /// FR-06: hanya telepon dan foto yang boleh diubah.
  void updateProfile({String? phone, String? photoPath}) {
    if (phone != null) user?.phone = phone;
    if (photoPath != null) user?.photoPath = photoPath;
    notifyListeners();
  }

  // ------------------------------------------------------------ kegiatan

  List<Activity> get sortedActivities {
    final list = activities.where((a) => !a.cancelled).toList()
      ..sort((a, b) => a.start.compareTo(b.start));
    return list;
  }

  List<Activity> get upcomingActivities =>
      sortedActivities.where((a) => !a.isPast).toList();

  List<String> get activityCategories => [
    'Semua',
    ...{for (final a in activities) a.category},
  ];

  bool isRegistered(Activity a) => myActivityIds.contains(a.id);

  /// FR-09, FR-10, AB-01.
  String? registerActivity(Activity a) {
    if (!isVerified) return 'Akun Anda belum diverifikasi admin desa.';
    if (a.cancelled) return 'Kegiatan ini telah dibatalkan oleh penyelenggara.';
    if (a.isPast) return 'Kegiatan ini sudah lewat, pendaftaran ditutup.';
    if (isRegistered(a)) return 'Anda sudah terdaftar pada kegiatan ini.';
    if (a.isFull) return 'Kuota kegiatan sudah penuh.';
    a.registered++;
    myActivityIds.add(a.id);
    _notify(
      'Pendaftaran kegiatan berhasil',
      'Anda terdaftar pada "${a.title}".',
      NotifType.activity,
      a.id,
    );
    notifyListeners();
    return null;
  }

  String? cancelActivity(Activity a) {
    if (!isRegistered(a)) return 'Anda belum terdaftar pada kegiatan ini.';
    if (!a.canCancel) return 'Batas waktu pembatalan telah lewat.';
    a.registered--;
    myActivityIds.remove(a.id);
    _notify(
      'Pendaftaran dibatalkan',
      'Pendaftaran Anda pada "${a.title}" telah dibatalkan.',
      NotifType.activity,
      a.id,
    );
    notifyListeners();
    return null;
  }

  // ------------------------------------------------------------- bantuan

  AidProgram programById(String id) => programs.firstWhere((p) => p.id == id);

  AidApplication? applicationFor(AidProgram p) {
    for (final a in applications) {
      if (a.programId == p.id) return a;
    }
    return null;
  }

  /// FR-18..FR-20, AB-01.
  String? submitApplication(
    AidProgram p,
    Map<String, String> data,
    List<AttachedDoc> docs,
  ) {
    if (!isVerified) return 'Akun Anda belum diverifikasi admin desa.';
    if (!p.isOpen) return 'Periode pendaftaran program ini sudah ditutup.';
    if (applicationFor(p) != null) {
      return 'Anda sudah mengajukan program ini pada periode yang sama. Pengajuan ganda tidak diperbolehkan.';
    }
    final app = AidApplication(
      id: 'ap${applications.length + 1}',
      programId: p.id,
      data: data,
      docs: docs,
      history: [StatusEvent(ApplicationStatus.sent, DateTime.now())],
    );
    applications.insert(0, app);
    _notify(
      'Pengajuan terkirim',
      'Pengajuan "${p.name}" berstatus Dikirim.',
      NotifType.aid,
      app.id,
    );
    notifyListeners();
    return null;
  }

  /// FR-22.
  String? resubmitApplication(
    AidApplication app,
    Map<String, String> data,
    List<AttachedDoc> docs,
  ) {
    if (app.status != ApplicationStatus.needsFix) {
      return 'Pengajuan ini tidak dapat diperbaiki.';
    }
    app.data = data;
    app.docs = docs;
    app.history.add(
      StatusEvent(
        ApplicationStatus.sent,
        DateTime.now(),
        'Warga mengirim ulang perbaikan.',
      ),
    );
    _notify(
      'Perbaikan terkirim',
      'Pengajuan "${programById(app.programId).name}" dikirim ulang.',
      NotifType.aid,
      app.id,
    );
    notifyListeners();
    return null;
  }

  /// FR-24/FR-25 (disimulasikan; pada produk nyata dilakukan admin di panel web).
  void simulateStatus(
    AidApplication app,
    ApplicationStatus status, {
    String? reason,
  }) {
    final needsReason =
        status == ApplicationStatus.needsFix ||
        status == ApplicationStatus.rejected;
    app.history.add(
      StatusEvent(
        status,
        DateTime.now(),
        needsReason ? (reason ?? 'Dokumen kurang jelas.') : reason,
      ),
    );
    _notify(
      'Status pengajuan berubah',
      '"${programById(app.programId).name}" kini berstatus ${status.label}.',
      NotifType.aid,
      app.id,
    );
    notifyListeners();
  }

  // ---------------------------------------------------------- notifikasi

  void markRead(AppNotification n) {
    if (!n.read) {
      n.read = true;
      notifyListeners();
    }
  }

  void markAllRead() {
    for (final n in notifications) {
      n.read = true;
    }
    notifyListeners();
  }

  void _notify(String title, String body, NotifType type, [String? targetId]) {
    notifications.insert(
      0,
      AppNotification(
        id: 'n${DateTime.now().microsecondsSinceEpoch}',
        title: title,
        body: body,
        type: type,
        time: DateTime.now(),
        targetId: targetId,
      ),
    );
  }

  // ------------------------------------------------------------ data awal

  void _seed() {
    final now = DateTime.now();
    DateTime at(int days, int hour, [int minute = 0]) {
      final d = now.add(Duration(days: days));
      return DateTime(d.year, d.month, d.day, hour, minute);
    }

    _takenNiks = {demoNik, '3603010202910002'};
    final current = user;
    if (current != null) _takenNiks.add(current.nik);

    activities = [
      Activity(
        id: 'k1',
        title: 'Posyandu Balita Melati II',
        description:
            'Penimbangan balita, pemberian vitamin A, imunisasi dasar, dan konsultasi gizi bersama bidan desa. '
            'Bawa buku KIA dan kartu menuju sehat (KMS).',
        start: at(4, 8),
        location: 'Balai Dusun 2',
        organizer: 'Kader Posyandu & Puskesmas',
        quota: 60,
        registered: 32,
        category: 'Kesehatan',
      ),
      Activity(
        id: 'k2',
        title: 'Kerja Bakti Saluran Irigasi',
        description:
            'Pembersihan saluran irigasi menjelang musim tanam bersama Dinas Pertanian. '
            'Warga diminta membawa cangkul, sabit, dan sarung tangan.',
        start: at(9, 7),
        location: 'Saluran Irigasi Blok Barat',
        organizer: 'Pemerintah Desa Sukamaju',
        quota: 100,
        registered: 41,
        category: 'Gotong Royong',
      ),
      Activity(
        id: 'k3',
        title: 'Penyuluhan Pertanian Organik',
        description: 'Pelatihan pembuatan pupuk organik dari limbah rumah tangga untuk petani dan kelompok tani.',
        start: at(14, 9),
        location: 'Aula Kantor Desa',
        organizer: 'Dinas Pertanian Kab. Tangerang',
        quota: 40,
        registered: 40,
        category: 'Pertanian',
      ),
      Activity(
        id: 'k4',
        title: 'Senam Lansia Sehat',
        description:
            'Senam ringan dan cek tekanan darah gratis bagi warga lanjut usia.',
        start: now.add(const Duration(hours: 10)),
        location: 'Lapangan Desa',
        organizer: 'Karang Werda',
        quota: 50,
        registered: 18,
        category: 'Kesehatan',
      ),
      Activity(
        id: 'k5',
        title: 'Musyawarah Desa Perencanaan Pembangunan',
        description: 'Pembahasan usulan pembangunan desa tahun anggaran mendatang. Kehadiran warga sangat diharapkan.',
        start: at(-6, 19),
        location: 'Aula Kantor Desa',
        organizer: 'BPD Sukamaju',
        quota: 80,
        registered: 66,
        category: 'Musyawarah',
      ),
    ];
    myActivityIds = {};

    programs = [
      AidProgram(
        id: 'p1',
        name: 'Bantuan Ibu Hamil & Menyusui',
        description: 'Bantuan gizi dan pendampingan kesehatan bagi ibu hamil dan ibu menyusui dari keluarga kurang mampu.',
        icon: Icons.pregnant_woman_rounded,
        requirements: [
          'Warga Desa Sukamaju yang telah terverifikasi',
          'Sedang hamil atau menyusui bayi usia di bawah 2 tahun',
          'Terdaftar di Posyandu atau Puskesmas setempat',
          'Berasal dari keluarga kurang mampu',
        ],
        periodStart: at(-20, 0),
        periodEnd: at(25, 0),
        fields: const [
          ProgramField(
            'kondisi',
            'Kondisi Saat Ini',
            kind: FieldKind.choice,
            options: ['Hamil', 'Menyusui'],
          ),
          ProgramField(
            'usia',
            'Usia Kehamilan / Usia Bayi',
            hint: 'Contoh: 20 minggu atau 8 bulan',
          ),
          ProgramField(
            'anak',
            'Jumlah Anak',
            kind: FieldKind.number,
            hint: 'Contoh: 2',
          ),
          ProgramField(
            'faskes',
            'Posyandu / Puskesmas Tempat Terdaftar',
            hint: 'Contoh: Posyandu Melati II',
          ),
        ],
        documents: const [
          'Foto KTP',
          'Foto Kartu Keluarga',
          'Buku KIA / Surat Keterangan Bidan',
        ],
      ),
      AidProgram(
        id: 'p2',
        name: 'BLT Dana Desa',
        description: 'Bantuan Langsung Tunai bagi keluarga miskin yang kehilangan mata pencaharian atau berpenghasilan rendah.',
        icon: Icons.payments_rounded,
        requirements: [
          'Warga Desa Sukamaju yang telah terverifikasi',
          'Keluarga miskin atau kehilangan mata pencaharian',
          'Belum menerima bantuan sosial lain (PKH/BPNT)',
          'Tidak berstatus ASN, TNI, atau Polri',
        ],
        periodStart: at(-15, 0),
        periodEnd: at(5, 0),
        fields: const [
          ProgramField(
            'pekerjaan',
            'Pekerjaan Kepala Keluarga',
            hint: 'Contoh: Buruh tani',
          ),
          ProgramField(
            'penghasilan',
            'Penghasilan per Bulan (Rp)',
            kind: FieldKind.number,
            hint: 'Contoh: 1200000',
          ),
          ProgramField(
            'tanggungan',
            'Jumlah Tanggungan Keluarga',
            kind: FieldKind.number,
            hint: 'Contoh: 4',
          ),
          ProgramField(
            'alasan',
            'Alasan Mengajukan',
            kind: FieldKind.multiline,
            hint: 'Jelaskan kondisi keluarga Anda',
          ),
        ],
        documents: const [
          'Foto KTP',
          'Foto Kartu Keluarga',
          'Foto Rumah Tampak Depan',
        ],
      ),
      AidProgram(
        id: 'p3',
        name: 'Bantuan Rehabilitasi Rumah',
        description:
            'Bantuan perbaikan rumah tidak layak huni bagi warga kurang mampu.',
        icon: Icons.home_repair_service_rounded,
        requirements: [
          'Warga Desa Sukamaju yang telah terverifikasi',
          'Memiliki rumah sendiri dengan kondisi tidak layak huni',
          'Memiliki bukti kepemilikan tanah atau surat keterangan desa',
        ],
        periodStart: at(40, 0),
        periodEnd: at(70, 0),
        fields: const [
          ProgramField(
            'kerusakan',
            'Bagian Rumah yang Rusak',
            kind: FieldKind.multiline,
            hint: 'Atap, dinding, lantai, dll.',
          ),
        ],
        documents: const ['Foto KTP', 'Foto Kondisi Rumah'],
      ),
    ];

    applications = [
      AidApplication(
        id: 'ap0',
        programId: 'p2',
        data: const {
          'pekerjaan': 'Buruh tani',
          'penghasilan': '1200000',
          'tanggungan': '4',
          'alasan': 'Penghasilan menurun sejak musim kemarau.',
        },
        docs: const [
          AttachedDoc(
            label: 'Foto KTP',
            fileName: 'ktp.jpg',
            sizeBytes: 820000,
          ),
          AttachedDoc(
            label: 'Foto Kartu Keluarga',
            fileName: 'kk.jpg',
            sizeBytes: 910000,
          ),
          AttachedDoc(
            label: 'Foto Rumah Tampak Depan',
            fileName: 'rumah.jpg',
            sizeBytes: 640000,
          ),
        ],
        history: [
          StatusEvent(ApplicationStatus.sent, at(-6, 9)),
          StatusEvent(ApplicationStatus.verifying, at(-5, 10)),
          StatusEvent(
            ApplicationStatus.needsFix,
            at(-3, 14),
            'Foto Kartu Keluarga buram dan sebagian data tidak terbaca. Mohon unggah ulang foto yang lebih jelas.',
          ),
        ],
      ),
    ];

    news = [
      NewsItem(
        id: 'b1',
        title: 'Pendaftaran BLT Dana Desa Dibuka Hingga Akhir Pekan',
        category: NewsCategory.pengumuman,
        date: at(-2, 8),
        author: 'Admin Desa Sukamaju',
        body:
            'Pemerintah Desa Sukamaju membuka pendaftaran penerima BLT Dana Desa melalui aplikasi DesaKu.\n\n'
            'Warga yang telah terverifikasi dapat mengajukan permohonan dengan melampirkan foto KTP, Kartu Keluarga, dan foto rumah.\n\n'
            'Perlu diingat: pengajuan bersifat permohonan. Penetapan penerima bantuan ditentukan oleh pemerintah desa sesuai ketentuan yang berlaku.',
      ),
      NewsItem(
        id: 'b2',
        title: 'Warga Kerja Bakti Bersihkan Saluran Irigasi bersama Dinas Pertanian',
        category: NewsCategory.berita,
        date: at(-4, 10),
        author: 'Admin Desa Sukamaju',
        body:
            'Ratusan warga Desa Sukamaju bergotong royong membersihkan saluran irigasi untuk menyambut musim tanam.\n\n'
            'Kegiatan ini didampingi Dinas Pertanian Kabupaten Tangerang dan akan dilanjutkan pada blok barat pekan depan.',
      ),
      NewsItem(
        id: 'b3',
        title: 'Jadwal Imunisasi Balita Bulan Ini',
        category: NewsCategory.berita,
        date: at(-7, 9),
        author: 'Admin Desa Sukamaju',
        body:
            'Imunisasi dasar lengkap untuk balita dilaksanakan di seluruh Posyandu desa.\n\n'
            'Orang tua diminta membawa buku KIA. Pendaftaran dapat dilakukan melalui menu Kegiatan.',
      ),
      NewsItem(
        id: 'b4',
        title: 'Pembayaran PBB Dapat Dilakukan di Kantor Desa',
        category: NewsCategory.pengumuman,
        date: at(-10, 8),
        author: 'Admin Desa Sukamaju',
        body: 'Warga dapat membayar PBB di Kantor Desa pada jam layanan Senin–Jumat pukul 08.00–15.00 WIB.',
      ),
    ];

    {
      notifications = [
        AppNotification(
          id: 'n1',
          title: 'Perbaikan diperlukan pada pengajuan BLT',
          body: 'Foto Kartu Keluarga buram. Mohon unggah ulang dokumen Anda.',
          type: NotifType.aid,
          time: at(-3, 14),
          targetId: 'ap0',
        ),
        AppNotification(
          id: 'n2',
          title: 'Kegiatan baru: Posyandu Balita Melati II',
          body: 'Pendaftaran dibuka. Segera daftar sebelum kuota penuh.',
          type: NotifType.activity,
          time: at(-1, 8),
          targetId: 'k1',
        ),
        AppNotification(
          id: 'n3',
          title: 'Pengumuman: Pendaftaran BLT Dana Desa',
          body: 'Pendaftaran dibuka hingga akhir pekan.',
          type: NotifType.news,
          time: at(-2, 8),
          targetId: 'b1',
        ),
      ];
    }
  }
}

final AppState appState = AppState();
