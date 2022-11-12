import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:undisc/components/card_discussions.dart';
import 'package:undisc/lang/lang.dart';
import 'package:undisc/page/profile/photo_zoom.dart';
import 'package:undisc/page/settings/settings.dart';
import 'package:undisc/page/splash_screen/splash_screen.dart';
import 'package:undisc/themes/themes.dart';

class Profile extends StatefulWidget {
  final String uid;
  const Profile({Key? key, required this.uid}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late FirebaseAuth user;
  late CollectionReference dbUser;

  Map<String, dynamic> dataUser = {};

  @override
  void initState(){
    super.initState();
    user = FirebaseAuth.instance;
    dbUser = FirebaseFirestore.instance.collection("users");
    getData();
  }

  void getData() async{
    await dbUser.where("uid", isEqualTo: widget.uid).get().then((value){
      setState(() {
        dataUser = value.docs.first.data() as Map<String, dynamic>;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Themes().transparent,
        foregroundColor: Themes().primary,
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        border: Border.all(color: Themes().primary, width: 3.0),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 9),
                            spreadRadius: 4.0,
                            blurRadius: 10,
                            color: Themes().grey300
                          )
                        ]
                      ),
                      child: Hero(
                        tag: "Profile",
                        child: dataUser.isNotEmpty && dataUser["photoURL"] != null ? InkWell(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PhotoZoom(urlPhoto: dataUser['photoURL']))),
                          borderRadius: BorderRadius.circular(100.0),
                          child: CircleAvatar(
                            radius: (size.width + size.height) / 22.0,
                            backgroundImage: NetworkImage(dataUser["photoURL"]),
                          ),
                        ) : CircleAvatar(
                          backgroundColor: Themes().transparent,
                          radius: (size.width + size.height) / 22.0,
                          backgroundImage: const AssetImage("lib/assets/images/user.png"),
                        ),
                      ),
                    ),

                    Container(width: 2.0, height: size.height / 20.0, color: Themes().grey300,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "10",
                          style: TextStyle(
                            fontSize: (size.width + size.height) / 50.0
                          ),
                        ),

                        Text(
                          "Discussion Post",
                          style: TextStyle(
                            fontSize: (size.width + size.height) / 100.0,
                            color: Themes().grey400
                          ),
                        )
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 30.0,),

                Text(
                  dataUser.isNotEmpty ? dataUser["name"] : "...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: (size.width + size.height) / 40.0
                  ),
                ),
                Text(
                  dataUser.isNotEmpty ? dataUser["study_program"] : "...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Themes().grey300,
                    fontSize: (size.width + size.height) / 60.0
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30.0,),

          Wrap(
            spacing: 8.0,
            alignment: WrapAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(5, 8),
                      spreadRadius: .0,
                      blurRadius: 20,
                      color: Themes().grey300
                    )
                  ]
                ),
                child: InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsProfile())),
                  highlightColor: Themes().transparent,
                  splashColor: Themes().transparent,
                  child: Chip(
                    backgroundColor: Themes().primary,
                    labelStyle: TextStyle(color: Themes().white),
                    label: Wrap(
                      spacing: 3.0,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.userGear, size: 18.0, color: Themes().white,),
                        const Text("Edit Profile"),
                      ],
                    ),
                    padding: const EdgeInsets.all(8.0),
                  ),
                ),
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(5, 8),
                      spreadRadius: .0,
                      blurRadius: 20,
                      color: Themes().grey300
                    )
                  ]
                ),
                child: InkWell(
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                      contentPadding: const EdgeInsets.all(30.0),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FaIcon(FontAwesomeIcons.arrowRightFromBracket, size: (size.width + size.height) / 35.0,),
                          const SizedBox(height: 25.0,),
                          Text("Sign Out", style: TextStyle(fontWeight: FontWeight.bold, fontSize: (size.width + size.height) / 55.0),),
                          const SizedBox(height: 10.0,),
                          Text("Are you sure you want to leave?", style: TextStyle(color: Themes().grey400),),
                          const SizedBox(height: 25.0,),
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  onPressed: () => Navigator.pop(context),
                                  color: Themes().grey100,
                                  textColor: Themes().grey500,
                                  elevation: 0.0,
                                  highlightElevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: const Text("Cancel"),
                                ),
                              ),

                              const SizedBox(width: 10.0,),

                              Expanded(
                                child: MaterialButton(
                                  onPressed: () async => user.signOut().whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (_) => const SplashScreen()))),
                                  color: Themes().danger,
                                  textColor: Themes().white,
                                  elevation: 0.0,
                                  highlightElevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: const Text("Yes"),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ),
                  highlightColor: Themes().transparent,
                  splashColor: Themes().transparent,
                  child: Chip(
                    backgroundColor: Themes().danger,
                    labelStyle: TextStyle(color: Themes().white),
                    label: Wrap(
                      spacing: 3.0,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.arrowRightFromBracket, size: 18.0, color: Themes().white,),
                        const Text("Logout"),
                      ],
                    ),
                    padding: const EdgeInsets.all(8.0),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30.0,),

          ListTile(
            title: Text(Lang().discussion, style: TextStyle(color: Themes().grey400),),
          ),

          Column(
            children: List.generate(10, (index) => Container(margin: const EdgeInsets.only(bottom: 20.0), child: cardDiscussions(size),)),
          )
        ],
      ),
    );
  }
}