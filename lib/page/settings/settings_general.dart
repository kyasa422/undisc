import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:undisc/components/dialog_waiting.dart';
import 'package:undisc/themes/themes.dart';
import '../../components/dialog_messages.dart';
import '../../components/settings/list_tile_with_editing.dart';
import '../../components/text_form_field.dart';
import '../splash_screen/splash_screen.dart';

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

  Map<String, dynamic> dataUser = {};
  late CollectionReference dbUser;
  late User? user;

  @override
  void initState(){
    super.initState();
    dbUser = FirebaseFirestore.instance.collection("users");
    user = FirebaseAuth.instance.currentUser;
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

    String? validatorPassword(String? value){
      if(value!.trim().isEmpty){
        return "Input cannot be empty!";
      }

      if(value.length < 8){
        return "Password cannot be less than 8 characters!";
      }

      if(!Crypt(dataUser['password']).match(value)){
        return "Wrong Password";
      }

      return null;
    }

    String? validatorNewPassword(String? value){
      if(value!.trim().isEmpty){
        return "Input cannot be empty!";
      }

      if(value.length < 8){
        return "Password cannot be less than 8 characters!";
      }

      if(value == inputPassword.text){
        return "The new password cannot be the same as the old one!";
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

      if(value != inputNewPassword.text){
        return "Passwords are not the same!";
      }

      return null;
    }

    void onSubmit() async{
      if(formKey.currentState!.validate()){
        dialogWating(context, size);
        try{
          await user?.updatePassword(inputNewPassword.text)
            .then((value) async {
              try {
                await user?.reauthenticateWithCredential(EmailAuthProvider.credential(
                  email: dataUser['email'], 
                  password: inputNewPassword.text
                )).then((_) async{
                  await dbUser.where("uid", isEqualTo: dataUser['uid']).get()
                    .then((value) async{
                      await dbUser.doc(value.docs.single.id).update({"password": Crypt.sha256(inputNewPassword.text).toString()})
                        .then((_) async{
                          await user?.reload()
                            .then((_){
                              getDataUser();
                              inputPassword.clear();
                              inputNewPassword.clear();
                              inputReNewPassword.clear();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                        });
                    });
                });
              } on FirebaseAuthException catch (_) {
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
        }catch(e){
          Navigator.pop(context);
          dialogMessages(context: context, title: "Error!", messages: "Server Error!", size: size);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("General Settings"), backgroundColor: Themes().transparent, foregroundColor: Themes().primary, elevation: 0.0,),
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
                    textFormField(controller: inputNewPassword, hintText: "Enter new password", obscureText: true, validator: validatorNewPassword),
                    const SizedBox(height: 10.0,),
                    textFormField(controller: inputReNewPassword, hintText: "Re-enter new password", obscureText: true, validator: validatorReNewPassword),
                    const SizedBox(height: 5.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          onPressed: (){
                            inputPassword.clear();
                            inputNewPassword.clear();
                            inputReNewPassword.clear();
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
        ],
      ),
    );
  }
}