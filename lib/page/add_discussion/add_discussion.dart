import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:undisc/lang/lang.dart';
import 'package:undisc/themes/themes.dart';

import '../../components/dialog_success.dart';
import '../../components/dialog_waiting.dart';

class AddDiscussion extends StatefulWidget {
  const AddDiscussion({Key? key}) : super(key: key);

  @override
  State<AddDiscussion> createState() => _AddDiscussionState();
}

class _AddDiscussionState extends State<AddDiscussion> {
  bool submitForCampus = false;
  String? selectReport;

  @override
  Widget build(BuildContext context) {
    List<String> dropdownItem = ["Biro Keuangan", "Akademik", "Pbael", "Kemahasiswaan", "Biro Sarana & Prasarana", "Konseling"];
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(Lang().addDiscussion),
        elevation: 0.0,
        backgroundColor: Themes().transparent,
        foregroundColor: Themes().primary,
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: Lang().discussionTitle,
                hintText: "E-learning assessment method...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                )
              ),
            ),
            const SizedBox(height: 10.0,),
            TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 10,
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                labelText: Lang().discussionContent,
                alignLabelWithHint: true,
                hintText: "I'm really having a hard time with the current e-learning assessment method...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                )
              ),
            ),
            const SizedBox(height: 10.0,),
            CheckboxListTile(
              value: submitForCampus,
              dense: true,
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
                side: const BorderSide()
              ),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    onChanged: (value){
                      setState(() {
                        selectReport = value as String?;
                      });
                    },
                    value: selectReport,
                    hint: const Text("Select report destination"),
                    items: dropdownItem.map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    )).toList(),
                  ),
                ),
              ),
            ) : Container(),
            const SizedBox(height: 10.0,),
            MaterialButton(
              onPressed: () async {
                dialogWating(context, size);
                await Future.delayed(const Duration(seconds: 5), (){
                  Navigator.pop(context);
                  dialogSuccess(context, size);
                });
              },
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
    );
  }
}