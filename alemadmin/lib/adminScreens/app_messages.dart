import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore =
    FirebaseFirestore.instance.collection('messages').snapshots();

class AppMessages extends StatefulWidget {
  static const String id = 'app_messages';
  @override
  _AppMessagesState createState() => _AppMessagesState();
}

class _AppMessagesState extends State<AppMessages> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Сообщения"),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: _firestore,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ));
          }
          return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot messages = snapshot.data.docs[index];
                final name = messages.data()['name'];
                final phone = messages.data()['phone'];
                final message = messages.data()['message'];
                final documentId = messages.data()['documentId'];
                final answer = messages.data()['answer'];
                final date = messages.data()['date'];
                return MessageCard(
                    name: name,
                    phone: phone,
                    message: message,
                    date: date,
                    documentId: documentId,
                    answer: answer);
              });
        },
      ),
    );
  }
}

class MessageCard extends StatefulWidget {
  final String name;
  final String phone;
  final String message;
  final String date;
  final String documentId;
  final String answer;

  MessageCard(
      {Key key,
      this.answer,
      this.name,
      this.phone,
      this.message,
      this.date,
      this.documentId})
      : super(key: key);

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${widget.date}'),
                SizedBox(
                  height: 10,
                ),
                Text('${widget.name}' ?? ''),
                Text('${widget.phone}' ?? ''),
                Container(
                  color: Colors.green[100],
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('${widget.message}' ?? '')),
                ),
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(height: 5.0),
              ]),
        ),
      ),
    );
  }
}
