import 'package:flutter/material.dart';
import 'package:undisc/themes/themes.dart';

import '../../components/settings/list_tile_with_editing.dart';
import '../../components/text_form_field.dart';

class SettingsGeneral extends StatefulWidget {
  const SettingsGeneral({super.key});

  @override
  State<SettingsGeneral> createState() => _SettingsGeneralState();
}

class _SettingsGeneralState extends State<SettingsGeneral> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController inputPassword = TextEditingController();
  TextEditingController inputNewPassword = TextEditingController();
  TextEditingController inputReNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? validatorPassword(String? value){
      if(value!.trim().isEmpty){
        return "Input cannot be empty!";
      }

      if(value.length < 8){
        return "Password cannot be less than 8 characters!";
      }

      return null;
    }

    String? validatorReNewPassword(String? value){
      if(value!.trim().isEmpty){
        return "Input cannot be empty!";
      }

      if(value.length < 8){
        return "Password cannot be less than 8 characters!";
      }

      if(value != inputPassword.text){
        return "Passwords are not the same!";
      }

      return null;
    }

    void onSubmit(){}

    return Scaffold(
      appBar: AppBar(backgroundColor: Themes().transparent, foregroundColor: Themes().primary, elevation: 0.0,),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          listTileWithEditing(
            context: context, 
            formKey: formKey,
            title: "Password",
            subtitle: "",
            customChangeModalEditing: Padding(
              padding: const EdgeInsets.all(15.0).add(EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textFormField(controller: inputPassword, hintText: "Enter password now", obscureText: true, validator: validatorPassword),
                    const SizedBox(height: 10.0,),
                    textFormField(controller: inputNewPassword, hintText: "Enter new password", obscureText: true, validator: validatorPassword),
                    const SizedBox(height: 10.0,),
                    textFormField(controller: inputReNewPassword, hintText: "Re-enter new password", obscureText: true, validator: validatorReNewPassword),
                    const SizedBox(height: 5.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          onPressed: () => Navigator.pop(context),
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
        ],
      ),
    );
  }
}