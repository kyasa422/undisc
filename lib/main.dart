import 'package:flutter/material.dart';
import 'package:undisc/page/splash_screen/splash_screen.dart';
import 'package:undisc/themes/themes.dart';

void main() => runApp(const Undesc());

class Undesc extends StatelessWidget {
  const Undesc({Key? key}) : super(key: key);

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