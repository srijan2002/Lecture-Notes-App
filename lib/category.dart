import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/models/Lesson_Name.dart';
import 'widgets/add_lesson.dart';
import 'models/role.dart';
import 'models/category_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/alert_les.dart';
import 'models/video_link.dart';
import 'models/file_link.dart';

List a = []; List b=[]; List c=[];
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
      b=doc['Video'];
      c=doc['Pdf'];
    });
    if(a.isEmpty)
      setState(() {
        a.add("No Lessons Yet !");
      });
    int first = a.length;
    int second=b.length;
    for(int i=second;i<first;i++)
      {
        setState(() {
          b.add("");
          c.add("");
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    Get();
    vis= (roll.Role_Type=='admin')?true:false;
    return Sizer(
      builder: (context,orientation,deviceType){
        return Scaffold(
            backgroundColor: Color(0xFF0C041A),
            appBar: AppBar(
              backgroundColor: Color(0xFF0C041A),
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
                    fontSize: 20.5,
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
                ),
                SizedBox(height: 25.sp,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1B0D38),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.sp),
                        topLeft: Radius.circular(30.sp)
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 35, 20, 10),
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
                                  Map map = {'name':b[index]};
                                  Map m = {'name':a[index]};
                                  Map n = {'name':c[index]};
                                  vid = Video_Link.fromJson(map);
                                  les = Lesson_Name.fromJson(m);
                                  fil = File_Link.fromJson(n);
                                  Navigator.pushNamed(context, '/note_file');
                                }
                              },
                              title: Center(
                                child: Row(
                                  children: [
                                    SizedBox(width: 20.sp,),
                                    Icon(
                                      Icons.notes
                                    ),
                                    SizedBox(width: 20.sp,),
                                    Text(
                                      "${a[index]}",
                                      style: TextStyle(
                                          fontFamily: 'Mont',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },

                      ),
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
