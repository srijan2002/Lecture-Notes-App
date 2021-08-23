import 'package:flutter/material.dart';
import 'package:video_app/models/user.dart';
import 'package:sizer/sizer.dart';

class User_Detail extends StatefulWidget {
  @override
  _User_DetailState createState() => _User_DetailState();
}

class _User_DetailState extends State<User_Detail> {
  @override
  Widget build(BuildContext context) {
  return Sizer(
    builder: (context,orientation,deviceType){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.white,
            size: 25.0,
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.popAndPushNamed(context, '/admin');
              }
          ),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Name :- ",
                    style: TextStyle(
                        color: Colors.cyanAccent,
                        fontFamily: 'MontB',
                        fontWeight: FontWeight.w200,
                        fontSize: 12.sp
                    ),
                  ),
                  Text(
                    "${user.Name}",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'MontB',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Email :- ",
                    style: TextStyle(
                        color: Colors.cyanAccent,
                        fontFamily: 'MontB',
                        fontWeight: FontWeight.w200,
                        fontSize: 12.sp
                    ),
                  ),
                  Text(
                    "${user.Email}",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'MontB',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Phone No. :- ",
                    style: TextStyle(
                        color: Colors.cyanAccent,
                        fontFamily: 'MontB',
                        fontWeight: FontWeight.w200,
                        fontSize: 12.sp
                    ),
                  ),
                  Text(
                    "${user.Phone}",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'MontB',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
  }
}
