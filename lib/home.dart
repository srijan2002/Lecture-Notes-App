import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'widgets/alertbox.dart';
import 'models/role.dart';
import 'widgets/add_category.dart';
import 'models/category_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 List b=[""]; List allData = [];
bool vis;
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data ={};  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  @override
  void initState(){
    super.initState();
    ctrl.addListener(() {
      int next = ctrl.page.round();
      if(currentPage!=next){
        setState(() {currentPage=next;});}
    });
  }
  int j=0;
  void Getdata()async{
    j=0; b=[];
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('categories');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    setState(() {
      allData = querySnapshot.docs.map((doc) => doc.id).toList();
      j=allData.length;
    });
  }

 Future <void> logout() async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut();
    Navigator.popAndPushNamed(context, '/login');
  }
  int currentPage =0; final PageController ctrl = PageController(viewportFraction: 0.70);

  @override
  Widget build(BuildContext context) {
    Getdata();
    vis= (roll.Role_Type=='admin')?true:false;
    return Sizer(
        builder: (context, orientation, deviceType) {
          return Scaffold(
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
                            logout();},
                          trailing: Icon(Icons.logout,color: Colors.white70,),
                          title: Text(
                            "Logout",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 13.sp,
                                fontFamily: 'Mont', color: Colors.white70
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
                elevation: 12,
                backgroundColor: Color(0xFF0C041A),
                iconTheme: IconThemeData(
                  color: Colors.white, size: 25.0,
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
                      color: Colors.white, fontSize: 20.5,
                      fontWeight: FontWeight.bold, fontFamily: 'Mont'
                  ),
                ),
              ),
              body:Stack(
                children:<Widget> [
                  Container(
                    color:Color(0xFF0C041A),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                      child: Container(
                        child: PageView.builder(
                            controller: ctrl,
                            scrollDirection: Axis.horizontal,
                            itemCount: allData.length,
                            itemBuilder: (context, int ind) {
                              bool active = ind == currentPage;
                              final double top = active?0:30.sp;
                              final double opacity=active?0.7:0;

                              return Padding(
                                padding: const EdgeInsets.fromLTRB(8,8,8,8),
                                child: InkWell(
                                  onTap: (){
                                    Map map = {'name':allData[ind]};
                                    cat = Category_Name.fromJson(map);
                                    Navigator.popAndPushNamed(context, '/category');
                                  },
                                  onLongPress: (){

                                    if(roll.Role_Type=='admin'){
                                      showDialog(context: context, builder: (context) {
                                        Map map = {'name':allData[ind]};
                                        cat = Category_Name.fromJson(map);
                                        return AlertD();
                                      });
                                    }
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
                                                  spreadRadius: 0.2, blurRadius: 12.sp,
                                                  offset: Offset(0, 3), // changes position of shadow
                                                ),
                                              ],),
                                            margin: EdgeInsets.only(top:top,bottom: 0,right: 20,left: 20),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.zero,
                                                bottomRight: Radius.zero,
                                                topRight: Radius.circular(25.sp),
                                                bottomLeft: Radius.circular(25.sp)
                                              ),
                                              child: Container(
                                                color: Color(0xFF331957),
                                                height: 200.sp, width: 150.sp,
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(20.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.edit,
                                                          color: Colors.white70,
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                            "${allData[ind]}",
                                                            style: TextStyle(
                                                                fontFamily: 'Mont', fontWeight: FontWeight.bold,
                                                                color:Colors.white, fontSize: 18
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),),),),),),
                                                   ],
                                    ),),),);
                            }),),),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            showDialog(context: context, builder: (context){
                              return Add_Category();
                            });
                          },
                          child: Container(
                            width: 95.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                            ),
                            child: Visibility(
                              visible: vis,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      "Add New",
                                      style: TextStyle(
                                        fontFamily: 'Mont',
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ],
                                )
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 7.sp,),
                        InkWell(
                          onTap: (){
                             Navigator.popAndPushNamed(context, '/admin');
                          },
                          child: Container(
                            width: 80.sp,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white
                            ),
                            child: Visibility(
                              visible: vis,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_back,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        "Back",
                                        style: TextStyle(
                                            fontFamily: 'Mont',
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ])
          );
        });
  }
}