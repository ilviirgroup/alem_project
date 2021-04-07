import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'service.dart';

class PeopleUpsert extends StatefulWidget {
  PeopleUpsert({Key key}) : super(key: key);

  @override
  _PeopleUpsertState createState() => _PeopleUpsertState();
}

class _PeopleUpsertState extends State<PeopleUpsert> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  Person person;
  @override
  Widget build(BuildContext context) {
    final Person _person = ModalRoute.of(context).settings.arguments;
    person = (_person == null) ? Person() : _person;
    return Scaffold(
      appBar: AppBar(
        title: Text((_person == null) ? 'Add a person' : 'Update a person'),
      ),
      body: _body,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            _key.currentState.save();
            updatePersonToPipedream(person);
            Navigator.pop<Person>(context, person);
          }),
    );
  }

  Widget get _body {
    return Form(
      key: _key,
      autovalidate: true,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextFormField(
                initialValue: person.name['first'],
                decoration: InputDecoration(labelText: 'First name'),
                onSaved: (String val) => person.name['first'] = val),
            TextFormField(
                initialValue: person.name['last'],
                decoration: InputDecoration(labelText: 'Last name'),
                onSaved: (String val) => person.name['last'] = val),
            TextFormField(
                initialValue: person.email,
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (String val) => person.email = val),
            TextFormField(
                initialValue: person.imageUrl,
                decoration: InputDecoration(labelText: 'Image URL'),
                onSaved: (String val) => person.imageUrl = val)
          ],
        ),
      ),
    );
  }

  void updatePersonToPipedream(Person person) {
    Future<Response> response;
    final String payload = """
    {
      "first": "${person.name['first']}",
      "last":"${person.name['last']}",
      "imageUrl": "${person.email}",
      "email":"${person.imageUrl}",
    }
    """;
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    if (person.id == null) {
      String url = "url";
      response = post(Uri.parse(url), headers: headers, body: payload);
    } else {
      String url = "url";
      response = put(Uri.parse(url), headers: headers, body: payload);
    }
    response.then((Response res) {
      Navigator.pop(context, Person.fromJson(res.body));
    });
  }
}
