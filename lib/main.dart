import 'package:video_app/sign-up_sign-in/signin.dart';
import 'sign-up_sign-in/signup.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import 'sign-up_sign-in/login.dart';
import 'category.dart';
import 'video.dart';
import 'package:firebase_core/firebase_core.dart';
import 'sign-up_sign-in/user_type.dart';
import 'admin_routes/admin.dart';
import 'sign-up_sign-in/admin_sign.dart';
import 'admin_routes/user_detail.dart';

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
      '/signin':(context)=>Signin(),
      '/user_type':(context)=>User_Type(),
      '/admin':(context)=>Admin(),
      '/admin_sign':(context)=>Admin_Sign(),
      '/user_detail':(context)=>User_Detail()
    },
  ));
}




