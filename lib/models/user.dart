class User {
  String? idUser;
  String? emailUser;
  String? role;
  String? password;
  String? namaUser;
  User({
    this.idUser,
    this.emailUser,
    this.role,
    this.password,
    this.namaUser,
  });
  factory User.fromJson(Map<String, dynamic> obj) {
    return User(
      idUser: obj['id_user'],
      namaUser: obj['nama_user'],
      emailUser: obj['email_user'],
      role: obj['role'],
      password: obj['password'],
    );
  }

  static String getNama(User user) {
    return user.namaUser!;
  }

  static String getEmail(User user) {
    return user.emailUser!;
  }
}
