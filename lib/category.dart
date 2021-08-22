import 'package:flutter/material.dart';
import 'video.dart';
var a = ["Lesson 1", "Lesson 2", "Lesson 3"];
class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
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
      body: Padding(
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

                onTap: (){
                   Navigator.pushNamed(context, '/video');
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
      )

    );
  }
}
