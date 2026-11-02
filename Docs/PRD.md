Product Requirements Document (PRD)

Aplikasi Mobile "Desa Ku": Sistem Informasi Kegiatan, Pendaftaran
Program Bantuan, dan Layanan Informasi Desa

Disusun oleh: Azkiya Zahrul Umam

NIM: 20230801187

Program Studi: Teknik Informatika

Institusi: Universitas Esa Unggul

Tahun: 2026

Versi Dokumen: 1.0

Riwayat Dokumen

Versi Tanggal Penyusun Keterangan

1.0 23 Oktober 2026 Azkiya Zahrul Penyusunan awal dokumen PRD
berdasarkan BRD Umam Desa Ku versi 1.0
1. Pendahuluan
1.1 Tujuan Dokumen

Dokumen Product Requirements Document (PRD) ini menguraikan kebutuhan
produk aplikasi mobile "Desa Ku" secara fungsional dan non-fungsional.
Dokumen ini menerjemahkan kebutuhan bisnis pada BRD menjadi fitur,
perilaku sistem, dan batasan teknis yang dapat dijadikan acuan
perancangan, pengembangan, dan pengujian.

1.2 Ruang Lingkup Produk

Produk terdiri atas dua komponen: (1) aplikasi mobile untuk warga, dan
(2) panel pengelolaan berbasis web untuk admin desa. Produk mencakup
registrasi dan verifikasi warga, kegiatan desa, notifikasi, program
bantuan, serta berita dan informasi desa.

1.3 Hubungan dengan BRD

Setiap kebutuhan pada dokumen ini ditelusuri ke kebutuhan bisnis pada
BRD (kode BR-01 sampai BR- 14). Penelusuran ini dicantumkan pada kolom
"Kebutuhan Bisnis" di tabel kebutuhan fungsional.

1.4 Definisi dan Singkatan

Istilah Definisi
<!-- Halaman 2 -->
Istilah Definisi

FR Functional Requirement, kebutuhan fungsional

NFR Non-Functional Requirement, kebutuhan non-fungsional

MVP Minimum Viable Product, versi awal produk dengan fitur inti

Push notification Pemberitahuan yang dikirim ke perangkat pengguna

Admin Desa Perangkat desa yang mengelola konten dan data pada panel
pengelolaan

OTP One-Time Password, kode sekali pakai untuk verifikasi

UAT User Acceptance Test, uji penerimaan pengguna
2. Gambaran Produk
2.1 Visi Produk

"Desa Ku" menjadi pintu layanan digital desa yang memudahkan setiap
warga mengetahui kegiatan, mengikuti kegiatan, dan mengajukan bantuan
dengan jelas, cepat, dan transparan.

2.2 Pernyataan Masalah

Informasi kegiatan desa yang tersebar, pendaftaran kegiatan dan bantuan
yang manual, serta status pengajuan yang tidak transparan menyebabkan
partisipasi rendah, antrean di kantor desa, dan pendataan yang sulit
direkap (lihat BRD bagian 3).

2.3 Sasaran Produk
1.  Warga menerima informasi kegiatan dan pengumuman secara langsung melalui notifikasi.
2.  Warga dapat mendaftar kegiatan dan mengajukan bantuan sepenuhnya melalui aplikasi.
3.  Admin desa dapat mengelola kegiatan, berita, dan verifikasi pengajuan dalam satu panel.
4.  Data warga dan pengajuan tersimpan aman dan dapat direkap.
2.4 Asumsi Produk
1.  Produk melayani satu desa pada tahap awal.
2.  Warga yang dapat mengakses layanan adalah warga yang datanya telah diverifikasi admin.
3.  Aplikasi hanya mencatat pengajuan bantuan; penetapan penerima tetap diputuskan pemerintah
    desa.
4.  Platform mobile awal adalah Android, dengan iOS dipertimbangkan pada fase berikutnya.
3. Pengguna dan Persona
Persona Deskripsi Kebutuhan Utama Kendala

Warga dewasa Pengguna telepon Mengetahui jadwal kegiatan, Literasi
digital
<!-- Halaman 3 -->
Persona Deskripsi Kebutuhan Utama Kendala

(misalnya Bu Siti, 34 pintar dengan mengajukan bantuan ibu hamil
terbatas, kuota tahun, ibu rumah penggunaan dasar dan menyusui, memantau
status terbatas tangga) (pesan dan media sosial)

Warga lanjut usia atau Pengguna yang Informasi yang mudah dibaca, Huruf
kecil sulit pengguna dibantu kadang dibantu pengajuan BLT dengan langkah
dibaca, takut (misalnya Pak Darto, keluarga sederhana salah isi 58
tahun, petani)

Admin Desa (misalnya Perangkat desa yang Mempublikasikan kegiatan dan
Waktu terbatas, Mas Rizki, 29 tahun, mengelola layanan berita,
memverifikasi pengajuan banyak tugas staf desa) dengan cepat lain

Kepala Desa Penyetuju kebijakan Melihat rekapitulasi kegiatan dan
Membutuhkan dan penerima bantuan secara ringkas data yang siap laporan
dibaca

Nama pada persona merupakan contoh ilustratif, bukan data hasil riset
lapangan.
4. Ruang Lingkup Rilis
4.1 Fitur MVP (Rilis 1)
1.  Registrasi, login, dan verifikasi warga.
2.  Daftar dan detail kegiatan, serta pendaftaran kegiatan.
3.  Notifikasi kegiatan dan pengumuman.
4.  Program bantuan: informasi, pengajuan, unggah dokumen, dan status.
5.  Berita dan informasi desa.
6.  Panel admin: kelola kegiatan, berita, warga, dan pengajuan bantuan.
4.2 Fitur Rilis Lanjutan
1.  Laporan rekapitulasi yang dapat diunduh (BR-11).
2.  Kanal pengaduan dan masukan warga (BR-14).
3.  Dukungan iOS.
4.  Pengiriman pengingat otomatis (misalnya H-1 kegiatan).
4.3 Di Luar Ruang Lingkup

Penyaluran dana, penetapan akhir penerima bantuan, layanan administrasi
kependudukan, pengelolaan keuangan desa, dan integrasi langsung dengan
sistem nasional (BRD bagian 5.2).
5. Kebutuhan Fungsional
Prioritas menggunakan skala MoSCoW: Must, Should, dan Could.
<!-- Halaman 4 -->
5.1 Modul Akun dan Verifikasi

Kode Kebutuhan Pengguna Prioritas Kebutuhan Bisnis

FR-01 Sistem menyediakan registrasi akun dengan Warga Must BR-01 nama
lengkap, NIK, nomor KK, nomor telepon, dan kata sandi

FR-02 Sistem menolak registrasi jika NIK sudah Sistem Must BR-01
terdaftar pada akun lain

FR-03 Sistem menampilkan status akun "menunggu Warga Must BR-01
verifikasi" setelah registrasi dan membatasi akses fitur layanan hingga
diverifikasi

FR-04 Admin dapat melihat daftar akun menunggu Admin Must BR-01, BR-
verifikasi, lalu menyetujui atau menolak 10 disertai alasan

FR-05 Sistem menyediakan login dan logout, serta Warga, Admin Must BR-12
pemulihan kata sandi melalui OTP

FR-06 Warga dapat melihat dan memperbarui data Warga Should BR-01 profil
non-identitas (nomor telepon, foto)

5.2 Modul Kegiatan

Kode Kebutuhan Pengguna Prioritas Kebutuhan Bisnis

FR-07 Sistem menampilkan daftar kegiatan terurut dari Warga Must BR-02
yang terdekat, dengan filter kategori

FR-08 Sistem menampilkan detail kegiatan: judul, Warga Must BR-02
deskripsi, tanggal, waktu, lokasi, penyelenggara, dan kuota

FR-09 Warga dapat mendaftar kegiatan dan Warga Must BR-03 membatalkan
pendaftaran sebelum batas waktu

FR-10 Sistem menolak pendaftaran jika kuota penuh atau Sistem Must BR-03
kegiatan telah lewat

FR-11 Admin dapat membuat, mengubah, membatalkan, Admin Must BR-10 dan
menghapus kegiatan

FR-12 Admin dapat melihat daftar peserta tiap kegiatan Admin Must BR-03
<!-- Halaman 5 -->
5.3 Modul Notifikasi dan Informasi

Kode Kebutuhan Pengguna Prioritas Kebutuhan Bisnis

FR-13 Sistem mengirim push notification saat kegiatan Sistem Must BR-04
atau pengumuman baru dipublikasikan

FR-14 Sistem menyimpan riwayat notifikasi di dalam Warga Should BR-04
aplikasi

FR-15 Admin dapat mempublikasikan berita dan Admin Must BR-09, BR-
pengumuman dengan judul, isi, dan gambar 10

FR-16 Warga dapat membaca daftar dan detail berita Warga Must BR-09

5.4 Modul Program Bantuan

Kode Kebutuhan Pengguna Prioritas Kebutuhan Bisnis

FR-17 Sistem menampilkan daftar program bantuan Warga Must BR-05 beserta
deskripsi, persyaratan, dan periode pendaftaran

FR-18 Warga dapat mengisi formulir pengajuan sesuai Warga Must BR-06
program dan melampirkan dokumen pendukung (foto atau PDF)

FR-19 Sistem memvalidasi kelengkapan isian wajib dan Sistem Must BR-06
format berkas sebelum pengajuan dikirim

FR-20 Sistem mencegah pengajuan ganda pada program Sistem Must BR-06
yang sama oleh warga yang sama dalam satu periode

FR-21 Sistem menampilkan status pengajuan: Dikirim, Warga Must BR-08
Sedang Diverifikasi, Perlu Perbaikan, Disetujui, atau Ditolak

FR-22 Warga dapat memperbaiki dan mengirim ulang Warga Should BR-08
pengajuan berstatus Perlu Perbaikan

FR-23 Admin dapat membuat dan mengubah program Admin Must BR-05, BR-
bantuan, termasuk persyaratan dan periode 10 pendaftaran

FR-24 Admin dapat memeriksa pengajuan beserta Admin Must BR-07 dokumen,
lalu mengubah status disertai alasan
<!-- Halaman 6 -->
Kode Kebutuhan Pengguna Prioritas Kebutuhan Bisnis
    untuk status Perlu Perbaikan atau Ditolak
FR-25 Sistem mengirim notifikasi kepada warga setiap Sistem Must BR-04,
BR- status pengajuan berubah 08

FR-26 Sistem menampilkan keterangan bahwa pengajuan Sistem Must BR-06
bersifat permohonan dan penetapan penerima ditentukan pemerintah desa

5.5 Modul Panel Admin dan Pelaporan

Kode Kebutuhan Pengguna Prioritas Kebutuhan Bisnis

FR-27 Panel admin menyediakan beranda ringkas: jumlah Admin, Should
BR-10, BR- warga terverifikasi, kegiatan aktif, dan pengajuan Kepala 11
menunggu verifikasi Desa

FR-28 Admin dapat mengelola akun admin lain dengan Admin Should BR-10,
BR- peran berbeda (admin penuh dan admin konten) 12

FR-29 Admin dapat mengekspor rekapitulasi peserta Admin Should BR-11
kegiatan dan pengajuan bantuan ke format spreadsheet atau PDF

FR-30 Sistem mencatat log aktivitas admin pada Sistem Should BR-12
perubahan status pengajuan dan verifikasi warga
6. User Story dan Kriteria Penerimaan
Berikut user story utama beserta kriteria penerimaan.

ID User Story Kriteria Penerimaan

US-01 Sebagai warga, saya ingin mendaftar Registrasi berhasil bila data
lengkap dan NIK belum akun agar dapat memakai layanan terdaftar; status
akun menjadi "menunggu desa verifikasi"; NIK ganda menampilkan pesan
penolakan

US-02 Sebagai admin, saya ingin Admin dapat menyetujui atau menolak;
penolakan memverifikasi warga agar hanya wajib beralasan; warga menerima
notifikasi hasilnya warga desa yang dapat masuk

US-03 Sebagai warga, saya ingin melihat Daftar tampil terurut tanggal;
detail memuat kegiatan desa agar tidak ketinggalan tanggal, lokasi, dan
kuota
<!-- Halaman 7 -->
ID User Story Kriteria Penerimaan
     informasi
US-04 Sebagai warga, saya ingin mendaftar Pendaftaran berhasil bila
kuota tersedia; kuota kegiatan dari aplikasi penuh menampilkan pesan;
pembatalan dapat dilakukan sebelum batas waktu

US-05 Sebagai warga, saya ingin menerima Notifikasi diterima pada
perangkat setelah admin notifikasi kegiatan baru mempublikasikan
kegiatan

US-06 Sebagai warga, saya ingin Persyaratan tampil sebelum formulir;
pengajuan mengajukan bantuan ibu hamil dan hanya terkirim bila isian
wajib dan dokumen menyusui atau BLT lengkap; pengajuan ganda ditolak

US-07 Sebagai warga, saya ingin memantau Status terbaru tampil pada
halaman pengajuan; status pengajuan agar tahu alasan tampil bila Perlu
Perbaikan atau Ditolak; perkembangannya notifikasi terkirim saat status
berubah

US-08 Sebagai admin, saya ingin memeriksa Admin dapat melihat data dan
dokumen, mengubah dan memproses pengajuan bantuan status, dan mengisi
alasan; perubahan tercatat pada log

US-09 Sebagai admin, saya ingin Kegiatan dan berita tersimpan, tampil
pada aplikasi menerbitkan kegiatan dan berita warga, dan memicu
notifikasi

US-10 Sebagai Kepala Desa, saya ingin Beranda panel menampilkan jumlah
warga, kegiatan melihat rekapitulasi ringkas aktif, dan pengajuan per
status
7. Alur Pengguna Utama
7.1 Registrasi dan Verifikasi Warga
1.  Warga membuka aplikasi dan memilih "Daftar".
2.  Warga mengisi nama, NIK, nomor KK, nomor telepon, dan kata sandi, lalu mengirim.
3.  Sistem memvalidasi data; bila NIK telah terdaftar, sistem menampilkan penolakan.
4.  Akun berstatus "menunggu verifikasi".
5.  Admin memeriksa data pada panel, lalu menyetujui atau menolak disertai alasan.
6.  Warga menerima notifikasi hasil. Bila disetujui, warga dapat memakai seluruh fitur.
7.2 Pendaftaran Kegiatan
1.  Warga membuka daftar kegiatan dan memilih satu kegiatan.
2.  Warga membaca detail, lalu memilih "Daftar".
3.  Sistem memeriksa kuota dan batas waktu.
4.  Bila memenuhi syarat, pendaftaran tercatat dan warga menerima konfirmasi; bila tidak, sistem
  menampilkan alasannya.
<!-- Halaman 8 -->
7.3 Pengajuan Program Bantuan
1.  Warga membuka daftar program bantuan dan memilih program.
2.  Warga membaca persyaratan dan keterangan bahwa pengajuan bersifat permohonan.
3.  Warga mengisi formulir dan mengunggah dokumen pendukung.
4.  Sistem memvalidasi isian dan berkas; bila belum lengkap, sistem menandai bagian yang kurang.
5.  Pengajuan terkirim dengan status "Dikirim".
6.  Admin memeriksa pengajuan, lalu mengubah status menjadi Sedang Diverifikasi, Perlu
    Perbaikan, Disetujui, atau Ditolak.
7.  Setiap perubahan status memicu notifikasi kepada warga. Pada status Perlu Perbaikan, warga
   memperbaiki dan mengirim ulang.
8. Kebutuhan Non-Fungsional
Kebutuhan non-fungsional mengacu pada karakteristik kualitas perangkat
lunak pada ISO/IEC 25010.

Kode Kategori Kebutuhan

NFR-01 Keamanan Kata sandi disimpan dalam bentuk hash; komunikasi data
memakai HTTPS

NFR-02 Keamanan Akses data dibatasi berdasarkan peran (warga hanya
melihat data miliknya; admin sesuai hak akses)

NFR-03 Pelindungan data pribadi NIK, nomor KK, dan dokumen pengajuan
disimpan terenkripsi dan hanya dapat diakses pihak berwenang, sesuai UU
Pelindungan Data Pribadi

NFR-04 Performa Halaman daftar dan detail termuat dalam waktu paling
lama 3 detik pada koneksi seluler 4G normal

NFR-05 Kapasitas Sistem mampu melayani minimal 1.000 pengguna terdaftar
dan 100 pengguna aktif bersamaan pada rilis awal

NFR-06 Ketersediaan Layanan tersedia minimal 99% setiap bulan di luar
pemeliharaan terjadwal

NFR-07 Kegunaan Antarmuka sederhana, teks minimal ukuran 16 sp, kontras
warna memadai, dan bahasa Indonesia yang mudah dipahami

NFR-08 Kegunaan Pengguna baru dapat menyelesaikan registrasi tanpa
panduan tambahan

NFR-09 Kompatibilitas Aplikasi berjalan pada Android versi 8.0 ke atas;
panel admin berjalan pada peramban modern

NFR-10 Keandalan Data dicadangkan otomatis minimal sekali sehari
<!-- Halaman 9 -->
Kode Kategori Kebutuhan

NFR-11 Efisiensi Ukuran unggahan gambar dikompresi agar hemat kuota
pengguna

NFR-12 Keterpeliharaan Kode terdokumentasi dan menggunakan kontrol versi

Angka pada NFR-04 sampai NFR-06 merupakan target awal yang dapat
disesuaikan setelah pengujian.
9. Model Data Tingkat Tinggi
Entitas Atribut Utama Relasi

Pengguna id, nama, NIK, nomor KK, telepon, kata Satu pengguna memiliki
sandi (hash), peran, status verifikasi banyak pendaftaran kegiatan dan
pengajuan

Kegiatan id, judul, deskripsi, tanggal, waktu, lokasi, Satu kegiatan
memiliki kuota, status banyak pendaftaran

PendaftaranKegiatan id, id pengguna, id kegiatan, waktu daftar,
Menghubungkan Pengguna status dan Kegiatan

ProgramBantuan id, nama, deskripsi, persyaratan, periode Satu program
memiliki mulai, periode selesai, status banyak pengajuan

PengajuanBantuan id, id pengguna, id program, data isian, Menghubungkan
Pengguna status, alasan, waktu dan ProgramBantuan

DokumenPengajuan id, id pengajuan, nama berkas, jenis, lokasi Satu
pengajuan memiliki penyimpanan banyak dokumen

Berita id, judul, isi, gambar, waktu terbit, penulis Dibuat oleh admin

Notifikasi id, id pengguna, judul, isi, jenis, waktu, Dimiliki oleh
pengguna status baca

LogAktivitas id, id admin, aksi, objek, waktu Dicatat untuk tindakan
admin
10. Rekomendasi Teknologi
Pilihan berikut merupakan rekomendasi awal yang dapat disesuaikan dengan
kemampuan dan sumber daya pengembang.

Komponen Rekomendasi Alasan

Aplikasi mobile Flutter atau React Native Satu basis kode, pengembangan
lebih cepat, dan mendukung Android serta iOS di masa depan
<!-- Halaman 10 -->
Komponen Rekomendasi Alasan

Panel admin Aplikasi web (misalnya React Mudah diakses dari komputer
kantor desa atau Laravel Blade)

Backend dan API Laravel atau Node.js (REST Ekosistem matang dan
dokumentasi luas API)

Basis data MySQL atau PostgreSQL Cocok untuk data relasional

Notifikasi Firebase Cloud Messaging Layanan push notification yang umum
digunakan pada Android

Penyimpanan berkas Penyimpanan objek (misalnya Menyimpan dokumen
pengajuan dengan layanan cloud storage) kontrol akses

Autentikasi Token (JWT) dan OTP Keamanan sesi dan pemulihan akun
11. Rencana Rilis
Rilis Cakupan Keluaran

Rilis 1 (MVP) FR-01 sampai FR-26 yang berprioritas Must, Aplikasi
Android dan panel ditambah FR-27 admin untuk uji coba terbatas

Rilis 2 FR-06, FR-14, FR-22, FR-28 sampai FR-30 Perbaikan berdasarkan
umpan (prioritas Should) balik dan pelaporan

Rilis 3 Kanal pengaduan, dukungan iOS, pengingat Perluasan layanan
otomatis (prioritas Could)
12. Metrik Keberhasilan Produk
Metrik berikut selaras dengan KPI pada BRD.

Metrik Definisi Target yang Diusulkan

Tingkat registrasi Warga terverifikasi dibagi total kepala Minimal 60%
dalam 6 bulan terverifikasi keluarga

Pengguna aktif bulanan Pengguna yang membuka aplikasi Minimal 50% dari
warga minimal sekali per bulan terverifikasi

Tingkat pendaftaran Pendaftar dibagi kuota kegiatan Meningkat dibanding
periode kegiatan sebelum aplikasi

Pengajuan bantuan Pengajuan digital dibagi total Minimal 70% melalui
aplikasi pengajuan

Waktu verifikasi Rata-rata selisih waktu kirim dan Lebih singkat dari
proses
<!-- Halaman 11 -->
Metrik Definisi Target yang Diusulkan

pengajuan keputusan manual

Kepuasan pengguna Hasil survei kepuasan Minimal 80% puas
13. Rencana Pengujian
Jenis Pengujian Tujuan Pelaksana

Pengujian fungsional Memastikan setiap FR berjalan sesuai kriteria
Pengembang penerimaan

Pengujian keamanan dasar Memeriksa kontrol akses, validasi input, dan
Pengembang perlindungan data

Pengujian kegunaan Menilai kemudahan penggunaan oleh warga Pengembang
dan dengan beragam tingkat literasi digital perwakilan warga

Pengujian performa Memeriksa waktu muat dan kapasitas (NFR-04,
Pengembang NFR-05)

UAT Memastikan produk memenuhi kebutuhan Perangkat desa bisnis dan
perwakilan warga
14. Risiko, Ketergantungan, dan Pertanyaan Terbuka
14.1 Risiko Produk

Risiko Dampak Mitigasi

Warga kesulitan memakai Adopsi rendah Desain sederhana, panduan singkat
dalam aplikasi aplikasi, dan pendampingan di kantor desa

Dokumen pengajuan Verifikasi lambat Petunjuk pengambilan foto dan
validasi ukuran berkualitas buruk (foto berkas buram)

Admin tidak responsif Pengajuan Notifikasi pengingat ke admin dan
penetapan tertunda penanggung jawab

Kebocoran data pribadi Kerugian warga Enkripsi, pembatasan akses, dan
log aktivitas dan reputasi desa

Perubahan aturan program Formulir tidak Formulir dan persyaratan dapat
diperbarui admin bantuan sesuai
<!-- Halaman 12 -->
14.2 Ketergantungan

Dukungan Kepala Desa, ketersediaan persyaratan program bantuan,
ketersediaan data warga untuk verifikasi, serta layanan notifikasi dan
penyimpanan cloud.

14.3 Pertanyaan Terbuka
1.  Apakah verifikasi warga cukup dengan pencocokan NIK dan nomor KK, atau perlu bukti
  tambahan seperti foto KTP?
2.  Dokumen apa saja yang diwajibkan untuk tiap program bantuan di desa terkait?
3.  Siapa yang menjadi penanggung jawab admin dan berapa jumlah admin yang dibutuhkan?
4.  Apakah warga tanpa telepon pintar perlu dilayani melalui perwakilan di kantor desa?
Daftar Pustaka

Cagan, M. (2018). Inspired: How to create tech products customers love
(2nd ed.). Wiley.

Cooper, A., Reimann, R., Cronin, D., & Noessel, C. (2014). About face:
The essentials of interaction design (4th ed.). Wiley.

International Organization for Standardization. (2011). ISO/IEC
25010:2011 Systems and software engineering: Systems and software
Quality Requirements and Evaluation (SQuaRE): System and software
quality models. ISO.

Republik Indonesia. (2014). Undang-Undang Nomor 6 Tahun 2014 tentang
Desa.

Republik Indonesia. (2022). Undang-Undang Nomor 27 Tahun 2022 tentang
Pelindungan Data Pribadi.

Wiegers, K., & Beatty, J. (2013). Software requirements (3rd ed.).
Microsoft Press.