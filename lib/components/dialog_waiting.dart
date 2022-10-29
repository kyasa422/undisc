
import 'package:flutter/material.dart';
import 'package:undisc/lang/lang.dart';
import '../themes/themes.dart';

Future<dynamic> dialogWating(BuildContext context, Size size) {
  return showDialog(
    context: context, 
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: Themes().primary,
          ),

          const SizedBox(height: 5.0,),
          Text("${Lang().pleaseWait}!")
        ],
      ),
    )
  );
}