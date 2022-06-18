import 'package:flutter/material.dart';

class HomePages extends StatelessWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Image.asset(
            'images/tokokitalogo.png',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
