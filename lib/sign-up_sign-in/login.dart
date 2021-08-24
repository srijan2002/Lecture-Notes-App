import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_app/models/role.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double widget1Opacity = 1.0;

  void initlogin() async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

        firebaseAuth.authStateChanges()
        .listen((User user)async {
      if (user == null) {} else {
        DocumentReference ref= Firestore.instance.collection('users').document(firebaseAuth.currentUser.uid);
        DocumentSnapshot doc =await ref.get();
        if(doc['role']=='user')
       Navigator.popAndPushNamed(context, '/home');
        else if(doc['role']=='admin')
          Navigator.popAndPushNamed(context, '/admin');
      Map x = {'role':doc['role']};
        roll = Role.fromJson(x);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    initlogin();
    return Sizer(
      builder: (context,orientation,deviceType){
        return Scaffold(
            backgroundColor: Colors.black,
            body:AnimatedOpacity(
              opacity: widget1Opacity,
              duration: const Duration(milliseconds: 500),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 200, 0, 50),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        // color: Color(0xFF4285F4),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Kindly Sign-in to continue !",
                          style:TextStyle(
                              fontSize: 18.sp,
                              fontFamily: 'Mont',
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.popAndPushNamed(context, '/user_type');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Mont',
                                  color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.popAndPushNamed(context, '/signup');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Signup",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Mont',
                                  color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
        );
      },
    );
  }
}
