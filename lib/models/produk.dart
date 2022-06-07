import 'package:flutter/material.dart';
import 'package:flutter_lans/models/registrasi.dart';

class Produk {
  int id;
  String? kodeProduk;
  String? namaProduk;
  int? hargaProduk;
  Produk(
      {required this.id, this.kodeProduk, this.namaProduk, this.hargaProduk});
  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
        id: obj['id'],
        kodeProduk: obj['kode_produk'],
        namaProduk: obj['nama_produk'],
        hargaProduk: obj['harga']);
  }
}
