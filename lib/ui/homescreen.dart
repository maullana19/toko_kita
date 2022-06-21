import 'package:flutter/material.dart';
import 'package:toko_kita/blocs/member_bloc.dart';
import 'package:toko_kita/helpers/user_info.dart';
import 'package:toko_kita/models/user.dart';
import 'package:toko_kita/widgets/buttomBar.dart';
import 'package:toko_kita/widgets/drawer.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  String? userRole;
  User user = User();

  @override
  void initState() {
    super.initState();
    isAdmin();
  }

  void isAdmin() async {
    var role = await UserInfo().getRole();
    await UserInfo().getUserID().then((id) => {
          MemberBloc.getUserData(id!).then((data) => {
                setState(() {
                  userRole = role.toString();
                  user = data;
                })
              })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: Colors.lightBlue,
        title: const Text('Home Page'),
      ),
      drawer: MyDrawer(userRole: userRole, user: user),
      bottomNavigationBar: ButtomBar(
        currentContext: context,
        currentIndex: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/tokokitalogo.png',
              width: 200,
              height: 200,
            ),
            const Text(
              'Selamat Datang',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Silahkan pilih menu yang ingin anda lakukan',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
