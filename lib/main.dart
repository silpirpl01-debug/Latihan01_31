import "package:flutter/material.dart";

class Barang {
  String nama;
  double harga;
  int stok;

  // Constructor digunakan untuk mengisi data awal setiap barang.
  Barang(this.nama, this.harga, this.stok);

  double nilaiStok() {
    return harga * stok;
  }

  // Mengecek apakah stok cukup untuk jumlah yang diminta.
  bool bisaDijual(int diminta) {
    return stok >= diminta;
  }

  // Fungsi ini digunakan untuk mencetak informasi lengkap barang.
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

class pembeli {
  String nama;
  bool statusAnggota;

  pembeli(this.nama, this.statusAnggota);

  void tampilkaninfo() {
    print("=====================");
    print("DATA PEMBELI");
    print("Nama: $nama");
    print("status anggota : ${statusanggota ? "anggota" : "bukan anggota"}");
    print("=====================");
  }
}

void main() {
  // Membuat tiga data barang menggunakan class Barang.
  Barang barang1 = Barang("Buku Tulis", 3000, 20);
  Barang barang2 = Barang("Pulpen", 2500, 15);
  Barang barang3 = Barang("Roti", 5000, 10);

  // Mengumpulkan seluruh objek barang ke dalam satu List.
  List<Barang> daftarBarang = [
    barang1,
    barang2,
    barang3,
  ];

  print("=== DAFTAR BARANG KOPERASI ===");

  // Melakukan perulangan untuk menampilkan data setiap barang.
  for (int i = 0; i < daftarBarang.length; i++) {
    print(
      "${i + 1}. ${daftarBarang[i].nama} - "
      "Rp${daftarBarang[i].harga.toStringAsFixed(0)} "
      "- Stok: ${daftarBarang[i].stok}",
    );
  }

  print("");
  print("=== KARTU BARANG ===");

  // Menjalankan method tampilkan() untuk semua barang dalam List.
  for (Barang barang in daftarBarang) {
    barang.tampilkan();
  }

  print("");
  print("=== CEK STOK PENJUALAN ===");

  int diminta = 10;

  if (barang1.bisaDijual(diminta)) {
    print("Buku Tulis bisa dijual sebanyak $diminta.");
  } else {
    print("Stok Buku Tulis tidak mencukupi.");
  }
}