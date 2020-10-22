import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, idx) => Container(
          padding: EdgeInsets.all(8),
          child: Text('This Works!'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Firestore.instance
                .collection('chat/QUOIXEuB3PJki5gm94pt/messages')
                .snapshots()
                .listen((data) {
              print('data..... ${data.documents}');
              data.documents.forEach((doc) {
                print('forEach_doc..... ${doc['text']}');
              });
            });
          }),
    );
  }
}
