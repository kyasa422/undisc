import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:undisc/components/dialog_waiting.dart';
import 'package:undisc/lang/lang.dart';
import 'package:undisc/themes/themes.dart';

import '../../components/dialog_success.dart';
import '../../components/discussion_details/modal_bottom_send_message.dart';

class DiscussionDetails extends StatefulWidget {
  const DiscussionDetails({Key? key}) : super(key: key);

  @override
  State<DiscussionDetails> createState() => _DiscussionDetailsState();
}

class _DiscussionDetailsState extends State<DiscussionDetails> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FocusNode inputCommentNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        title: Text(Lang().discussion),
        elevation: 0.0,
        backgroundColor: Themes().transparent,
        foregroundColor: Themes().primary,
      ),

      bottomNavigationBar: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0).add(EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
        color: Themes().white,
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: TextFormField(
                focusNode: inputCommentNode,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Themes().grey300,
                  isDense: true,
                  hintText: "${Lang().giveYourComment}...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none
                  )
                ),
              ),
            ),

            const SizedBox(width: 5.0,),

            Material(
              clipBehavior: Clip.hardEdge,
              shape: const CircleBorder(),
              child: IconButton(
                onPressed: (){}, 
                icon: const FaIcon(FontAwesomeIcons.paperPlane)
              ),
            )
          ],
        )
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    children: [
                      Text(
                        Lang().notifications,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: (size.width + size.height) / 50.0
                        ),
                      ),
                
                      Text(
                        "28 Oct 2022",
                        style: TextStyle(
                          color: Themes().grey400,
                          fontSize: (size.width + size.height) / 90.0
                        ),
                      )
                    ],
                  ),
          
                  InkWell(
                    onTap: (){},
                    child: Chip(label: Text("Process", style: TextStyle(fontSize: (size.width + size.height) / 90.0),))
                  )
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                Lang().lorem,
                style: TextStyle(
                  color: Themes().grey500,
                  fontSize: (size.width + size.height) / 75.0
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 7.0),
                      child: Material(
                        shape: const CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        color: Themes().transparent,
                        child: IconButton(
                          onPressed: (){}, 
                          icon: const FaIcon(FontAwesomeIcons.star),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 7.0),
                      child: Material(
                        shape: const CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        color: Themes().transparent,
                        child: IconButton(
                          onPressed: () => inputCommentNode.requestFocus(), 
                          icon: const FaIcon(FontAwesomeIcons.comments),
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: const EdgeInsets.only(right: 7.0),
                  child: Material(
                    shape: const CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    color: Themes().transparent,
                    child: IconButton(
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        clipBehavior: Clip.hardEdge,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))
                        ),
                        builder: (_) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              onTap: () => modalBottomSendMessage(context, onSend: () async {
                                dialogWating(context, size);
                                await Future.delayed(const Duration(seconds: 5), (){
                                  Navigator.pop(context);
                                  dialogSuccess(context, size);
                                });
                              }),
                              leading: const FaIcon(FontAwesomeIcons.check),
                              title: Text(Lang().accept),
                            ),
                            ListTile(
                              onTap: () => modalBottomSendMessage(context, onSend: () async {
                                dialogWating(context, size);
                                await Future.delayed(const Duration(seconds: 5), (){
                                  Navigator.pop(context);
                                  dialogSuccess(context, size);
                                });
                              }),
                              leading: const FaIcon(FontAwesomeIcons.xmark),
                              title: Text(Lang().reject),
                            ),
                          ],
                        )
                      ),
                      icon: const FaIcon(FontAwesomeIcons.ellipsisVertical),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Themes().grey100,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(5, 8),
                      spreadRadius: 1,
                      blurRadius: 10,
                      color: Themes().grey300
                  )
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Countup(
                        begin: 0, 
                        end: 2235,
                        duration: const Duration(seconds: 3),
                        separator: ",",
                        style: TextStyle(
                          fontSize: (size.width + size.height) / 50.0
                        ),
                      ),
                
                      Text(
                        "Voted By",
                        style: TextStyle(
                          fontSize: (size.width + size.height) / 100.0,
                          color: Themes().grey400
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 2.0, 
                    color: Themes().grey400, 
                    height: 10.0,
                  ),
                  Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Countup(
                        begin: 0, 
                        end: 10,
                        duration: const Duration(seconds: 3),
                        separator: ",",
                        style: TextStyle(
                          fontSize: (size.width + size.height) / 50.0
                        ),
                      ),
                
                      Text(
                        "Comments",
                        style: TextStyle(
                          fontSize: (size.width + size.height) / 100.0,
                          color: Themes().grey400
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 2.0, 
                    color: Themes().grey400, 
                    height: 10.0,
                  ),
                  Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Countup(
                        begin: 0, 
                        end: 200,
                        duration: const Duration(seconds: 3),
                        separator: ",",
                        style: TextStyle(
                          fontSize: (size.width + size.height) / 50.0
                        ),
                      ),
                
                      Text(
                        "Views",
                        style: TextStyle(
                          fontSize: (size.width + size.height) / 100.0,
                          color: Themes().grey400
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      "Comments",
                      style: TextStyle(
                        color: Themes().grey400
                      ),
                    ), 
                    contentPadding: const EdgeInsets.all(0.0),
                  ),

                  ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage("https://eugeneputra.web.app/img/img1.jpg"),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Eugene Feilian Putra Rangga sssssssssssssssss ssssssssss",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Teknik Informatika · 28 Oct 2022",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Themes().grey400,
                            fontSize: (size.width + size.height) / 90.0
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(Lang().lorem),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}