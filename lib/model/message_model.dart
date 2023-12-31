import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  Timestamp? sendTime;
  String? sendDate;
  String? message;
  final String senderId;
  final String senderEmail;
  final String reseiverId;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.reseiverId,
    this.message,
    this.sendTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId':senderId,
      'senderEmail':senderEmail,
      'reseiverId':reseiverId,
      'message':message,
      'time':sendTime,
      'date':sendDate,
    };
  }
}
