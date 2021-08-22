import 'package:cloud_firestore/cloud_firestore.dart';

class Database{

  final String uid;
  Database({this.uid});
  final CollectionReference ref = Firestore.instance.collection('users');

  Future data(String email,String name, String age)async{
    return await ref.document(uid).setData({
      'email':email,
      'name':name,
      'age':age
    });

  }

}