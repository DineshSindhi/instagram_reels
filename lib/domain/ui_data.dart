import 'package:flutter/material.dart';
import 'package:instagram_pp/domain/ui_helper.dart';

import '../presentation/pages/reels_page.dart';

class AppData{
  static   List<Map<String,dynamic>> mData =[
    {
      'icon':Icon(Icons.home),
      'label':myText('Home'),
      'page':Center(child: Text('Home'),)
    },
    {
      'icon':Icon(Icons.search),
      'label':myText('Search'),
      'page':Center(child: Text('Search'),)
    },
    {
      'icon':Icon(Icons.add_box_outlined),
      'label':myText('New Post'),
      'page':Center(child: Text('New Post'),)
    },
    {
      'icon':Icon(Icons.video_collection_outlined),
      'label':myText('Reels'),
      'page':ReelsPage()
    },
    {
      'icon':Icon(Icons.account_circle),
      'label':myText('Profile'),
      'page':Center(child: Text('Profile'),)
    },
  ];
}