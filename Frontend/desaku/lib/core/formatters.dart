const _months = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
];
const _monthsShort = [
  'JAN',
  'FEB',
  'MAR',
  'APR',
  'MEI',
  'JUN',
  'JUL',
  'AGU',
  'SEP',
  'OKT',
  'NOV',
  'DES',
];
const _days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];

String two(int n) => n.toString().padLeft(2, '0');

String monthShort(DateTime d) => _monthsShort[d.month - 1];

/// 14 November 2026
String fmtDate(DateTime d) => '${d.day} ${_months[d.month - 1]} ${d.year}';

/// Sabtu, 14 November 2026
String fmtDateLong(DateTime d) => '${_days[d.weekday - 1]}, ${fmtDate(d)}';

/// 08.00 WIB
String fmtTime(DateTime d) => '${two(d.hour)}.${two(d.minute)} WIB';

String fmtDateTime(DateTime d) => '${fmtDate(d)}, ${fmtTime(d)}';

/// "5 menit lalu", "Kemarin", dst.
String fmtAgo(DateTime d) {
  final diff = DateTime.now().difference(d);
  if (diff.inMinutes < 1) return 'Baru saja';
  if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
  if (diff.inHours < 24) return '${diff.inHours} jam lalu';
  if (diff.inDays == 1) return 'Kemarin';
  if (diff.inDays < 7) return '${diff.inDays} hari lalu';
  return fmtDate(d);
}

String fmtSize(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(0)} KB';
  return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
}
