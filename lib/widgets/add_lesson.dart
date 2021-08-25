import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/services/database.dart';

class Add_Lesson extends StatefulWidget {
  @override
  _Add_LessonState createState() => _Add_LessonState();
}

class _Add_LessonState extends State<Add_Lesson> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context,orientation, deviceType){
        return AlertDialog(
          backgroundColor: Colors.white,
          content:   Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: "Enter Lesson Name",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          )
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return 'Enter Lesson Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)),
                    onPressed: () async{
                      if (_formKey.currentState.validate()) {
                        await Database().addles(nameController.text);
                        Navigator.pop(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
