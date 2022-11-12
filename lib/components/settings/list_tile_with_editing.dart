import 'package:flutter/material.dart';
import 'package:undisc/components/text_form_field.dart';

import '../../themes/themes.dart';

Material listTileWithEditing({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required String title,
  required String subtitle,
  String? Function(String?)? validator,
  int? minLines,
  int maxLines = 1,
  TextEditingController? controller,
  String? hintText,
  TextInputType? keyboardType,
  bool obscureText = false,
  String? errorText,
  Widget? customChangeModalEditing,
  Function()? onSubmit
}) {
  return Material(
    color: Themes().grey100,
    borderRadius: BorderRadius.circular(20.0),
    elevation: 0.0,
    child: ListTile(
      title: Text(title, style: TextStyle(color: Themes().grey),),
      subtitle: Text(subtitle, style: TextStyle(color: Themes().grey400),),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onTap: () => showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))
        ), 
        builder: (_) => customChangeModalEditing ?? Padding(
          padding: const EdgeInsets.all(15.0).add(EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textFormField(
                  controller: controller,
                  hintText: "What's new your email?",
                  errorText: errorText,
                  keyboardType: keyboardType,
                  validator: validator,
                ),
                const SizedBox(height: 5.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: (){
                        controller!.clear();
                        Navigator.pop(context);
                      },
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
          ),
        )
      ),
    ),
  );
}