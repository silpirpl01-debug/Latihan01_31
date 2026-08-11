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

  // Method untuk menjual barang.
  // Stok hanya berkurang jika jumlah yang diminta mencukupi.
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

  // Mengecek apakah stok cukup untuk jumlah yang diminta.
  bool bisaDijual(int diminta) {
    return _stok >= diminta;
  }

  // Menampilkan informasi barang.
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

// BarangPromo merupakan turunan dari class Barang.
class BarangPromo extends Barang {
  double persenDiskon;

  // Constructor menggunakan super().
  BarangPromo(
    String nama,
    double harga,
    int stok,
    this.persenDiskon,
  ) : super(nama, harga, stok);

  // Menghitung harga setelah mendapatkan diskon.
  double hargaPromo() {
    return harga - (harga * persenDiskon / 100);
  }

  // Menampilkan informasi barang promo.
  void tampilkanPromo() {
    print("========================");
    print("KARTU BARANG PROMO");
    print("Nama         : $nama");
    print("Harga Normal : Rp${harga.toStringAsFixed(0)}");
    print("Stok         : $stok");
    print("Diskon       : $persenDiskon%");
    print("Harga Promo  : Rp${hargaPromo().toStringAsFixed(0)}");
    print("========================");
  }
}

// Class Pembeli dengan status anggota menggunakan bool.
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

void main() {
  // Membuat data barang.
  Barang barang1 = Barang("Buku Tulis", 3000, 20);
  Barang barang2 = Barang("Pulpen", 2500, 15);
  Barang barang3 = Barang("Roti", 5000, 10);

  // Menyimpan barang dalam List.
  List<Barang> daftarBarang = [
    barang1,
    barang2,
    barang3,
  ];

  print("=== DAFTAR BARANG KOPERASI ===");

  // Menampilkan daftar barang.
  for (int i = 0; i < daftarBarang.length; i++) {
    print(
      "${i + 1}. ${daftarBarang[i].nama} - "
      "Rp${daftarBarang[i].harga.toStringAsFixed(0)} "
      "- Stok: ${daftarBarang[i].stok}",
    );
  }

  print("");
  print("=== KARTU BARANG ===");

  // Menampilkan informasi setiap barang.
  for (Barang barang in daftarBarang) {
    barang.tampilkan();
  }

  print("");
  print("=== DATA PEMBELI ===");

  // Membuat objek Pembeli.
  Pembeli pembeli1 = Pembeli("Silvi", true);

  // Menampilkan data pembeli.
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

  // Membuat satu objek BarangPromo.
  BarangPromo promo1 = BarangPromo(
    "Buku Gambar",
    10000,
    10,
    20,
  );

  // Menampilkan informasi barang promo.
  promo1.tampilkanPromo();

  print("");
  print("=== UJI ENKAPSULASI DAN PENJUALAN ===");

  // Membaca stok melalui getter.
  print("Stok awal Buku Tulis : ${barang1.stok}");

  // Menjual 5 barang.
  if (barang1.jual(5)) {
    print("Penjualan 5 Buku Tulis berhasil.");
  } else {
    print("Penjualan 5 Buku Tulis gagal.");
  }

  print("Stok setelah penjualan : ${barang1.stok}");

  // Mencoba menjual lebih banyak dari stok yang tersedia.
  if (barang1.jual(20)) {
    print("Penjualan 20 Buku Tulis berhasil.");
  } else {
    print("Penjualan 20 Buku Tulis gagal, stok tidak mencukupi.");
  }

  print("Stok akhir Buku Tulis : ${barang1.stok}");
}

// Melindungi _stok penting untuk menjaga integritas data koperasi.
// Dengan _stok, perubahan stok tidak dapat dilakukan sembarangan dari luar class.
// Stok hanya dapat berkurang melalui method jual() jika jumlahnya mencukupi.
// Dengan begitu, stok tidak mudah menjadi salah atau negatif dan data koperasi tetap akurat.