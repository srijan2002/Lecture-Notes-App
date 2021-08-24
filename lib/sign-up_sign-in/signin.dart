import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_app/models/role.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {




  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child('users');


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future <String> Get(String Doc) async
  {
    DocumentReference ref= Firestore.instance.collection('users').document(Doc);
    DocumentSnapshot doc =await ref.get();
    print(doc['role']);
     return doc['role'];

  }

  void registerToFb() async{
    await Firebase.initializeApp();
    firebaseAuth
        .signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text)
         .then((value) async{
          String x= await Get(firebaseAuth.currentUser.uid);
          print(x);
          if(x=='user') {
            Map map = {'role':'user'};
            roll = Role.fromJson(map);
            Navigator.popAndPushNamed(context, '/home');
          }
          if(x=='admin') {
            Map map = {'role':'admin'};
            roll = Role.fromJson(map);
            Navigator.popAndPushNamed(context, '/admin');
          }
         })
        .catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 25.0,
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.popAndPushNamed(context, '/user_type');
            }
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: "Enter Email",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Enter Email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: "Enter Password",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Enter Password';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      print(emailController.text);
                      registerToFb();
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
      ),
    );}
}
