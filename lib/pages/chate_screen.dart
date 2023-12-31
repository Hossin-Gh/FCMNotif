import 'package:chate_app/sevrices/chat/chat_servic.dart';
import 'package:chate_app/widgets/chate_item.dart';
import 'package:chate_app/widgets/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChateScr extends StatefulWidget {
  ChateScr({super.key, required this.userEmail, required this.userId});
  final String userEmail;
  final String userId;

  @override
  State<ChateScr> createState() => _ChateScrState();
}

class _ChateScrState extends State<ChateScr> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessages(widget.userId, _messageController.text);
      //clen controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.userEmail,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _messagesList(),
            ),
            _messageInputBox(),
          ],
        ),
      ),
    );
  }

  Widget _messagesList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          _firebaseAuth.currentUser!.uid, widget.userId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("${snapshot.error.toString()}خطا ");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('لودینگ');
        } else {
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _messagesItem(document))
                .toList(),
          );
        }
      },
    );
  }

  Widget _messagesItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var aligment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      margin: EdgeInsets.all(8),
      alignment: aligment,
      
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            ChatItem(message: data['message']),
          ],
        ),
      ),
    );
  }

  Widget _messageInputBox() {
    return Row(
      children: [
        Expanded(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              autofocus: true,
              controller: _messageController,
              obscureText: false,
              style: TextStyle(
                color: Colors.black,
              ),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'پیام خود را وارد کنید',
                labelStyle: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () => sendMessage(),
        )
      ],
    );
  }
}
