import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'service.dart';

class PersonList extends StatefulWidget {
  PersonList({Key key}) : super(key: key);

  @override
  _PersonListState createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('People'),
      ),
      body: scaffoldBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/peopleUpsert');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget get scaffoldBody {
    return FutureBuilder<dynamic>(
      future: fetchPeople(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text('Oh No! Error! ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return Text('No people found');
        }
        final List<Person> people = Person.fromJsonArray(snapshot.data.body);
        final List<Widget> personTiles =
            people.map((Person person) => personWidget(person));
        return GridView.extent(
          maxCrossAxisExtent: 300,
          children: personTiles,
        );
      },
    );
  }

  Widget personWidget(Person person) {}
  Future<dynamic> fetchPeople() {
    final String url = '/people/?pipedream_response=1';
    return get(Uri.parse(url));
  }
}
