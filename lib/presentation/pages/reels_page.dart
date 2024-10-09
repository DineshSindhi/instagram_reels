import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_pp/presentation/pages/reels_dat.dart';

class ReelsPage extends StatefulWidget {
  @override
  State<ReelsPage> createState() => _ReelsPageState();
}
class _ReelsPageState extends State<ReelsPage> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  late CollectionReference mReels;
  PageController? pageController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: fireStore.collection('reels').get(),
          builder: (_,snapshot){
             if(snapshot.hasData){
              return PageView.builder(
                    controller: pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var mData=snapshot.data!.docs[index].data();
                      if(snapshot.hasData){
                        return ReelsData(mData,snapshot.data!.docs[index].id);
                      }
                      return Container() ;
                    });
            }
            return Container();
          },
        )
    );
  }
}