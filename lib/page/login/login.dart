import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:undisc/components/dialog_messages.dart';
import 'package:undisc/components/dialog_waiting.dart';
import 'package:undisc/components/text_input_auth.dart';
import 'package:undisc/page/forgot_password/forgot_password.dart';
import 'package:undisc/page/register/register.dart';
import 'package:undisc/page/splash_screen/splash_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  String? errorEmail;
  String? errorPassword;

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

  String? validatorPassword(String? value){
    if(value!.trim().isEmpty){
      return "Password can't be empty!";
    }

    if(value.length < 8){
      return "Password cannot be less than 8 characters!";
    }

    return null;
  }

  void onSubmit() async{
    if(formKey.currentState!.validate()){
      errorEmail = null;
      errorPassword = null;
      dialogWating(context, size);
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailInput.text,
          password: passwordInput.text
        ).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_) => const SplashScreen())));
      }on FirebaseAuthException catch(e){
        if(e.code == "user-not-found"){
          setState(() => errorEmail = "User not found!");
          Navigator.pop(context);
        }else if(e.code == "wrong-password"){
          setState(() => errorPassword = "Wrong password!");
          Navigator.pop(context);
        }else{
          dialogMessages(context: context, title: "Error!", messages: "Server Error!", size: size);
        }
      }
    }
  }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 400,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("lib/assets/images/image.login.png"),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Login",
                        style: TextStyle(
                          color: Color.fromARGB(255, 49, 0, 100),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(248, 231, 221, 221),
                            blurRadius: 20,
                            offset: Offset(17, 17),
                          ),
                        ],
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            textInputAuth(context: context, controller: emailInput, hintText: "Email", validator: validatorEmail, keyboardType: TextInputType.emailAddress, errorText: errorEmail),
                            textInputAuth(context: context, controller: passwordInput, hintText: "Password", last: true, keyboardType: TextInputType.visiblePassword, obscureText: true, validator: validatorPassword, errorText: errorPassword),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPassword())),
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: SizedBox(
                        width: 170,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: onSubmit,
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              elevation: 2,
                              backgroundColor:
                                  const Color.fromARGB(255, 49, 0, 100)),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: SizedBox(
                        width: 170,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const Register()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              elevation: 0,
                              backgroundColor: Colors.white),
                          child: const Center(
                            child: Text(
                              "Create Account?",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 49, 0, 100)
                                ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
