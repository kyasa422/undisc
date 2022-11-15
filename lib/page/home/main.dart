import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:undisc/lang/lang.dart';
import 'package:undisc/page/add_discussion/add_discussion.dart';
import 'package:undisc/page/home/home/home.dart';
import 'package:undisc/page/home/my_discussions/my_discussions.dart';
import 'package:undisc/page/home/notifications/notifications.dart';
import 'package:undisc/page/home/search/search.dart';
import 'package:undisc/themes/themes.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int bottomPageController = 0;

  late Stream<QuerySnapshot> dbNotifications;
  late User? user;

  @override
  void initState(){
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    dbNotifications = FirebaseFirestore.instance.collection("notifications").where("destinations", isEqualTo: user?.uid).where("read", isEqualTo: false).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PageController pageController = PageController(initialPage: bottomPageController);

    return WillPopScope(
      onWillPop: () async {
        if(bottomPageController > 0){
          setState(() => bottomPageController = 0);
          pageController.animateToPage(0, duration: const Duration(seconds: 1), curve: Curves.ease);
          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: (index){
            setState(() => bottomPageController = index);
          },
          children: const [
            Home(),
            MyDiscussions(),
            Search(),
            Notifications()
          ],
        ),
        floatingActionButton: bottomPageController < 2  ? FloatingActionButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddDiscussion())),
          backgroundColor: Themes().primary,
          child: const FaIcon(FontAwesomeIcons.plus),
        ) : null,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                selectedIndex: bottomPageController,
                onTabChange: (index){
                  pageController.animateToPage(index, duration: const Duration(seconds: 1), curve: Curves.ease);
                },
                rippleColor: Themes().grey300,
                gap: 8,
                activeColor: Colors.black,
                iconSize: (size.width + size.height) / 77.9,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Themes().grey100,
                color: Colors.black,
                tabs: [
                  GButton(
                    icon: FontAwesomeIcons.house,
                    text: Lang().home,
                  ),
                  GButton(
                    icon: FontAwesomeIcons.icons,
                    text: Lang().myDiscussions,
                  ),
                  GButton(
                    icon: FontAwesomeIcons.magnifyingGlass,
                    text: Lang().search,
                  ),
                  GButton(
                    icon: FontAwesomeIcons.solidBell,
                    leading: StreamBuilder<QuerySnapshot>(
                      stream: dbNotifications,
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return FaIcon(FontAwesomeIcons.solidBell, size: (size.width + size.height) / 77.9,);
                        }

                        if(snapshot.data!.size == 0){
                          return FaIcon(FontAwesomeIcons.solidBell, size: (size.width + size.height) / 77.9,);
                        }

                        return Badge(
                          badgeColor: Themes().primary,
                          badgeContent: Text(snapshot.data!.size.toString(), style: TextStyle(fontSize: (size.width + size.height) / 110.0, color: Themes().white),),
                          position: BadgePosition.topEnd(top: -11, end: -9),
                          child: FaIcon(FontAwesomeIcons.solidBell, size: (size.width + size.height) / 77.9,),
                        );
                      }
                    ),
                    text: Lang().notifications,
                  ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}