import "package:flutter/material.dart";

class Barang {
  String nama;
  double harga;
  int _stok;

  // Constructor untuk mengisi data barang.
  Barang(this.nama, this.harga, this._stok);

  // Getter untuk membaca stok.
  int get stok {
    return _stok;
  }

  // Stok hanya dapat berkurang melalui method jual().
  bool jual(int n) {
    if (_stok >= n) {
      _stok -= n;
      return true;
    } else {
      return false;
    }
  }

  // Menghitung nilai seluruh stok.
  double nilaiStok() {
    return harga * _stok;
  }

  // Mengecek apakah stok mencukupi.
  bool bisaDijual(int diminta) {
    return _stok >= diminta;
  }

  // Method untuk menampilkan informasi barang.
  void tampilkan() {
    print("========================");
    print("KARTU BARANG");
    print("Nama  : $nama");
    print("Harga : Rp${harga.toStringAsFixed(0)}");
    print("Stok  : $stok");
    print("Nilai Stok : Rp${nilaiStok().toStringAsFixed(0)}");
    print("========================");
  }
}


// ================= BARANG PROMO =================

class BarangPromo extends Barang {
  double persenDiskon;

  BarangPromo(
    String nama,
    double harga,
    int stok,
    this.persenDiskon,
  ) : super(nama, harga, stok);

  // Menghitung harga setelah diskon.
  double hargaPromo() {
    return harga - (harga * persenDiskon / 100);
  }

  // Override method tampilkan() dari class Barang.
  @override
  void tampilkan() {
    print("========================");
    print("KARTU BARANG PROMO");
    print("Label        : PROMO");
    print("Nama         : $nama");
    print("Harga Coret  : Rp${harga.toStringAsFixed(0)}");
    print("Diskon       : $persenDiskon%");
    print("Harga Promo  : Rp${hargaPromo().toStringAsFixed(0)}");
    print("Stok         : $stok");
    print("========================");
  }
}


// ================= BARANG GROSIR =================

class BarangGrosir extends Barang {
  int minimalPembelian;

  BarangGrosir(
    String nama,
    double harga,
    int stok,
    this.minimalPembelian,
  ) : super(nama, harga, stok);

  // Mengecek apakah pembelian memenuhi minimal grosir.
  bool bisaGrosir(int jumlah) {
    return jumlah >= minimalPembelian;
  }

  // Override method tampilkan() dari class Barang.
  @override
  void tampilkan() {
    print("========================");
    print("KARTU BARANG GROSIR");
    print("Nama              : $nama");
    print("Harga             : Rp${harga.toStringAsFixed(0)}");
    print("Stok              : $stok");
    print("Minimal Pembelian : $minimalPembelian");
    print("========================");
  }
}


// ================= PEMBELI =================

class Pembeli {
  String nama;
  bool statusAnggota;

  // Constructor untuk mengisi data pembeli.
  Pembeli(this.nama, this.statusAnggota);

  // Menampilkan informasi pembeli.
  void tampilkanInfo() {
    print("========================");
    print("DATA PEMBELI");
    print("Nama : $nama");
    print(
      "Status Anggota : ${statusAnggota ? "Anggota" : "Bukan Anggota"}",
    );
    print("========================");
  }
}

void prosesBeli(String inputjumlah){
  try {
    int jumlah = int.parse(inputjumlah);

    print("jumlah pembeli : $jumlah");
    print("input jumlah berhasil diproses.");
  } catch (e) {
    print("input jumlah tidak valid. Silahkan masukkan angka.");
  } finally{
    print("transaksi dicatat di log.");
  }
}

// ================= MAIN =================

void main() {

  Barang barang1 = Barang("Buku Tulis", 3000, 20);
  Barang barang2 = Barang("Pulpen", 2500, 15);
  Barang barang3 = Barang("Roti", 5000, 10);
  barang1._stok = 100;
  // Menyimpan barang dalam List.
  List<Barang> daftarBarang = [
    barang1,
    barang2,
    barang3,
  ];

  print("=== DAFTAR BARANG KOPERASI ===");

  for (int i = 0; i < daftarBarang.length; i++) {
    print(
      "${i + 1}. ${daftarBarang[i].nama} - "
      "Rp${daftarBarang[i].harga.toStringAsFixed(0)} "
      "- Stok: ${daftarBarang[i].stok}",
    );
  }


  print("");
  print("=== KARTU BARANG ===");

  for (Barang barang in daftarBarang) {
    barang.tampilkan();
  }


  print("");
  print("=== DATA PEMBELI ===");

  Pembeli pembeli1 = Pembeli("Silvi", true);

  pembeli1.tampilkanInfo();


  print("");
  print("=== CEK STOK PENJUALAN ===");

  int diminta = 10;

  if (barang1.bisaDijual(diminta)) {
    print("Buku Tulis bisa dijual sebanyak $diminta.");
  } else {
    print("Stok Buku Tulis tidak mencukupi.");
  }


  print("");
  print("=== BARANG PROMO ===");

  // Membuat objek BarangPromo.
  BarangPromo promo1 = BarangPromo(
    "Buku Gambar",
    10000,
    10,
    20,
  );

  // Memanggil method tampilkan() hasil override.
  promo1.tampilkan();


  print("");
  print("=== BARANG GROSIR ===");

  // Membuat objek BarangGrosir.
  BarangGrosir grosir1 = BarangGrosir(
    "Pulpen",
    2500,
    50,
    10,
  );

  // Memanggil method tampilkan() hasil override.
  grosir1.tampilkan();

  // Mengecek minimal pembelian grosir.
  if (grosir1.bisaGrosir(15)) {
    print("Pembelian 15 Pulpen memenuhi syarat grosir.");
  } else {
    print("Pembelian belum memenuhi minimal grosir.");
  }


  print("");
  print("=== UJI ENKAPSULASI DAN PENJUALAN ===");

  print("Stok awal Buku Tulis : ${barang1.stok}");

  // Menjual 5 Buku Tulis.
  if (barang1.jual(5)) {
    print("Penjualan 5 Buku Tulis berhasil.");
  } else {
    print("Penjualan 5 Buku Tulis gagal.");
  }

  print("Stok setelah penjualan : ${barang1.stok}");

  // Mencoba menjual lebih banyak dari stok.
  if (barang1.jual(20)) {
    print("Penjualan 20 Buku Tulis berhasil.");
  } else {
    print("Penjualan 20 Buku Tulis gagal, stok tidak mencukupi.");
  }

  print("Stok akhir Buku Tulis : ${barang1.stok}");

  print("");
  print("=== UJI VALIDASI ANGKA ===");
  prosesBeli("5");
  prosesBeli("dua");
  prosesBeli("abc");
}
// Penanganan galat membuat program tidak langsung berhenti saat terjadi kesalahan input.
// Sistem memberikan pesan yang jelas dan tetap melanjutkan proses,
// sehingga transaksi lebih aman dan pengurus lebih percaya pada sistem.