import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:undisc/components/card_discussion_load.dart';
import 'package:undisc/components/card_discussions.dart';
import 'package:undisc/components/dialog_messages.dart';
import 'package:undisc/lang/lang.dart';

class MyDiscussions extends StatefulWidget {
  const MyDiscussions({Key? key}) : super(key: key);

  @override
  State<MyDiscussions> createState() => _MyDiscussionsState();
}

class _MyDiscussionsState extends State<MyDiscussions> {
  int limitDiscussion = 10;

  late CollectionReference dbDiscussion;
  late CollectionReference dbVotedDiscussion;
  late CollectionReference dbUser;
  late User? user;

  @override
  void initState(){
    super.initState();
    dbDiscussion = FirebaseFirestore.instance.collection("discussion");
    dbVotedDiscussion = FirebaseFirestore.instance.collection("voted_discussion");
    dbUser = FirebaseFirestore.instance.collection("users");
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {setState((){});},
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
              FutureBuilder<QuerySnapshot>(
                future: dbUser.where("uid", isEqualTo: user?.uid).get(),
                builder: (context, snapshotUser) {
                  if(snapshotUser.connectionState == ConnectionState.waiting){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(10, (index) => Container(margin: const EdgeInsets.only(bottom: 30.0), child: cardDiscussionsLoad(size))),
                    );
                  }
        
                  return FutureBuilder<QuerySnapshot<Object?>>(
                    future: dbDiscussion.limit(limitDiscussion).where("uid", isEqualTo: user?.uid).get(),
                    builder: (context, snapshotDiscussion) {
                      if(snapshotDiscussion.connectionState == ConnectionState.waiting){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(10, (index) => Container(margin: const EdgeInsets.only(bottom: 30.0), child: cardDiscussionsLoad(size))),
                        );
                      }

                      if(snapshotDiscussion.data!.size == 0){
                        return Column(
                          children: [
                            Image.asset(
                              "lib/assets/images/online_discussion.png",
                              height: size.height / 1.7,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Text(
                                "You haven't had a discussion yet. Make your discussion",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: (size.width + size.height) / 60.0
                                ),
                              )
                            )
                          ],
                        );
                      }
              
                      return Column(
                        children: snapshotDiscussion.data!.docs.map((e){
                          Map<String, dynamic> dataDiscussion = e.data() as Map<String, dynamic>;
              
                          return StreamBuilder<QuerySnapshot>(
                            stream: dbVotedDiscussion.where("id_discussion", isEqualTo: e.id).snapshots(),
                            builder: (context, snapshotVotedDiscussion) {
                              if(snapshotVotedDiscussion.connectionState == ConnectionState.waiting){
                                return Container(margin: const EdgeInsets.only(bottom: 30.0), child: cardDiscussionsLoad(size));
                              }
              
                              Map<String, dynamic> data = {"user": snapshotUser.data!.docs.single.data(), "discussion": dataDiscussion, "voted": snapshotVotedDiscussion.data!.size.toDouble()};
                              int checkUserVoted = snapshotVotedDiscussion.data!.docs.where((element) => (element.data() as Map<String, dynamic>)['uid'] == user?.uid).toList().length;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                margin: const EdgeInsets.only(bottom: 30.0),
                                child: cardDiscussions(
                                  size,
                                  data: data,
                                  votedActive: checkUserVoted == 1 ? true : false,
                                  onTapVoted: () async {
                                    if(checkUserVoted == 1){
                                      await snapshotVotedDiscussion.data!.docs.where((element) => (element.data() as Map<String, dynamic>)['uid'] == user?.uid).single.reference.delete().then((_) async {
                                        await e.reference.update({"voted": snapshotVotedDiscussion.data!.size - 1});
                                      }).catchError((_){
                                        dialogMessages(context: context, title: "Error!", messages: "Server Error!", size: size);
                                      });
                                    }else{
                                      await dbVotedDiscussion.add({
                                        "id_discussion": e.id,
                                        "uid": user?.uid,
                                        "date": DateTime.now()
                                      }).then((value) async {
                                        await e.reference.update({"voted": snapshotVotedDiscussion.data!.size + 1});
                                      }).catchError((_) {
                                        dialogMessages(context: context, title: "Error!", messages: "Server Error!", size: size);
                                      });
                                    }
                                  }
                                ),
                              );
                            }
                          );
                        }).toList(),
                      );
                    }
                  );
                }
              )
            ],
          ),
        ),
      ),
    ); 
  }
}