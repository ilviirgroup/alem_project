import 'dart:convert';

class Category {
  final int id;
  final String ai;
  final String name;
  final String photo;
  final List subcategory;
  Category(this.id, this.ai, this.name, this.photo, this.subcategory);
  factory Category.fromMap(Map<String, dynamic> json) {
    return Category(json['pk'], json['ai'], json['name'], json['photo'],
        json['subcategory']);
  }
}

class SubCategory {
  final int id;
  final String name;

  SubCategory(this.id, this.name);
  factory SubCategory.fromMap(Map<String, dynamic> json) {
    return SubCategory(json['pk'], json['name']);
  }
}

class Person {
  int id;
  Map<String, String> name;
  String email;
  String imageUrl;
  Person() {
    name = <String, String>{};
  }
  static Person fromJson(String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return Person()
      ..id = data['id']
      ..name = data['name']
      ..email = data['email']
      ..imageUrl = data['imageUrl'];
  }

  static List<Person> fromJsonArray(String jsonString) {
    final Iterable<dynamic> data = jsonDecode(jsonString);
    return data
        .map<Person>((dynamic d) => Person()
          ..id = d['id']
          ..name = {'first': d['first'], 'last': d['last']}
          ..email = d['email']
          ..imageUrl = d['imageUrl'])
        .toList();
  }
}
