// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:instagram_project/domain/ui_data.dart';
// import 'package:instagram_project/domain/ui_helper.dart';
// import 'package:video_player/video_player.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: MediaQuery.of(context).orientation==Orientation.portrait?AppBar(title: Text('Reels'),):AppBar(),
//       body: MediaQuery.of(context).orientation==Orientation.portrait?portraitUi():landscapeUi(),
//     );
//   }
//
// }
//PageView.builder(
//               scrollDirection: Axis.vertical,
//               itemCount: 5,
//               itemBuilder: (context, index) {
//                 return Row(
//                   children: [
//                     Container(
//                       height: 650,
//                       width: 400,
//                       decoration: BoxDecoration(
//                         color: Colors.blue.shade100,
//                         borderRadius: BorderRadius.circular(9)
//                       ),
//                     ),
//
//                   ],
//                 );
//               },)
