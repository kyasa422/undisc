import 'package:flutter/material.dart';
import '../../themes/themes.dart';

Container appBar(BuildContext context, Size size, Map<String, dynamic> data, {Function()? onTapAvatar}) {
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
                color: Themes().dark,
                fontSize: (size.width + size.height) / 45.0
              )
            ),

            SizedBox(
              width: size.width / 1.5,
              child: Text(
                data.isNotEmpty && data['name'] != null ? data['name'] : '...',
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
          onTap: onTapAvatar,
          borderRadius: BorderRadius.circular(100.0),
          child: data['photoURL'],
        )
      ],
    ),
  );
}