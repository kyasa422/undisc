import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:undisc/components/dialog_messages.dart';
import 'package:undisc/components/dialog_waiting.dart';
import 'package:undisc/components/text_form_field.dart';
import 'package:undisc/lang/lang.dart';
import 'package:undisc/themes/themes.dart';

class AddDiscussion extends StatefulWidget {
  const AddDiscussion({Key? key}) : super(key: key);

  @override
  State<AddDiscussion> createState() => _AddDiscussionState();
}

class _AddDiscussionState extends State<AddDiscussion> {
  bool submitForCampus = false;
  String? selectReport;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late CollectionReference dbDiscussion;
  late CollectionReference dbDiscussionStatus;
  late CollectionReference dbNotifications;
  late CollectionReference dbUser;
  late User? user;

  TextEditingController titleInput = TextEditingController();
  TextEditingController contentInput = TextEditingController();

  @override
  void initState(){
    super.initState();
    dbDiscussion = FirebaseFirestore.instance.collection("discussion");
    dbDiscussionStatus = FirebaseFirestore.instance.collection("discussion_status");
    dbNotifications = FirebaseFirestore.instance.collection("notifications");
    dbUser = FirebaseFirestore.instance.collection("users");
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> dropdownItem = ["Biro Keuangan", "Akademik", "Pbael", "Kemahasiswaan", "Biro Sarana & Prasarana", "Konseling"];

    String? validator(String? value){
      if(value!.isEmpty){
        return "Input cannot be empty!";
      }

      return null;
    }

    void onSubmit() async{
      if(formKey.currentState!.validate()){
        dialogWating(context, size);
        await dbUser.where("uid", isEqualTo: user?.uid).get()
          .then((value) async{
            Map<String, dynamic> dataUser = value.docs.single.data() as Map<String, dynamic>;
            await dbDiscussion.add({
              "uid": dataUser['uid'],
              "destination": selectReport?.toLowerCase(),
              "hima": dataUser['study_program'],
              "title": titleInput.text,
              "content": contentInput.text,
              "date": DateTime.now().toString(),
              "voted": 0
            }).then((value) async{
              await dbDiscussionStatus.add({
                "id_discussion": value.id,
                "progress": "publish",
                "status": "accepted",
                "title": "Discussion successfully published",
                "messages": "Your discussion has been published successfully. Keep the words so that the discussion is not deleted by the Student Association or the campus.",
                "time": DateTime.now().toString()
              }).then((_) async{
                if(selectReport != null){
                  await dbDiscussionStatus.add({
                    "id_discussion": value.id,
                    "progress": "hima",
                    "status": "waiting",
                    "title": "Waiting for approval from the Student Association",
                    "messages": "Your discussion will be filtered by the Student Association to be forwarded to the Campus.",
                    "time": null
                  }).then((_) async{
                    await dbUser.where("role", isEqualTo: "hima").where("study_program", isEqualTo: dataUser['study_program']).get()
                      .then((value) async{
                        Map<String, dynamic> dataUserHima = value.docs.single.data() as Map<String, dynamic>;
                        await dbNotifications.add({
                          "destinations": dataUserHima['uid'],
                          "title": "Ask for approval",
                          "content": "There is a discussion that will be forwarded to the campus, please filter this discussion before it is forwarded to the campus.",
                          "read": false,
                          "date": DateTime.now()
                        }).then((_){
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                      });
                  });
                }else{
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              });
            });
          }).catchError((_){
            Navigator.pop(context);
            dialogMessages(context: context, title: "Error", messages: "Server Error", size: size);
          });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(Lang().addDiscussion),
        elevation: 0.0,
        backgroundColor: Themes().transparent,
        foregroundColor: Themes().primary,
      ),

      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              children: [
                textFormField(
                  hintText: "E-learning assessment method...",
                  validator: validator,
                  controller: titleInput,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next
                ),
                const SizedBox(height: 10.0,),
                textFormField(
                  hintText: "I'm really having a hard time with the current e-learning assessment method...",
                  minLines: 10,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  validator: validator,
                  controller: contentInput
                ),
                const SizedBox(height: 10.0,),
                CheckboxListTile(
                  value: submitForCampus,
                  dense: true,
                  checkColor: Themes().white,
                  activeColor: Themes().primary,
                  checkboxShape: const CircleBorder(),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(Lang().submitReportForCampus),
                  onChanged: (value){
                    setState((){
                      submitForCampus = value!;
                      !value ? selectReport = null : null;
                    });
                  }
                ),
                const SizedBox(height: 10.0,),
                submitForCampus ? Material(
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      onChanged: (value){
                        setState(() {
                          selectReport = value as String?;
                        });
                      },
                      value: selectReport,
                      hint: const Text("Select report destination"),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Themes().grey300,
                        border: InputBorder.none,
                      ),
                      validator: (String? value) => value == null ? "Input cannot be empty!" : null,
                      items: dropdownItem.map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      )).toList(),
                    ),
                  ),
                ) : Container(),
                const SizedBox(height: 10.0,),
                MaterialButton(
                  onPressed: onSubmit,
                  color: Themes().primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  elevation: 0.0,
                  highlightElevation: 0.0,
                  padding: const EdgeInsets.all(10.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 20.0,
                    children: [
                      FaIcon(FontAwesomeIcons.paperPlane, color: Themes().white,),
                      Text("Posting", style: TextStyle(color: Themes().white),)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}