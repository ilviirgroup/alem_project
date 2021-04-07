import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:alemadmin/service.dart';
import 'package:flutter/material.dart';

import 'add_sub_category.dart';
import 'subCategory_item.dart';

class SubCategories extends StatefulWidget {
  static const String id = "sub_category";

  final List subCategories;
  final String categoryName;
  final int categoryId;
  final String categoryAlemId;
  SubCategories(
      {this.subCategories,
      this.categoryName,
      this.categoryId,
      this.categoryAlemId});

  @override
  _SubCategoriesState createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  // List<SubCategory> parseSubCategories(String responseBody) {
  //   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed
  //       .map<SubCategory>((json) => SubCategory.fromMap(json))
  //       .toList();
  // }

  // Future<List<SubCategory>> fetchSubCategories() async {
  //   var uri = Uri.parse('http://127.0.0.1:8000/subcategory-list/');
  //   http.Response response = await http.get(uri);
  //   if (response.statusCode == 200) {
  //     return parseSubCategories(response.body);
  //   } else {
  //     throw Exception('Unable to fetch subcategories from the REST API');
  //   }
  // }

  int id;
  String name;
  @override
  void initState() {
    super.initState();
    // print(widget.subCategories);
    getObjects();
  }

  getObjects() {
    widget.subCategories.map((link) {
      return Text('link');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AddSubCategory(categoryId: widget.categoryId)));
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
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
                )),
          )
        ],
      ),
      body: Container(
          // color: Colors.black12,
          // child: FutureBuilder(
          //   future: fetchSubCategories(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return Center(
          //         child: CircularProgressIndicator(
          //           backgroundColor: Colors.lightBlueAccent,
          //         ),
          //       );
          //     }

          //     final subCategories = snapshot.data;
          //     print(subCategories);

          //     List<SubCategoryItem> subCategoryList = [];
          //     for (var item in subCategories) {
          //       // print(item.category);
          //       print(item.id);
          //       print(item.name);
          //       print(item.url);
          //       print(item.category);
          //       final subCategoryName = item.name;
          //       // final catId = item.category;

          //       final subCategoryId = item.id;
          //       final subCategoryitem = SubCategoryItem(
          //         subCategoryName: subCategoryName,
          //         subCategoryId: subCategoryId,
          //         categoryAlemId: widget.categoryAlemId,
          //       );

          //       subCategoryList.add(subCategoryitem);
          //     }
          //     return ListView(
          //       children: subCategoryList,
          //       padding: EdgeInsets.all(10.0),
          //     );
          //   },
          // ),
          ),
    );
  }
}
