import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:undisc/components/dialog_messages.dart';
import 'package:undisc/page/discussion_details/discussion_details.dart';
import 'package:undisc/page/discussion_timeline/discussion_timeline.dart';
import 'package:undisc/page/profile/profile.dart';
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
  int limitContent = 10;
  String orderBy = "date";

  late CollectionReference dbUsers;
  late CollectionReference dbVotedDiscussion;
  late CollectionReference dbDiscussion;
  late User? user;

  @override
  void initState() {
    super.initState();
    dbUsers = FirebaseFirestore.instance.collection("users");
    user = FirebaseAuth.instance.currentUser;
    dbDiscussion = FirebaseFirestore.instance.collection("discussion");
    dbVotedDiscussion = FirebaseFirestore.instance.collection("voted_discussion");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 80.0),
          children: [
            // AppBar
            FutureBuilder<QuerySnapshot<Object?>>(
              future: dbUsers.where("uid", isEqualTo: user?.uid).get(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return appBar(
                    context, 
                    size, 
                    {
                      "name": "...", 
                      "photoURL": CircleAvatar(backgroundImage: const AssetImage('lib/assets/images/user.png'), backgroundColor: Themes().transparent,)
                    }
                  );
                }

                Map<String, dynamic> dataUser = snapshot.data!.docs.single.data() as Map<String, dynamic>;
                return appBar(
                  context, 
                  size, 
                  {
                    "name": dataUser['name'], 
                    "photoURL": dataUser['photoURL'] != null ? 
                      CircleAvatar(backgroundImage: NetworkImage(dataUser['photoURL']), backgroundColor: Themes().transparent,) : 
                      CircleAvatar(backgroundImage: const AssetImage('lib/assets/images/user.png'), backgroundColor: Themes().transparent,)
                  },
                  onTapAvatar: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Profile(uid: dataUser['uid']))),
                );
              }
            ),
            // End App Bar


            const SizedBox(
              height: 20.0,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: pill(
                      text: "Featured",
                      active: pillCategoryContent == 1 ? true : false,
                      onTap: () {
                        setState((){
                          pillCategoryContent = 1;
                          orderBy = "voted";
                        });
                      }
                    ),
                  ),
                  Expanded(
                    child: pill(
                      text: "Most Recent",
                      active: pillCategoryContent == 2 ? true : false,
                      onTap: () {
                        setState((){
                          pillCategoryContent = 2;
                          orderBy = "date";
                        });
                      }
                    ),
                  ),
                ],
              ),
            ),

            
            const SizedBox(
              height: 30.0,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: dbDiscussion.limit(limitContent).orderBy(orderBy, descending: true).snapshots(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                }

                return Column(
                  children: snapshot.data!.docs.map((e){
                    Map<String, dynamic> dataDiscussion = e.data() as Map<String, dynamic>;

                    return FutureBuilder<QuerySnapshot<Object?>>(
                      future: dbUsers.where("uid", isEqualTo: dataDiscussion['uid']).get(),
                      builder: ((context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return const CircularProgressIndicator();
                        }

                        Map<String, dynamic> data = {"user": snapshot.data!.docs.single.data(), "discussion": dataDiscussion};
                        return FutureBuilder<QuerySnapshot<Object?>>(
                          future: dbVotedDiscussion.where("uid", isEqualTo: user!.uid).where("id_discussion", isEqualTo: e.id).get(),
                          builder: (context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return const CircularProgressIndicator();
                            }

                            return AnimatedContainer(
                              margin: const EdgeInsets.only(bottom: 30.0),
                              duration: const Duration(milliseconds: 500),
                              child: cardDiscussions(
                                size,
                                data: data,
                                onTapArticle: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DiscussionDetails())),
                                onTapComment: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DiscussionDetails())),
                                onTapStatus: data['user']['uid'] == user!.uid ? () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DiscussionTimeline())) : null,
                                votedActive: snapshot.data!.size == 1 ? true : false,
                                onTapVoted: () async {
                                  if(snapshot.data!.size == 1){
                                    await dbVotedDiscussion.doc(snapshot.data!.docs.single.id).delete().then((_) async{
                                      await dbDiscussion.doc(e.id).update({"voted": data['discussion']['voted'] - 1});
                                    }).catchError((_){
                                      dialogMessages(context: context, title: "Error!", messages: "Server Error", size: size);
                                    });
                                  }else{
                                    await dbVotedDiscussion.add({
                                      "id_discussion": e.id,
                                      "uid": user?.uid,
                                      "date": DateTime.now()
                                    }).then((_) async{
                                      await dbDiscussion.doc(e.id).update({"voted": data['discussion']['voted'] + 1});
                                    }).catchError((_){
                                      dialogMessages(context: context, title: "Error!", messages: "Server Error", size: size);
                                    });
                                  }
                                }
                              ),
                            );
                          }
                        );
                      }),
                    );
                  }).toList()
                );
              }
            ),
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
        child: Text(text, textAlign: TextAlign.center,),
      ),
    );
  }
}
