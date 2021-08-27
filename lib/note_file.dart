import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_app/models/user.dart';
import 'package:video_app/services/database.dart';
import 'dart:io';
import 'models/category_name.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'models/video_link.dart';
import 'models/role.dart';
import 'package:sizer/sizer.dart';
class Note_File extends StatefulWidget {
  @override
  _Note_FileState createState() => _Note_FileState();
}

class _Note_FileState extends State<Note_File> {
  String msg = "Upload";
  File file; double progress=0.0; String destination; bool vis=false; bool ad = (roll.Role_Type=='admin')?true:false;
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context,orientation,deviceType){
        return  Scaffold(
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
                  Navigator.popAndPushNamed(context, '/category');
                }
            ),
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        if(vid.name!="")
                          Navigator.popAndPushNamed(context, '/video');
                      },
                      child: Container(
                        width: 125.sp,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_arrow, color: Colors.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                "Play Lesson",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'MontB',
                                    fontSize: 15
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8.sp,),
                    InkWell(
                      onTap: (){
                      },
                      child: Container(
                        width: 110.sp,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.attach_file_sharp, color: Colors.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                "Files",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'MontB',
                                    fontSize: 15
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60,),
                Visibility(
                  visible: ad,
                  child: Container(
                    height: 90,
                    width: 90,
                    child: LiquidCircularProgressIndicator(
                      value: progress, // Defaults to 0.5.
                      valueColor: AlwaysStoppedAnimation(Color(0xFF761EE9)), // Defaults to the current Theme's accentColor.
                      backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
                      borderColor: Color(0xFF3D1B94),
                      borderWidth: 5.0,
                      direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                      center: Text("${(progress * 100).toStringAsFixed(2)} %"),
                    ),
                  ),
                ),
                SizedBox(height: 35,),
                Visibility(
                  visible: ad,
                  child: FloatingActionButton.extended(
                      backgroundColor: Colors.white,
                      label: Text(
                        "Add New",
                        style: TextStyle(
                            fontFamily: 'MontB',
                            fontWeight: FontWeight.w600,
                          color: Colors.black
                        ),
                      ),
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      onPressed: () async{

                        FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: false);
                        File file = File(result.files.single.path);
                        final filename = basename(file.path);
                        destination = '/lessons/$filename';
                        final ref = FirebaseStorage.instance.ref();
                        // await ref.child(destination).putFile(file);
                        UploadTask task = ref.child(destination).putFile(file);
                        task.snapshotEvents.listen((event) {
                          setState(() {
                            progress = event.bytesTransferred.toDouble()/event.totalBytes.toDouble();
                            if(progress==1.00)
                              vis=true;
                          });
                        });
                      }
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(height: 30,),
                Visibility(
                  visible: (vis&ad),
                  child: InkWell(
                    onTap: ()async{
                      final CollectionReference catref = Firestore.instance.collection('categories');
                      final ref = FirebaseStorage.instance.ref();
                      String url=  await ref.child(destination).getDownloadURL();
                      vid.name=url;
                      await catref.document(cat.name).updateData({
                        'Video':FieldValue.arrayUnion([url])
                      });
                      setState(() {
                        msg="Uploaded";
                      });
                    },
                    child: Container(
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(15.sp)
                     ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          "$msg",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'MontB',
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        );
      },
    );
  }
}
