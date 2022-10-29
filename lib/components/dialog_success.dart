
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:undisc/lang/lang.dart';
import '../themes/themes.dart';

Future<dynamic> dialogSuccess(BuildContext context, Size size) {
  return showDialog(
    context: context, 
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            FontAwesomeIcons.circleCheck, 
            size: (size.width + size.height) / 12.0,
            color: Themes().success,
          ),
          const SizedBox(height: 5.0,),
          Text("${Lang().success}!")
        ],
      ),
    )
  );
}