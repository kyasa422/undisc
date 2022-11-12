import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:undisc/firebase_options.dart';
import 'package:undisc/page/splash_screen/splash_screen.dart';
import 'package:undisc/themes/themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const Undisc());
}

class Undisc extends StatelessWidget {
  const Undisc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: Themes().primary)
      ),
      home: const SplashScreen(),
    );
  }
}