import 'package:flutter/material.dart';
import 'dart:ffi';

class User {
  String? id_user;
  String? email_user;
  String? password;
  String? nama_user;
  User({
    this.id_user,
    this.email_user,
    this.password,
    this.nama_user,
  });
  factory User.fromJson(Map<String, dynamic> obj) {
    return User(
      id_user: obj['id_user'],
      nama_user: obj['nama_user'],
      email_user: obj['email_user'],
      password: obj['password'],
    );
  }

  static String getNama(User user) {
    return user.nama_user!;
  }

  static String getEmail(User user) {
    return user.email_user!;
  }
}
