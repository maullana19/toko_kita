// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:toko_kita/ui/homescreen.dart';
import 'package:toko_kita/ui/produk_page.dart';
import 'package:toko_kita/ui/profile_page.dart';

class ButtomBar extends StatelessWidget {
  final BuildContext? currentContext;
  final int? currentIndex;
  static List route = [
    const HomePages(),
    const ProdukPage(),
    const ProfilePage(),
  ];
  const ButtomBar({Key? key, this.currentContext, this.currentIndex})
      : super(key: key);

  void onTabTapped(int index) {
    Navigator.pushReplacement(
      currentContext!,
      MaterialPageRoute(
        builder: (context) => route[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: currentIndex ?? 0,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'List Produk',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
