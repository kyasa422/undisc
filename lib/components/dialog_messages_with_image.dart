import 'package:flutter/material.dart';

import '../themes/themes.dart';

Future<dynamic> dialogMessagesWithImage(BuildContext context, Size size) {
  return showDialog(
    context: context, 
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("lib/assets/images/mail_send.png"),
          const Text(
            "Check your mail",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0,),
          Text(
            "We sent an email to reset your password.", 
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Themes().grey400,
              fontSize: (size.width + size.height) / 80.0
            ),
          )
        ],
      ),
    )
  );
}