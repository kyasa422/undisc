import 'package:flutter/material.dart';
import 'package:undisc/page/profile/profile.dart';
import '../../themes/themes.dart';

Container appBar(BuildContext context, Size size) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    margin: const EdgeInsets.only(top: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hai, ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: (size.width + size.height) / 45.0
              )
            ),

            SizedBox(
              width: size.width / 1.5,
              child: Text(
                "Eugene Feilian Putra Rangga",
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Themes().black54,
                  fontSize: (size.width + size.height) / 65.0
                )
              ),
            ),
          ],
        ),

        InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Profile(uid: 'Jy2DE8Jj2zUEHtCS7Ty2oYKR3wG3',))),
          borderRadius: BorderRadius.circular(100.0),
          child: const Hero(
            transitionOnUserGestures: true,
            tag: "Profile",
            child: CircleAvatar(
              backgroundImage: NetworkImage("https://eugeneputra.web.app/img/img1.jpg"),
            ),
          ),
        )
      ],
    ),
  );
}