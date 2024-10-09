import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_pp/presentation/on_board/sign_up_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/ui_helper.dart';
import '../pages/home_page.dart';
import '../pages/navigation_bar.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController=TextEditingController();
  var passController=TextEditingController();
  bool isHide=true;
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Scaffold(
      body: MediaQuery.of(context).size.height>310?
      Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Instagram',style: TextStyle(fontSize: 30,)),
            mySizeBox(),
            myTextFiled(controllerName: emailController, label: 'Email',hint: 'Enter your Email'),
            mySizeBox(),
            Container(
              height: 65,
              width: 500,
              child: TextField(
                controller: passController,
                decoration: InputDecoration(
                    label: Text('Password'),
                    hintText: 'Enter your Password',
                    suffixIcon: InkWell(
                        onTap: (){
                          if(isHide){
                            isHide=false;
                          }else{
                            isHide=true;
                          }
                          setState(() {});
                        },
                        child: Icon(Icons.remove_red_eye)),
                    border: OutlineInputBorder(
                      borderRadius:  BorderRadius.circular(12),
                    )
                ),
                obscureText: isHide,
              ),
            ),
            mySizeBox(),
            Container(
              width: 500,
              height: 50,
              child: ElevatedButton(onPressed: () async {
                if(emailController.text.isNotEmpty&&passController.text.isNotEmpty){
                  try{
                    var value=await firebaseAuth.signInWithEmailAndPassword(email: emailController.text.toString(), password: passController.text.toString());
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationPage(),));
                    var pref=await SharedPreferences.getInstance();
                    pref.setString('uId', value.user!.uid);
                  }on FirebaseAuthException catch(e){
                    if (e.code == 'user-not-found') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User not found')));

                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong-password')));

                      print('Wrong password provided for that user.');
                    }
                  }catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));

                  }
                }else{}
              }, child: Text('Login',style: TextStyle(fontSize: 25,color: Colors.white),),style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(),
                backgroundColor: Colors.blue.shade500,
              )),
            ),
            mySizeBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account? ',style: TextStyle(fontSize: 20,color: Colors.purple.shade600),),
                InkWell(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
                },
                    child: Text('Sign up',style: TextStyle(fontSize: 21,color: Colors.blue),)),
              ],
            ),

          ],
        ),
      ):SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Instagram',style: TextStyle(fontSize: 30,)),
              mySizeBox(),
              myTextFiled(controllerName: emailController, label: 'Email',hint: 'Enter your Email'),
              mySizeBox(),
              Container(
                height: 65,
                width: 500,
                child: TextField(
                  controller: passController,
                  decoration: InputDecoration(
                      label: Text('Password'),
                      hintText: 'Enter your Password',
                      suffixIcon: InkWell(
                          onTap: (){
                            if(isHide){
                              isHide=false;
                            }else{
                              isHide=true;
                            }
                            setState(() {});
                          },
                          child: Icon(Icons.remove_red_eye)),
                      border: OutlineInputBorder(
                        borderRadius:  BorderRadius.circular(12),
                      )
                  ),
                  obscureText: isHide,
                ),
              ),
              mySizeBox(),
              Container(
                width: 500,
                height: 50,
                child: ElevatedButton(onPressed: () async {
                  if(emailController.text.isNotEmpty&&passController.text.isNotEmpty){
                    try{
                      var value=await firebaseAuth.signInWithEmailAndPassword(email: emailController.text.toString(), password: passController.text.toString());
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationPage(),));
                      var pref=await SharedPreferences.getInstance();
                      pref.setString('uId', value.user!.uid);
                    }on FirebaseAuthException catch(e){
                      if (e.code == 'user-not-found') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User not found')));

                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong-password')));

                        print('Wrong password provided for that user.');
                      }
                    }catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));

                    }
                  }else{}
                }, child: Text('Login',style: TextStyle(fontSize: 25,color: Colors.white),),style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                  backgroundColor: Colors.blue.shade500,
                )),
              ),
              mySizeBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account? ',style: TextStyle(fontSize: 20,color: Colors.purple.shade600),),
                  InkWell(onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
                  },
                      child: Text('Sign up',style: TextStyle(fontSize: 21,color: Colors.blue),)),
                ],
              ),

            ],
          ),
        ),
      )
    );
  }
}