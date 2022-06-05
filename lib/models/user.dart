import 'package:flutter/material.dart';

// create model user
class User {
  String? id;
  String? email;
  String? password;
  String? nama;
  String? alamat;
  String? nohp;
  String? foto;
  User(
      {this.id,
      this.email,
      this.password,
      this.nama,
      this.alamat,
      this.nohp,
      this.foto});
  factory User.fromJson(Map<String, dynamic> obj) {
    return User(
        id: obj['id'],
        email: obj['email'],
        password: obj['password'],
        nama: obj['nama']);
  }
}
