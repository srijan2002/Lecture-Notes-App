import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import '../services/database.dart';
import 'package:video_app/models/role.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child('users');


  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void registerToFb() async{
    await Firebase.initializeApp();
    firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text)
        .then((result) async {
          await Database(uid:result.user.uid).data(emailController.text,nameController.text,phoneController.text);
          Map map = {'role':'user'};
          roll = Role.fromJson(map);
         Navigator.popAndPushNamed(context, '/home');

    }).catchError((err) {
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
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
             Navigator.popAndPushNamed(context, '/login');
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
                   padding: EdgeInsets.all(15.0),
                 child: TextFormField(
                   controller: nameController,
                   decoration: InputDecoration(

                     labelText: "Enter User Name",

                     enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10.0)
                     )
                   ),
                   validator: (value){
                     if(value.isEmpty){
                       return 'Enter User Name';
                     }
                     return null;
                   },
                 ),
               ),
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
               Padding(
                 padding: EdgeInsets.all(20.0),
                 child: TextFormField(
                   controller: phoneController,
                   decoration: InputDecoration(
                       labelText: "Enter Phone Number",
                       enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10.0)
                       )
                   ),
                   validator: (value){
                     if(value.isEmpty){
                       return 'Enter Phone Number';
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
                     // data(emailController.text,passwordController.text);
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
   );


  }
}
