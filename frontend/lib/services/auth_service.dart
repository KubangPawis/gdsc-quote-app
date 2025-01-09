import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AuthService {

  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password)async{
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e){
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password)async{
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e){
    }
    return null;
  }

  Future<void> signout() async{
    try {
      await _auth.signOut();
    } catch (e){
    }
  }
}
  // Future<void> signup({
  //   required String email,
  //   required String password,
  // }) async {

  //   try {

  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email, 
  //       password: password
  //       );

  //   } on FirebaseAuthException catch(e){
  //     String message = '';
  //     if (e.code == 'weak-password'){
  //       message = 'The password provided is too weak.';
  //     } else if (e.code == 'email-already-in-use'){
  //       message = 'An account already exists with that email.';
  //     }
  //     Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.SNACKBAR,
  //       backgroundColor: Colors.black54,
  //       textColor: Colors.white,
  //       fontSize: 14.0
  //     );
  //   }
  //   catch(e){

  //   }
  // }
//}