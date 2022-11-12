import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:undisc/page/discussion_details/discussion_details.dart';
import 'package:undisc/themes/themes.dart';

import '../../../lang/lang.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0).add(const EdgeInsets.only(top: 20.0, bottom: 80.0)),
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(top: 12.0, left: 12.0),
                  child: FaIcon(FontAwesomeIcons.magnifyingGlass),
                ),
                filled: true,
                fillColor: Themes().grey300,
                hintText: Lang().hintSearchInput,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none
                )
              ),
            ),

            const SizedBox(height: 20.0,),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
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
                borderRadius: BorderRadius.circular(10.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10.0),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DiscussionDetails())),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.all(0.0),
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage("https://eugeneputra.web.app/img/img1.jpg"),
                      ),
                      title: const Text("Wc tidak bersih!"),
                      subtitle: Text(
                        Lang().lorem,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}