import 'package:flutter/material.dart';

void main() {
  int stok = 3;

  print("--- Penjualan Buku Tulis ---");

  while (stok > 0) {
    stok--;
    print("Terjual 1, sisa stok: $stok");
  }

  // Bahaya jika kondisi berhenti pada while keliru:
  // Program dapat terus berjalan tanpa henti (infinite loop)
  // atau menjual barang melebihi stok yang tersedia.
  //
  // Cara memastikan koperasi tidak menjual melebihi stok:
  // Gunakan kondisi while (stok > 0) dan kurangi nilai stok
  // setiap kali terjadi penjualan (stok--), sehingga penjualan
  // akan berhenti saat stok mencapai 0.
}