import 'package:toko_kita/helpers/user_info.dart';

class LogoutBloc {
  Future<bool> logout() async {
    await UserInfo().logout();
    return true;
  }
}
