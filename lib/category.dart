import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/models/Lesson_Name.dart';
import 'widgets/add_lesson.dart';
import 'models/role.dart';
import 'models/category_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/alert_les.dart';
List a = [];
bool vis;
class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  void Get() async
  {
    DocumentReference ref= Firestore.instance.collection('categories').document(cat.name);
    DocumentSnapshot doc =await ref.get();
    setState(() {
      a=doc['Lessons'];

    });
    if(a.isEmpty)
      setState(() {
        a.add("No Lessons Yet !");
      });
  }
  @override
  Widget build(BuildContext context) {
    Get();
    vis= (roll.Role_Type=='admin')?true:false;
    return Sizer(
      builder: (context,orientation,deviceType){
        return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              iconTheme: IconThemeData(
                color: Colors.white,
                size: 25.0,
              ),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: (){
                    Navigator.popAndPushNamed(context, '/home');
                  }
              ),
              title: Text(
                "Lessons",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Mont'
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                  child: InkWell(
                    onTap: (){
                      showDialog(context: context, builder: (context){
                        return Add_Lesson();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                      ),
                      child: Visibility(
                        visible: vis,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                            )
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
                    child: ListView.builder(
                      itemCount: a.length,
                      itemBuilder: (context,index){
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          color: Colors.white,
                          child: ListTile(
                            onLongPress: (){
                              if(roll.Role_Type=='admin'){
                                showDialog(context: context, builder: (context) {
                                  Map map = {'name':a[index]};
                                  les = Lesson_Name.fromJson(map);
                                  return Alert_Les();
                                });
                              }
                            },
                            onTap: (){
                              if(!(a[0]=="No Lessons Yet !")){
                                Navigator.pushNamed(context, '/video');
                              }
                            },
                            title: Center(
                              child: Text(
                                "${a[index]}",
                                style: TextStyle(
                                    fontFamily: 'Mont',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ),
                        );
                      },

                    ),
                  ),
                ),
              ],
            )

        );
      },
    );
  }
}
