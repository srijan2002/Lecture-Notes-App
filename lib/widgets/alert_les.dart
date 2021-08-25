import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/models/role.dart';
import 'package:video_app/services/database.dart';
import 'package:video_app/models/Lesson_Name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_app/models/category_name.dart';
class Alert_Les extends StatefulWidget {
  @override
  _Alert_LesState createState() => _Alert_LesState();
}

class _Alert_LesState extends State<Alert_Les> {

  void Delete(String name)async{
    DocumentReference ref= Firestore.instance.collection('categories').document(cat.name);
    DocumentSnapshot doc =await ref.get();
    ref.updateData({
      'Lessons': FieldValue.arrayRemove([name]),

    });

  }
  @override
  Widget build(BuildContext context) {
    bool vis = (roll.Role_Type=='admin')?true:false;
    return Sizer(
        builder: (context, orientation, deviceType) {
          return Visibility(
            visible: vis,
            child: AlertDialog(
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
                            fontFamily: 'Mont', color: Colors.white70,
                            fontSize: 14.sp, fontWeight: FontWeight.bold
                        ),
                      ),
                      FlatButton.icon(
                        onPressed: () {
                          if(vis){
                             Delete(les.name);
                            Navigator.pop(context);
                          }
                        },
                        label: Text(""),
                        icon: Icon(Icons.delete,color: Colors.white70,),
                      )
                    ],),
                  CloseButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.white70,
                  )],),
            ),
          );
        }

    );
  }
}
