import 'package:flutter/material.dart';

class LoginUserPage extends StatelessWidget {
  final _emailUserTextboxController = TextEditingController();
  final _passwordUserTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 230, 225, 255),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
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
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: Container(
                    height: 388,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Login User',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        _emailuserTextField(),
                        SizedBox(
                          height: 20.0,
                        ),
                        _passworduserTextField(),
                        SizedBox(
                          height: 20.0,
                        ),
                        RaisedButton(
                          child: Text('Login'),
                          onPressed: () {},
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
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
    );
  }

  _passworduserTextField() {
    return TextField(
      controller: _passwordUserTextboxController,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _loginButton() {
    return RaisedButton(
      child: Text('Login'),
      onPressed: () {},
    );
  }
}
