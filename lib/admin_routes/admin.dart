import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:video_app/admin_routes/users_list.dart';
import 'users_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_app/models/user.dart';
import 'dart:convert';


class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
   int a=0,bb=0,c=0,d=0;
  Future <void> logout() async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut();
    Navigator.popAndPushNamed(context, '/login');
  }
  List allData=[""];
  List b= []; List id=[];
  void Getdata()async{
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    allData = querySnapshot.docs.map((doc) => doc.data()).toList(); int j=0;

    print(allData.length);
    for(var i=0;i<allData.length;i++) {
      if (allData[i]['role'] != 'admin')
      {
        setState(() {
          b.add(allData[i]['name']);
          id.add(allData[i]);
        });
      }
    }
    if(b==null)
      b[0]="No Users Yet !";

    print(b);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType){
          return Scaffold(
            backgroundColor: Colors.black,
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
                  icon: Icon(Icons.menu,color: Colors.white,),
                  onPressed: (){
                    _scaffold.currentState.openDrawer();
                  }
              ),
            ),
             body:
              Column(
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
                             borderRadius: BorderRadius.circular(12),
                             color: Colors.white
                           ),
                           child: Padding(
                             padding: const EdgeInsets.all(9.0),
                             child: Text(
                               "Users",
                               style: TextStyle(
                                 fontFamily: 'MontB',
                                 fontSize: 14.sp,
                                 fontWeight: FontWeight.w600,
                                 color: Colors.black
                               ),
                             ),
                           ),
                         ),
                       ), InkWell(
                         onTap: (){
                           setState(() {
                             a=0;bb=1;c=0;d=0;
                           });
                         },
                         child: Container(
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(12),
                               color: Colors.white
                           ),
                           child: Padding(
                             padding: const EdgeInsets.all(9.0),
                             child: Text(
                               "Categories",
                               style: TextStyle(
                                   fontFamily: 'MontB',
                                   fontSize: 14.sp,
                                   fontWeight: FontWeight.w600,
                                   color: Colors.black
                               ),
                             ),
                           ),
                         ),
                       ),
                       Container(
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(12),
                             color: Colors.white
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(9.0),
                           child: Text(
                             "Add",
                             style: TextStyle(
                                 fontFamily: 'MontB',
                                 fontSize: 14.sp,
                                 fontWeight: FontWeight.w600,
                                 color: Colors.black
                             ),
                           ),
                         ),
                       ), Container(
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(12),
                             color: Colors.white
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(9.0),
                           child: Text(
                             "New",
                             style: TextStyle(
                                 fontFamily: 'MontB',
                                 fontSize: 14.sp,
                                 fontWeight: FontWeight.w600,
                                 color: Colors.black
                             ),
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
                 SizedBox(height: 40,),
                 if(a==1)
          Container(
          color: Colors.black,
          child: ListView.builder(
          shrinkWrap: true,
          itemCount: b.length,
          itemBuilder: (context,index){
          return Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 25, 0),
          child: Card(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
          ),
          child: InkWell(
            onTap: (){
           user = Data.fromJson(id[index]);
           Navigator.popAndPushNamed(context,'/user_detail');
            },
            child: Container(
            height: 35,
            width: 60,

            child: Center(
            child: Text(
            "${b[index]}",
            style: TextStyle(
            color: Colors.black,
            fontFamily: 'MontB',
            fontWeight: FontWeight.w600,
            fontSize: 14
            ),
            ),
            ),
            ),
          ),
          ),
          );
          },
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
