import 'package:flutter/material.dart';

import 'app_theme.dart';

/// Status verifikasi akun warga (FR-03, FR-04).
enum VerificationStatus { pending, verified, rejected }

class UserProfile {
  UserProfile({
    required this.name,
    required this.nik,
    required this.kk,
    required this.phone,
    required this.password,
    this.status = VerificationStatus.pending,
    this.rejectReason,
    this.photoPath,
  });

  String name;
  final String nik;
  final String kk;
  String phone;
  String password;
  VerificationStatus status;
  String? rejectReason;
  String? photoPath;

  String get firstName => name.trim().split(' ').first;
  String get maskedNik => nik.length == 16
      ? '${nik.substring(0, 4)} •••• •••• ${nik.substring(12)}'
      : nik;
  String get maskedKk => kk.length == 16
      ? '${kk.substring(0, 4)} •••• •••• ${kk.substring(12)}'
      : kk;
}

class Activity {
  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.start,
    required this.location,
    required this.organizer,
    required this.quota,
    required this.registered,
    required this.category,
    this.cancelled = false,
  });

  final String id;
  final String title;
  final String description;
  final DateTime start;
  final String location;
  final String organizer;
  final int quota;
  int registered;
  final String category;
  bool cancelled;

  int get remaining => quota - registered;
  bool get isPast => start.isBefore(DateTime.now());
  bool get isFull => remaining <= 0;

  /// Pembatalan hanya boleh sampai 24 jam sebelum kegiatan dimulai.
  DateTime get cancelDeadline => start.subtract(const Duration(hours: 24));
  bool get canCancel => DateTime.now().isBefore(cancelDeadline);
}

class ProgramField {
  const ProgramField(
    this.key,
    this.label, {
    this.hint,
    this.kind = FieldKind.text,
    this.options = const [],
  });
  final String key;
  final String label;
  final String? hint;
  final FieldKind kind;
  final List<String> options;
}

enum FieldKind { text, number, multiline, choice }

class AidProgram {
  const AidProgram({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.requirements,
    required this.periodStart,
    required this.periodEnd,
    required this.fields,
    required this.documents,
  });

  final String id;
  final String name;
  final String description;
  final IconData icon;
  final List<String> requirements;
  final DateTime periodStart;
  final DateTime periodEnd;
  final List<ProgramField> fields;

  /// Daftar dokumen pendukung yang wajib dilampirkan (foto atau PDF).
  final List<String> documents;

  bool get isOpen {
    final now = DateTime.now();
    return !now.isBefore(periodStart) &&
        now.isBefore(periodEnd.add(const Duration(days: 1)));
  }

  bool get notStarted => DateTime.now().isBefore(periodStart);
}

/// FR-21: status pengajuan bantuan.
enum ApplicationStatus { sent, verifying, needsFix, approved, rejected }

extension ApplicationStatusX on ApplicationStatus {
  String get label => switch (this) {
    ApplicationStatus.sent => 'Dikirim',
    ApplicationStatus.verifying => 'Sedang Diverifikasi',
    ApplicationStatus.needsFix => 'Perlu Perbaikan',
    ApplicationStatus.approved => 'Disetujui',
    ApplicationStatus.rejected => 'Ditolak',
  };

  Color get color => switch (this) {
    ApplicationStatus.sent => AppColors.info,
    ApplicationStatus.verifying => AppColors.warning,
    ApplicationStatus.needsFix => AppColors.orange,
    ApplicationStatus.approved => AppColors.success,
    ApplicationStatus.rejected => AppColors.danger,
  };

  IconData get icon => switch (this) {
    ApplicationStatus.sent => Icons.send_rounded,
    ApplicationStatus.verifying => Icons.hourglass_top_rounded,
    ApplicationStatus.needsFix => Icons.edit_note_rounded,
    ApplicationStatus.approved => Icons.check_circle_rounded,
    ApplicationStatus.rejected => Icons.cancel_rounded,
  };
}

class AttachedDoc {
  const AttachedDoc({
    required this.label,
    required this.fileName,
    this.path,
    this.sizeBytes = 0,
  });
  final String label;
  final String fileName;
  final String? path;
  final int sizeBytes;
}

class StatusEvent {
  const StatusEvent(this.status, this.time, [this.reason]);
  final ApplicationStatus status;
  final DateTime time;
  final String? reason;
}

class AidApplication {
  AidApplication({
    required this.id,
    required this.programId,
    required this.data,
    required this.docs,
    required this.history,
  });

  final String id;
  final String programId;
  Map<String, String> data;
  List<AttachedDoc> docs;
  final List<StatusEvent> history;

  ApplicationStatus get status => history.last.status;
  String? get reason => history.last.reason;
  DateTime get submittedAt => history.first.time;
}

enum NewsCategory { berita, pengumuman }

class NewsItem {
  const NewsItem({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    required this.date,
    required this.author,
  });
  final String id;
  final String title;
  final String body;
  final NewsCategory category;
  final DateTime date;
  final String author;

  String get categoryLabel =>
      category == NewsCategory.berita ? 'Berita' : 'Pengumuman';
  String get excerpt => body.split('\n').first;
}

enum NotifType { activity, aid, news, account }

class AppNotification {
  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.time,
    this.targetId,
    this.read = false,
  });
  final String id;
  final String title;
  final String body;
  final NotifType type;
  final DateTime time;
  final String? targetId;
  bool read;
}
