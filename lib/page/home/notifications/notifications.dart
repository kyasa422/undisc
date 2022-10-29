import 'package:flutter/material.dart';
import 'package:undisc/lang/lang.dart';
import 'package:undisc/page/discussion_details/discussion_details.dart';
import 'package:undisc/themes/themes.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 20.0, bottom: 80.0),
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                Lang().notifications,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: (size.width + size.height) / 45.0
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(5, 8),
                    spreadRadius: 0,
                    blurRadius: 10,
                    color: Themes().grey300
                  )
                ]
              ),
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                color: Themes().primary,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DiscussionDetails())),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.all(0.0),
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage("https://eugeneputra.web.app/img/img1.jpg"),
                      ),
                      title: Text(Lang().discussionForYou, style: TextStyle(color: Themes().white),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Lang().lorem,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Themes().grey300
                            ),
                          ),
                          Text(
                            "28 Oct 2022",
                            style: TextStyle(
                              color: Themes().grey400
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Themes().grey100,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(5, 8),
                    spreadRadius: 0,
                    blurRadius: 10,
                    color: Themes().grey300
                  )
                ]
              ),
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DiscussionDetails())),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.all(0.0),
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage("https://eugeneputra.web.app/img/img1.jpg"),
                      ),
                      title: Text(Lang().discussionForYou),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Lang().lorem,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "28 Oct 2022",
                            style: TextStyle(
                              color: Themes().grey400
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}