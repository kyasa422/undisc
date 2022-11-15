import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../themes/themes.dart';
import 'package:undisc/string_extensions.dart';

Container cardDiscussions(
  Size size,
  {
    Map<String, dynamic>? data,
    Function()? onTapStatus,
    Function()? onTapArticle,
    Function()? onTapComment,
    Function()? onTapVoted,
    bool votedActive = false
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
                  leading: data!['user']['photoURL'] != null ? CircleAvatar(
                    backgroundImage: NetworkImage(data['user']['photoURL']),
                  ) : const CircleAvatar(
                    backgroundImage: AssetImage("lib/assets/images/user.png"),
                  ),
                  title: Text(
                    data['user']['name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: (size.width + size.height) / 90.0,
                      fontWeight: FontWeight.bold
                    ),
                  ), 
                  subtitle: Text(
                    data['user']['role'] == "student" || data['user']['role'] == 'hima' ? data['user']['study_program'].toString().toTitleCase() : 'Universitas Dian Nusantara',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: (size.width + size.height) / 100.0
                    ),
                  ),
                ),
              ),

              onTapStatus != null ? InkWell(
                onTap: onTapStatus,
                child: Chip(label: Text("Timeline", style: TextStyle(fontSize: (size.width + size.height) / 90.0),))
              ) : Container()
            ],
          ),
        ),
        const SizedBox(height: 5.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            data['discussion']['title'],
            style: const TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            DateFormat("dd MMM yyyy").format(DateTime.parse(data['discussion']['date'])).toString(),
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
                data['discussion']['content'],
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
                      onPressed: onTapVoted, 
                      color: votedActive ? Themes().primary : null,
                      icon: votedActive ? const FaIcon(FontAwesomeIcons.solidStar) : const FaIcon(FontAwesomeIcons.star)
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
                    end: data['discussion']['voted'] != null ? double.tryParse(data['discussion']['voted'].toString()) ?? 0.0 : 0.0,
                    duration: const Duration(seconds: 2),
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