import 'dart:js';

import 'package:application_1/pages/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        // child: ElevatedButton{
        //   onPressed: (){
        //     SignInWithGoogle();
        //   },
        //   child: Text('Login Page')
        // }
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

SignInWithGoogle() async {
  GoogleSignInAccount? googleUser= await GoogleSignIn().signIn();

  GoogleSignInAuthentication? googleAuth=await googleUser?.authentication;

  AuthCredential credential= GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);

  print(userCredential.user?.displayName); 

  if (userCredential.user != null) {
    Navigator.of(context as BuildContext).push(MaterialPageRoute(
      builder: (context) =>HomePage(title: 'homepage')
    ));
  }
}