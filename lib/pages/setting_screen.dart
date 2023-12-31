import 'package:chate_app/pages/login_screen.dart';
import 'package:chate_app/sevrices/auth/auth_servic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScr extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  SettingScr({super.key});

  @override
  Widget build(BuildContext context) {
    void singOut() async {
      final authServic = Provider.of<AuthServic>(context, listen: false);
      await authServic.singOut();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('با موفقیت از حساب خود خارج شدید'),
        ),
      );

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => LoginScr(),
          ),
          (route) => false);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () => singOut(),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text((_firebaseAuth.currentUser!.email).toString()),
              // Text(_firebaseAuth.currentUser!.phoneNumber.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
