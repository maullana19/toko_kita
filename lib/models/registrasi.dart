import 'package:flutter/material.dart';
import 'package:flutter_lans/models/produk.dart';

class Registrasi {
  int? code;
  bool? status;
  String? data;
  Registrasi({this.code, this.status, this.data});
  factory Registrasi.fromJson(Map<String, dynamic> obj) {
    return Registrasi(
        code: obj['code'], status: obj['status'], data: obj['data']);
  }
}