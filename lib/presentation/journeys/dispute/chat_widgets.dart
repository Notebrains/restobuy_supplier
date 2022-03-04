
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String msgText;
  final String msgSender;
  final bool user;

  const MessageBubble({Key? key, required this.msgText, required this.msgSender, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
            child: Text(msgSender,
              style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500, letterSpacing: 1),
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(50),
              topLeft: user ? const Radius.circular(50) : const Radius.circular(0),
              bottomRight: const Radius.circular(50),
              topRight: user ? const Radius.circular(0) : const Radius.circular(50),
            ),
            color: user ? Colors.red.shade50 : Colors.white,
            elevation: 1.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
              child: Text(
                msgText,
                style: TextStyle(
                  color: user ? Colors.black87 : Colors.deepOrangeAccent,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}