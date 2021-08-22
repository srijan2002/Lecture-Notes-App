import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double widget1Opacity = 1.0;

  void initlogin(){
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

        firebaseAuth.authStateChanges()
        .listen((User user) {
      if (user == null) {} else {
       Navigator.popAndPushNamed(context, '/home');
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
                          Navigator.popAndPushNamed(context, '/signin');
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
