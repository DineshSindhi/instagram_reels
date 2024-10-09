import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_mange.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        Switch(value:context.watch<ThemeProvider>().toggleTheme,onChanged: (value){
          context.read<ThemeProvider>().toggleTheme=value;
        },),
      ],),
    );
  }
}
