import 'package:chate_app/pages/chate_screen.dart';
import 'package:chate_app/pages/setting_screen.dart';
import 'package:chate_app/sevrices/auth/auth_servic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScr extends StatefulWidget {
  const HomeScr({super.key});

  @override
  State<HomeScr> createState() => _HomeScrState();
}

class _HomeScrState extends State<HomeScr> {
  // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[700],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Center(
            child: Text(
              'صفحه اصلی',
              style: TextStyle(
                  color: Colors.blueGrey[700],
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SettingScr(),
                  ),
                );
              },
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: _chatList(),
      ),
    );
  }

  Widget _chatList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }
        ;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              Text('on Loading ...'),
              CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          );
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((document) => _buildUserList(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserList(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

    if (_firebaseAuth.currentUser!.email != data['email']) {
      return ListTile(
        title: Container(
          height: MediaQuery.of(context).size.width / 10,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 241, 111, 109),
                blurRadius: 5,
                spreadRadius: 0,
                blurStyle: BlurStyle.solid,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Text(data['email']),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ChateScr(userEmail: data['email'], userId: data['uid']),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
