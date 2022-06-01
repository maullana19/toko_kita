import 'package:flutter/material.dart';
import 'package:flutter_lans/blocs/login_bloc.dart';
import 'package:flutter_lans/helpers/user_info.dart';
import 'package:flutter_lans/ui/produk_page.dart';
import 'package:flutter_lans/ui/registrasi_page.dart';
import 'package:flutter_lans/widgets/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Kita'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrasiPage()));
                },
                child: Icon(
                  Icons.login_outlined,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Center(
        child: Container(
          width: 450,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.blue, //BorderRadius.all
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 10, width: 3),
                    _emailTextField(),
                    _passwordTextField(),
                    _buttonLogin()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Center(
      child: Column(
        children: [
          Divider(
            height: 20,
          )
        ],
      ),
    );
  }

  //Membuat Textbox email
  Widget _emailTextField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      decoration: const InputDecoration(
          label: Text("Email"),
          labelStyle: TextStyle(
            color: Colors.white,
          )),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        //validasi harus diisi
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
    );
  }

  //Membuat Textbox password
  Widget _passwordTextField() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: const InputDecoration(
          label: Text("Password"),
          labelStyle: TextStyle(
            color: Colors.white,
          )),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        //jika karakter yang dimasukkan kurang dari 6 karakter
        if (value!.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Tombol Login
  Widget _buttonLogin() {
    return ElevatedButton(
        child: const Text("Login"),
        style: ElevatedButton.styleFrom(
            primary: Colors.lightBlue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
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
    LoginBloc.login(
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) async {
      await UserInfo().setToken(value.token.toString());
      await UserInfo().setUserID(int.parse(value.userID.toString()));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ProdukPage()));
    }, onError: (error) {
      print(error);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
                description: "Login gagal, silahkan coba lagi guys !",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  // Membuat menu untuk membuka halaman registrasi
  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text(
          "Registrasi",
          style: TextStyle(color: Colors.red),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegistrasiPage()));
        },
      ),
    );
  }
}
