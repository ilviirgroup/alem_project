import 'dart:core';

// import 'package:alemshop/screens/product_detail/product_detail_scr
import 'package:alemadmin/adminScreens/product/products_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _firestore = FirebaseFirestore.instance;
final user = FirebaseAuth.instance;

class SearchListItem extends StatelessWidget {
  final int subId;
  final int price;
  final List url;
  final String alemid;
  final String name;
  final List colors;
  final List sizes;
  SearchListItem(
      {this.url,
      this.name,
      this.colors,
      this.sizes,
      this.subId,
      this.alemid,
      this.price});
  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart>(context);

    return ListTile(
      contentPadding: EdgeInsets.all(10),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Products(
                      // colorTypes: colors,
                      // sizeTypes: sizes,
                      // urls: urls,
                      subId: subId,
                      categoryAlemId: alemid,
                      // price: price,
                      // url: url,
                    )));
      },
      title: Text(name),
      leading: Image.network(url[0]),
      trailing: Text(price.toString() + " TMT"),
    );
  }
}
