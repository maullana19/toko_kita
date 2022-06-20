class Login {
  int? code;
  bool? status;
  String? token;
  int? userID;
  String? userEmail;
  String? role;
  String? message;
  Login(
      {this.code,
      this.status,
      this.token,
      this.userID,
      this.userEmail,
      this.role,
      this.message});
  factory Login.fromJson(Map<String, dynamic> obj) {
    return Login(
        code: obj['code'],
        status: obj['status'],
        token: obj['data']['token'],
        role: obj['data']['role'],
        userID: obj['data']['user']['id'],
        userEmail: obj['data']['user']['email']);
  }
  factory Login.error(Map<String, dynamic> obj) {
    return Login(
        code: obj['code'], status: obj['status'], message: obj['data']);
  }
}
