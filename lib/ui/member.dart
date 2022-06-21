import 'package:flutter/material.dart';
import 'package:toko_kita/blocs/member_bloc.dart';
import 'package:toko_kita/helpers/user_info.dart';
import 'package:toko_kita/widgets/buttomBar.dart';
import 'package:toko_kita/widgets/drawer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({Key? key, memberId}) : super(key: key);

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  String userRole = 'member';

  @override
  void initState() {
    super.initState();
    isAdmin();
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
        primary: true,
        backgroundColor: Colors.lightBlue,
        title: const Text('Dashboard'),
      ),
      drawer: MyDrawer(userRole: userRole),
      bottomNavigationBar: ButtomBar(
        currentContext: context,
        currentIndex: 1,
      ),
      body: Center(
        child: FutureBuilder<List>(
          future: MemberBloc.getAllDataUser(),
          builder: (context, AsyncSnapshot<List> snapshot) {
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
            // ignore: avoid_print
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListMember(
                    list: snapshot.data,
                  )
                : const Center(
                    child: Text('data Kosong'),
                  );
          },
        ),
      ),
    );
  }
}

class ListMember extends StatelessWidget {
  final List? list;

  const ListMember({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemCount: list?.length ?? 0,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(list?[index]?.namaUser ?? 'data kosong'),
            subtitle: Text(list?[index]?.emailUser ?? 'data kosong'),
            trailing: Text(list?[index]?.role ?? 'data kosong'),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black,
        ),
      ),
    );
  }
}
