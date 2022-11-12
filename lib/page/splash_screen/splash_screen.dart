import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:undisc/page/email_nonactivated/email_nonactivated.dart';
import 'package:undisc/page/home/main.dart';
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
    if(FirebaseAuth.instance.currentUser != null){
      if(FirebaseAuth.instance.currentUser!.emailVerified){
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const Main()), (route) => false);     
        });
      }else{
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const EmailNonActivated()), (route) => false);     
        });
      }
    }else{
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const Login()), (route) => false);
      });
    }
  }

  @override
  void dispose(){
    super.dispose();
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
              Image.asset(
                "lib/assets/images/image.splash.png",
                width: 210,
                height: 210,
              )
            ],
          ),
        ),
      ),
    );
  }
}
