import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:undisc/components/dialog_messages.dart';
import 'package:undisc/components/dialog_waiting.dart';
import 'package:undisc/page/splash_screen/splash_screen.dart';
import '../../components/settings/list_tile_with_editing.dart';
import '../../components/settings/modal_bottom_authenticate_password_for_change_email.dart';
import '../../components/text_form_field.dart';
import '../../themes/themes.dart';

class SettingAccount extends StatefulWidget {
  const SettingAccount({super.key});

  @override
  State<SettingAccount> createState() => _SettingAccountState();
}

class _SettingAccountState extends State<SettingAccount> {
  late User? user;
  late CollectionReference dbUser;
  Map<String, dynamic> dataUser = {};

  GlobalKey<FormState> formKeyEmail = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyName = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPassword = GlobalKey<FormState>();

  TextEditingController inputName = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPasswordForChangeEmail = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  TextEditingController inputNewPassword = TextEditingController();
  TextEditingController inputReNewPassword = TextEditingController();

  @override
  void initState(){
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    dbUser = FirebaseFirestore.instance.collection("users");
    getDataUser();
  }

  void getDataUser() async {
    await dbUser.where("uid", isEqualTo: user!.uid).get()
      .then((value){
        setState(() {
          dataUser = value.docs.single.data() as Map<String, dynamic>;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String? validator(String? value){
      if(value!.trim().isEmpty){
        return "Input cannot be empty!";
      }

      return null;
    }

    String? validatorEmail(String? value){
      if(value!.trim().isEmpty){
        return "Input cannot be empty!";
      }

      if(value == dataUser['email']){
        return "You can't use the same email!";
      }

      return null;
    }


    String? validatorPassword(String? value){
      if(value!.trim().isEmpty){
        return "Input cannot be empty!";
      }

      if(value.length < 8){
        return "Password cannot be less than 8 characters!";
      }

      return null;
    }

    void onSubmitChangeName() async{
      if(formKeyName.currentState!.validate()){
        dialogWating(context, size);
        await dbUser.where("uid", isEqualTo: dataUser['uid']).get()
          .then((value) async{
            dbUser.doc(value.docs.single.id).update({"name": inputName.text})
              .then((_){
                inputName.clear();
                getDataUser();
                Navigator.pop(context);
                Navigator.pop(context);
              }).catchError((_) {dialogMessages(context: context, title: "Error!", messages: "Server Error!", size: size);});
          }).catchError((_) {dialogMessages(context: context, title: "Error!", messages: "Server Error!", size: size);});
      }
    }

    void onSubmitChangeEmail() async {
      if(formKeyEmail.currentState!.validate()){
        dialogWating(context, size);
        await dbUser.where("email", isEqualTo: inputEmail.text).get()
          .then((value) async{
            if(value.size == 0){
              await modalBottomAuthenticatePasswordForChangeEmail(
                context: context,
                controller: inputPasswordForChangeEmail,
                validator: validatorPassword, 
                onCancel: () {
                  inputEmail.clear();
                  inputPasswordForChangeEmail.clear();

                  formKeyEmail.currentState!.reset();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                onSubmit: () {
                  if(!Crypt(dataUser['password']).match(inputPasswordForChangeEmail.text)){
                    dialogMessages(context: context, title: "Error!", messages: "Wrong Password!", size: size);
                  }else{
                    Navigator.pop(context);
                  }
                }
              ).whenComplete(() async {
                if(inputPasswordForChangeEmail.text.isNotEmpty || inputPasswordForChangeEmail.text.trim() != ""){
                  try{
                    await user?.updateEmail(inputEmail.text)
                      .then((_) async {
                        try{
                          await user?.reauthenticateWithCredential(EmailAuthProvider.credential(
                            email: inputEmail.text, 
                            password: inputPasswordForChangeEmail.text
                          ))
                            .whenComplete(() async{
                              await dbUser.where("uid", isEqualTo: dataUser['uid']).get()
                                .then((value) async{
                                  dbUser.doc(value.docs.single.id).update({"email": inputEmail.text})
                                    .then((_) async {
                                      await user?.reload()
                                        .then((_) async{
                                          await user?.sendEmailVerification()
                                            .then((_){
                                              inputEmail.clear();
                                              inputPasswordForChangeEmail.clear();
                                              formKeyEmail.currentState!.reset();
                                              Navigator.push(context, MaterialPageRoute(builder: (_) => const SplashScreen()));
                                            });
                                        });
                                    }).catchError((error){
                                      Navigator.pop(context);
                                      dialogMessages(context: context, title: "Error!", messages: "Server Error!", size: size);
                                    });
                                }).catchError((error){
                                  Navigator.pop(context);
                                  dialogMessages(context: context, title: "Error!", messages: "Server Error!", size: size);
                                });
                            }).catchError((error){
                              Navigator.pop(context);
                              dialogMessages(context: context, title: "Error!", messages: "Server Error!", size: size);
                            });
                        }on FirebaseAuthException catch(e){
                          Navigator.pop(context);
                          dialogMessages(context: context, title: "Error!", messages: "Server Error!", size: size);
                        }
                      });
                  }on FirebaseAuthException catch(e){
                    if(e.code == "requires-recent-login"){
                      Navigator.pop(context);
                      dialogMessages(context: context, title: "Error!", messages: "There was an authentication error. Please re-login!", size: size)
                        .then((_) async{
                          FirebaseAuth.instance.signOut()
                            .then((value) => Navigator.push(context, MaterialPageRoute(builder: (_) => const SplashScreen())))
                            .catchError((_) => dialogMessages(context: context, title: "Error!", messages: "Server Error", size: size));
                        });
                    }
                  }
                }
              });
            }else{
              Navigator.pop(context);
              dialogMessages(context: context, title: "Error!", messages: "Email Already!", size: size);
            }
          }).catchError((error){
            Navigator.pop(context);
            dialogMessages(context: context, title: "Error!", messages: "Server Error!", size: size); 
          });
      }
    }

    void onSubmitChangePassword(){
      if(formKeyPassword.currentState!.validate()){
        print("OK");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Account settings"), 
        backgroundColor: Themes().transparent, 
        foregroundColor: Themes().primary,
        elevation: 0.0,
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          Material(
            clipBehavior: Clip.hardEdge,
            child: CircleAvatar(
              backgroundColor: Themes().transparent,
              radius: (size.width + size.height) / 15.0,
              child: Image.asset("lib/assets/images/user.png"),
            ),
          ),
          const SizedBox(height: 10.0,),
          InkWell(
            onTap: (){},
            highlightColor: Themes().transparent,
            splashColor: Themes().transparent,
            child: Text(
              "Change Photo", 
              textAlign: TextAlign.center,
              style: TextStyle(color: Themes().grey400),
            ),
          ),
          const SizedBox(height: 20.0,),
          listTileWithEditing(
            context: context, 
            formKey: formKeyEmail,
            title: "Email",
            subtitle: dataUser.isNotEmpty ? dataUser['email'] : '...', 
            hintText: "What's your new email?", 
            controller: inputEmail, 
            validator: validatorEmail,
            keyboardType: TextInputType.emailAddress,
            onSubmit: onSubmitChangeEmail
          ),
          const SizedBox(height: 20.0,),
          listTileWithEditing(
            context: context, 
            formKey: formKeyName,
            title: "Name",
            subtitle: dataUser.isNotEmpty ? dataUser['name'] : '...', 
            hintText: "What's your new name?", 
            controller: inputName, 
            validator: validator,
            keyboardType: TextInputType.name,
            onSubmit: onSubmitChangeName
          ),
          const SizedBox(height: 10.0,),
        ],
      ),
    );
  }
}