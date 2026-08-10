import "package:flutter/material.dart";

class barang {
  String nama;
  double harga;
  int stok;

  barang(this.nama, this.harga, this.stok);

  void tampilkaninfo(){
    print("====================");
    print("KARTU BARANG");
    print("Nama : $nama");
    print("Harga  : Rp$harga.toStringAsFixed(0}");
    print("stok : $stok");
     print("====================");
  }
}

void main() {
  barang barang1 = barang("Buku tulis", 3000, 20);
  barang barang2 = barang("pulpen", 2500, 15);
  barang barang3 = barang("roti", 5000, 10);
  print("=== DATA BARANG KOPERASI ===");
  barang1.tampilkaninfo();
  barang2.tampilkaninfo();
  barang3.tampilkaninfo();
}