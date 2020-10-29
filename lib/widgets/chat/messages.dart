import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('chat').snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final chatDocs = chatSnapshot.data.documents;
        print('chatDocs..... ${chatSnapshot.data.documents.length}');

        return ListView.builder(
          itemCount: chatDocs.length,
          itemBuilder: (ctx, idx) => Text(chatDocs[idx]['text']),
        );
      },
    );
  }
}
