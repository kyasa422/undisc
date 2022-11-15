import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:undisc/components/dialog_messages.dart';
import 'package:undisc/components/dialog_waiting.dart';
import 'package:undisc/page/login/login.dart';
import 'package:undisc/page/splash_screen/splash_screen.dart';
import 'package:undisc/themes/themes.dart';
import '../../components/text_input_auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();

}

class _RegisterState extends State<Register> {
  late CollectionReference dbUsers;
  String? errorEmail;
  String? errorNim;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nimImput = TextEditingController();
  TextEditingController emailInput = TextEditingController();
  TextEditingController nameInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  TextEditingController repeatPasswordInput = TextEditingController();
  String? studyProgramInput;

  @override
  void initState(){
    super.initState();
    dbUsers = FirebaseFirestore.instance.collection("users");
  }

  @override
  Widget build(BuildContext context) {
    final List<String> studyProgramList = ["Teknik Informatika", "Teknik Elektro", "Teknik Mesin", "Teknik Sipil", "Akuntansi", "Ilmu Komunikasi", "Manajemen", "Sastra Inggris"];
    final Size size = MediaQuery.of(context).size;

    String? validatorNim(String? value){
      if(value!.trim().isEmpty){
        return "Nim can't be empty!";
      }

      if(value.length != 9){
        return "Nim is 9 digits!";
      }

      return null;
    }

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
    
    String? validatorName(String? value){
      if(value!.trim().isEmpty){
        return "Name can't be empty!";
      }
      return null;
    }

    String? validatorStudyProgram(String? value){
      if(value == null){
        return "Study Program can't be empty!";
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

    String? validatorRepeatPassword(String? value){
      if(value!.trim().isEmpty){
        return "Password can't be empty!";
      }

      if(value.length < 8){
        return "Password cannot be less than 8 characters!";
      }

      if(passwordInput.text != value){
        return "Passwords are not the same!";
      }

      return null;
    }

    void onSubmit() async{
      if(formKey.currentState!.validate()){
        dialogWating(context, size);
        await dbUsers.where("nim", isEqualTo: nimImput.text).get()
          .then((value) async{
            if(value.docs.isEmpty){
              try{
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: emailInput.text,
                  password: passwordInput.text
                ).then((value) async {
                  await value.user?.sendEmailVerification().then((_) async {
                    await dbUsers.add({
                      "uid": FirebaseAuth.instance.currentUser!.uid,
                      "nim": nimImput.text,
                      "email": emailInput.text,
                      "password": Crypt.sha256(passwordInput.text).toString(),
                      "name": nameInput.text,
                      "study_program": studyProgramInput,
                      "photoURL": FirebaseAuth.instance.currentUser!.photoURL,
                      "role": "Student"
                    }).then((_){
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const SplashScreen()), (route) => false);
                    });
                  });
                });
              }on FirebaseAuthException catch(e){
                errorEmail = null;
                if(e.code == "email-already-in-use"){
                  errorEmail = "Email is available!";
                }
                setState((){});
                Navigator.pop(context);
              }
            }else{
              setState((){
                errorNim = "Nim is available!";
              });
              Navigator.pop(context);
            }
          }).catchError((_){
            Navigator.pop(context);
            dialogMessages(context: context, title: "Error!", messages: "Server Error!", size: size);
          });
      }
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor:
         Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: size.height / 4.5,
                width: size.width / 1.3,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("lib/assets/images/image.register.png"),
                          fit: BoxFit.fill
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                margin: const EdgeInsets.only(top: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Register",
                      style: TextStyle(
                        color: Themes().primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )
                    ),
                    
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Themes().grey300,
                                  blurRadius: 20,
                                  offset: const Offset(17, 17),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                textInputAuth(context: context, controller: nimImput, hintText: "NIM", keyboardType: TextInputType.number, validator: validatorNim, errorText: errorNim),
                                textInputAuth(context: context, controller: emailInput, hintText: "Email", keyboardType: TextInputType.emailAddress, validator: validatorEmail, errorText: errorEmail),
                                textInputAuth(context: context, controller: nameInput, hintText: "Name", validator: validatorName),
                                DropdownButtonFormField(
                                  hint: const Text("Study Program"),
                                  isDense: false,
                                  value: studyProgramInput,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10.0),
                                    hintStyle: TextStyle(color: Themes().grey)
                                  ),
                                  items: studyProgramList.map((e) => DropdownMenuItem(
                                    value: e.toLowerCase(),
                                    child: Text(e),
                                  )).toList(),
                                  validator: validatorStudyProgram,
                                  onChanged: (String? value){
                                    setState(() => studyProgramInput = value);
                                  },
                                ),
                                textInputAuth(context: context, controller: passwordInput, hintText: "Password", obscureText: true, validator: validatorPassword),
                                textInputAuth(context: context, controller: repeatPasswordInput, hintText: "Repeat Password", obscureText: true, last: true, validator: validatorRepeatPassword),
                              ],
                            ),
                          ),
                    
                          const SizedBox(height: 30),
                    
                          Center(
                            child: SizedBox(
                              width: 170,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: onSubmit,
                                style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  elevation: 2,
                                  backgroundColor: Themes().primary
                                ),
                                child: const Center(
                                  child: Text(
                                    "Register",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
        
                    const SizedBox(height: 30),
        
                    Center(
                      child: SizedBox(
                        width: 170,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const Login()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              elevation: 0,
                              backgroundColor: Colors.white
                            ),
                          child: Center(
                            child: Text(
                              "Account ready?",
                              style: TextStyle(
                                color: Themes().primary
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
