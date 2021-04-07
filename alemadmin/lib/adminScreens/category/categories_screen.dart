import 'dart:convert';

import 'package:alemadmin/adminScreens/subCategory/subCategories_screen.dart';
import 'package:alemadmin/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_category.dart';
import 'update_category.dart';
import 'package:http/http.dart' as http;

class Categories extends StatefulWidget {
  static const String id = 'categories';
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  TextEditingController categoryController = TextEditingController();

  String text;
  int categoryId = 0;

  List<Category> parseCategories(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Category>((json) => Category.fromMap(json)).toList();
  }

  Future<List<Category>> fetchCategories() async {
    var uri = Uri.parse('http://127.0.0.1:8000/category-list/');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return parseCategories(response.body);
    } else {
      throw Exception('Unable to fetch categories from the REST API');
    }
  }

  @override
  void initState() {
    super.initState();
    categoryController.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Категории"),
        centerTitle: false,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddCategory()));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.library_add,
                    size: 22,
                    color: Colors.blue[700],
                  ),
                  Text(
                    'Добавить',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700]),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: fetchCategories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView.builder(
            // itemExtent: 80.0,
            padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              var items = snapshot.data;
              var kategoriya = items[index];

              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                  onLongPress: () => {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => AlertDialog(
                        content: Text('Вы хотите удалить?'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              'НЕТ',
                              style: TextStyle(color: Colors.lightBlue),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                categoryId = kategoriya.id;
                              });
                              String url = Uri.encodeFull(
                                  'http://127.0.0.1:8000/category-list/$categoryId');
                              http
                                  .delete(Uri.parse(url))
                                  .then((http.Response res) {
                                setState(() {
                                  print('Status code : ${res.statusCode}');
                                });
                              });

                              Navigator.pop(context);
                            },
                            child: Text(
                              'Удалить',
                              style: TextStyle(color: Colors.lightBlue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  },
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SubCategories(
                          subCategories: kategoriya.subcategory,
                          categoryName: kategoriya.name,
                          categoryId: kategoriya.id,
                          categoryAlemId: kategoriya.ai,
                        ),
                      ),
                    );
                  },
                  child: GridTile(
                    child: Container(
                      color: Colors.black45,
                      child: (kategoriya.photo != null)
                          ? Image.network(kategoriya.photo)
                          : Center(
                              child: Text(
                                'Surat ýok',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ),
                    ),
                    footer: GridTileBar(
                      leading: Text(
                        kategoriya.id.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.black45,
                      title: Text(
                        kategoriya.name,
                        textAlign: TextAlign.start,
                      ),
                      trailing: GestureDetector(
                          child: Icon(Icons.edit),
                          onTap: () {
                            print(kategoriya.subcategory);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UpdateCategory(
                                  categoryId: kategoriya.id,
                                  name: kategoriya.name,
                                  alemId: kategoriya.ai,
                                  image: kategoriya.photo,
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
