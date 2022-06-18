// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:toko_kita/frontend/ui/daftar_user.dart';

class LoginUserPage extends StatelessWidget {
  final _emailUserTextboxController = TextEditingController();
  final _passwordUserTextboxController = TextEditingController();

  LoginUserPage({Key? key}) : super(key: key);

  BuildContext? get context => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 230, 225, 255),
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              Image.asset(
                'images/ecommercelogos.png',
                width: 150,
                height: 120,
                scale: 1.5,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: SizedBox(
                    height: 388,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Login User',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        _emailuserTextField(),
                        const SizedBox(
                          height: 20.0,
                        ),
                        _passworduserTextField(),
                        const SizedBox(
                          height: 20.0,
                        ),
                        _loginButton(),
                        const SizedBox(
                          height: 20.0,
                        ),
                        RaisedButton(
                          child: const Text('Daftar'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegistrasiUser(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _emailuserTextField() {
    return TextField(
      controller: _emailUserTextboxController,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
    );
  }

  _passworduserTextField() {
    return TextField(
      controller: _passwordUserTextboxController,
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _loginButton() {
    return RaisedButton(
      child: const Text('Login'),
      onPressed: () {},
    );
  }
}
