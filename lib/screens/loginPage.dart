import 'package:flutter/material.dart';

// import 'package:task1/screens/addmissionListPage.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'package:task1/screens/homePage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.pink,
        Colors.blue,
      ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SafeArea(
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: Form(
                    key: widget._formKey,
                    child: ListView(
                      children: [
                        _icon(),
                        const SizedBox(height: 50),
                        _inputField('Email id', _emailController),
                        const SizedBox(height: 20),
                        _inputField('Password', _passwordController,
                            isPassword: true),
                        const SizedBox(height: 50),
                        _registerBtn(),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          shape: BoxShape.circle),
      child: const Icon(Icons.person, color: Colors.white, size: 100),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.white));
    return TextFormField(
      validator: isPassword
          ? ((password) => password!.length < 6
              ? 'Password should be at least 6 characters'
              : null)
          : validateEmail,
      style: const TextStyle(color: Colors.white),
      controller: controller,
      keyboardType:
          isPassword ? TextInputType.text : TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
    );
  }

  Widget _registerBtn() {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        if (connectivity == ConnectivityResult.none) {
          return ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('No Internet Connection'),
                    content: Text('Please check your internet connection.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const SizedBox(
              width: double.infinity,
              child: Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          );
        } else {
          return ElevatedButton(
            onPressed: () {
              if (widget._formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
            },
            child: const SizedBox(
              width: double.infinity,
              child: Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          );
        }
      },
      child: const SizedBox(),
    );
  }
}
