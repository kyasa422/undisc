import 'package:flutter/material.dart';
import 'package:undisc/page/discussion_details/discussion_details.dart';
import 'package:undisc/themes/themes.dart';
import '../../../components/card_discussions.dart';
import '../../../components/home/app_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pillCategoryContent = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 80.0),
          children: [
            appBar(context, size),
            const SizedBox(height: 20.0,),
            SizedBox(
              width: double.infinity,
              height: 35.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 10.0,),
                  pill(text: "Featured", active: pillCategoryContent == 1 ? true : false, onTap: (){setState(() => pillCategoryContent = 1);}),
                  pill(text: "Most Recent", active: pillCategoryContent == 2 ? true : false, onTap: (){setState(() => pillCategoryContent = 2);}),
                  pill(text: "Solved", active: pillCategoryContent == 3 ? true : false, onTap: (){setState(() => pillCategoryContent = 3);}),
                  pill(text: "Process", active: pillCategoryContent == 4 ? true : false, onTap: (){setState(() => pillCategoryContent = 4);}),
                  const SizedBox(width: 10.0,),
                ],
              ),
            ),
            const SizedBox(height: 30.0,),
            cardDiscussions(
              size, 
              onTapArticle: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DiscussionDetails())),
              onTapComment: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DiscussionDetails())),
            ),
            const SizedBox(height: 30.0,),
            cardDiscussions(
              size, 
              onTapArticle: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DiscussionDetails())),
              onTapComment: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DiscussionDetails())),
            )
          ],
        ),
      )
    );
  }

  

  InkWell pill({required String text, bool active = false, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.0),
      splashColor: Themes().transparent,
      highlightColor: Themes().transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: active ? Themes().grey300 : Themes().grey100,
        ),
        child: Text(text),
      ),
    );
  }
}