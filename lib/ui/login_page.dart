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
        title: Text('TokoKita.com'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Daftar',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegistrasiPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'TokoKita.com',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontFamily: 'Pacifico',
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              child: _isLoading ? CircularProgressIndicator() : null,
              height: 20,
              width: 50,
            ),
            Padding(padding: EdgeInsets.all(5)),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _emailTextField(),
                  _passwordTextField(),
                  SizedBox(height: 50),
                  _loginButton(),
                  SizedBox(height: 50),
                  // create text
                  Text(
                    'Nyalakan Localhost Server',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        fontFamily: "roboto"),
                  ),
                ],
              ),
            ),
          ],
          // create copy right
          textBaseline: TextBaseline.alphabetic,
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: TextFormField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.black),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          obscureText: false,
          controller: _emailTextboxController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'email harus diisi';
            }
            return null;
          },
        ));
  }

  Widget _passwordTextField() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: TextFormField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.black),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          obscureText: true,
          controller: _passwordTextboxController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Password harus diisi';
            }
            return null;
          },
        ));
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

  Widget _loginButton() {
    return StreamBuilder<bool>(
      builder: (context, snapshot) {
        return RaisedButton(
          color: Colors.blue,
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _submit();
            }
          },
        );
      },
    );
  }
}
