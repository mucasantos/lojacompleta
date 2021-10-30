import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class User {
  User({
    this.email,
    this.password,
    this.name,
    this.confirmPassword,
    this.id,
    this.userImage,
  });

  User.fromDocument({DocumentSnapshot document}) {
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
  }

  String id;
  String email;
  String password;
  String name;
  String confirmPassword;
  String userImage;
  bool admin = false;

  DocumentReference get firestoreRef =>
      Firestore.instance.document('users/$id');

  CollectionReference get cartReference => firestoreRef.collection('cart');

  Future<void> saveData() async {
    await firestoreRef.setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
