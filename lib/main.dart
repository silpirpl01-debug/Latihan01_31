import "package:flutter/material.dart";

class Barang {
  String nama;
  double harga;
  int stok;

  Barang(this.nama, this.harga, this.stok);

  void tampilkan() {
    print("====================");
    print("KARTU BARANG");
    print("Nama  : $nama");
    print("Harga : Rp${harga.toStringAsFixed(0)}");
    print("Stok  : $stok");
    print("====================");
  }
}

void main() {
  Barang barang1 = Barang("Buku tulis", 3000, 20);
  Barang barang2 = Barang("Pulpen", 2500, 15);
  Barang barang3 = Barang("Roti", 5000, 10);

  print("=== DATA BARANG KOPERASI ===");

  List<Barang> daftarBarang = [
    barang1,
    barang2,
    barang3,
  ];

  for (Barang barang in daftarBarang) {
    barang.tampilkan();
  }
}
/*
  Perbedaan dari Sprint 3:
  Sebelumnya, data nama dan harga barang dibuat dalam List yang berbeda,
  sehingga setiap data masih terpisah. Pada Sprint ini, informasi barang
  seperti nama, harga, dan stok disatukan ke dalam class Barang.
  Setiap barang kemudian disimpan dalam satu List<Barang>, sehingga
  struktur data menjadi lebih teratur dan hubungan antar data lebih jelas.
*/