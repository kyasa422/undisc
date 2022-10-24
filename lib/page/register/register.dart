import 'package:flutter/material.dart';
import 'package:undisc/page/login/login.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Login())), child: const Text("Login")),
          TextButton(onPressed: (){}, child: const Text("Register")),
        ],
      )
    );
  }
}