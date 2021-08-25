import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/models/role.dart';
import 'package:video_app/services/database.dart';
import 'package:video_app/models/category_name.dart';
class AlertD extends StatefulWidget {
  @override
  _AlertDState createState() => _AlertDState();
}

class _AlertDState extends State<AlertD> {
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
                        onPressed: () async{
                           if(vis){
                             await Database().delcat(cat.name);
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
