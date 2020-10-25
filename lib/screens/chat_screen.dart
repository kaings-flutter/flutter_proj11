import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chat/QUOIXEuB3PJki5gm94pt/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: streamSnapshot.data.documents.length,
            itemBuilder: (ctx, idx) => Container(
              padding: EdgeInsets.all(8),
              child: Text(streamSnapshot.data.documents[idx]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Firestore.instance
                .collection('chat/QUOIXEuB3PJki5gm94pt/messages')
                .add({'text': 'Newly Added!!!!!'});
          }),
    );
  }
}
