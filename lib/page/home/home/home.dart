import 'package:flutter/material.dart';
import 'package:undisc/themes/themes.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          margin: const EdgeInsets.only(top: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hai, ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: (size.width + size.height) / 40.0)),
                  SizedBox(
                    width: size.width / 1.5,
                    child: Text("Iqbal Febrianwar",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Themes().black54,
                            fontSize: (size.width + size.height) / 60.0)),
                  ),
                ],
              ),
              const CircleAvatar(
                backgroundImage:
                    NetworkImage("https://iqbalfebrianwar.github.io/iqbal.jpg"),
              )
            ],
          ),
        )
      ],
    ));
  }
}
