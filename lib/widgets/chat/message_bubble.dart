import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String email;
  final bool isMe;
  final Key key;

  MessageBubble(this.message, this.email, this.isMe, {this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    email.substring(0, email.indexOf('@')),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.subtitle1.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -8,
          left: isMe ? null : 125,
          right: isMe ? 125 : null,
          child: CircleAvatar(
            backgroundColor:
                !isMe ? Colors.grey[300] : Theme.of(context).accentColor,
            child: FittedBox(
              child: Text(email.substring(0, email.indexOf('@'))),
            ),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
