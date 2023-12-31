import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String message;
  ChatItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.greenAccent[100],
      ),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
