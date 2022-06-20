import 'package:flutter/material.dart';

class RegistrasiUser extends StatelessWidget {
  const RegistrasiUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: Colors.lightBlue,
        title: const Text('Registrasi User'),
      ),
      body: const Center(
        child: Text('Sedang Dibuat'),
      ),
    );
  }
}
