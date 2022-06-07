import 'package:flutter/material.dart';
import 'package:flutter_lans/blocs/login_bloc.dart';
import 'package:flutter_lans/helpers/user_info.dart';
import 'package:flutter_lans/ui/produk_page.dart';
import 'package:flutter_lans/ui/registrasi_page.dart';
import 'package:flutter_lans/widgets/warning_dialog.dart';
import 'package:flutter_lans/frontend/ui/login_user.dart';

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/tokokitalogo.png',
                width: 150,
                height: 120,
              ),
              SizedBox(
                child: _isLoading ? CircularProgressIndicator() : null,
                height: 20,
                width: 50,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(248, 106, 203, 248),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login (Admin)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30),
                      _emailTextField(),
                      _passwordTextField(),
                      SizedBox(height: 30),
                      _loginButton(),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Belum punya akun? ",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegistrasiPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Daftar",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 150),
                          Row(
                            children: [
                              _ButtonLoginUserPagess(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: Colors.white,
            ),
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.white),
            // underline

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
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
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: Colors.white),
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
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
          "Registrasi?",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shadowColor: Colors.black,
            minimumSize: const Size.fromHeight(50),
          ),
          child: Text(
            'Login',
            style: TextStyle(color: Colors.black),
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

  // create widget button right
  Widget _ButtonLoginUserPagess() {
    return Center(
      child: InkWell(
        child: const Text(
          "Login User Page",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginUserPage()));
        },
      ),
    );
  }

  // create widget spacebeetwen
  Widget _spaceBeetwen() {
    return SizedBox(
      height: 20,
    );
  }
}
