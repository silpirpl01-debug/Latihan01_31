import "package:flutter/material.dart";

//FUNGSI UNTUK MENGHITUNG TOTAL BELANJA
double hitungTotal(int jumlah, double harga) {
  return jumlah * harga;
}

// FUNGSI MENGHTUNG TOTAL AKHIR SETELAH POTONGAN
double hitungHargaAkhir(double total, double persenPotongan) {
  return total - (total * persenPotongan / 100);
}

void main() {
  //Data transaksi 
  int jumlah = 5;
  double harga = 3000;

  //memanggil fungsi 
  double total = hitungTotal(jumlah, harga);

  //menentukan potongan sesuai aturan koperasi
  double potongan;

  if  (total > 200000) {
    potongan = 10;
  } else if (total > 100000) {
    potongan = 5;
  } else {
    potongan = 0;
  }

  // Menghitung harga akhir setelah potongan
  double hargaAkhir = hitungHargaAkhir(total, potongan);

  //Menampilkan hasil total belanja
  print("=== TRANSAKSI KOPERASI ===");
  print("Jumlah Barang : $jumlah");
  print("Harga Satuan : Rp${harga.toStringAsFixed(0)}");
  print("Total Belanja : Rp${total.toStringAsFixed(0)}");
  print("Potongan : $potongan%");
  print("Total Bayar : Rp${hargaAkhir.toStringAsFixed(0)}");
}

/*
Program dibagi menjadi fungsi agar lebih mudah dipelihara. Jika aturan potongan berubah, cukup mengubah fungsi hitungHargaAkhir() atau logika penentuan potongan satu kali saja sehingga seluruh program langsung mengikuti aturan baru.
*/