Business Requirements Document (BRD)

Aplikasi Mobile "DesaKu": Sistem Informasi Kegiatan, Pendaftaran Program
Bantuan, dan Layanan Informasi Desa

Disusun oleh: Azkiya Zahrul Umam

NIM: 20230801187

Program Studi: Teknik Informatika

Institusi: Universitas Esa Unggul

Tahun: 2026

Versi Dokumen: 1.0

Riwayat Dokumen

Versi Tanggal Penyusun Keterangan

1.0 23 Oktober 2026 Azkiya Zahrul Umam Penyusunan awal dokumen BRD
1. Pendahuluan
1.1 Tujuan Dokumen

Dokumen Business Requirements Document (BRD) ini disusun untuk
mendefinisikan kebutuhan bisnis, tujuan, ruang lingkup, serta kriteria
keberhasilan dari pengembangan aplikasi mobile "Desa Ku". Dokumen ini
menjadi landasan bersama antara pemangku kepentingan (pemerintah desa,
warga, dan pihak pengembang) sebelum kebutuhan dirinci lebih lanjut pada
Product Requirements Document (PRD) dan dokumen perancangan teknis.

1.2 Ruang Lingkup Dokumen

Dokumen ini membahas aspek bisnis dari aplikasi "Desa Ku", meliputi
latar belakang permasalahan, tujuan bisnis, pemangku kepentingan, proses
bisnis, kebutuhan bisnis, asumsi, risiko, dan indikator keberhasilan.
Spesifikasi fungsional rinci, rancangan antarmuka, dan arsitektur teknis
tidak dibahas di sini dan akan diuraikan pada dokumen PRD.

1.3 Definisi dan Singkatan

Istilah Definisi

BRD Business Requirements Document, dokumen yang memuat kebutuhan bisnis
suatu proyek

PRD Product Requirements Document, dokumen yang memuat kebutuhan
<!-- Halaman 2 -->
Istilah Definisi
                 produk secara fungsional dan teknis
Warga Penduduk desa yang terdata dan menjadi pengguna aplikasi

Admin Desa Perangkat desa yang diberi wewenang mengelola konten dan data
pada aplikasi

Kepala Desa Pimpinan pemerintah desa sebagai pihak penyetuju kebijakan

BLT Bantuan Langsung Tunai, salah satu program bantuan bagi warga yang
memenuhi kriteria

NIK Nomor Induk Kependudukan

KK Kartu Keluarga

KPI Key Performance Indicator, indikator kinerja utama

1.4 Referensi

Dokumen ini disusun dengan merujuk pada Undang-Undang Nomor 6 Tahun 2014
tentang Desa, Undang-Undang Nomor 14 Tahun 2008 tentang Keterbukaan
Informasi Publik, Undang-Undang Nomor 27 Tahun 2022 tentang Pelindungan
Data Pribadi, serta panduan analisis bisnis dari BABOK Guide dan praktik
penulisan kebutuhan perangkat lunak (Wiegers & Beatty, 2013). Daftar
lengkap tersedia pada bagian Daftar Pustaka.
2. Ringkasan Eksekutif
Pemerintah desa memiliki kewajiban menyampaikan informasi kegiatan dan
layanan kepada warganya. Pada praktiknya, penyampaian informasi di
banyak desa masih mengandalkan pengumuman lisan, papan pengumuman, atau
grup percakapan yang tidak terstruktur. Pendaftaran program bantuan juga
sering dilakukan secara manual dan datang langsung ke kantor desa,
sehingga berpotensi menimbulkan antrean, kesalahan pencatatan, serta
informasi yang tidak merata.

Aplikasi mobile "Desa Ku" diusulkan sebagai sarana digital terpadu yang
memungkinkan warga melakukan registrasi, melihat dan mendaftar kegiatan
desa, mengajukan diri pada program bantuan pemerintah (misalnya bantuan
ibu hamil dan menyusui serta BLT), dan memperoleh informasi resmi desa.
Di sisi lain, perangkat desa memperoleh panel pengelolaan untuk
mengelola kegiatan, berita, dan pengajuan bantuan secara lebih tertib
dan terdokumentasi.

Dokumen ini merumuskan kebutuhan bisnis tersebut sebagai dasar
pengembangan aplikasi.
3. Latar Belakang dan Permasalahan
3.1 Latar Belakang

Transformasi digital pada pemerintahan desa mendorong pemanfaatan
teknologi informasi untuk meningkatkan kualitas pelayanan publik. Desa
sebagai unit pemerintahan terdekat dengan masyarakat
<!-- Halaman 3 -->
membutuhkan kanal komunikasi yang cepat, mudah diakses, dan dapat
dipertanggungjawabkan. Penggunaan telepon pintar yang semakin luas
membuka peluang penyampaian layanan desa melalui aplikasi mobile.

3.2 Identifikasi Permasalahan

Berdasarkan gambaran kondisi yang umum terjadi pada pelayanan desa,
permasalahan yang diidentifikasi adalah sebagai berikut.

No. Permasalahan Dampak

P-01 Informasi kegiatan desa disampaikan Sebagian warga tidak menerima
informasi tepat melalui media yang tidak terpusat waktu sehingga
partisipasi kegiatan rendah

P-02 Pendaftaran kegiatan dilakukan secara Sulit memperkirakan jumlah
peserta dan manual merekap kehadiran

P-03 Pendaftaran program bantuan dilakukan Antrean di kantor desa,
risiko kesalahan data, secara langsung dan manual dan proses verifikasi
yang lambat

P-04 Informasi syarat dan status bantuan kurang Warga kesulitan
mengetahui persyaratan dan transparan perkembangan pengajuannya

P-05 Data warga dan riwayat pengajuan tidak Pelaporan dan evaluasi
program menjadi sulit terdokumentasi secara digital

3.3 Peluang

Tersedianya aplikasi terpadu memungkinkan pemerintah desa menyampaikan
informasi secara serentak, menyederhanakan pendaftaran kegiatan dan
bantuan, serta menghasilkan data yang dapat dijadikan bahan evaluasi dan
pelaporan.
4. Tujuan Bisnis dan Sasaran Terukur
4.1 Tujuan Bisnis
1.  Meningkatkan jangkauan dan ketepatan waktu penyampaian informasi kegiatan serta
  pengumuman desa kepada warga.
2. Mempermudah warga dalam mendaftar kegiatan desa tanpa harus datang langsung.
3. Mempermudah dan mempercepat proses pengajuan program bantuan pemerintah, serta
   meningkatkan transparansi statusnya.
4.  Menyediakan pendataan digital yang tertib sebagai dasar pelaporan dan pengambilan
   keputusan pemerintah desa.
5.  Menyediakan kanal informasi resmi desa yang mudah diakses oleh seluruh warga.
4.2 Sasaran Terukur

Sasaran berikut merupakan target yang diusulkan dan dapat disesuaikan
bersama pemerintah desa.
<!-- Halaman 4 -->
Kode Sasaran Target yang Diusulkan

S-01 Warga yang terdaftar dan terverifikasi Minimal 40% kepala keluarga
dalam 6 bulan pada aplikasi setelah peluncuran

S-02 Kegiatan desa yang diumumkan melalui 100% kegiatan resmi desa
aplikasi

S-03 Pengajuan program bantuan yang Minimal 70% dari total pengajuan
pada periode diproses melalui aplikasi berikutnya

S-04 Waktu verifikasi pengajuan bantuan Berkurang dibandingkan proses
manual oleh admin (ditetapkan setelah pengukuran awal)

S-05 Tingkat kepuasan pengguna Minimal 80% responden menyatakan puas
pada survei pengguna
5. Ruang Lingkup
5.1 Dalam Ruang Lingkup (In Scope)
1.  Registrasi akun warga dan verifikasi data warga oleh admin desa.
2.  Penayangan daftar dan detail kegiatan desa, serta pendaftaran kegiatan oleh warga.
3.  Pemberitahuan (notifikasi) mengenai kegiatan dan pengumuman desa.
4.  Pendaftaran program bantuan pemerintah, mencakup informasi program, persyaratan,
   pengajuan, unggah dokumen pendukung, dan pelacakan status pengajuan.
5.  Penyampaian berita dan informasi desa.
6.  Panel pengelolaan berbasis web bagi admin desa untuk mengelola kegiatan, berita, data warga,
  dan pengajuan bantuan.
7.  Laporan rekapitulasi dasar (peserta kegiatan dan pengajuan bantuan).
5.2 Di Luar Ruang Lingkup (Out of Scope)
1.  Penyaluran atau transfer dana bantuan secara digital.
2.  Penetapan akhir penerima bantuan, yang tetap menjadi kewenangan pemerintah desa dan
   mengikuti ketentuan program yang berlaku.
3.  Layanan administrasi kependudukan seperti penerbitan surat keterangan.
4.  Pengelolaan keuangan desa.
5.  Integrasi langsung dengan sistem nasional (misalnya basis data kependudukan atau sistem
   bantuan pusat) pada tahap awal.
6. Pemangku Kepentingan
Pemangku Kepentingan Peran Kepentingan Utama

Warga Pengguna akhir Memperoleh informasi, mendaftar kegiatan, dan
aplikasi mengajukan bantuan dengan mudah
<!-- Halaman 5 -->
Pemangku Kepentingan Peran Kepentingan Utama

Admin Desa (perangkat Pengelola konten dan Mengelola kegiatan, berita,
dan verifikasi desa) data pengajuan secara efisien

Kepala Desa Penyetuju kebijakan Layanan desa yang transparan, tertib,
dan akuntabel

Pelaksana program Penyedia kriteria dan Ketepatan sasaran penerima
bantuan bantuan (pihak terkait data program di tingkat desa/kecamatan)

Pengembang Perancang dan Kejelasan kebutuhan dan ruang lingkup pembangun
aplikasi pengembangan
7. Analisis Proses Bisnis
7.1 Proses Saat Ini (As-Is)
1.  Perangkat desa menyampaikan informasi kegiatan melalui pengumuman lisan, papan informasi,
   atau pesan berantai.
2.  Warga yang ingin mengikuti kegiatan melapor langsung kepada perangkat desa atau panitia.
3.  Pada program bantuan, warga mendatangi kantor desa, menyampaikan data dan berkas secara
    langsung, kemudian menunggu proses verifikasi manual.
4.  Perangkat desa mencatat data pendaftar pada buku atau berkas terpisah.
5.  Warga mengetahui hasil pengajuan dengan bertanya langsung kepada perangkat desa.
7.2 Proses yang Diusulkan (To-Be)
1.  Admin desa mempublikasikan kegiatan dan pengumuman melalui panel pengelolaan, dan warga
  menerima notifikasi pada aplikasi.
2.  Warga melakukan registrasi dan, setelah diverifikasi admin, dapat mengakses seluruh fitur.
3.  Warga melihat daftar kegiatan dan mendaftar melalui aplikasi; admin memantau jumlah peserta
   secara langsung.
4.  Warga memilih program bantuan, memeriksa persyaratan, mengisi formulir, dan mengunggah
  dokumen pendukung melalui aplikasi.
5.  Admin memverifikasi pengajuan dan memperbarui status (diterima untuk diproses, perlu
    perbaikan, disetujui, atau ditolak disertai alasan), kemudian warga memantau status melalui
     aplikasi.
6.  Seluruh data tersimpan secara digital sehingga rekapitulasi dan pelaporan dapat dihasilkan
  dengan cepat.
7.3 Analisis Kesenjangan

Aspek Kondisi Saat Ini Kondisi yang Diharapkan
<!-- Halaman 6 -->
Aspek Kondisi Saat Ini Kondisi yang Diharapkan

Penyampaian informasi Tersebar dan tidak merata Terpusat dengan
notifikasi langsung

Pendaftaran kegiatan Manual Digital melalui aplikasi

Pengajuan bantuan Datang langsung dan Digital dengan pelacakan status
manual

Pendataan Terpisah dan tidak Terpusat dan terdokumentasi terstruktur

Transparansi Terbatas Status dan persyaratan dapat diakses warga
8. Kebutuhan Bisnis
Kebutuhan bisnis berikut dinyatakan pada tingkat tinggi. Prioritas
menggunakan skala MoSCoW: Must (wajib), Should (sebaiknya), dan Could
(dapat).

Kode Kebutuhan Bisnis Tujuan Terkait Prioritas

BR-01 Sistem harus memungkinkan warga melakukan 1, 4 Must registrasi
akun dan diverifikasi oleh admin desa agar hanya warga desa yang dapat
mengakses layanan

BR-02 Sistem harus menampilkan daftar dan detail kegiatan 1, 2 Must desa
kepada warga

BR-03 Sistem harus memungkinkan warga mendaftar kegiatan 2, 4 Must desa
dan admin melihat daftar peserta

BR-04 Sistem harus mengirimkan pemberitahuan kegiatan dan 1, 5 Must
pengumuman kepada warga

BR-05 Sistem harus menampilkan program bantuan yang 3 Must tersedia
beserta persyaratannya

BR-06 Sistem harus memungkinkan warga mengajukan diri 3 Must pada
program bantuan, termasuk bantuan ibu hamil dan menyusui serta BLT,
dengan melampirkan dokumen pendukung

BR-07 Sistem harus memungkinkan admin memverifikasi 3, 4 Must pengajuan
bantuan dan memperbarui status pengajuan

BR-08 Sistem harus menampilkan status pengajuan bantuan 3 Must kepada
warga

BR-09 Sistem harus menyediakan sarana penyampaian berita 1, 5 Must
<!-- Halaman 7 -->
Kode Kebutuhan Bisnis Tujuan Terkait Prioritas
    dan informasi resmi desa
BR-10 Sistem harus menyediakan panel pengelolaan bagi 4 Must admin desa
untuk mengelola kegiatan, berita, data warga, dan pengajuan bantuan

BR-11 Sistem harus menyediakan laporan rekapitulasi peserta 4 Should
kegiatan dan pengajuan bantuan

BR-12 Sistem harus melindungi data pribadi warga sesuai 1, 3, 4 Must
ketentuan pelindungan data pribadi

BR-13 Sistem sebaiknya dapat digunakan oleh warga dengan 1, 5 Should
tingkat literasi digital yang beragam melalui tampilan yang sederhana

BR-14 Sistem dapat menyediakan kanal pengaduan atau 5 Could masukan
warga pada pengembangan berikutnya
9. Aturan Bisnis
Kode Aturan Bisnis

AB-01 Hanya warga yang datanya telah diverifikasi admin desa yang dapat
mendaftar kegiatan dan mengajukan bantuan.

AB-02 Setiap warga hanya dapat memiliki satu akun yang terhubung dengan
satu NIK.

AB-03 Setiap program bantuan memiliki persyaratan yang ditetapkan oleh
pemerintah desa sesuai ketentuan program dan harus ditampilkan sebelum
warga mengajukan.

AB-04 Pengajuan bantuan hanya berstatus permohonan; keputusan penerima
bantuan ditetapkan oleh pemerintah desa dan bukan oleh sistem.

AB-05 Penolakan atau permintaan perbaikan pengajuan harus disertai
alasan yang dapat dilihat warga.

AB-06 Hanya admin yang berwenang yang dapat menerbitkan kegiatan,
berita, dan mengubah status pengajuan.

AB-07 Data pribadi warga hanya digunakan untuk keperluan layanan desa
dan tidak dibagikan kepada pihak yang tidak berwenang.
10. Asumsi, Batasan, dan Ketergantungan
10.1 Asumsi
1.  Sebagian besar warga sasaran memiliki telepon pintar dan akses internet yang memadai.
<!-- Halaman 8 -->
2. Pemerintah desa bersedia menunjuk admin yang bertugas mengelola
   konten dan verifikasi secara berkala.
   3. Data kependudukan warga dapat diperoleh dari pemerintah desa
      untuk keperluan verifikasi.
   4. Persyaratan program bantuan disediakan oleh pemerintah desa atau
      pihak pelaksana program.
10.2 Batasan
1.  Aplikasi dirancang untuk satu desa pada tahap awal.
2.  Pengembangan dibatasi oleh sumber daya waktu dan tenaga pengembang.
3.  Aplikasi tidak menggantikan prosedur resmi penetapan penerima bantuan.
10.3 Ketergantungan
1.  Dukungan dan persetujuan Kepala Desa serta perangkat desa.
2.  Ketersediaan data dan persyaratan program bantuan.
3.  Ketersediaan infrastruktur server dan layanan notifikasi.
11. Analisis Risiko
Kode Risiko Kemungkinan Dampak Strategi Mitigasi

R-01 Rendahnya adopsi warga Sedang Tinggi Antarmuka sederhana, karena
keterbatasan literasi sosialisasi, dan pendampingan digital di kantor
desa

R-02 Kebocoran atau Rendah Tinggi Pembatasan hak akses, penyalahgunaan
data pribadi enkripsi, dan kebijakan pengelolaan data

R-03 Admin desa tidak konsisten Sedang Sedang Penetapan penanggung jawab
memperbarui konten dan dan pelatihan admin memverifikasi pengajuan

R-04 Keterbatasan koneksi Sedang Sedang Desain ringan dan internet di
wilayah desa penyimpanan sementara informasi penting

R-05 Salah paham bahwa Sedang Sedang Penjelasan jelas pada aplikasi
pendaftaran di aplikasi bahwa pengajuan bersifat menjamin penerimaan
permohonan bantuan

R-06 Ketidaksesuaian persyaratan Rendah Sedang Konfigurasi persyaratan
program dengan perubahan program dapat diperbarui oleh kebijakan admin
<!-- Halaman 9 -->
12. Indikator Keberhasilan (KPI)
Kode Indikator Cara Pengukuran Target yang Diusulkan

K-01 Jumlah warga terdaftar dan Data pada panel admin Sesuai sasaran
S-01 terverifikasi

K-02 Persentase kegiatan yang Perbandingan kegiatan di 100% diumumkan
melalui aplikasi aplikasi dengan seluruh kegiatan resmi

K-03 Jumlah pendaftar per kegiatan Rekapitulasi pendaftaran Meningkat
dibandingkan periode sebelum aplikasi

K-04 Persentase pengajuan bantuan Data pengajuan pada sistem Sesuai
sasaran S-03 melalui aplikasi

K-05 Rata-rata waktu verifikasi Selisih waktu pengajuan dan Lebih
singkat dari pengajuan pembaruan status proses manual

K-06 Tingkat kepuasan pengguna Survei pengguna Minimal 80% puas
13. Analisis Manfaat
Manfaat yang diharapkan dari implementasi aplikasi "Desa Ku" diuraikan
secara kualitatif sebagai berikut.

Pemangku Kepentingan Manfaat

Warga Informasi lebih cepat dan merata, pendaftaran kegiatan dan bantuan
tanpa antrean, serta kejelasan status pengajuan

Admin Desa Pengelolaan data lebih tertib, beban pencatatan manual
berkurang, dan rekapitulasi lebih cepat

Kepala Desa Pelayanan yang lebih transparan, data pendukung pengambilan
keputusan, dan peningkatan citra pelayanan desa

Estimasi biaya pengembangan dan operasional (pengembangan aplikasi,
server, layanan notifikasi, serta pelatihan admin) akan dirinci pada
tahap perencanaan proyek berikutnya sesuai pilihan teknologi dan sumber
daya yang digunakan.
14. Rencana Implementasi
Implementasi diusulkan secara bertahap sebagai berikut.

Tahap Kegiatan Keluaran
1. Persiapan Penyepakatan kebutuhan dengan pemerintah desa, BRD dan PRD
   yang
<!-- Halaman 10 -->
Tahap Kegiatan Keluaran
              pengumpulan data dan persyaratan program           disetujui
2. Perancangan Perancangan antarmuka, alur pengguna, dan basis
   Prototipe dan data rancangan sistem
3. Pengembangan Pembangunan aplikasi mobile dan panel admin Aplikasi
   versi MVP
4. Pengujian Pengujian fungsional dan uji penerimaan pengguna Laporan
   pengujian
5. Peluncuran Pelatihan admin dan uji coba kepada sebagian Umpan balik
   pengguna Terbatas warga
6. Peluncuran Peluncuran kepada seluruh warga dan pengukuran Laporan
   evaluasi Penuh dan Evaluasi KPI
7. Kriteria Penerimaan dan Persetujuan
15.1 Kriteria Penerimaan
1.  Seluruh kebutuhan bisnis berprioritas Must (BR-01 sampai BR-10 dan BR-12) berfungsi sesuai
    deskripsi.
2.  Warga dapat menyelesaikan alur registrasi, pendaftaran kegiatan, dan pengajuan bantuan tanpa
   bantuan teknis.
3.  Admin desa dapat mengelola kegiatan, berita, dan verifikasi pengajuan melalui panel
   pengelolaan.
4.  Data pribadi warga terlindungi sesuai kebijakan akses yang ditetapkan.
5.  Aplikasi lolos uji penerimaan pengguna bersama perwakilan pemerintah desa.
Daftar Pustaka

International Institute of Business Analysis. (2015). A guide to the
business analysis body of knowledge (BABOK Guide) (Version 3). IIBA.

Republik Indonesia. (2008). Undang-Undang Nomor 14 Tahun 2008 tentang
Keterbukaan Informasi Publik.

Republik Indonesia. (2014). Undang-Undang Nomor 6 Tahun 2014 tentang
Desa.

Republik Indonesia. (2022). Undang-Undang Nomor 27 Tahun 2022 tentang
Pelindungan Data Pribadi.

Wiegers, K., & Beatty, J. (2013). Software requirements (3rd ed.).
Microsoft Pr