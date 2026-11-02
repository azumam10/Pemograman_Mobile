import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Root aplikasi: MaterialApp dengan RingkasanPage sebagai halaman utama.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabungku Layout',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const RingkasanPage(),
    );
  }
}

// Halaman Ringkasan Tabungan (data statis/hardcode).
class RingkasanPage extends StatelessWidget {
  const RingkasanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar dengan judul halaman.
      appBar: AppBar(title: const Text('Ringkasan Tabungan')),
      // SingleChildScrollView mencegah overflow saat layar pendek/landscape.
      body: SingleChildScrollView(
        // Jarak 16 di seluruh sisi body.
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kartu ringkasan tabungan.
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  // Column rata kiri: nama, lalu baris saldo dan target.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nama tabungan (tebal).
                      const Text(
                        'Tabungan Laptop',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Baris Saldo: label di kiri, nilai di kanan.
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Saldo'),
                          Text('Rp 2.500.000'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Baris Target: label di kiri, nilai di kanan.
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Target'),
                          Text('Rp 10.000.000'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Baris 3 tombol ringkasan dengan lebar rata (Expanded).
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: _AksiItem(icon: Icons.add_circle, label: 'Tambah'),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: _AksiItem(icon: Icons.remove_circle, label: 'Tarik'),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: _AksiItem(icon: Icons.history, label: 'Riwayat'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Satu item aksi: Container berisi Column (Icon di atas, Text di bawah).
class _AksiItem extends StatelessWidget {
  const _AksiItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    return Container(
      // Padding dalam kotak agar ikon & teks tidak mepet.
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: warna.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: warna.onPrimaryContainer),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: warna.onPrimaryContainer)),
        ],
      ),
    );
  }
}
