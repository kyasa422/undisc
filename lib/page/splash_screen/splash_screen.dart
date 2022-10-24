import 'package:flutter/material.dart';
import 'package:undisc/page/login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    sleep();
  }

  Future sleep() async{ // Jangan dihapus biar ada sleep nya dulu sampe 5 detik nanti kalo dah 5 detik bakal ke login
    return await Future.delayed(const Duration(seconds: 5), () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const Login()), (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold( // Lo maenan disini aja maenin UInya
      body: Center(child: Text("Splash Screen"),),
    );
  }
}