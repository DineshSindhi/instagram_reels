import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_pp/presentation/pages/profile_page.dart';
import 'package:instagram_pp/presentation/pages/reels_page.dart';
import 'package:provider/provider.dart';

import '../../domain/ui_data.dart';
import '../../domain/ui_helper.dart';
import '../theme/theme_mange.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int selectItem=3;
  List<Widget>PageList=[
    Center(child: Text('Home'),),
    Center(child: Text('Search'),),
    Center(child: Text('New Post'),),
    ReelsPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width<550?
        BottomNavigationBar(
        unselectedItemColor: context.watch<ThemeProvider>().toggleTheme?Colors.white:Colors.black,
        selectedItemColor: context.watch<ThemeProvider>().toggleTheme?Colors.white:Colors.black87,
        currentIndex: selectItem,
        elevation: 0,
        onTap: (value){
          selectItem=value;
          setState(() {

          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Search',),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined),label: 'New Post'),
          BottomNavigationBarItem(icon: Icon(Icons.video_collection_outlined),label: 'Reels'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: 'Profile'),
        ],
      ):MediaQuery.of(context).size.width>550&&MediaQuery.of(context).size.width<800?
      MediaQuery.of(context).size.width>550&&MediaQuery.of(context).size.width<700?reelUi():landscapeUiIcon():landscapeUi(),
      body: PageList[selectItem],
    );
  }
  landscapeUi(){
    return Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MediaQuery.of(context).size.height>600?
          Column(
            children: [
              mySizeBox(),
              myText22('Instagram'),
              Switch(value:context.watch<ThemeProvider>().toggleTheme,onChanged: (value){
                context.read<ThemeProvider>().toggleTheme=value;
              },),
              mySizeBox(),
              SizedBox(
                width: 210,
                height: 500,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: AppData.mData.length,
                  itemBuilder: (context, index) {
                    var data= AppData.mData[index];
                    return Container(
                      width: 210,
                      height: 70,
                      child: Center(
                        child: ListTile(
                          onTap: (){
                            selectItem=index;
                            setState(() {

                            });
                          },
                          leading: data['icon'],
                          title: data['label'],
                        ),
                      ),
                    );
                  },),
              )
            ],
          ):SingleChildScrollView(
            child: Column(
              children: [
                mySizeBox(),
                myText22('Instagram'),
                Switch(value:context.watch<ThemeProvider>().toggleTheme,onChanged: (value){
                  context.read<ThemeProvider>().toggleTheme=value;
                },),
                mySizeBox(),
                SizedBox(
                  width: 210,
                  height: 500,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: AppData.mData.length,
                    itemBuilder: (context, index) {
                      var data= AppData.mData[index];
                      return Container(
                        width: 210,
                        height: 70,
                        child: Center(
                          child: ListTile(
                            onTap: (){
                              selectItem=index;
                              setState(() {

                              });
                            },
                            leading: data['icon'],
                            title: data['label'],
                          ),
                        ),
                      );
                    },),
                )
              ],
            ),
          ),
          Container(height: double.infinity,width: 3,color: Colors.grey,),
          SizedBox(width: 50,),
          Expanded(
            child: AppData.mData[selectItem]['page'],
          ),

        ],
      );
  }
  landscapeUiIcon(){
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MediaQuery.of(context).size.height>600?
        Column(
          children: [
            mySizeBox(),
            Image.asset('assets/images/logo_iconB.png',width: 70,height: 70,),
            Switch(value:context.watch<ThemeProvider>().toggleTheme,onChanged: (value){
              context.read<ThemeProvider>().toggleTheme=value;
            },),
            mySizeBox(),
            SizedBox(
              width: 100,
              height: 400,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: AppData.mData.length,
                itemBuilder: (context, index) {
                  var data= AppData.mData[index];
                  return Container(
                    width: 210,
                    height: 70,
                    child: Center(
                      child: ListTile(
                        onTap: (){
                          selectItem=index;
                          setState(() {

                          });
                        },
                        title: data['icon'],
                      ),
                    ),
                  );
                },),
            )
          ],
        ):SingleChildScrollView(
          child: Column(
            children: [
              mySizeBox(),
              Image.asset('assets/images/logo_iconB.png',width: 90,height: 90,),
              Switch(value:context.watch<ThemeProvider>().toggleTheme,onChanged: (value){
                context.read<ThemeProvider>().toggleTheme=value;
              },),
              mySizeBox(),
              SizedBox(
                width: 210,
                height: 500,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: AppData.mData.length,
                  itemBuilder: (context, index) {
                    var data= AppData.mData[index];
                    return Container(
                      width: 210,
                      height: 70,
                      child: Center(
                        child: ListTile(
                          onTap: (){
                            selectItem=index;
                            setState(() {

                            });
                          },

                          title: data['icon'],
                        ),
                      ),
                    );
                  },),
              )
            ],
          ),
        ),
        Container(height: double.infinity,width: 3,color: Colors.grey,),
        SizedBox(width: 50,),
        Expanded(
          child: AppData.mData[selectItem]['page'],
        ),

      ],
    );
  }
  reelUi(){
    return Row(mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: 100,),
        Expanded(child:
        AppData.mData[selectItem]['page'],),
      ],
    );
  }
}