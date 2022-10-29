import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:undisc/components/card_discussions.dart';
import 'package:undisc/lang/lang.dart';
import 'package:undisc/themes/themes.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

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
                        child: CircleAvatar(
                          radius: (size.width + size.height) / 22.0,
                          backgroundImage: const NetworkImage("https://eugeneputra.web.app/img/img1.jpg"),
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
                  "Eugene Feilian Putra Rangga",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: (size.width + size.height) / 40.0
                  ),
                ),
                Text(
                  "Teknik Informatika",
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