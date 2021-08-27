import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class User_Type extends StatefulWidget {
  @override
  _User_TypeState createState() => _User_TypeState();
}

class _User_TypeState extends State<User_Type> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType){
          return Scaffold(
            backgroundColor: Color(0xFF190734),
            appBar: AppBar(
              backgroundColor: Color(0xFF190734),
              iconTheme: IconThemeData(
                color: Colors.white,
                size: 25.0,
              ),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: (){
                    Navigator.popAndPushNamed(context,'/login');
                  }
              ),
            ),
            body: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 100.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Select User",
                      style:TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'Mont',
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){Navigator.popAndPushNamed(context, '/admin_sign');},
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                                "Admin",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.5.sp,
                                fontFamily: 'Mont',
                                color: Colors.black

                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){Navigator.popAndPushNamed(context, '/signin');},
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Student",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.5.sp,
                                  fontFamily: 'Mont',
                                  color: Colors.black

                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
