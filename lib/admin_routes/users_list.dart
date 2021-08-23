import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Users_List extends StatefulWidget {

  @override
  _Users_ListState createState() => _Users_ListState();
}

class _Users_ListState extends State<Users_List> {
List allData=[""];
 List b= [];
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
          });
        }
    }
    if(b==null)
      b[0]="No Users Yet !";

    print(b);
  }

  @override
  Widget build(BuildContext context) {
     Getdata();
    return Container(
      color: Colors.black,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: b.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              ),
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
          );
        },
      ),
    );
  }
}
