import 'package:flutter/material.dart';
import 'package:undisc/components/card_discussions.dart';
import 'package:undisc/lang/lang.dart';
import 'package:undisc/page/discussion_timeline/discussion_timeline.dart';

class MyDiscussions extends StatelessWidget {
  const MyDiscussions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 20.0, bottom: 80.0),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                Lang().myDiscussions,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: (size.width + size.height) / 45.0
                ),
              ),
            ),
            const SizedBox(height: 8.0,),
            cardDiscussions(size, onTapStatus: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DiscussionTimeline())))
          ],
        ),
      ),
    ); 
  }
}