import 'package:flutter/material.dart';
import 'package:toko_kita/blocs/registrasi_bloc.dart';
import 'package:toko_kita/widgets/success_dialog.dart';
import 'package:toko_kita/widgets/warning_dialog.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);
  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Isi Formulir Dibawah Ini',
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(height: 35),
                _namaTextField(),
                SizedBox(height: 10),
                _emailTextField(),
                SizedBox(height: 10),
                _passwordTextField(),
                SizedBox(height: 10),
                _passwordKonfirmasiTextField(),
                SizedBox(height: 40),
                _buttonRegistrasi(),
                SizedBox(height: 50),
                _floatingActionBackButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _namaTextField() {
    return TextFormField(
      controller: _namaTextboxController,
      decoration: InputDecoration(
        labelText: 'Nama',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.length < 3) {
          return "Nama harus diisi minimal 3 karakter";
        }
        return null;
      },
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      controller: _emailTextboxController,
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Email harus diisi";
        }
        return null;
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      controller: _passwordTextboxController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.length < 6) {
          return "Password harus diisi minimal 6 karakter";
        }
        return null;
      },
    );
  }

  Widget _passwordKonfirmasiTextField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Konfirmasi Password',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.length < 6) {
          return "Konfirmasi Password harus diisi minimal 6 karakter";
        }
        if (value != _passwordTextboxController.text) {
          return "Konfirmasi Password tidak sesuai";
        }
        return null;
      },
    );
  }

  Widget _buttonRegistrasi() {
    return ElevatedButton(
        child: const Text("Registrasi"),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) _submit();
          }
        });
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    RegistrasiBloc.registrasi(
            nama: _namaTextboxController.text,
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SuccessDialog(
                description: "Registrasi berhasil, silahkan login",
                okClick: () {
                  Navigator.pop(context);
                },
              ));
    }, onError: (error) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
                description: "Registrasi gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  Widget _floatingActionBackButton() {
    return FloatingActionButton(
      child: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
