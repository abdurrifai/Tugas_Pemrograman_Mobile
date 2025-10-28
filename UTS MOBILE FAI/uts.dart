import 'dart:math';

abstract class Transportasi {
  String id;
  String nama;
  double _tarifDasar;
  int kapasitas; 

  Transportasi(this.id, this.nama, this._tarifDasar, this.kapasitas);

  double get tarifDasar => _tarifDasar;
  double hitungTarif(int jumlahPenumpang);
  void tampilInfo() {
    print('ID: $id');
    print('Nama: $nama');
    print('Tarif Dasar: Rp${_tarifDasar.toStringAsFixed(0)}');
    print('Kapasitas: $kapasitas orang');
  }
}

class Taksi extends Transportasi {
  double jarak; // km
  Taksi(String id, String nama, double tarifDasar, int kapasitas, this.jarak)
      : super(id, nama, tarifDasar, kapasitas);

double hitungTarif(int jumlahPenumpang) {
    return tarifDasar * jarak;
  }

  void tampilInfo() {
    super.tampilInfo();
    print('Jenis: Taksi');
    print('Jarak: $jarak km');
    print('----------------------------');
  }
}

class Bus extends Transportasi {
  bool adaWifi;
  Bus(String id, String nama, double tarifDasar, int kapasitas, this.adaWifi)
      : super(id, nama, tarifDasar, kapasitas); 

  double hitungTarif(int jumlahPenumpang) {
    double total = (tarifDasar * jumlahPenumpang) + (adaWifi ? 5000 : 0);
    return total;
}

void tampilInfo() {
    super.tampilInfo();
    print('Jenis: Bus');
    print('Ada Wifi: ${adaWifi ? "Ya" : "Tidak"}');
    print('----------------------------');
  }
}

class Pesawat extends Transportasi {
  String kelasPenerbangan; // Ekonomi ataun Bisnis
  Pesawat(String id, String nama, double tarifDasar, int kapasitas, this.kelasPenerbangan)
      : super(id, nama, tarifDasar, kapasitas);

  double hitungTarif(int jumlahPenumpang) {
    double faktor = (kelasPenerbangan == "Bisnis") ? 1.5 : 1.0;
    return tarifDasar * jumlahPenumpang * faktor;
}

  void tampilInfo() {
    super.tampilInfo();
    print('Jenis: Pesawat');
    print('Kelas: $kelasPenerbangan');
    print('----------------------------');
  }
}

class Pemesanan {
  String idPemesanan;
  String namaPelanggan;
  Transportasi transportasi;
  int jumlahPenumpang;
  double totalTarif;

  Pemesanan(this.idPemesanan, this.namaPelanggan, this.transportasi,this.jumlahPenumpang, this.totalTarif);

  void cetakStruk() {
    print('===== Struk Pemesanan =====');
    print('ID Pemesanan: $idPemesanan');
    print('Nama Pelanggan: $namaPelanggan');
    transportasi.tampilInfo();
    print('Jumlah Penumpang: $jumlahPenumpang');
    print('Total Tarif: Rp${totalTarif.toStringAsFixed(0)}');
    print('===========================\n');
  }

  Map<String, dynamic> toMap() {
    return {
      'idPemesanan': idPemesanan,
      'namaPelanggan': namaPelanggan,
      'transportasi': transportasi.nama,
      'jumlahPenumpang': jumlahPenumpang,
      'totalTarif': totalTarif,
    };
  }
}

Pemesanan buatPemesanan(Transportasi t, String nama, int jumlahPenumpang) {
  double total = t.hitungTarif(jumlahPenumpang);
  String id = 'PSN${Random().nextInt(99999).toString().padLeft(4, '0')}';
  return Pemesanan(id, nama, t, jumlahPenumpang, total);
}

void tampilSemuaPemesanan(List<Pemesanan> daftar) {
  print('===== DAFTAR PEMESANAN =====');
  for (var p in daftar) {
    p.cetakStruk();
  }
  print('Total Pemesanan: ${daftar.length}');
  print('=============================');
}

void main() {
  Taksi taksi1 = Taksi('TX001', 'Blue Bird', 8000, 4, 12);
  Bus bus1 = Bus('BS001', 'TransJakarta', 3000, 40, true);
  Pesawat pesawat1 = Pesawat('PSW001', 'Garuda Indonesia', 1500000, 180, 'Bisnis');

  taksi1.tampilInfo();
  bus1.tampilInfo();
  pesawat1.tampilInfo();

  var p1 = buatPemesanan(taksi1, 'Andi', 2);
  var p2 = buatPemesanan(bus1, 'Budi', 10);
  var p3 = buatPemesanan(pesawat1, 'Citra', 2);

  List<Pemesanan> daftarPemesanan = [p1, p2, p3];
  tampilSemuaPemesanan(daftarPemesanan);
}