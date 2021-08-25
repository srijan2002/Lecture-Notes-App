import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_app/models/category_name.dart';

class Database{

  final String uid;
  Database({this.uid});
  final CollectionReference ref = Firestore.instance.collection('users');
  final CollectionReference catref = Firestore.instance.collection('categories');
  Future data(String email,String name, String phone)async{
    return await ref.document(uid).setData({
      'email':email,
      'name':name,
      'phone':phone,
      'role':'user'
    });

  }

  Future addcat(String name)async{
    return await catref.document(name).setData({
      'Lessons':FieldValue.arrayUnion([])
    });

  }

  Future delcat(String name)async{
    return await catref.document(name).delete();

  }
  Future addles(String name)async{
    return await catref.document(cat.name).updateData({
      'Lessons':FieldValue.arrayUnion([name])
    });
  }

  Future delles(String name)async{

  }


}