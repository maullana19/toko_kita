// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toko_kita/blocs/member_bloc.dart';
import 'package:toko_kita/helpers/user_info.dart';
import 'package:toko_kita/models/user.dart';
import 'package:toko_kita/widgets/buttomBar.dart';
import 'package:toko_kita/widgets/drawer.dart';
import 'package:toko_kita/widgets/myInput.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late int id;
  String? userRole;
  @override
  void initState() {
    super.initState();
    isUser();
    isAdmin();
  }

  void isUser() async {
    var userID = await UserInfo().getUserID();
    setState(() {
      id = userID!;
    });
  }

  void isAdmin() async {
    var role = await UserInfo().getRole();
    setState(() {
      userRole = role.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      drawer: MyDrawer(userRole: userRole),
      bottomNavigationBar: ButtomBar(
        currentContext: context,
        currentIndex: 2,
      ),
      body: Card(
        margin: const EdgeInsets.all(16),
        elevation: 16,
        child: Container(
          alignment: Alignment.center,
          child: FutureBuilder<User>(
            future: MemberBloc.getUserData(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                // easy loading
                EasyLoading.show(
                  status: 'Toko Kita',
                  maskType: EasyLoadingMaskType.black,
                );
              } else {
                EasyLoading.dismiss();
              }
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? MyProfile(
                      data: snapshot.data,
                    )
                  : const Center(
                      child: Text('data Kosong'),
                    );
            },
          ),
        ),
      ),
    );
  }
}

class MyProfile extends StatelessWidget {
  final User? data;

  const MyProfile({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person, size: 150),
          const SizedBox(height: 16),
          MyInput(
            label: 'Email',
            value: TextEditingController(text: data?.emailUser),
          ).standart(isRead: true),
          const SizedBox(height: 16),
          MyInput(
            label: 'Nama',
            value: TextEditingController(text: data?.namaUser),
          ).standart(isRead: true),
          const SizedBox(height: 16),
          MyInput(
            label: 'Role',
            value: TextEditingController(text: data?.role),
          ).standart(isRead: true),
        ],
      ),
    );
  }
}
