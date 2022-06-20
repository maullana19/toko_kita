class Login {
  int? code;
  bool? status;
  String? token;
  int? userID;
  String? userEmail;
  String? message;
  Login(
      {this.code,
      this.status,
      this.token,
      this.userID,
      this.userEmail,
      this.message});
  factory Login.fromJson(Map<String, dynamic> obj) {
    return Login(
        code: obj['code'],
        status: obj['status'],
        token: obj['data']['token'],
        userID: obj['data']['user']['id'],
        userEmail: obj['data']['user']['email']);
  }
  factory Login.error(Map<String, dynamic> obj) {
    return Login(
        code: obj['code'], status: obj['status'], message: obj['data']);
  }
}
