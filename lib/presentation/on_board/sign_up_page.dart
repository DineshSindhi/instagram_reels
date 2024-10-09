import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/model/user_model.dart';
import '../../domain/ui_helper.dart';
class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  var emailController=TextEditingController();
  var passController=TextEditingController();
  var nameController=TextEditingController();
  var userNameController=TextEditingController();
  bool isHide=true;
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  // FirebaseStorage firebaseStorage=FirebaseStorage.instance;
  FirebaseFirestore fireStore =FirebaseFirestore.instance;
  late CollectionReference mUsers;
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    mUsers=fireStore.collection('users');
    return Scaffold(
      body: MediaQuery.of(context).size.height>550?
      Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Create Account',style: TextStyle(fontSize: 30,)),
            mySizeBox(),
            myTextFiled(controllerName: nameController, label: 'Name',hint: 'Enter your Name'),
            mySizeBox(),
            myTextFiled(controllerName: userNameController, label: 'User Name',hint: 'Enter your User Name',keyboardType: TextInputType.number,),
            mySizeBox(),
            myTextFiled(controllerName: emailController, label: 'Email',hint: 'Enter your Email',),
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
                if(emailController.text.isNotEmpty&&passController.text.isNotEmpty&&userNameController.text.isNotEmpty&&nameController.text.isNotEmpty){
                  try{
                    var cred =await firebaseAuth.createUserWithEmailAndPassword(email: emailController.text.toString(), password: passController.text.toString());
                    var data= UserModel(email: emailController.text.toString(),
                        pass: passController.text.toString(),
                        uid: cred.user!.uid,
                        userName: userNameController.text.toString(),

                        name: nameController.text.toString());
                    mUsers.doc(cred.user!.uid).set(data.toDoc());
                    Navigator.pop(context);
                  }on FirebaseAuthException catch(e){
                    if (e.code == 'weak-password') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Week Password')));
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account already exists for that email')));
                      print('The account already exists for that email.');
                    }
                  }catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
                  }
                }else{

                }
              }, child: Text('Sign Up',style: TextStyle(fontSize: 25,color: Colors.white),),style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(),
                backgroundColor: Colors.blue.shade500,),),
            ),
            mySizeBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an Account,',style: TextStyle(fontSize: 20,color: Colors.purple.shade600),),
                InkWell(onTap: (){
                  Navigator.pop(context);
                },
                    child: Text(' Login now',style: TextStyle(fontSize: 21,color: Colors.blue),)),
              ],
            ),
          ],
        ),
      ):Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Create Account',style: TextStyle(fontSize: 30,)),
              mySizeBox(),
              myTextFiled(controllerName: nameController, label: 'Name',hint: 'Enter your Name'),
              mySizeBox(),
              myTextFiled(controllerName: userNameController, label: 'User Name',hint: 'Enter your User Name',keyboardType: TextInputType.number,),
              mySizeBox(),
              myTextFiled(controllerName: emailController, label: 'Email',hint: 'Enter your Email',),
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
                  if(emailController.text.isNotEmpty&&passController.text.isNotEmpty&&userNameController.text.isNotEmpty&&nameController.text.isNotEmpty){
                    try{
                      var cred =await firebaseAuth.createUserWithEmailAndPassword(email: emailController.text.toString(), password: passController.text.toString());
                      var data= UserModel(email: emailController.text.toString(),
                          pass: passController.text.toString(),
                          uid: cred.user!.uid,
                          userName: userNameController.text.toString(),
                          name: nameController.text.toString());
                      mUsers.doc(cred.user!.uid).set(data.toDoc());
                      Navigator.pop(context);
                    }on FirebaseAuthException catch(e){
                      if (e.code == 'weak-password') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Week Password')));
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account already exists for that email')));
                        print('The account already exists for that email.');
                      }
                    }catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
                    }
                  }else{
          
                  }
                }, child: Text('Sign Up',style: TextStyle(fontSize: 25,color: Colors.white),),style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                  backgroundColor: Colors.blue.shade500,),),
              ),
              mySizeBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an Account,',style: TextStyle(fontSize: 20,color: Colors.purple.shade600),),
                  InkWell(onTap: (){
                    Navigator.pop(context);
                  },
                      child: Text(' Login now',style: TextStyle(fontSize: 21,color: Colors.blue),)),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
