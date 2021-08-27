import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_app/models/user.dart';
import 'dart:convert';


class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
   int a=0,bb=0,c=0,d=0; int j=0;
  Future <void> logout() async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut();
    Navigator.popAndPushNamed(context, '/login');
  }
  List allData=[""]; List allId=[''];
  List b= []; List id=[]; List id2 = [];
  void Getdata()async{
    j=0; b=[];id=[]; id2=[];
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    allId =querySnapshot.docs.map((doc) => doc.id).toList();

    for(var i=0;i<allData.length;i++) {
      if (allData[i]['role'] != 'admin') {
        setState(() {
          b.add(allData[i]['name']);
          id.add(allData[i]); j++;
          id2.add(allId[i]);
        });
      }
    }
  if(j==0){
    setState(() {
      b=["No Users Yet !"];
    });
  }
    print(id2);

  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType){
          return Scaffold(
            backgroundColor: Color(0xFF190734),
            drawer: Drawer(
              child: Container(
                color: Color(0xFF190734),
                child: ListView(

                  children: [
                    SizedBox(height: 20,),
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
                    SizedBox(height: 10,),
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
              backgroundColor: Color(0xFF190734),
              iconTheme: IconThemeData(
                color: Colors.white,
                size: 25.0,
              ),
              leading: IconButton(
                  icon: Icon(Icons.menu,color: Colors.white,),
                  onPressed: (){
                    _scaffold.currentState.openDrawer();
                  }
              ),
            ),
             body: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         InkWell(
                           onTap: (){
                             setState(() {
                               a=1;bb=0;c=0;d=0;
                               Getdata();
                             });
                           },
                           child: Container(
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.only(
                                   topLeft: Radius.circular(0.sp),
                                   topRight: Radius.circular(7.sp),
                                   bottomLeft: Radius.circular(7.sp),
                                   bottomRight: Radius.circular(7.sp),
                                 ),
                                 color:(a==1)?Colors.white:Color(0xFF030310)
                             ),
                             child: Padding(
                               padding: const EdgeInsets.all(9.0),
                               child: Text(
                                 "Users",
                                 style: TextStyle(
                                     fontFamily: 'MontB',
                                     fontSize: 14.sp,
                                     fontWeight: FontWeight.w600,
                                     color:(a==1)?Color(0xFF030310):Colors.white
                                 ),
                               ),
                             ),
                           ),
                         ), InkWell(
                           onTap: (){
                             setState(() {
                               a=0;bb=1;c=0;d=0;
                               Navigator.pushNamed(context, '/home');
                             });
                           },
                           child: Container(
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0.sp),
                                      topRight: Radius.circular(7.sp),
                                      bottomLeft: Radius.circular(7.sp),
                                      bottomRight: Radius.circular(7.sp),
                                    ),
                                 color: (bb==1)?Colors.white:Color(0xFF030310)
                             ),
                             child: Padding(
                               padding: const EdgeInsets.all(9.0),
                               child: Text(
                                 "Categories",
                                 style: TextStyle(
                                     fontFamily: 'MontB',
                                     fontSize: 14.sp,
                                     fontWeight: FontWeight.w600,
                                     color: (bb==1)?Color(0xFF030310):Colors.white
                                 ),
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                   SizedBox(height: 40,),
                   if(a==1)
                          Expanded(
                            child: Container(
                               decoration: BoxDecoration(
                                 color: Color(0xFF4E3374),
                                 borderRadius: BorderRadius.only(
                                   topLeft: Radius.circular(0.sp),
                                   topRight: Radius.circular(30.sp),
                                   bottomLeft: Radius.zero,
                                   bottomRight: Radius.zero,
                                 )
                               ),
                               child: Padding(
                                 padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                 child: ListView.builder(
                                   shrinkWrap: true,
                                   itemCount: b.length,
                                   itemBuilder: (context,index){
                                     return Padding(
                                       padding: const EdgeInsets.fromLTRB(20, 5, 25, 0),
                                       child: Card(
                                         color: Color(0xFF4E3374),
                                         elevation: 0.0,
                                         shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(12),
                                         ),
                                         child: InkWell(
                                           onTap: (){
                                            if(j!=0){
                                              user = Data.fromJson(id[index]);
                                              Navigator.pushNamed(context,'/user_detail',arguments: {'id':id2[index]});
                                            }
                                           },
                                           child: Container(
                                             height: 35,
                                             width: 60,

                                             child: Center(
                                               child: Text(
                                                 "${b[index]}",
                                                 style: TextStyle(
                                                     color: Colors.white70,
                                                     fontFamily: 'MontB',
                                                     fontWeight: FontWeight.w600,
                                                     fontSize: 13.sp
                                                 ),
                                               ),
                                             ),
                                           ),
                                         ),
                                       ),
                                     );
                                   },
                                 ),
                               ),
                             ),
                          )
                   else
                     Padding(
                       padding: const EdgeInsets.fromLTRB(5, 100, 5, 0),
                       child: Center(
                         child: Text(
                           "Welcome Admin",
                           style: TextStyle(
                               fontSize: 19.sp,
                               fontWeight: FontWeight.w600,
                               fontFamily: 'MontB',
                               color: Color(0xFF555555)
                           ),
                         ),
                       ),
                     )
                 ],
               ),
          );
        }
    );
  }
}
