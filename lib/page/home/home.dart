import 'package:flutter/material.dart';
import 'package:undisc/lang/lang.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Lang().appName),)
    );
  }
}