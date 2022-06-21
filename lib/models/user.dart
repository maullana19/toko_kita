class User {
  int? code;
  String? idUser;
  String? emailUser;
  String? role;
  String? password;
  String? namaUser;
  User({
    this.code,
    this.idUser,
    this.emailUser,
    this.role,
    this.password,
    this.namaUser,
  });
  factory User.fromJson(Map<String, dynamic> obj) {
    return User(
      code: obj['code'],
      namaUser: obj['data']['nama'],
      emailUser: obj['data']['email'],
      role: obj['data']['role'],
      password: obj['data']['password'],
    );
  }

  factory User.list(Map<String, dynamic> obj) {
    return User(
      namaUser: obj['nama'],
      emailUser: obj['email'],
      role: obj['role'],
    );
  }

  static String getNama(User user) {
    return user.namaUser!;
  }

  static String getEmail(User user) {
    return user.emailUser!;
  }
}
