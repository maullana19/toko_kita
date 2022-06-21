import 'package:flutter/material.dart';
import 'package:toko_kita/blocs/member_bloc.dart';
import 'package:toko_kita/blocs/produk_bloc.dart';
import 'package:toko_kita/helpers/user_info.dart';
import 'package:toko_kita/models/user.dart';
import 'package:toko_kita/ui/produk_form.dart';
import 'package:toko_kita/widgets/buttomBar.dart';
import 'package:toko_kita/widgets/drawer.dart';
import 'package:toko_kita/widgets/itemProduct.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key, memberId}) : super(key: key);

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  String userRole = 'member';
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
        title: const Text('Dashboard'),
        actions: [
          userRole == 'admin'
              ? IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProdukForm(),
                      ),
                    );
                  },
                )
              : const SizedBox(),
        ],
      ),
      drawer: MyDrawer(userRole: userRole, user: user),
      bottomNavigationBar: ButtomBar(
        currentContext: context,
        currentIndex: 1,
      ),
      body: Center(
        child: FutureBuilder<List>(
          future: ProdukBloc.getProduks(),
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
                ? ListProduk(
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

class ListProduk extends StatelessWidget {
  final List? list;

  const ListProduk({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: list == null ? 0 : list?.length,
      itemBuilder: (context, i) {
        return ItemProduk(
          produk: list![i],
        );
      },
    );
  }
}
