import 'package:flutter/material.dart';

import '../../lang/lang.dart';
import '../../themes/themes.dart';

Future<dynamic> modalBottomSendMessage(
  BuildContext context,
  {
    Function()? onSend
  }
) {
  return showModalBottomSheet(
    context: context,
    clipBehavior: Clip.hardEdge,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))
    ),
    builder: (_) => Container(
      padding: const EdgeInsets.all(8.0).add(EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            minLines: 3,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              filled: true,
              fillColor: Themes().grey300,
              hintText: Lang().sendMessage,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none
              )
            ),
          ),
          const SizedBox(height: 5.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: Text(Lang().cancel),
              ),

              const SizedBox(width: 5.0,),
              
              MaterialButton(
                onPressed: onSend,
                color: Themes().primary,
                textColor: Themes().white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                elevation: 0.0,
                highlightElevation: 0.0,
                child: Text(Lang().send),
              ),
            ],
          )
        ],
      ),
    )
  );
}