import 'package:flutter/material.dart';
import 'package:undisc/page/login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    sleep();
  }

  Future sleep() async {
    // Jangan dihapus biar ada sleep nya dulu sampe 5 detik nanti kalo dah 5 detik bakal ke login
    return await Future.delayed(
        const Duration(seconds: 5),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const Login()),
            (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return thiswidget();
  }

  //hancurr massss
  //lagi galau malah ngoding haduhhhh
  Widget thiswidget() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 220,
              ),
              Image.asset(
                "lib/assets/images/image.logo.splash.png",
                width: 230,
                height: 230,
              ),
              const SizedBox(
                height: 200,
              ),
              Container(
                child: Image.asset(
                  "lib/assets/images/image.splash.png",
                  width: 210,
                  height: 210,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
