
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_pp/data/model/comment_model.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../data/model/reels_model.dart';
import '../../domain/ui_helper.dart';
import '../theme/theme_mange.dart';
class ReelsData extends StatefulWidget {
  final snapshot;
  String? id;
  ReelsData(this.snapshot,this.id);
  @override
  State<ReelsData> createState() => _ReelsDataState();
}
class _ReelsDataState extends State<ReelsData> {
  var commentController=TextEditingController();
  late VideoPlayerController? mController;
  PageController? pageController;
  bool isVisible = false;
  bool isLike = false;
  int count=0;
  Color? mColor;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    mColor;
    mController = VideoPlayerController.networkUrl(Uri.parse(widget.snapshot['url']));
    if (mController != null) {
      mController!.initialize().then((value){});
      mController!.play();
      mController!.setLooping(true);
      mController!.setVolume(1);
    }
    mController!.addListener(() {
      if(mounted){
        setState(() {

        });
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:mController!=null?
      MediaQuery.of(context).size.width<550?portraitUi():MediaQuery.of(context).size.width>550&&MediaQuery.of(context).size.width<750?landscapeUiIcon():landscapeUi():
          Center(child: Text('Can\'t play video'),)
    );
  }
  portraitUi(){
    var eachData=ReelsModel.fromDoc(widget.snapshot);
    return Center(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Stack(
          children: [
            VideoPlayer(mController!),
            InkWell(
              onTap: () {
                if (mController!.value.isPlaying) {
                  mController!.pause();
                  isVisible = true;

                } else {
                  mController!.play();
                  isVisible = false;

                }
              },
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 100),
                opacity: isVisible ? 1 : 0,
                child: Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black54),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 5,
              right: 12,
              child: AnimatedOpacity(
                opacity: isVisible?0:1,
                duration: Duration(milliseconds: 100),
                child: Column(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    myWidget(() {
                      setState(() {
                        isLike=!isLike;
                        isLike?count=1:isLike==false?count=0:count=1;
                      });
                      fireStore.collection('reels').doc(widget.id).update({
                        'isLike':isLike,
                        'likes': count,
                      });
                    }, eachData.isLike? Icon(Icons.favorite,color:Colors.red):Icon(Icons.favorite_border,color:Colors.white)),
                    myTextW('${eachData.likes}',),
                    mySizeBoxHigh(),
                    myWidget(() {
                      showModalBottomSheet(
                        context: context, builder: (context) {
                        return Container(width: double.infinity,
                          decoration: BoxDecoration(
                            color: context.watch<ThemeProvider>().toggleTheme?Colors.black:Colors.white,
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(20),left:Radius.circular(20) )
                          ),
                          height: 500,
                          child: Column(children: [
                            Container(margin:EdgeInsets.all(5),width: 40,height: 4,decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(10)),),
                            myText22('Comments'),
                            Container(width: double.infinity,height: 2,color: Colors.grey,),
                            Expanded(
                              child: StreamBuilder(
                                stream: fireStore.collection('reels').doc(widget.id).collection('comment').snapshots(),
                                builder: (context, snapshot) {
                                  if(snapshot.connectionState==ConnectionState.waiting){
                                    return Center(child: CircularProgressIndicator());
                                  }
                                   if (snapshot.hasData){
                                    return snapshot.data!.docs.isNotEmpty?ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        var mData= snapshot.data!.docs[index].data();
                                        return ListTile(
                                          leading:CircleAvatar(
                                              backgroundImage:eachData.profile==''?NetworkImage('assets/images/logo.png'):NetworkImage('${eachData.profile}')),
                                          title: myTextNor('${mData['userName']}'),
                                          subtitle: myTextNor('${mData['comment']}'),
                                          trailing: Column(children: [
                                            Icon(Icons.favorite_border),
                                            myTextNor('0',),
                                          ],),
                                        );
                                      },):Center(child: Text('No Comment Yet..'),);
                                  }
                                  return Container();
                                }
                              ),
                            ),
                            TextField(
                              controller: commentController,
                              decoration: InputDecoration(
                              border: OutlineInputBorder(),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      if(commentController.text.isNotEmpty){
                                        CollectionReference mComment= fireStore.collection('reels').doc(widget.id).collection('comment');
                                        var data=CommentModel(
                                          profile: widget.snapshot['profile'],
                                          comment: commentController.text.toString(),
                                          userName: widget.snapshot['userName'],
                                          isLike: false,
                                          like: '0',
                                        );
                                        mComment.add(data.toDoc());
                                      }

                                    },
                                      child: Icon(Icons.send))),
                            ),
                          ],
                          ),
                        );
                      },);
                    }, Icon(Icons.comment,color: Colors.white)),
                    myTextW('0',),
                    mySizeBoxHigh(),
                    myWidget(() {
                      showModalBottomSheet(context: context, builder: (context) {
                        return Container(width: double.infinity,
                          child: Column(children: [
                            Container(margin:EdgeInsets.all(5),width: 40,height: 4,decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(10)),),
                            myText22('Share'),
                            Container(width: double.infinity,height: 2,color: Colors.grey,)
                          ],
                          ),
                        );
                      },);
                    }, Icon(Icons.send,color: Colors.white,)),
                    myTextW('0',),
                    mySizeBoxHigh(),
                    myWidget(() {
                      showModalBottomSheet(context: context, builder: (context) {
                        return Container();
                      },);
                    }, Icon(Icons.more_vert,color: Colors.white)),
                    mySizeBoxHigh(),
                    myWidget(() { }, Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.white)
                      ),
                      child: Center(child: Icon(Icons.music_note_outlined,color: Colors.white),),)),
                  ],),
              ),
            ),
            MediaQuery.of(context).size.height>200?
            AnimatedOpacity(
              opacity: isVisible?0:1,
              duration: Duration(milliseconds: 100),
              child: Column(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  Row(children: [
                    mySizeBox5(),
                    myWidget(() { }, CircleAvatar(
                        backgroundImage:eachData.profile==''?NetworkImage('assets/images/logo.png'):NetworkImage('${eachData.profile}'))),
                    mySizeBox5(),
                    myWidget(() { }, myTextW('${eachData.userName}',)),
                    mySizeBox5(),
                    myWidget(() { }, Container(
                      width: 70,
                      height: 21,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.white)
                      ),
                      child: Center(child: myTextW('Follow',),),)),
                  ],),
                  mySizeBoxHigh(),
                  Row(children: [
                    mySizeBox5(),
                    myTextW('${eachData.description}',),],),
                  mySizeBoxHigh(),
                  Row(children: [
                    mySizeBox5(),
                    Container(
                      height: 22,
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade600),
                      child: FittedBox(
                        child: Row(children: [
                          Icon(Icons.music_note_outlined,color: Colors.white,),
                          mySizeBox5(),
                          myTextW('music',)
                        ],),
                      ),
                    ),
                    mySizeBox5(),
                    Container(
                      height: 22,
                      width: MediaQuery.of(context).size.width>250?180:100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade600),
                      child: FittedBox(
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.account_circle,color: Colors.white),mySizeBox5(),
                            myTextW('${eachData.userName}',)
                          ],),
                      ),
                    ),
                  ],),
                  mySizeBoxHigh5(),
                ],
              ),
            ):Container(),

          ],
        ),
      ),
    );
  }
  landscapeUi(){
    var eachData=ReelsModel.fromDoc(widget.snapshot);
    return  MediaQuery.of(context).size.width>640&&MediaQuery.of(context).size.height>737?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 650,
                width: 500,
                child: Row(
                  children: [
                    Container(
                      height: 650,
                      width: 380,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          VideoPlayer(mController!),
                          InkWell(
                            onTap: () {
                              if (mController!.value.isPlaying) {
                                mController!.pause();
                                isVisible = true;
                                setState(() {

                                });
                              } else {
                                mController!.play();
                                isVisible = false;
                                setState(() {

                                });
                              }
                            },
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 100),
                              opacity: isVisible ? 1 : 0,
                              child: Center(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black54),
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Column(
                            mainAxisAlignment:MainAxisAlignment.end,
                            children: [
                              Row(children: [
                                mySizeBox5(),
                                myWidget(() { }, CircleAvatar(backgroundImage: NetworkImage('${eachData.profile}'),)),
                                mySizeBox5(),
                                myWidget(() { }, myTextW('${eachData.userName}',)),
                                mySizeBox5(),
                                myWidget(() { }, Container(
                                  width: 70,
                                  height: 21,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.white)
                                  ),
                                  child: Center(child: myTextW('Follow',),),)),
                              ],),
                              mySizeBoxHigh(),
                              Row(children: [
                                mySizeBox5(),
                                myTextW('${eachData.description}',),],),
                              mySizeBoxHigh(),
                              Row(children: [
                                mySizeBox5(),
                                Container(
                                  height: 22,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade600),
                                  child: FittedBox(
                                    child: Row(children: [
                                      Icon(Icons.music_note_outlined,color: Colors.white,),
                                      mySizeBox5(),
                                      myTextW('music',)
                                    ],),
                                  ),
                                ),
                                mySizeBox5(),
                                Container(
                                  height: 22,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:Colors.grey.shade600),
                                  child: FittedBox(
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.account_circle,color: Colors.white),mySizeBox5(),
                                        myTextW('${eachData.userName}',)
                                      ],),
                                  ),
                                ),
                              ],),
                              mySizeBoxHigh5(),
                            ],
                          )

                        ],
                      ),
                    ),
                    mySizeBoxHighIcon(),
                    MediaQuery.of(context).size.height>606?
                    Column(mainAxisAlignment: MainAxisAlignment. end,
                      children: [

                        myWidget(() {
                        }, Icon(Icons.favorite_border)),
                        myTextWhite('0',context),
                        mySizeBoxHigh(),
                        myWidget(() {

                        }, Icon(Icons.comment)),
                        myTextWhite('0',context),
                        mySizeBoxHigh(),
                        myWidget(() {
                        }, Icon(Icons.send,)),
                        myTextWhite('0',context),
                        mySizeBoxHigh(),
                        myWidget(() {

                        }, Icon(Icons.more_vert,)),
                        mySizeBoxHigh(),
                        myWidget(() { }, Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all()
                          ),
                          child: Center(child: Icon(Icons.music_note_outlined,),),)),
                      ],):SingleChildScrollView(child:
                    Column(mainAxisAlignment: MainAxisAlignment. center,
                        children: [
                          SizedBox(height: 380,),
                          myWidget(() {
                          }, Icon(Icons.favorite_border)),
                          myTextWhite('0',context),
                          mySizeBoxHigh(),
                          myWidget(() {

                          }, Icon(Icons.comment)),
                          myTextWhite('0',context),
                          mySizeBoxHigh(),
                          myWidget(() {
                          }, Icon(Icons.send,)),
                          myTextWhite('0',context),
                          mySizeBoxHigh(),
                          myWidget(() {

                          }, Icon(Icons.more_vert,)),
                          mySizeBoxHigh(),
                          myWidget(() { }, Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all()
                            ),
                            child: Center(child: Icon(Icons.music_note_outlined,),),)),
                        ],),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ):
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:MediaQuery.of(context).size.height>670?Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 650,
                width: 500,
                child: Row(
                  children: [
                    Container(
                      height: 650,
                      width: 380,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          VideoPlayer(mController!),
                          InkWell(
                            onTap: () {
                              if (mController!.value.isPlaying) {
                                mController!.pause();
                                isVisible = true;
                                setState(() {

                                });
                              } else {
                                mController!.play();
                                isVisible = false;
                                setState(() {

                                });
                              }
                            },
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 100),
                              opacity: isVisible ? 1 : 0,
                              child: Center(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black54),
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Column(
                            mainAxisAlignment:MainAxisAlignment.end,
                            children: [
                              Row(children: [
                                mySizeBox5(),
                                myWidget(() { }, CircleAvatar(backgroundImage: NetworkImage('${eachData.profile}'),)),
                                mySizeBox5(),
                                myWidget(() { }, myTextW('${eachData.userName}',)),
                                mySizeBox5(),
                                myWidget(() { }, Container(
                                  width: 70,
                                  height: 21,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.white)
                                  ),
                                  child: Center(child: myTextW('Follow',),),)),
                              ],),
                              mySizeBoxHigh(),
                              Row(children: [
                                mySizeBox5(),
                                myTextW('${eachData.description}',),],),
                              mySizeBoxHigh(),
                              Row(children: [
                                mySizeBox5(),
                                Container(
                                  height: 22,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade600),
                                  child: FittedBox(
                                    child: Row(children: [
                                      Icon(Icons.music_note_outlined,color: Colors.white,),
                                      mySizeBox5(),
                                      myTextW('music',)
                                    ],),
                                  ),
                                ),
                                mySizeBox5(),
                                Container(
                                  height: 22,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade600),
                                  child: FittedBox(
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.account_circle,color: Colors.white),mySizeBox5(),
                                        myTextW('${eachData.userName}',)
                                      ],),
                                  ),
                                ),
                              ],),
                              mySizeBoxHigh5(),
                            ],
                          )

                        ],
                      ),
                    ),
                    mySizeBoxHighIcon(),
                    MediaQuery.of(context).size.height>606?
                    Column(mainAxisAlignment: MainAxisAlignment. end,
                      children: [

                        myWidget(() {
                        }, Icon(Icons.favorite_border)),
                        myTextWhite('0',context),
                        mySizeBoxHigh(),
                        myWidget(() {

                        }, Icon(Icons.comment)),
                        myTextWhite('0',context),
                        mySizeBoxHigh(),
                        myWidget(() {
                        }, Icon(Icons.send,)),
                        myTextWhite('0',context),
                        mySizeBoxHigh(),
                        myWidget(() {

                        }, Icon(Icons.more_vert,)),
                        mySizeBoxHigh(),
                        myWidget(() { }, Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all()
                          ),
                          child: Center(child: Icon(Icons.music_note_outlined,),),)),
                      ],):SingleChildScrollView(child:
                    Column(mainAxisAlignment: MainAxisAlignment. center,
                      children: [
                        SizedBox(height: 380,),
                        myWidget(() {
                        }, Icon(Icons.favorite_border)),
                        myTextWhite('0',context),
                        mySizeBoxHigh(),
                        myWidget(() {

                        }, Icon(Icons.comment)),
                        myTextWhite('0',context),
                        mySizeBoxHigh(),
                        myWidget(() {
                        }, Icon(Icons.send,)),
                        myTextWhite('0',context),
                        mySizeBoxHigh(),
                        myWidget(() {

                        }, Icon(Icons.more_vert,)),
                        mySizeBoxHigh(),
                        myWidget(() { }, Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all()
                          ),
                          child: Center(child: Icon(Icons.music_note_outlined,),),)),
                      ],),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ):Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: 500,
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: 380,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          VideoPlayer(mController!),
                          InkWell(
                            onTap: () {
                              if (mController!.value.isPlaying) {
                                mController!.pause();
                                isVisible = true;
                                setState(() {

                                });
                              } else {
                                mController!.play();
                                isVisible = false;
                                setState(() {

                                });
                              }
                            },
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 100),
                              opacity: isVisible ? 1 : 0,
                              child: Center(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black54),
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Column(
                            mainAxisAlignment:MainAxisAlignment.end,
                            children: [
                              Row(children: [
                                mySizeBox5(),
                                myWidget(() { }, CircleAvatar(backgroundImage: NetworkImage('${eachData.profile}'),)),
                                mySizeBox5(),
                                myWidget(() { }, myTextW('${eachData.userName}',)),
                                mySizeBox5(),
                                myWidget(() { }, Container(
                                  width: 70,
                                  height: 21,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.white)
                                  ),
                                  child: Center(child: myTextW('Follow',),),)),
                              ],),
                              mySizeBoxHigh(),
                              Row(children: [
                                mySizeBox5(),
                                myTextW('${eachData.description}',),],),
                              mySizeBoxHigh(),
                              Row(children: [
                                mySizeBox5(),
                                Container(
                                  height: 22,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade600),
                                  child: FittedBox(
                                    child: Row(children: [
                                      Icon(Icons.music_note_outlined,color: Colors.white,),
                                      mySizeBox5(),
                                      myTextW('music',)
                                    ],),
                                  ),
                                ),
                                mySizeBox5(),
                                Container(
                                  height: 22,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade600),
                                  child: FittedBox(
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.account_circle,color: Colors.white),mySizeBox5(),
                                        myTextW('${eachData.userName}',)
                                      ],),
                                  ),
                                ),
                              ],),
                              mySizeBoxHigh5(),
                            ],
                          )

                        ],
                      ),
                    ),
                    mySizeBoxHighIcon(),
                    MediaQuery.of(context).size.height>606?
                    Column(mainAxisAlignment: MainAxisAlignment. end,
                      children: [

                        myWidget(() {
                        }, Icon(Icons.favorite_border)),
                        myTextWhite('0',context),
                        mySizeBoxHigh(),
                        myWidget(() {

                        }, Icon(Icons.comment)),
                        myTextWhite('0',context),
                        mySizeBoxHigh(),
                        myWidget(() {
                        }, Icon(Icons.send,)),
                        myTextWhite('0',context),
                        mySizeBoxHigh(),
                        myWidget(() {

                        }, Icon(Icons.more_vert,)),
                        mySizeBoxHigh(),
                        myWidget(() { }, Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all()
                          ),
                          child: Center(child: Icon(Icons.music_note_outlined,),),)),
                      ],):SingleChildScrollView(child:
                    Column(mainAxisAlignment: MainAxisAlignment. center,
                      children: [
                        SizedBox(height: 380,),
                        myWidget(() {
                        }, Icon(Icons.favorite_border)),
                        myTextWhite('0',context),
                        mySizeBoxHigh(),
                        myWidget(() {

                        }, Icon(Icons.comment)),
                        myTextWhite('0',context),
                        mySizeBoxHigh(),
                        myWidget(() {
                        }, Icon(Icons.send,)),
                        myTextWhite('0',context),
                        mySizeBoxHigh(),
                        myWidget(() {

                        }, Icon(Icons.more_vert,)),
                        mySizeBoxHigh(),
                        myWidget(() { }, Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all()
                          ),
                          child: Center(child: Icon(Icons.music_note_outlined,),),)),
                      ],),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
  landscapeUiIcon(){
    var eachData=ReelsModel.fromDoc(widget.snapshot);
    return  MediaQuery.of(context).size.width>640&&MediaQuery.of(context).size.height>737?
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 650,
              width: 500,
              child: Row(
                children: [
                  Container(
                    height: 650,
                    width: 380,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        VideoPlayer(mController!),
                        InkWell(
                          onTap: () {
                            if (mController!.value.isPlaying) {
                              mController!.pause();
                              isVisible = true;
                              setState(() {

                              });
                            } else {
                              mController!.play();
                              isVisible = false;
                              setState(() {

                              });
                            }
                          },
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 100),
                            opacity: isVisible ? 1 : 0,
                            child: Center(
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black54),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Column(
                          mainAxisAlignment:MainAxisAlignment.end,
                          children: [
                            Row(children: [
                              mySizeBox5(),
                              myWidget(() { }, CircleAvatar(backgroundImage: NetworkImage('${eachData.profile}'),)),
                              mySizeBox5(),
                              myWidget(() { }, myTextW('${eachData.userName}',)),
                              mySizeBox5(),
                              myWidget(() { }, Container(
                                width: 70,
                                height: 21,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.white)
                                ),
                                child: Center(child: myTextW('Follow',),),)),
                            ],),
                            mySizeBoxHigh(),
                            Row(children: [
                              mySizeBox5(),
                              myTextW('${eachData.description}',),],),
                            mySizeBoxHigh(),
                            Row(children: [
                              mySizeBox5(),
                              Container(
                                height: 22,
                                width: 180,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade600),
                                child: FittedBox(
                                  child: Row(children: [
                                    Icon(Icons.music_note_outlined,color: Colors.white,),
                                    mySizeBox5(),
                                    myTextW('music',)
                                  ],),
                                ),
                              ),
                              mySizeBox5(),
                              Container(
                                height: 22,
                                width: 180,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade600),
                                child: FittedBox(
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.account_circle,color: Colors.white),mySizeBox5(),
                                      myTextW('${eachData.userName}',)
                                    ],),
                                ),
                              ),
                            ],),
                            mySizeBoxHigh5(),
                          ],
                        )

                      ],
                    ),
                  ),
                  mySizeBoxHighIcon(),
                  MediaQuery.of(context).size.height>606?
                  Column(mainAxisAlignment: MainAxisAlignment. end,
                    children: [

                      myWidget(() {
                      }, Icon(Icons.favorite_border)),
                      myTextWhite('0',context),
                      mySizeBoxHigh(),
                      myWidget(() {

                      }, Icon(Icons.comment)),
                      myTextWhite('0',context),
                      mySizeBoxHigh(),
                      myWidget(() {
                      }, Icon(Icons.send,)),
                      myTextWhite('0',context),
                      mySizeBoxHigh(),
                      myWidget(() {

                      }, Icon(Icons.more_vert,)),
                      mySizeBoxHigh(),
                      myWidget(() { }, Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all()
                        ),
                        child: Center(child: Icon(Icons.music_note_outlined,),),)),
                    ],):SingleChildScrollView(child:
                  Column(mainAxisAlignment: MainAxisAlignment. center,
                    children: [
                      SizedBox(height: 380,),
                      myWidget(() {
                      }, Icon(Icons.favorite_border)),
                      myTextWhite('0',context),
                      mySizeBoxHigh(),
                      myWidget(() {

                      }, Icon(Icons.comment)),
                      myTextWhite('0',context),
                      mySizeBoxHigh(),
                      myWidget(() {
                      }, Icon(Icons.send,)),
                      myTextWhite('0',context),
                      mySizeBoxHigh(),
                      myWidget(() {

                      }, Icon(Icons.more_vert,)),
                      mySizeBoxHigh(),
                      myWidget(() { }, Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all()
                        ),
                        child: Center(child: Icon(Icons.music_note_outlined,),),)),
                    ],),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    ):
    SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:MediaQuery.of(context).size.height>670?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 650,
                  width: 500,
                  child: Row(
                    children: [
                      Container(
                        height: 650,
                        width: 380,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            VideoPlayer(mController!),
                            InkWell(
                              onTap: () {
                                if (mController!.value.isPlaying) {
                                  mController!.pause();
                                  isVisible = true;
                                  setState(() {

                                  });
                                } else {
                                  mController!.play();
                                  isVisible = false;
                                  setState(() {

                                  });
                                }
                              },
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 100),
                                opacity: isVisible ? 1 : 0,
                                child: Center(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black54),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Column(
                              mainAxisAlignment:MainAxisAlignment.end,
                              children: [
                                Row(children: [
                                  mySizeBox5(),
                                  myWidget(() { }, CircleAvatar(backgroundImage: NetworkImage('${eachData.profile}'),)),
                                  mySizeBox5(),
                                  myWidget(() { }, myTextW('${eachData.userName}',)),
                                  mySizeBox5(),
                                  myWidget(() { }, Container(
                                    width: 70,
                                    height: 21,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.white)
                                    ),
                                    child: Center(child: myTextW('Follow',),),)),
                                ],),
                                mySizeBoxHigh(),
                                Row(children: [
                                  mySizeBox5(),
                                  myTextW('${eachData.description}',),],),
                                mySizeBoxHigh(),
                                Row(children: [
                                  mySizeBox5(),
                                  Container(
                                    height: 22,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade600),
                                    child: FittedBox(
                                      child: Row(children: [
                                        Icon(Icons.music_note_outlined,color: Colors.white,),
                                        mySizeBox5(),
                                        myTextW('music',)
                                      ],),
                                    ),
                                  ),
                                  mySizeBox5(),
                                  Container(
                                    height: 22,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade600),
                                    child: FittedBox(
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.account_circle,color: Colors.white),mySizeBox5(),
                                          myTextW('${eachData.userName}',)
                                        ],),
                                    ),
                                  ),
                                ],),
                                mySizeBoxHigh5(),
                              ],
                            )

                          ],
                        ),
                      ),
                      mySizeBoxHighIcon(),
                      MediaQuery.of(context).size.height>606?
                      Column(mainAxisAlignment: MainAxisAlignment. end,
                        children: [

                          myWidget(() {
                          }, Icon(Icons.favorite_border)),
                          myTextWhite('0',context),
                          mySizeBoxHigh(),
                          myWidget(() {

                          }, Icon(Icons.comment)),
                          myTextWhite('0',context),
                          mySizeBoxHigh(),
                          myWidget(() {
                          }, Icon(Icons.send,)),
                          myTextWhite('0',context),
                          mySizeBoxHigh(),
                          myWidget(() {

                          }, Icon(Icons.more_vert,)),
                          mySizeBoxHigh(),
                          myWidget(() { }, Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all()
                            ),
                            child: Center(child: Icon(Icons.music_note_outlined,),),)),
                        ],):SingleChildScrollView(child:
                      Column(mainAxisAlignment: MainAxisAlignment. center,
                        children: [
                          SizedBox(height: 380,),
                          myWidget(() {
                          }, Icon(Icons.favorite_border)),
                          myTextWhite('0',context),
                          mySizeBoxHigh(),
                          myWidget(() {

                          }, Icon(Icons.comment)),
                          myTextWhite('0',context),
                          mySizeBoxHigh(),
                          myWidget(() {
                          }, Icon(Icons.send,)),
                          myTextWhite('0',context),
                          mySizeBoxHigh(),
                          myWidget(() {

                          }, Icon(Icons.more_vert,)),
                          mySizeBoxHigh(),
                          myWidget(() { }, Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all()
                            ),
                            child: Center(child: Icon(Icons.music_note_outlined,),),)),
                        ],),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ):Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: 500,
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: 380,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            VideoPlayer(mController!),
                            InkWell(
                              onTap: () {
                                if (mController!.value.isPlaying) {
                                  mController!.pause();
                                  isVisible = true;
                                  setState(() {

                                  });
                                } else {
                                  mController!.play();
                                  isVisible = false;
                                  setState(() {

                                  });
                                }
                              },
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 100),
                                opacity: isVisible ? 1 : 0,
                                child: Center(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black54),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Column(
                              mainAxisAlignment:MainAxisAlignment.end,
                              children: [
                                Row(children: [
                                  mySizeBox5(),
                                  myWidget(() { }, CircleAvatar(backgroundImage: NetworkImage('${eachData.profile}'),)),
                                  mySizeBox5(),
                                  myWidget(() { }, myTextW('${eachData.userName}',)),
                                  mySizeBox5(),
                                  myWidget(() { }, Container(
                                    width: 70,
                                    height: 21,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.white)
                                    ),
                                    child: Center(child: myTextW('Follow',),),)),
                                ],),
                                mySizeBoxHigh(),
                                Row(children: [
                                  mySizeBox5(),
                                  myTextW('${eachData.description}',),],),
                                mySizeBoxHigh(),
                                Row(children: [
                                  mySizeBox5(),
                                  Container(
                                    height: 22,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade600),
                                    child: FittedBox(
                                      child: Row(children: [
                                        Icon(Icons.music_note_outlined,color: Colors.white,),
                                        mySizeBox5(),
                                        myTextW('music',)
                                      ],),
                                    ),
                                  ),
                                  mySizeBox5(),
                                  Container(
                                    height: 22,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade600),
                                    child: FittedBox(
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.account_circle,color: Colors.white),mySizeBox5(),
                                          myTextW('${eachData.userName}',)
                                        ],),
                                    ),
                                  ),
                                ],),
                                mySizeBoxHigh5(),
                              ],
                            )

                          ],
                        ),
                      ),
                      mySizeBoxHighIcon(),
                      MediaQuery.of(context).size.height>606?
                      Column(mainAxisAlignment: MainAxisAlignment. end,
                        children: [

                          myWidget(() {
                          }, Icon(Icons.favorite_border)),
                          myTextWhite('0',context),
                          mySizeBoxHigh(),
                          myWidget(() {

                          }, Icon(Icons.comment)),
                          myTextWhite('0',context),
                          mySizeBoxHigh(),
                          myWidget(() {
                          }, Icon(Icons.send,)),
                          myTextWhite('0',context),
                          mySizeBoxHigh(),
                          myWidget(() {

                          }, Icon(Icons.more_vert,)),
                          mySizeBoxHigh(),
                          myWidget(() { }, Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all()
                            ),
                            child: Center(child: Icon(Icons.music_note_outlined,),),)),
                        ],):SingleChildScrollView(child:
                      Column(mainAxisAlignment: MainAxisAlignment. center,
                        children: [
                          SizedBox(height: 380,),
                          myWidget(() {
                          }, Icon(Icons.favorite_border)),
                          myTextWhite('0',context),
                          mySizeBoxHigh(),
                          myWidget(() {

                          }, Icon(Icons.comment)),
                          myTextWhite('0',context),
                          mySizeBoxHigh(),
                          myWidget(() {
                          }, Icon(Icons.send,)),
                          myTextWhite('0',context),
                          mySizeBoxHigh(),
                          myWidget(() {

                          }, Icon(Icons.more_vert,)),
                          mySizeBoxHigh(),
                          myWidget(() { }, Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all()
                            ),
                            child: Center(child: Icon(Icons.music_note_outlined,),),)),
                        ],),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
  
}




