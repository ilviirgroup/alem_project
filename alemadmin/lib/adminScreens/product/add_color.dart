import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final _firestore = FirebaseFirestore.instance;

class AddColor extends StatefulWidget {
  @override
  _AddColorState createState() => _AddColorState();
}

class _AddColorState extends State<AddColor> {
  List names = [];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name;
  int colorId = 0;

  @override
  Widget build(BuildContext context) {
    try {
      _firestore.collection('lastids').get().then(
          (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
                colorId = doc.data()['color'];
              }));
      _firestore
          .collection('color')
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) {
                  names.add(doc['name']);
                })
              });
    } catch (e) {
      print(e);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Добавить новый цвет')),
      body: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Необходимые";
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Название цвета'),
                onChanged: (value) {
                  name = value;
                },
              ),
            ),
          ),
          Container(
            height: 80,
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            child: RaisedButton.icon(
              elevation: 8,
              color: Colors.greenAccent[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              onPressed: () => {
                if (_formKey.currentState.validate())
                  {
                    if (names.contains(name))
                      {Fluttertoast.showToast(msg: 'Этот цвет уже существует')}
                    else
                      {
                        _firestore
                            .collection('lastids')
                            .doc('lastIds')
                            .update({'color': (colorId + 1)}),
                        _firestore.collection('color').add({
                          'id': colorId,
                          'name': name,
                        }),
                        Fluttertoast.showToast(msg: 'Цвет добавлен'),
                        Navigator.pop(context)
                      },
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => Successfull())),
                  }
              },
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              label: Text(
                "Добавить",
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
