import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServic extends ChangeNotifier {
  //instance of firebase auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //instance of firebase store
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //sing in with email and password
  Future<UserCredential> singInWithEmailAndPassword(
      String email, String password) async {
    try {
      //sing in
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      //add new documnt for new user in user collection it its dosen't exist
      _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email
        },
        SetOptions(merge: true),
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sing up with email and password and password confirmation
  Future<UserCredential> singUpWithEmailAndPassword(
      String email, String password) async {
    try {
      //creat user
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      //creat new documnt for new user in user collection
      _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': userCredential.user!.email
        },
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign user out
  Future<void> singOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}

