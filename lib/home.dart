import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
String G; List a=["Maths","Physics","Chemistry","Biology"]; List b=[" "];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  Map data ={};   GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();
    ctrl.addListener(() {
      int next = ctrl.page.round();

      if(currentPage!=next){
        setState(() {
          currentPage=next;
        });
      }

    });
  }
 Future <void> logout() async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut();
    Navigator.popAndPushNamed(context, '/login');
  }
  int currentPage =0;
  final PageController ctrl = PageController(viewportFraction: 0.70);
  @override
  Widget build(BuildContext context) {


    // Get();

    return Sizer(
        builder: (context, orientation, deviceType) {
          return Scaffold(
              drawer: Drawer(
                child: Container(
                  color: Colors.grey.shade900,
                  child: ListView(

                    children: [
                      Container(
                        color: Colors.black54,
                        child: ListTile(
                          onTap: ()async{
                            logout();
                          },
                          trailing: Icon(Icons.logout,color: Colors.white70,),
                          title: Text(
                            "Logout",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 13.sp,
                                fontFamily: 'Mont',
                                color: Colors.white70
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2,),
                      Container(
                        color: Colors.black54,
                        child: ListTile(
                          onTap: (){
                            SystemNavigator.pop();
                          },
                          trailing: Icon(Icons.close,color: Colors.white70,),
                          title: Text(
                            "Exit",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 13.sp,
                                fontFamily: 'Mont',
                                color: Colors.white70
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              key: _scaffold,
              appBar: AppBar(
                backgroundColor: Colors.black,
                iconTheme: IconThemeData(
                  color: Colors.white,
                  size: 25.0,
                ),
                leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: (){
                      _scaffold.currentState.openDrawer();
                    }
                ),
                title: Text(
                  "Categories",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mont'
                  ),
                ),

              ),

              body:Stack(
                children:<Widget> [

                  Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                      child: Container(
                        child: PageView.builder(
                            controller: ctrl,
                            scrollDirection: Axis.horizontal,
                            itemCount: a.length,
                            itemBuilder: (context, int ind) {
                              bool active = ind == currentPage;
                              final double top = active?30:70;
                              final double opacity=active?0.7:0;

                              return Padding(
                                padding: const EdgeInsets.fromLTRB(8,8,8,8),
                                child: InkWell(
                                  onTap: (){
                                    // getData(a[ind]);
                                    Navigator.popAndPushNamed(context, '/category');
                                  },
                                  onLongPress: (){
                                    showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.black54,
                                        title: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceEvenly,
                                              children: [
                                                Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      fontFamily: 'Mont',
                                                      color: Colors.white70,
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                FlatButton.icon(
                                                  onPressed: () {
                                                  },
                                                  label: Text(""),
                                                  icon: Icon(Icons.delete,color: Colors.white70,),
                                                )
                                              ],
                                            ),
                                            CloseButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              color: Colors.white70,
                                            )
                                          ],
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    width: 38.w,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                          child: AnimatedContainer(
                                            duration: Duration(milliseconds: 500),
                                            curve: Curves.easeOutQuint,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.white30.withOpacity(opacity),
                                                  spreadRadius: 0.2,
                                                  blurRadius: 25.sp,
                                                  offset: Offset(0, 5), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            margin: EdgeInsets.only(top:top,bottom: 0,right: 20,left: 20),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(25.sp),
                                              child: Container(
                                                color: Color(0xFFA29F9F),
                                                height: 250.sp,
                                                width: 200.sp,
                                                child: Center(
                                                  child: Text(
                                                    "${a[ind]}",
                                                    style: TextStyle(
                                                        fontFamily: 'Mont',
                                                        fontWeight: FontWeight.bold,
                                                        color:Colors.white,
                                                        fontSize: 18
                                                    ),

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                        )
                      ),
                    ),
                  ),
                 
                ]
              )
          );
        }
    );
  }
}