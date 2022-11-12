import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:undisc/components/dialog_messages.dart';
import 'package:undisc/components/dialog_waiting.dart';
import 'package:undisc/page/login/login.dart';
import 'package:undisc/themes/themes.dart';
import '../splash_screen/splash_screen.dart';

class EmailNonActivated extends StatefulWidget {
  const EmailNonActivated({super.key});

  @override
  State<EmailNonActivated> createState() => _EmailNonActivatedState();
}

class _EmailNonActivatedState extends State<EmailNonActivated> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(FontAwesomeIcons.userLock, size: (size.width + size.height) / 15.0,),
                  const SizedBox(height: 20.0,),
                  Text(
                    "Account has not been activated",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: (size.width + size.height) / 50.0
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Please check your email to activate this account.\nIf the account has been verified, please press the validate button.",
                      style: TextStyle(
                        fontSize: (size.width + size.height) / 70.0,
                        color: Themes().grey400
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  TextButton(
                    onPressed: () async{
                      dialogWating(context, size);
                      await FirebaseAuth.instance.currentUser!.reload()
                        .whenComplete(() async{
                          Navigator.pop(context);
                          if(FirebaseAuth.instance.currentUser!.emailVerified){
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const SplashScreen()));
                          }else{
                            dialogMessages(context: context, title: "Error!", messages: "You have not activated your account!.", size: size);
                          }
                        });
                    },
                    child: Text(
                      "Account Validation",
                      style: TextStyle(color: Themes().primary),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: const Alignment(0.0, .97),
            child: TextButton(
              onPressed: (){
                FirebaseAuth.instance.signOut().whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (_) => const Login())));
              },
              child: Text(
                "Click here to change account",
                style: TextStyle(color: Themes().grey400),
              ),
            ),
          )
        ],
      )
    );
  }

  
}