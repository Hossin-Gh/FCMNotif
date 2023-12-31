import 'package:chate_app/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  //instsnce of fire base Auth and store
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // receive messages
  Stream<QuerySnapshot> getMessages(
      String senderUserId, String reseverUserId) {
    // find chat room id from users id
    List<String> ids = [senderUserId, reseverUserId];
    ids.sort();
    final String chatRoomId = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('time', descending: false)
        .snapshots();
  }

  //sed messges
  Future<void> sendMessages(String reseiverId, String message) async {
    //current user
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp currentTime = Timestamp.now();

    //new message
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        reseiverId: reseiverId,
        sendTime: currentTime,
        message: message);

    //constructor chat room id from current user id to reseiver id
    List<String> ids = [currentUserId, reseiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    //add message to firebase data source

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }
}
