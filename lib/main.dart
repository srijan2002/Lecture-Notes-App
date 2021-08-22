import 'package:video_app/signin.dart';

import 'signup.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'category.dart';
import 'video.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: Login(),
    routes: {
      '/login':(context)=>Login(),
      '/home':(context)=>Home(),
      '/category':(context)=>Category(),
      '/video':(context)=>Video(),
      '/signup': (context)=>Signup(),
      '/signin':(context)=>Signin()
    },
  ));
}




