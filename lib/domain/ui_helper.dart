
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presentation/theme/theme_mange.dart';

myTextFiled({required TextEditingController controllerName,required String label, String? hint,keyboardType=TextInputType.text,
  String? suffixText,Icon? suffixIcon,String? prefixText,bool obscureText=false}){
  return Container(
    height: 65,
    width: 500,
    child: TextField(
      controller: controllerName,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        label: Text(label),hintText: hint,
        suffixText: suffixText,
        suffixIcon: suffixIcon,
        prefixText: prefixText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
mySizeBox(){
  return SizedBox(
    height: 10,
  );
}
myAppBar(String text){
  return AppBar
    (title: Text(text),
    centerTitle: true,backgroundColor: Colors.blueGrey,);
}
myPassController({required TextEditingController controllerName,required String label, String? hint,bool value=true}){
  return TextField(
    controller: controllerName,
    obscureText: value,
    decoration: InputDecoration(
        label: Text(label),hintText: hint,
        suffixIcon: InkWell(
            onTap: (){
              value==true?
              value=false:value=true;
            },
            child: Icon(Icons.remove_red_eye)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12)
        )
    ),
  );
}
myWidget(VoidCallback onTap,Widget widget,){
  return InkWell(
    onTap: onTap,
      child: widget
  );
}
myText22(String text){
  return Text(text,style: TextStyle(fontSize: 22),);
}
myText(String text){
  return Text(text,style: TextStyle(fontWeight: FontWeight.bold),);
}
myTextWhite(String text,BuildContext context){
  return Text(text,style: TextStyle(color:context.watch<ThemeProvider>().toggleTheme?Colors.white:Colors.black),);
}
mySizeBox5(){
  return SizedBox(width: 5,);
}
mySizeBoxHigh(){
  return SizedBox(height: 9,);
}
mySizeBoxHigh5(){
  return SizedBox(height: 5,);
}
mySizeBoxHighIcon(){
  return SizedBox(width: 15,);
}
myTextW(String text,){
  return Text(text,style: TextStyle(color:Colors.white),);
}
myTextNor(String text,){
  return Text(text,);
}