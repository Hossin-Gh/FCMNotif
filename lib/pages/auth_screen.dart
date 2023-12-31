import 'package:chate_app/pages/home_screen.dart';
import 'package:chate_app/pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScr extends StatefulWidget {
  const AuthScr({super.key});

  @override
  State<AuthScr> createState() => _AuthScrState();
}

class _AuthScrState extends State<AuthScr> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return HomeScr();
            } else {
              return LoginScr();
            }
          },
        ),
      ),
    );
  }
}
