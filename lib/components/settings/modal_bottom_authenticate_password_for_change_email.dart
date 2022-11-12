import 'package:flutter/material.dart';

import '../../themes/themes.dart';
import '../text_form_field.dart';

Future<dynamic> modalBottomAuthenticatePasswordForChangeEmail({
  required BuildContext context,
  required TextEditingController controller,
  required String? Function(String?) validator,
  required Function() onSubmit,
  required Function() onCancel,
  String? errorText
}) {
  return showModalBottomSheet(
    context: context, 
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))
    ), 
    builder: (_) => Padding(
      padding: const EdgeInsets.all(15.0).add(EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          textFormField(
            controller: controller, 
            hintText: "Enter your password", 
            errorText: errorText, 
            obscureText: true, 
            validator: validator,
            keyboardType: TextInputType.visiblePassword
          ),
          const SizedBox(height: 5.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                onPressed: onCancel,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: const Text("Cancel"),
              ),

              const SizedBox(width: 5.0,),
              
              MaterialButton(
                onPressed: onSubmit,
                color: Themes().primary,
                textColor: Themes().white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                elevation: 0.0,
                highlightElevation: 0.0,
                child: const Text("Send"),
              ),
            ],
          )
        ],
      ),
    )
  );
}