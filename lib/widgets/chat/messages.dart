import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (ctx, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final chatDocs = chatSnapshot.data.documents;
            print('chatDocs..... ${chatSnapshot.data.documents.length}');
            print('futureSnapshot data..... ${futureSnapshot.data.email}');

            return ListView.builder(
              reverse: true, // reverse the list frm bottom to top
              itemCount: chatDocs.length,
              itemBuilder: (ctx, idx) => MessageBubble(
                chatDocs[idx]['text'],
                chatDocs[idx]['userEmail'],
                chatDocs[idx]['userId'] == futureSnapshot.data.uid,
                key: ValueKey(chatDocs[idx]
                    .documentID), // `documentID` will give specific id of the document which is unique
              ),
            );
          },
        );
      },
    );
  }
}
