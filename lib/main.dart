import "package:flutter/material.dart";

class Barang {
  String nama;
  double harga;
  int stok;

  // Constructor digunakan untuk mengisi data awal setiap barang.
  Barang(this.nama, this.harga, this.stok);

  double nilaiStok(){
    return harga * stok;
  }

  // Fungsi ini digunakan untuk mencetak informasi lengkap barang.
  void tampilkan() {
    print("========================");
    print("KARTU BARANG");
    print("Nama  : $nama");
    print("Harga : Rp${harga.toStringAsFixed(0)}");
    print("Stok  : $stok");
    print("nilai stok : Rp${nilaiStok().toStringAsFixed(0)}");
    print("========================");
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
}