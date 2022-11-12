import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:undisc/components/dialog_waiting.dart';
import 'package:undisc/page/splash_screen/splash_screen.dart';

import '../../components/dialog_messages_with_image.dart';
import '../../themes/themes.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String? validatorEmail(String? value){
      bool regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value!);

      if(value.trim().isEmpty) {
        return "Email can't be empty!";
      }

      if(!regex){
        return "Email format is not correct!";
      }

      return null;
    }

    void onSubmit() async{
      if(formKey.currentState!.validate()){
        dialogWating(context, size);
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailInput.text)
          .whenComplete(() async{
            Navigator.pop(context);
            await dialogMessagesWithImage(context, size).whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (_) => const SplashScreen())));
          });
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(elevation: 0.0, backgroundColor: Themes().transparent, foregroundColor: Themes().primary,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "lib/assets/images/forgot_password.png",
              width: double.infinity,
            ),
      
            Text(
              "Forgot your password?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: (size.width + size.height) / 55.0
              ),
            ),
      
            const SizedBox(height: 10.0,),
      
            Text(
              "Enter the email you registered with to reset your password.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: (size.width + size.height) / 80.0,
                color: Themes().grey400
              ),
            ),
      
            const SizedBox(height: 20.0,),
      
            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                     TextFormField(
                      controller: emailInput,
                      keyboardType: TextInputType.emailAddress,
                      validator: validatorEmail,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Themes().grey300,
                        hintText: "Enter your email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none
                        )
                      ),
                    ),
      
                    const SizedBox(height: 20.0,),
            
                    SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: onSubmit,
                        color: Themes().primary,
                        textColor: Themes().white,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        highlightElevation: 0.0,
                        child: const Text("Send"),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}