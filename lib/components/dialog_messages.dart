import 'package:flutter/material.dart';

import '../themes/themes.dart';

Future<dynamic> dialogMessages({
  required BuildContext context,
  required String title,
  required String messages,
  required Size size
}) {
  return showDialog(
    context: context, 
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0,),
          Text(
            messages, 
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