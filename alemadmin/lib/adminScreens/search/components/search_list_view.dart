
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'search_list_item.dart';

final _firestore = FirebaseFirestore.instance;

class SearchListView extends StatelessWidget {
  final String name;
  SearchListView({this.name});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final categories = snapshot.data.docs.reversed;
        List<SearchListItem> categoryList = [];
        for (var category in categories) {
          final url = category.data()['url'];
          final id = category.data()['subcategory'];
          final String name = category.data()['name'];
          final colors = category.data()['colors'];
          final sizes = category.data()['sizes'];
          final String alemid = category.data()['alemid'];
          final price = category.data()['price'];
          final regex = RegExp('${this.name}');
          final categoryitem = SearchListItem(
            url: url,
            name: name,
            colors: colors,
            sizes: sizes,
            subId: id,
            alemid: alemid,
            price: price,
          );
          if ((regex.hasMatch(alemid.toLowerCase()) ||
                  regex.hasMatch(name) ||
                  regex.hasMatch(name.toLowerCase())) &&
              this.name != '') {
            categoryList.add(categoryitem);
          }
        }
        return ListView(
          children: categoryList,
          padding: EdgeInsets.all(10.0),
        );
      },
    );
  }
}
