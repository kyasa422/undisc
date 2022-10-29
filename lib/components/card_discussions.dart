import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:undisc/lang/lang.dart';

import '../themes/themes.dart';

Container cardDiscussions(
  Size size,
  {
    Function()? onTapStatus,
    Function()? onTapArticle,
    Function()? onTapComment
  }
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20.0),
    padding: const EdgeInsets.symmetric(vertical: 10.0),
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.all(0.0),
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage("https://eugeneputra.web.app/img/img1.jpg"),
                  ),
                  title: Text(
                    "Eugene Feilian Putra Rangga",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: (size.width + size.height) / 90.0,
                      fontWeight: FontWeight.bold
                    ),
                  ), 
                  subtitle: Text(
                    "Teknik Informatika",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: (size.width + size.height) / 100.0
                    ),
                  ),
                ),
              ),

              InkWell(
                onTap: onTapStatus,
                child: Chip(label: Text("Process", style: TextStyle(fontSize: (size.width + size.height) / 90.0),))
              )
            ],
          ),
        ),
        const SizedBox(height: 5.0,),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "Download As PDF",
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "16 Oct 2022",
            style: TextStyle(
              color: Themes().grey400,
              fontSize: (size.height + size.width) / 100
            ),
          ),
        ),
        const SizedBox(height: 5.0,),
        Material(
          color: Themes().transparent,
          child: InkWell(
            onTap: onTapArticle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Text(
                Lang().lorem,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Themes().grey500,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 13.0,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              direction: Axis.horizontal,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 7.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(100.0),
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
                    borderRadius: BorderRadius.circular(100.0),
                    clipBehavior: Clip.hardEdge,
                    color: Themes().transparent,
                    child: IconButton(
                      onPressed: onTapComment, 
                      icon: const FaIcon(FontAwesomeIcons.comments),
                    ),
                  ),
                ),
              ],
            ),

            Container(
              margin: const EdgeInsets.only(right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
            )
          ],
        )
      ],
    )
  );
}