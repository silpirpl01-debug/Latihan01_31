import "package:flutter/material.dart";

// ================= BARANG =================

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
    if (n <= 0) {
      return false;
    }

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
    return diminta > 0 && _stok >= diminta;
  }

  // Method untuk mendapatkan harga jual.
  double hargaJual(int jumlah) {
    return harga;
  }

  // Method untuk mendapatkan potongan barang.
  double potonganBarang(int jumlah) {
    return 0;
  }

  // Method untuk menampilkan informasi barang.
  void tampilkan() {
    print("========================");
    print("KARTU BARANG");
    print("Nama       : $nama");
    print("Harga      : Rp${harga.toStringAsFixed(0)}");
    print("Stok       : $stok");
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

  // Menghitung harga setelah diskon promo.
  @override
  double hargaJual(int jumlah) {
    return harga - (harga * persenDiskon / 100);
  }

  // Potongan promo per barang.
  @override
  double potonganBarang(int jumlah) {
    return harga * persenDiskon / 100;
  }

  // Menghitung harga promo.
  double hargaPromo() {
    return hargaJual(1);
  }

  // Override method tampilkan().
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
  double persenDiskonGrosir;

  BarangGrosir(
    String nama,
    double harga,
    int stok,
    this.minimalPembelian,
  )   : persenDiskonGrosir = 5,
        super(nama, harga, stok);

  // Mengecek apakah pembelian memenuhi minimal grosir.
  bool bisaGrosir(int jumlah) {
    return jumlah >= minimalPembelian;
  }

  // Harga jual menyesuaikan pembelian grosir.
  @override
  double hargaJual(int jumlah) {
    if (bisaGrosir(jumlah)) {
      return harga - (harga * persenDiskonGrosir / 100);
    }

    return harga;
  }

  // Potongan harga grosir per barang.
  @override
  double potonganBarang(int jumlah) {
    if (bisaGrosir(jumlah)) {
      return harga * persenDiskonGrosir / 100;
    }

    return 0;
  }

  // Override method tampilkan().
  @override
  void tampilkan() {
    print("========================");
    print("KARTU BARANG GROSIR");
    print("Nama              : $nama");
    print("Harga             : Rp${harga.toStringAsFixed(0)}");
    print("Stok              : $stok");
    print("Minimal Pembelian : $minimalPembelian");
    print("Diskon Grosir     : $persenDiskonGrosir%");
    print("========================");
  }
}

// ================= PEMBELI =================

class Pembeli {
  String nama;
  bool statusAnggota;

  // Constructor untuk mengisi data pembeli.
  Pembeli(this.nama, this.statusAnggota);

  // Diskon tambahan untuk anggota koperasi.
  double persenDiskonAnggota() {
    if (statusAnggota) {
      return 10;
    }

    return 0;
  }

  // Menampilkan informasi pembeli.
  void tampilkanInfo() {
    print("========================");
    print("DATA PEMBELI");
    print("Nama : $nama");
    print(
      "Status Anggota : ${statusAnggota ? "Anggota" : "Bukan Anggota"}",
    );
    print("Diskon Anggota : ${persenDiskonAnggota()}%");
    print("========================");
  }
}

// ================= PROSES TRANSAKSI =================

void prosesBeli(
  String inputJumlah,
  Barang barang,
  Pembeli pembeli,
) {
  try {
    // Mengubah input string menjadi integer.
    int jumlah = int.parse(inputJumlah);

    // Validasi jumlah.
    if (jumlah <= 0) {
      print("Jumlah pembelian harus lebih dari 0.");
      return;
    }

    // Validasi stok.
    if (!barang.bisaDijual(jumlah)) {
      throw Exception(
        "Stok ${barang.nama} tidak mencukupi. "
        "Stok tersedia: ${barang.stok}.",
      );
    }

    // Menentukan harga jual per barang.
    double hargaSatuan = barang.hargaJual(jumlah);

    // Menghitung subtotal.
    double subtotal = hargaSatuan * jumlah;

    // Menghitung potongan barang/promo/grosir.
    double potonganBarang =
        barang.potonganBarang(jumlah) * jumlah;

    // Menghitung potongan anggota.
    double persenAnggota = pembeli.persenDiskonAnggota();
    double potonganAnggota =
        subtotal * persenAnggota / 100;

    // Total potongan.
    double totalPotongan =
        potonganBarang + potonganAnggota;

    // Total yang harus dibayar.
    double totalBayar =
        subtotal - potonganAnggota;

    // Mengurangi stok setelah transaksi berhasil.
    bool berhasil = barang.jual(jumlah);

    if (!berhasil) {
      throw Exception("Transaksi gagal karena stok tidak mencukupi.");
    }

    print("");
    print("========================");
    print("DETAIL TRANSAKSI");
    print("========================");
    print("Pembeli          : ${pembeli.nama}");
    print("Status           : "
        "${pembeli.statusAnggota ? "Anggota" : "Bukan Anggota"}");
    print("Barang           : ${barang.nama}");
    print("Jumlah           : $jumlah");
    print("Harga Satuan     : Rp${hargaSatuan.toStringAsFixed(0)}");
    print("Subtotal         : Rp${subtotal.toStringAsFixed(0)}");
    print("Potongan Barang  : Rp${potonganBarang.toStringAsFixed(0)}");
    print("Potongan Anggota : Rp${potonganAnggota.toStringAsFixed(0)}");
    print("Total Potongan   : Rp${totalPotongan.toStringAsFixed(0)}");
    print("Total Bayar      : Rp${totalBayar.toStringAsFixed(0)}");
    print("Stok Sekarang    : ${barang.stok}");
    print("========================");
    print("Transaksi berhasil.");
  } catch (e) {
    print("");
    print("TERJADI GALAT:");
    print(e);
  } finally {
    // Transaksi tetap dicatat meskipun terjadi kesalahan.
    print("Transaksi dicatat di log.");
  }
}

// ================= ASYNC LAPORAN =================

// Fungsi async untuk memuat laporan penjualan.
Future<void> muatLaporan() async {
  print("");
  print("=== MEMUAT LAPORAN ===");
  print("Menyiapkan laporan...");

  // Simulasi proses mengambil data selama 1 detik.
  await Future.delayed(Duration(seconds: 1));

  print("Laporan siap!");
}

// ================= MAIN =================

Future<void> main() async {
  try {
    // ================= LANGKAH 1: MUAT LAPORAN =================

    print("");
    print("================================");
    print(" SISTEM KASIR BRANTAS MART");
    print("================================");

    await muatLaporan();

    // ================= LANGKAH 2: DATA BARANG =================

    Barang barang1 = Barang(
      "Buku Tulis",
      3000,
      100,
    );

    Barang barang2 = Barang(
      "Pulpen",
      2500,
      15,
    );

    Barang barang3 = Barang(
      "Roti",
      5000,
      10,
    );

    BarangPromo promo1 = BarangPromo(
      "Buku Gambar",
      10000,
      10,
      20,
    );

    BarangGrosir grosir1 = BarangGrosir(
      "Pulpen Grosir",
      2500,
      50,
      10,
    );

    // Menyimpan semua barang dalam List.
    List<Barang> daftarBarang = [
      barang1,
      barang2,
      barang3,
      promo1,
      grosir1,
    ];

    // ================= LANGKAH 3: TAMPILKAN BARANG =================

    print("");
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

    // ================= LANGKAH 4: DATA PEMBELI =================

    print("");
    print("=== DATA PEMBELI ===");

    Pembeli pembeli1 = Pembeli(
      "Silvi",
      true,
    );

    pembeli1.tampilkanInfo();

    // ================= LANGKAH 5: CEK PROMO =================

    print("");
    print("=== CEK BARANG PROMO ===");

    promo1.tampilkan();

    // ================= LANGKAH 6: CEK GROSIR =================

    print("");
    print("=== CEK BARANG GROSIR ===");

    grosir1.tampilkan();

    int jumlahGrosir = 15;

    if (grosir1.bisaGrosir(jumlahGrosir)) {
      print(
        "Pembelian $jumlahGrosir ${grosir1.nama} "
        "memenuhi syarat grosir.",
      );
    } else {
      print(
        "Pembelian $jumlahGrosir ${grosir1.nama} "
        "belum memenuhi minimal grosir.",
      );
    }

    // ================= LANGKAH 7: PROSES TRANSAKSI =================

    print("");
    print("=== PROSES 1 TRANSAKSI ===");

    // Pembeli membeli 5 Buku Tulis.
    prosesBeli(
      "5",
      barang1,
      pembeli1,
    );

    // ================= LANGKAH 8: UJI SALAH INPUT =================

    print("");
    print("=== UJI SALAH INPUT ===");

    // Input bukan angka.
    prosesBeli(
      "dua",
      barang1,
      pembeli1,
    );

    // Input melebihi stok.
    prosesBeli(
      "200",
      barang1,
      pembeli1,
    );

    // Input nol.
    prosesBeli(
      "0",
      barang1,
      pembeli1,
    );

    // ================= LANGKAH 9: TAMPILKAN STOK AKHIR =================

    print("");
    print("=== STOK AKHIR ===");

    for (Barang barang in daftarBarang) {
      print(
        "${barang.nama} : ${barang.stok}",
      );
    }

    // ================= SELESAI =================

    print("");
    print("================================");
    print(" PROGRAM SELESAI");
    print("================================");
  } catch (e) {
    // Menangani galat runtime agar program tidak langsung berhenti.
    print("");
    print("Terjadi galat runtime: $e");
    print("Program tetap dapat memberikan informasi kesalahan.");
  }
}